unit UfrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBAccess, Uni, MemDS, Grids, DBGrids,
  Buttons, ADODB,IniFiles,StrUtils, VirtualTable,
  DosMove, Menus, ComCtrls, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, frxClass,
  frxBarcode, UniProvider, SQLServerUniProvider, MySQLUniProvider, OracleUniProvider;

//==为了通过发送消息更新主窗体状态栏而增加==//
const
  WM_UPDATETEXTSTATUS=WM_USER+1;
TYPE
  TWMUpdateTextStatus=TWMSetText;
//=========================================//

type
  TfrmMain = class(TForm)
    UniConnExtSystem: TUniConnection;
    Panel1: TPanel;
    ADOConnection1: TADOConnection;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    DosMove1: TDosMove;
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    DBGridEh1: TDBGridEh;
    UniQuery1: TUniQuery;
    DataSource1: TDataSource;
    DateTimePicker2: TDateTimePicker;
    BitBtn2: TBitBtn;
    frxReport1: TfrxReport;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    RadioGroup2: TRadioGroup;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    VirtualTable1: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure UniQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);
  private
    { Private declarations }
    function MakeAdoDBConn:boolean;
    function MakeExtSystemDBConn:boolean;
    //==为了通过发送消息更新主窗体状态栏而增加==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS消息处理函数}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//Text为该格式#$2+'0:abc'+#$2+'1:def'表示状态栏第0格显示abc,第1格显示def,依此类推
    //==========================================//
    procedure MakeBarcode(const AReq_Detail_ID, AReq_Header_ID, AHis_Item_No, AFriend_Req_Detail_ID, ASpecimen_Type:String;const APatientname,ASex,AAge,AAgeunit,AReq_time,AReq_dept,AReq_doc,AHis_item_name,APatient_type:String);
  public
    { Public declarations }
  end;

function ScalarSQLCmd(AConnectionString:string;ASQL:string):string;
function ExecSQLCmd(AConnectionString:string;ASQL:string):integer;

var
  frmMain: TfrmMain;

  operator_name:string;
  operator_id:string;
  LisConn:string;//Lis连接字符串,MakeDBConn过程中被赋值,然后传入QC.DLL、CalcItemPro.dll
  
implementation

uses UfrmRequestInfo, UfrmLogin;

{$R *.dfm}

procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunction.dll';
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//解密
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';

const
  CryptStr='lc';

function ExecSQLCmd(AConnectionString:string;ASQL:string):integer;
var
  Conn:TADOConnection;
  Qry:TAdoQuery;
