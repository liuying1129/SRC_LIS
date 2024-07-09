unit UfrmMain;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Buttons, IniFiles, DB,
  ADODB, DateUtils, CoolTrayIcon, Menus, ShlObj, ActiveX, ComObj;

type
  TfrmMain = class(TForm)
    CheckListBox1: TCheckListBox;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    ADOConnection1: TADOConnection;
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    Label1: TLabel;
    LYTray1: TCoolTrayIcon;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    function MakeDBConn:boolean;
    procedure MakeWorkGroupChecklistbox;//将工作组导入CheckListBox中
    procedure CheckTheListBox;//根据当前病人的结果在checklistbox1中打钩
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

const
  sCryptSeed='lc';//加解密种子
  SYSNAME='LIS';

var
  LisConn:String;
  hnd:integer;

function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//解密
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';
procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunction.dll';

procedure OperateLinkFile(ExePathAndName:string; LinkFileName: widestring;
  LinkFilePos:integer;AddorDelete: boolean);
VAR
  tmpobject:IUnknown;
  tmpSLink:IShellLink;
  tmpPFile:IPersistFile;
  PIDL:PItemIDList;
  LinkFilePath:array[0..MAX_PATH]of char;
  StartupFilename:string;
begin
  case LinkFilePos of
    1:SHGetSpecialFolderLocation(0,CSIDL_BITBUCKET,pidl);
    2:SHGetSpecialFolderLocation(0,CSIDL_CONTROLS,pidl);
    3:SHGetSpecialFolderLocation(0,CSIDL_DESKTOP,pidl);
    4:SHGetSpecialFolderLocation(0,CSIDL_DESKTOPDIRECTORY,pidl);
    5:SHGetSpecialFolderLocation(0,CSIDL_DRIVES,pidl);
    6:SHGetSpecialFolderLocation(0,CSIDL_FONTS,pidl);
    7:SHGetSpecialFolderLocation(0,CSIDL_NETHOOD,pidl);
    8:SHGetSpecialFolderLocation(0,CSIDL_NETWORK,pidl);
    9:SHGetSpecialFolderLocation(0,CSIDL_PERSONAL,pidl);
    10:SHGetSpecialFolderLocation(0,CSIDL_PRINTERS,pidl);
    11:SHGetSpecialFolderLocation(0,CSIDL_PROGRAMS,pidl);
    12:SHGetSpecialFolderLocation(0,CSIDL_RECENT,pidl);
    13:SHGetSpecialFolderLocation(0,CSIDL_SENDTO,pidl);
    14:SHGetSpecialFolderLocation(0,CSIDL_STARTMENU,pidl);
    15:SHGetSpecialFolderLocation(0,CSIDL_STARTUP,pidl);
    16:SHGetSpecialFolderLocation(0,CSIDL_TEMPLATES,pidl);
  end;
  shgetpathfromidlist(pidl,LinkFilePath);
  linkfilename:=LinkFilePath+LinkFileName;
  if AddorDelete then
  begin
    if not fileexists(linkfilename) then
    begin
      startupfilename:=ExePathAndName;
      tmpobject:=createcomobject(CLSID_ShellLink);
      tmpSLink:=tmpobject as ishelllink;
      tmpPfile:=tmpobject as IPersistFile;
      tmpslink.SetPath(pchar(startupfilename));
      tmpslink.SetWorkingDirectory(pchar(extractfilepath(startupfilename)));
      tmppfile.save(pwchar(linkfilename),false);
    end;
  end else
  begin
    if fileexists(linkfilename) then deletefile(linkfilename);
  end;
end;

function ScalarSQLCmd(AConnectionString:string;ASQL:string):string;
var
  Conn:TADOConnection;
  Qry:TAdoQuery;
