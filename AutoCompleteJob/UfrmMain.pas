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
    procedure MakeWorkGroupChecklistbox;//�������鵼��CheckListBox��
    procedure CheckTheListBox;//���ݵ�ǰ���˵Ľ����checklistbox1�д�
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

const
  sCryptSeed='lc';//�ӽ�������
  SYSNAME='LIS';

var
  LisConn:String;
  hnd:integer;

function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//����
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
      WriteLog(pchar('����ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL));
      if length(frmMain.memo1.Lines.Text)>=60000 then frmMain.memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      frmMain.memo1.Lines.Add(DateTimeToStr(now)+':����ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL);
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
  ifIntegrated:boolean;//�Ƿ񼯳ɵ�¼ģʽ

  pInStr,pDeStr:Pchar;
  i:integer;
begin
  result:='';
  
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.INI'));
  datasource := Ini.ReadString('�������ݿ�', '������', '');
  initialcatalog := Ini.ReadString('�������ݿ�', '���ݿ�', '');
  ifIntegrated:=ini.ReadBool('�������ݿ�','���ɵ�¼ģʽ',false);
  userid := Ini.ReadString('�������ݿ�', '�û�', '');
  password := Ini.ReadString('�������ݿ�', '����', '107DFC967CDCFAAF');
  Ini.Free;
  //======����password
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
  //Persist Security Info,��ʾADO�����ݿ����ӳɹ����Ƿ񱣴�������Ϣ
  //ADOȱʡΪTrue,ADO.netȱʡΪFalse
  //�����лᴫADOConnection��Ϣ��TADOLYQuery,������ΪTrue
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
    ss:='������'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ݿ�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ɵ�¼ģʽ'+#2+'CheckListBox'+#2+#2+'0'+#2+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('�������ݿ�','�������ݿ�',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MakeDBConn;

  lytray1.Hint:='�Զ������������鹤�� - ����';

  Timer1.Enabled:=false;
  Timer1.Interval:=55*60*1000;//ÿ55����ɨ��һ��,��2:00:00-2:59:59֮���п���ִ������.����ִ�����ζ�ҵ����Ӱ�첻��
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
  adotemp3.SQL.Text:='SELECT Name FROM CommCode where typename=''�������'' and sysname='''+SYSNAME+''' ';
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
  CheckBox1.Checked:=configini.ReadBool('Interface','�����Զ�����',false);
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
    bb:=configini.ReadBool('������',ss,false);
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
  configini.WriteBool('������',s2,(Sender as TCheckListBox).Checked[i]);
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
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
  Memo1.Lines.Add(DateTimeToStr(now));//���ڹ۲��������Ƿ�����

  if HourOf(now)<>2 then exit;

  for i:=0 to CheckListBox1.Items.Count-1 do
  begin
    if not CheckListBox1.Checked[i] then continue;

    sWorkGroup:=CheckListBox1.Items.Strings[i];

    if '1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from Chk_Con cc WITH(NOLOCK),chk_valu cv WITH(NOLOCK) where cc.unid=cv.pkunid and cc.combin_id='''+sWorkGroup+''' and isnull(cc.TjXinDianTu,'''')='''' and dbo.uf_CriticalValueAlarm(cv.itemid,cc.sex,cc.age,cv.itemvalue)=1') then
    begin
      WriteLog(pchar('��'+sWorkGroup+'������δ�����Σ��ֵ,�������������!'));
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(DateTimeToStr(now)+':��'+sWorkGroup+'������δ�����Σ��ֵ,�������������!');
      continue;
    end;

    s1:=' select   *  from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+sWorkGroup+''' ';//��������˵ĵ�
    s2:=' select unid from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+sWorkGroup+''' ';//��S1��ͬ������ѡ��Χ��ͬ��
    s3:='             from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+sWorkGroup+''' ';//��S1��ͬ������ѡ��Χ��ͬ��
    //����4����ACID
    //Atomicity��ԭ���ԡ�:Ҫôһ��ɹ�,Ҫôһ��ʧ��
    //Consistency��һ���ԡ�:����ǰ�����ݵ������Ա���һ��
    //Isolation�������ԡ�:����û������������ݿ�ʱ,���ݿ�Ϊÿ���û���������,���ᱻ��������Ĳ�������������,�����������֮���໥����
                //4��������뼶��:
                //��δ�ύ:һ������δ�ύ,�����ı���ܱ��������񿴵�
                //�����ύ:һ�������ύ��,�����ı�����ܱ��������񿴵�[SQL SERVERĬ�ϼ���]
                //���ظ���:ͬһ����������SELECT��ѯ�Ľ��������ͬ��,��������������Ը����ݽ����˲������ύ[MySQL InnoDB����Ĭ�ϼ���]
                //���л�:��д�໥��������,���뼶�����,����ϵͳ������
    //Durability���־��ԡ�:����һ�����ύ,�������ݿ������ݵĸı���������Ե�,��������ʹ���ݿⷢ������Ҳ���������κ�Ӱ��
    ADOConnection1.BeginTrans;
    try//������(���öϵ㲢��ִֹ�л�ϵ�)��BeginTrans��CommitTrans֮��������ִֹ�У����ݲ����ύ
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
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(DateTimeToStr(now)+':��'+sWorkGroup+'�������������!');
    except
      WriteLog(pchar('��'+sWorkGroup+'���������������쳣!'));
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(DateTimeToStr(now)+':��'+sWorkGroup+'���������������쳣!');
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
  configini.WriteBool('Interface','�����Զ�����',CheckBox1.Checked);
  configini.Free;
end;

procedure TfrmMain.N2Click(Sender: TObject);
begin
  if (MessageDlg('�˳��󽫲����Զ������������鹤��,ȷ���˳���', mtWarning, [mbYes, mbNo], 0) <> mrYes) then exit;

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
        MessageBox(application.Handle,pchar('�ó������������У�'),
                    'ϵͳ��ʾ',MB_OK+MB_ICONinformation);   
        Halt;
    end;

finalization
    if hnd <> 0 then CloseHandle(hnd);

end.