begin
  Conn:=TADOConnection.Create(nil);
  Conn.LoginPrompt:=false;
  Conn.ConnectionString:=AConnectionString;
  Qry:=TAdoQuery.Create(nil);
  Qry.Connection:=Conn;
  Qry.Close;
  Qry.SQL.Clear;
  Qry.SQL.Text:=ASQL;
  Try
    Result:=Qry.ExecSQL;
  except
    on E:Exception do
    begin
      WriteLog(pchar('操作者:'+operator_name+'。函数ExecSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL));
      MESSAGEDLG('函数ExecSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL,mtError,[mbOK],0);
      Result:=-1;
    end;
  end;
  Qry.Free;
  Conn.Free;
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
      WriteLog(pchar('操作者:'+operator_name+'。函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL));
      MESSAGEDLG('函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL,mtError,[mbOK],0);
      Qry.Free;
      Conn.Free;
      exit;
    end;
  end;
  Result:=Qry.Fields[0].AsString;
  Qry.Free;
  Conn.Free;
end;
  
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MakeExtSystemDBConn;
  MakeAdoDBConn;

  UniQuery1.Connection:=UniConnExtSystem;
  VirtualTable1.Connection:=ADOConnection1;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  frmRequestInfo.ShowModal;
end;

function TfrmMain.MakeAdoDBConn: boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  userid, password, datasource, initialcatalog: string;{, provider}
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('连接LIS数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接LIS数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接LIS数据库','集成登录模式',false);
  userid := Ini.ReadString('连接LIS数据库', '用户', '');
  password := Ini.ReadString('连接LIS数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  newconnstr :='';
  newconnstr := newconnstr + 'user id=' + UserID + ';';
  newconnstr := newconnstr + 'password=' + Password + ';';
  newconnstr := newconnstr + 'data source=' + datasource + ';';
  newconnstr := newconnstr + 'Initial Catalog=' + initialcatalog + ';';
  newconnstr := newconnstr + 'provider=' + 'SQLOLEDB.1' + ';';
  //Persist Security Info,表示ADO在数据库连接成功后是否保存密码信息
  //ADO缺省为True,ADO.net缺省为False
  //程序中会传ADOConnection信息给TADOLYQuery,故设置为True
  newconnstr := newconnstr + 'Persist Security Info=True;';
  if ifIntegrated then
    newconnstr := newconnstr + 'Integrated Security=SSPI;';
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
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+'启用该模式,则用户及口令无需填写'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接LIS数据库','连接LIS数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

function TfrmMain.MakeExtSystemDBConn: boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  ServerMySQL, ServerOracle, ServerSQLServer, icMySQL, icSQLServer, uidMySQL, uidOracle, uidSQLServer, pwdMySQL, pwdOracle, pwdSQLServer: string;
  port:Integer;
  ifMySQL,ifOracle,ifSQLServer,ifIntegrated:boolean;

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  ifMySQL:=ini.ReadBool('MySQL','启用',false);
  ifOracle:=ini.ReadBool('Oracle','启用',false);
  ifSQLServer:=ini.ReadBool('SQL Server','启用',false);
  ServerMySQL := Ini.ReadString('MySQL', '服务器', '');
  ServerOracle := Ini.ReadString('Oracle', '服务器', '');
  ServerSQLServer := Ini.ReadString('SQL Server', '服务器', '');
  port := Ini.ReadInteger('MySQL', '端口号', -1);
  icMySQL := Ini.ReadString('MySQL', '数据库', '');
  icSQLServer := Ini.ReadString('SQL Server', '数据库', '');
  ifIntegrated:=ini.ReadBool('SQL Server','集成登录模式',false);
  uidMySQL := Ini.ReadString('MySQL', '用户', '');
  uidOracle := Ini.ReadString('Oracle', '用户', '');
  uidSQLServer := Ini.ReadString('SQL Server', '用户', '');
  pwdMySQL := Ini.ReadString('MySQL', '口令', '107DFC967CDCFAAF');
  pwdOracle := Ini.ReadString('Oracle', '口令', '107DFC967CDCFAAF');
  pwdSQLServer := Ini.ReadString('SQL Server', '口令', '107DFC967CDCFAAF');  
  Ini.Free;
  //======解密password
  pInStr:=pchar(pwdMySQL);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(pwdMySQL,length(pDeStr));
  for i :=1  to length(pDeStr) do pwdMySQL[i]:=pDeStr[i-1];
  //==========
  //======解密password
  pInStr:=pchar(pwdOracle);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(pwdOracle,length(pDeStr));
  for i :=1  to length(pDeStr) do pwdOracle[i]:=pDeStr[i-1];
  //==========
  //======解密password
  pInStr:=pchar(pwdSQLServer);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(pwdSQLServer,length(pDeStr));
  for i :=1  to length(pDeStr) do pwdSQLServer[i]:=pDeStr[i-1];
  //==========

  newconnstr :='';
  if ifMySQL then
  begin
    //Provider Name为MySQL时,切记设置中文字符集(如Charset=GBK).否则:select中文别名报错;字段的中文值显示乱码
    newconnstr := newconnstr + 'Provider Name=' + 'MySQL' + ';';
    newconnstr := newconnstr + 'Login Prompt=False;Charset=GBK;';
    newconnstr := newconnstr + 'Data Source=' + ServerMySQL + ';';
    newconnstr := newconnstr + 'User ID=' + uidMySQL + ';';
    newconnstr := newconnstr + 'Password=' + pwdMySQL + ';';
    newconnstr := newconnstr + 'Database=' + icMySQL + ';';
    newconnstr := newconnstr + 'Port=' + inttostr(port) + ';';
    try
      UniConnExtSystem.Connected := false;
      UniConnExtSystem.ConnectString:=newconnstr;
      UniConnExtSystem.Connect;
      result:=true;
    except
      result:=false;
    end;
  end;
  if ifOracle then
  begin
    //Provider Name为Oracle时,Server属性格式:Host IP:Port:SID,如10.195.252.13:1521:kthis1
    //Oracle的默认Port为1521
    //查询Oracle SID:select instance_name from V$instance;
    newconnstr := newconnstr + 'Provider Name=' + 'Oracle' + ';';
    newconnstr := newconnstr + 'Login Prompt=False;Direct=True;';
    newconnstr := newconnstr + 'Data Source=' + ServerOracle + ';';
    newconnstr := newconnstr + 'User ID=' + uidOracle + ';';
    newconnstr := newconnstr + 'Password=' + pwdOracle + ';';
    try
      UniConnExtSystem.Connected := false;
      UniConnExtSystem.ConnectString:=newconnstr;
      UniConnExtSystem.Connect;
      result:=true;
    except
      result:=false;
    end;
  end;
  if ifSQLServer then
  begin
    newconnstr := newconnstr + 'Provider Name=' + 'SQL Server' + ';';
    newconnstr := newconnstr + 'Login Prompt=False;';
    newconnstr := newconnstr + 'user id=' + uidSQLServer + ';';
    newconnstr := newconnstr + 'password=' + pwdSQLServer + ';';
    newconnstr := newconnstr + 'data source=' + ServerSQLServer + ';';
    newconnstr := newconnstr + 'Database=' + icSQLServer + ';';
    //Persist Security Info,表示ADO在数据库连接成功后是否保存密码信息
    //ADO缺省为True,ADO.net缺省为False
    //程序中会传ADOConnection信息给TADOLYQuery,故设置为True
    newconnstr := newconnstr + 'PersistSecurityInfo=True;';
    if ifIntegrated then
      newconnstr := newconnstr + 'Authentication=auWindows;';
    try
      UniConnExtSystem.Connected := false;
      UniConnExtSystem.ConnectString := newconnstr;
      UniConnExtSystem.Connected := true;
      result:=true;
    except
      result:=false;
    end;
  end;
  if not result then
  begin
    ss:='启用'+#2+'CheckListBox'+#2+#2+'0'+#2+'支持5.7及以前版本,8.0及以后版本的服务端需特殊设置'+#2+#3+
        '服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '端口号'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1'+#3+
        '启用'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
        '服务器'+#2+'Edit'+#2+#2+'1'+#2+'格式【Host IP:Port:SID】'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'1'+#2+#2+'1'+#3+
        '启用'+#2+'CheckListBox'+#2+#2+'2'+#2+#2+#3+
        '服务器'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'2'+#2+'启用该模式,则用户及口令无需填写'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'2'+#2+#2+'1';
    if ShowOptionForm('连接外部系统数据库','MySQL'+#2+'Oracle'+#2+'SQL Server',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteInteger('Interface','selBRLB',RadioGroup1.ItemIndex);{记录病人类别的选择}
  configini.WriteInteger('Interface','ifPreview',RadioGroup2.ItemIndex);{记录是否打印预览模式}

  configini.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  configini:tinifile;
begin
  frmLogin.ShowModal;

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  RadioGroup1.ItemIndex:=configini.ReadInteger('Interface','selBRLB',0);{记录病人类别的选择}
  RadioGroup2.ItemIndex:=configini.ReadInteger('Interface','ifPreview',0);{记录打印预览、直接打印}

  configini.Free;

  DateTimePicker1.Date:=Date-7;
  DateTimePicker2.Date:=Date;
end;

procedure TfrmMain.updatestatusBar(const text: string);
//Text为该格式#$2+'0:abc'+#$2+'1:def'表示状态栏第0格显示abc,第1格显示def,依此类推
var
  i,J2Pos,J2Len,TextLen,j:integer;
  tmpText:string;
begin
  TextLen:=length(text);
  for i :=0 to StatusBar1.Panels.Count-1 do
  begin
    J2Pos:=pos(#$2+inttostr(i)+':',text);
    J2Len:=length(#$2+inttostr(i)+':');
    if J2Pos<>0 then
    begin
      tmpText:=text;
      tmpText:=copy(tmpText,J2Pos+J2Len,TextLen-J2Pos-J2Len+1);
      j:=pos(#$2,tmpText);
      if j<>0 then tmpText:=leftstr(tmpText,j-1);
      StatusBar1.Panels[i].Text:=tmpText;
    end;
  end;
end;

procedure TfrmMain.WMUpdateTextStatus(var message: twmupdatetextstatus);
begin
  UpdateStatusBar(pchar(message.Text));
  message.Result:=-1;
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
var
  patientname,req_dept,patient_type:string;
begin
  patientname:='';
  req_dept:='';
  patient_type:='';
  if trim(LabeledEdit1.Text)<>'' then patientname:=' and patientname like ''%'+trim(LabeledEdit1.Text)+'%'' '; 
  if trim(LabeledEdit2.Text)<>'' then req_dept:=' and req_dept like ''%'+trim(LabeledEdit2.Text)+'%'' ';
  if RadioGroup1.ItemIndex=1 then patient_type:=' and patient_type=''门诊'' ';
  if RadioGroup1.ItemIndex=2 then patient_type:=' and patient_type=''住院'' ';

  UniQuery1.Close;
  UniQuery1.SQL.Clear;
  UniQuery1.SQL.Text:='select req_header_id,patientname as 姓名,sex as 性别,age as 年龄,ageunit as 年龄单位,req_time as 申请时间,req_dept as 申请科室,req_doc as 申请医生,patient_type as 患者类别,'+
                      ' req_detail_id,his_item_no as 项目代码,his_item_name as 项目名称,specimen_type as 样本类型 '+
                      ' from view_test_request where req_time between :DateTimePicker1 and :DateTimePicker2 '+patientname+req_dept+patient_type+' order by req_time desc,req_header_id';
  UniQuery1.ParamByName('DateTimePicker1').Value:=DateTimePicker1.DateTime;//设计期Time设置为00:00:00.放心,下拉选择日期时不会改变Time值
  UniQuery1.ParamByName('DateTimePicker2').Value:=DateTimePicker2.DateTime;//设计期Time设置为23:59:59.放心,下拉选择日期时不会改变Time值
  UniQuery1.Open;
end;

procedure TfrmMain.UniQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  
  DBGridEh1.Columns.Items[0].Width:=110;//req_header_id
  DBGridEh1.Columns.Items[1].Width:=42;//姓名
  DBGridEh1.Columns.Items[2].Width:=30;//性别
  DBGridEh1.Columns.Items[3].Width:=30;//年龄
  DBGridEh1.Columns.Items[4].Width:=30;//年龄单位
  DBGridEh1.Columns.Items[5].Width:=135;//开单时间
  DBGridEh1.Columns.Items[6].Width:=60;//开单科室
  DBGridEh1.Columns.Items[7].Width:=60;//开单医生
  DBGridEh1.Columns.Items[8].Width:=60;//患者类别
  DBGridEh1.Columns.Items[9].Width:=95;//req_detail_id
  DBGridEh1.Columns.Items[10].Width:=60;//项目代码
  DBGridEh1.Columns.Items[11].Width:=60;//项目名称
  DBGridEh1.Columns.Items[12].Width:=60;//样本类型
end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
var
  i,j:integer;

  Save_Cursor:TCursor;
  OldCurrent:TBookmark;

  Req_Detail_ID, Req_Header_ID, His_Item_No, specimen_type:String;
  patientname,sex,age,ageunit,req_time,req_dept,req_doc,his_item_name,patient_type:String;

  Select_Req_Detail_ID_List:TStrings;
  Select_Req_Detail_ID:String;//格式如('0001','0002','0003'),方便拼接SQL
  Friend_Req_Detail_ID:String;//友军.格式如('0001','0002','0003'),方便拼接SQL
begin
  if not UniQuery1.Active then exit;
  if UniQuery1.RecordCount=0 then exit;

  if DBGridEh1.SelectedRows.Count<=0 then exit;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  Select_Req_Detail_ID:='';
  Select_Req_Detail_ID_List:=TStringList.Create;

  //Grid勾选记录判断方式二 begin
  //该方式无需循环全部数据集,只需循环所选记录（该循环用于生成【选择的Req_Detail_ID列表】,生成条码及打印项目均在此范围内）
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
  memo1.Lines.Add(DateTimeToStr(now) + ':正在生成条码......');
  OldCurrent:=DBGridEh1.DataSource.DataSet.GetBookmark;
  DBGridEh1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGridEh1.SelectedRows.Count-1 do
  begin
    DBGridEh1.DataSource.DataSet.Bookmark:=DBGridEh1.SelectedRows[i];

    Select_Req_Detail_ID_List.Add(DBGridEh1.DataSource.DataSet.fieldbyname('Req_Detail_ID').AsString+'='+DBGridEh1.DataSource.DataSet.fieldbyname('Req_Header_ID').AsString);

    Select_Req_Detail_ID:=Select_Req_Detail_ID+','+''''+DBGridEh1.DataSource.DataSet.fieldbyname('Req_Detail_ID').AsString+'''';
  end;
  DBGridEh1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGridEh1.DataSource.DataSet.EnableControls;
  //Grid勾选记录判断方式二 end}
  
  delete(Select_Req_Detail_ID,1,1);//删除第一个字符，即逗号
  if Select_Req_Detail_ID<>'' then Select_Req_Detail_ID:='('+Select_Req_Detail_ID+')';

  //Grid勾选记录判断方式二 begin
  //该方式无需循环全部数据集,只需循环所选记录（该循环用于生成条码）
  OldCurrent:=DBGridEh1.DataSource.DataSet.GetBookmark;
  DBGridEh1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGridEh1.SelectedRows.Count-1 do
  begin
    DBGridEh1.DataSource.DataSet.Bookmark:=DBGridEh1.SelectedRows[i];

    Req_Detail_ID:=DBGridEh1.DataSource.DataSet.fieldbyname('Req_Detail_ID').AsString;
    Req_Header_ID:=DBGridEh1.DataSource.DataSet.fieldbyname('Req_Header_ID').AsString;
    His_Item_No:=DBGridEh1.DataSource.DataSet.fieldbyname('项目代码').AsString;
    specimen_type:=DBGridEh1.DataSource.DataSet.fieldbyname('样本类型').AsString;
    
    patientname:=DBGridEh1.DataSource.DataSet.fieldbyname('姓名').AsString;
    sex:=DBGridEh1.DataSource.DataSet.fieldbyname('性别').AsString;
    age:=DBGridEh1.DataSource.DataSet.fieldbyname('年龄').AsString;
    ageunit:=DBGridEh1.DataSource.DataSet.fieldbyname('年龄单位').AsString;
    req_time:=FormatDatetime('YYYY-MM-DD HH:NN:SS',DBGridEh1.DataSource.DataSet.fieldbyname('申请时间').AsDateTime);
    req_dept:=DBGridEh1.DataSource.DataSet.fieldbyname('申请科室').AsString;
    req_doc:=DBGridEh1.DataSource.DataSet.fieldbyname('申请医生').AsString;
    his_item_name:=DBGridEh1.DataSource.DataSet.fieldbyname('项目名称').AsString;
    patient_type:=DBGridEh1.DataSource.DataSet.fieldbyname('患者类别').AsString;

    Friend_Req_Detail_ID:='';
    for j := 0 to Select_Req_Detail_ID_List.Count-1 do
    begin
      //表示从选中范围内找到自己的友军(自己除外)
      if(Select_Req_Detail_ID_List.Names[j]<>Req_Detail_ID)and(Select_Req_Detail_ID_List.ValueFromIndex[j]=Req_Header_ID) then
        Friend_Req_Detail_ID:=Friend_Req_Detail_ID+','+''''+Select_Req_Detail_ID_List.Names[j]+'''';
    end;
    delete(Friend_Req_Detail_ID,1,1);//删除第一个字符，即逗号
    if Friend_Req_Detail_ID<>'' then Friend_Req_Detail_ID:='('+Friend_Req_Detail_ID+')';

    MakeBarcode(Req_Detail_ID,Req_Header_ID,His_Item_No,Friend_Req_Detail_ID,specimen_type,patientname,sex,age,ageunit,req_time,req_dept,req_doc,his_item_name,patient_type);
  end;
  DBGridEh1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGridEh1.DataSource.DataSet.EnableControls;
  //Grid勾选记录判断方式二 end}

  Select_Req_Detail_ID_List.Free;

  //用于打印的数据集,条码相同的项目合并在一起 begin
  //姓名|性别|年龄|年龄单位|申请时间|申请科室|条码号|项目名称1,项目名称2...
  VirtualTable1.Close;
  VirtualTable1.SQL.Clear;
  VirtualTable1.SQL.Text:='SELECT '+
                          'MIN(patientname) AS 姓名,'+            //barcode分组中其中一个patientname
                          'MIN(sex) AS 性别,'+                    //barcode分组中其中一个sex
                          'MIN(age) AS 年龄,'+                    //barcode分组中其中一个age
                          'MIN(ageunit) AS 年龄单位,'+            //barcode分组中其中一个ageunit
                          'MIN(req_time) AS 申请时间,'+           //barcode分组中其中一个req_time
                          'MIN(req_dept) AS 申请科室,'+           //barcode分组中其中一个req_dept
                          'barcode as 条码号,'+
                          'STUFF( '+
                          '  (SELECT '','' + his_item_name '+
                          '   FROM make_barcode b2 '+
                          '   WHERE b2.barcode = b1.barcode '+
                          '   FOR XML PATH(''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), 1, 1, '''') AS 项目名称 '+
                          'FROM make_barcode b1 '+
                          'where barcode<>'' '+
                          'and req_detail_id in '+Select_Req_Detail_ID+
                          'GROUP BY barcode';
  VirtualTable1.Open;
  //用于打印的数据集,条码相同的项目合并在一起 end

  //打印 begin
  frxReport1.Clear;//清除报表模板
  if not frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'TubeLabels.fr3') then
  begin
    if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
    memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + '加载打印模板TubeLabels.fr3失败');
    exit;
  end;

  while not VirtualTable1.Eof do
  begin
    if RadioGroup2.ItemIndex=0 then  //预览模式
      begin frxReport1.PrintOptions.ShowDialog:=true;frxReport1.ShowReport; end
    else  //直接打印模式
    begin
      if frxReport1.PrepareReport then begin frxReport1.PrintOptions.ShowDialog:=false;frxReport1.Print;end;
    end;

    VirtualTable1.Next;
  end;
  //打印 end

  Screen.Cursor := Save_Cursor;  { Always restore to normal }
  
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
  memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':打印操作完成！');
end;

procedure TfrmMain.frxReport1GetValue(const VarName: String; var Value: Variant);
begin
  if VarName='申请科室' then Value:=VirtualTable1.fieldbyname('申请科室').AsString;
  if VarName='姓名' then Value:=VirtualTable1.fieldbyname('姓名').AsString;
  if VarName='性别' then Value:=VirtualTable1.fieldbyname('性别').AsString;
  if VarName='年龄' then Value:=VirtualTable1.fieldbyname('年龄').AsString;
  if VarName='年龄单位' then Value:=VirtualTable1.fieldbyname('年龄单位').AsString;
  if VarName='申请时间' then Value:=VirtualTable1.fieldbyname('申请时间').AsString;
  if VarName='项目名称' then Value:=VirtualTable1.fieldbyname('项目名称').AsString;
  if VarName='条码号' then Value:=VirtualTable1.fieldbyname('条码号').AsString;//设计期,设置条码对象的Expression属性为<条码号>
end;

procedure TfrmMain.MakeBarcode(const AReq_Detail_ID, AReq_Header_ID, AHis_Item_No, AFriend_Req_Detail_ID, ASpecimen_Type: String;const APatientname,ASex,AAge,AAgeunit,AReq_time,AReq_dept,AReq_doc,AHis_item_name,APatient_type:String);
var
  adotemp11,adotemp33,adotemp44,adotemp55,adotemp66:TAdoquery;

  defaultWorkGroup:String;//默认工作组
  defaultWorkGroup44:String;//默认工作组

  his_item_no:String;
  specimen_type:String;
  ExtSystemId:String;
  barcode:String;
begin
    //make_barcode:条码表
    //自已:req_detail_id
    //友军:同一患者(req_header_id)下的其他req_detail_id
    
    //条码表:将外部系统申请单视图复制到LIS，并补充条码字段
    ADOTemp66:=TADOQuery.Create(nil);
    ADOTemp66.Connection:=ADOConnection1;
    ADOTemp66.Close;
    ADOTemp66.SQL.Clear;
    ADOTemp66.SQL.Text:='select TOP 1 * from make_barcode where req_detail_id='''+AReq_Detail_ID+''' ';
    ADOTemp66.Open;
    barcode:=ADOTemp66.fieldbyname('barcode').AsString;
    if ADOTemp66.RecordCount<=0 then ExecSQLCmd(LisConn,'insert into make_barcode (req_detail_id,req_header_id,operator,patientname,sex,age,ageunit,req_time,req_dept,req_doc,his_item_no,his_item_name,specimen_type,patient_type) values ('''+AReq_Detail_ID+''','''+AReq_Header_ID+''','''+operator_name+''','''+APatientname+''','''+ASex+''','''+AAge+''','''+AAgeunit+''','''+AReq_time+''','''+AReq_dept+''','''+AReq_doc+''','''+AHis_Item_No+''','''+AHis_item_name+''','''+ASpecimen_Type+''','''+APatient_type+''')');
    ADOTemp66.Free;

    //情形1:自已已生成过条码
    if barcode<>'' then exit;

    //情形2:自己及友军均无条码,则自己做为条码且将自己写入make_barcode
    //经过情形1的判断,现在自己肯定无条码,故只用判断友军
    if(AFriend_Req_Detail_ID<>'')and('1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from make_barcode where req_detail_id in '+AFriend_Req_Detail_ID+' and barcode<>'''' ')) then
    begin                                                                                                                                                                                                                
      ExecSQLCmd(LisConn,'update make_barcode set barcode='''+AReq_Detail_ID+''' where req_detail_id='''+AReq_Detail_ID+''' ');
      exit;
    end; 

    //情形3:友军存在条码,且友军的工作组、样本类型与自己一样,则使用友军的条码,且将友军条码写入自己的条码
    if AFriend_Req_Detail_ID<>'' then
    begin
      //查询外部系统编码 begin
      ADOTemp55:=TADOQuery.Create(nil);
      ADOTemp55.Connection:=ADOConnection1;
      ADOTemp55.Close;
      ADOTemp55.SQL.Clear;
      ADOTemp55.SQL.Text:='select * from CommCode WITH(NOLOCK) where TypeName=''样本接收'' ';
      ADOTemp55.Open;
      while not ADOTemp55.Eof do
      begin
        if ADOTemp55.fieldbyname('id').AsString='外部系统编码' then ExtSystemId:=ADOTemp55.fieldbyname('Name').AsString;

        ADOTemp55.Next;
      end;
      ADOTemp55.Free;
      if ExtSystemId='' then ExtSystemId:='HIS';
      //查询外部系统编码 end

      //查询自己的工作组 begin
      ADOTemp11:=TADOQuery.Create(nil);
      ADOTemp11.Connection:=ADOConnection1;
      ADOTemp11.Close;
      ADOTemp11.SQL.Clear;
      ADOTemp11.SQL.Text:='select top 1 ci.dept_DfValue '+
                          'from combinitem ci,HisCombItem hci '+
                          'where ci.Unid=hci.CombUnid and hci.ExtSystemId='''+ExtSystemId+
                          ''' and hci.HisItem=:HisItem';
      ADOTemp11.Parameters.ParamByName('HisItem').Value:=AHis_Item_No;
      ADOTemp11.Open;
      defaultWorkGroup:=ADOTemp11.fieldbyname('dept_DfValue').AsString;
      ADOTemp11.Free;
      //查询自己的工作组 end

      //查询存在条码的友军(自身除外) begin
      adotemp33:=TADOQuery.Create(nil);
      adotemp33.Connection:=ADOConnection1;
      adotemp33.Close;
      adotemp33.SQL.Clear;
      adotemp33.SQL.Text:='select * from make_barcode where req_detail_id in '+AFriend_Req_Detail_ID+' and barcode<>'''' ';
      adotemp33.Open;
      while not adotemp33.Eof do
      begin
        his_item_no:=adotemp33.fieldbyname('his_item_no').AsString;
        specimen_type:=adotemp33.fieldbyname('specimen_type').AsString;

        adotemp44:=TADOQuery.Create(nil);
        adotemp44.Connection:=ADOConnection1;
        adotemp44.Close;
        adotemp44.SQL.Clear;
        adotemp44.SQL.Text:='select top 1 ci.dept_DfValue '+
                            'from combinitem ci,HisCombItem hci '+
                            'where ci.Unid=hci.CombUnid and hci.ExtSystemId='''+ExtSystemId+
                            ''' and hci.HisItem=:HisItem';
        adotemp44.Parameters.ParamByName('HisItem').Value:=his_item_no;
        adotemp44.Open;
        defaultWorkGroup44:=adotemp44.fieldbyname('dept_DfValue').AsString;
        adotemp44.Free;

        if(specimen_type=ASpecimen_Type)and(defaultWorkGroup=defaultWorkGroup44)and(defaultWorkGroup<>'')and(ASpecimen_Type<>'')then
        begin
          ExecSQLCmd(LisConn,'update make_barcode set barcode='''+adotemp33.fieldbyname('barcode').AsString+''' where req_detail_id='''+AReq_Detail_ID+''' ');
          exit;
        end;

        adotemp33.Next;
      end;
      adotemp33.Free;
      //查询存在于make_barcode中的友军(自身除外) end
    end;

    //情形4:上面的情况均没有条码,则自己做为条码且将自己写入make_barcode
    ExecSQLCmd(LisConn,'update make_barcode set barcode='''+AReq_Detail_ID+''' where req_detail_id='''+AReq_Detail_ID+''' ');
end;

end.