begin
  Result:='';
  Conn:=TADOConnection.Create(nil);
  Conn.LoginPrompt:=false;
  Conn.ConnectionString:=AConnectionString;
  Qry:=TAdoQuery.Create(nil);
  Qry.Connection:=Conn;
  Qry.Close;
  Qry.SQL.Clear;
  Qry.SQL.Text:=ASQL;
  Try
    Qry.Open;
  except
    on E:Exception do
    begin
      WriteLog(pchar('函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL));
      if length(frmMain.memo1.Lines.Text)>=60000 then frmMain.memo1.Lines.Clear;//memo只能接受64K个字符
      frmMain.memo1.Lines.Add(DateTimeToStr(now)+':函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL);
      Qry.Free;
      Conn.Free;
      exit;
    end;
  end;
  Result:=Qry.Fields[0].AsString;
  Qry.Free;
  Conn.Free;
end;

function GetConnectString:string;
var
  Ini:tinifile;
  userid, password, datasource, initialcatalog: string;
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
begin
  result:='';
  
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.INI'));
  datasource := Ini.ReadString('连接数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接数据库','集成登录模式',false);
  userid := Ini.ReadString('连接数据库', '用户', '');
  password := Ini.ReadString('连接数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,sCryptSeed);
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  result := result + 'user id=' + UserID + ';';
  result := result + 'password=' + Password + ';';
  result := result + 'data source=' + datasource + ';';
  result := result + 'Initial Catalog=' + initialcatalog + ';';
  result := result + 'provider=' + 'SQLOLEDB.1' + ';';
  //Persist Security Info,表示ADO在数据库连接成功后是否保存密码信息
  //ADO缺省为True,ADO.net缺省为False
  //程序中会传ADOConnection信息给TADOLYQuery,故设置为True
  result := result + 'Persist Security Info=True;';
  if ifIntegrated then
    result := result + 'Integrated Security=SSPI;';
end;

function TfrmMain.MakeDBConn: boolean;
var
  newconnstr,ss: string;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  newconnstr := GetConnectString;

  try
    ADOConnection1.Connected := false;
    ADOConnection1.ConnectionString := newconnstr;
    ADOConnection1.Connected := true;
    result:=true;
    LisConn:=newconnstr;
  except
  end;
  if not result then
  begin
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接数据库','连接数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MakeDBConn;

  lytray1.Hint:='自动结束当批检验工作 - 服务';

  Timer1.Enabled:=false;
  Timer1.Interval:=55*60*1000;//每55分钟扫描一次,故2:00:00-2:59:59之间有可能执行两次.就算执行两次对业务上影响不大
  Timer1.Enabled:=true;
end;

procedure TfrmMain.MakeWorkGroupChecklistbox;
var
  adotemp3:tadoquery;
begin
  CheckListBox1.Items.Clear;

  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='SELECT Name FROM CommCode where typename=''检验组别'' and sysname='''+SYSNAME+''' ';
  adotemp3.Open;
  while not adotemp3.Eof do
  begin
    CheckListBox1.Items.Add(adotemp3.fieldbyname('name').AsString);

    adotemp3.Next;
  end;
  adotemp3.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  ConfigIni:tinifile;
begin
  MakeWorkGroupChecklistbox;
  CheckTheListBox;

  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  CheckBox1.Checked:=configini.ReadBool('Interface','开机自动运行',false);
  configini.Free;

  OperateLinkFile(application.ExeName,'\'+ChangeFileExt(ExtractFileName(Application.ExeName),'.lnk'),15,CheckBox1.Checked);
end;

procedure TfrmMain.CheckTheListBox;
var
  i:integer;
  ConfigIni:tinifile;
  ss:string;
  bb:boolean;
begin
  for i:=0 to CheckListBox1.Items.Count-1 do CheckListBox1.Checked[i]:=false;

  for i:=0 to CheckListBox1.Items.Count-1 do
  begin
    ss:=CheckListBox1.Items.Strings[i];
    if ss='' then continue;

    ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    bb:=configini.ReadBool('工作组',ss,false);
    ConfigIni.Free;

    if bb then CheckListBox1.Checked[i]:=true;
  end;
end;

procedure TfrmMain.CheckListBox1ClickCheck(Sender: TObject);
var
  i:integer;
  s2:string;
  ConfigIni:tinifile;
begin
  i:=(Sender as TCheckListBox).ItemIndex;

  s2:=(Sender as TCheckListBox).Items.Strings[i];
  if s2='' then exit;

  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  configini.WriteBool('工作组',s2,(Sender as TCheckListBox).Checked[i]);
  ConfigIni.Free;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  MakeWorkGroupChecklistbox;
  CheckTheListBox;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
  adotemp11:tadoquery;
  s1,s2,s3,sWorkGroup:string;
  i:integer;
begin
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
  Memo1.Lines.Add(DateTimeToStr(now));//用于观测服务程序是否死掉

  if HourOf(now)<>2 then exit;

  for i:=0 to CheckListBox1.Items.Count-1 do
  begin
    if not CheckListBox1.Checked[i] then continue;

    sWorkGroup:=CheckListBox1.Items.Strings[i];

    if '1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from Chk_Con cc WITH(NOLOCK),chk_valu cv WITH(NOLOCK) where cc.unid=cv.pkunid and cc.combin_id='''+sWorkGroup+''' and isnull(cc.TjXinDianTu,'''')='''' and dbo.uf_CriticalValueAlarm(cv.itemid,cc.sex,cc.age,cv.itemvalue)=1') then
    begin
      WriteLog(pchar('【'+sWorkGroup+'】存在未报告的危急值,不允许结束操作!'));
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
      memo1.Lines.Add(DateTimeToStr(now)+':【'+sWorkGroup+'】存在未报告的危急值,不允许结束操作!');
      continue;
    end;

    s1:=' select   *  from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+sWorkGroup+''' ';//所有已审核的单
    s2:=' select unid from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+sWorkGroup+''' ';//与S1相同，除了选择范围不同外
    s3:='             from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+sWorkGroup+''' ';//与S1相同，除了选择范围不同外
    //事务4特性ACID
    //Atomicity【原子性】:要么一起成功,要么一起失败
    //Consistency【一致性】:事务前后数据的完整性保持一致
    //Isolation【隔离性】:多个用户并发访问数据库时,数据库为每个用户开启事务,不会被其他事务的操作数据所干扰,多个并发事务之间相互隔离
                //4种事务隔离级别:
                //读未提交:一个事务未提交,它做的变更能被其他事务看到
                //读已提交:一个事务提交后,它做的变更才能被其他事务看到[SQL SERVER默认级别]
                //可重复读:同一个事务中用SELECT查询的结果总是相同的,哪怕是其他事务对该数据进行了操作并提交[MySQL InnoDB引擎默认级别]
                //串行化:读写相互都会阻塞,隔离级别最高,牺牲系统并发性
    //Durability【持久性】:事务一旦被提交,它对数据库中数据的改变就是永久性的,接下来即使数据库发生故障也不对其有任何影响
    ADOConnection1.BeginTrans;
    try//经测试(设置断点并中止执行或断电)，BeginTrans与CommitTrans之间的语句中止执行，数据不会提交
      adotemp11:=tadoquery.Create(nil);
      adotemp11.Connection:=ADOConnection1;
      ADOtemp11.Close;
      ADOtemp11.SQL.Clear;
      ADOtemp11.SQL.Add('insert into chk_con_bak '+s1);
      ADOtemp11.ExecSQL;

      ADOtemp11.Close;
      ADOtemp11.SQL.Clear;
      ADOtemp11.SQL.Add('insert into chk_valu_bak select * from chk_VALU where issure=1 and pkunid in ('+s2+')');
      ADOtemp11.ExecSQL;

      ADOtemp11.Close;
      ADOtemp11.SQL.Clear;
      ADOtemp11.SQL.Add('delete '+s3);
      ADOtemp11.ExecSQL;

      adotemp11.Free;

      ADOConnection1.CommitTrans;
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
      memo1.Lines.Add(DateTimeToStr(now)+':【'+sWorkGroup+'】结束工作完成!');
    except
      WriteLog(pchar('【'+sWorkGroup+'】结束工作发生异常!'));
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
      memo1.Lines.Add(DateTimeToStr(now)+':【'+sWorkGroup+'】结束工作发生异常!');
      ADOConnection1.RollbackTrans;
    end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ConfigIni:tinifile;
begin
  action:=caNone;
  LYTray1.HideMainForm;
  
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  configini.WriteBool('Interface','开机自动运行',CheckBox1.Checked);
  configini.Free;
end;

procedure TfrmMain.N2Click(Sender: TObject);
begin
  if (MessageDlg('退出后将不再自动结束当批检验工作,确定退出吗？', mtWarning, [mbYes, mbNo], 0) <> mrYes) then exit;

  application.Terminate;
end;

procedure TfrmMain.N1Click(Sender: TObject);
begin
  LYTray1.ShowMainForm;
end;

initialization
    hnd := CreateMutex(nil, True, Pchar(ExtractFileName(Application.ExeName)));
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
        MessageBox(application.Handle,pchar('该程序已在运行中！'),
                    '系统提示',MB_OK+MB_ICONinformation);   
        Halt;
    end;

finalization
    if hnd <> 0 then CloseHandle(hnd);

end.
