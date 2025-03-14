unit UfrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBAccess, Uni, MemDS, Grids, DBGrids,
  Buttons, ADODB,IniFiles,StrUtils, VirtualTable,
  DosMove, Menus, ComCtrls, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, frxClass,
  frxBarcode, UniProvider, SQLServerUniProvider, MySQLUniProvider, OracleUniProvider;

//==Ϊ��ͨ��������Ϣ����������״̬��������==//
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
    //==Ϊ��ͨ��������Ϣ����������״̬��������==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS��Ϣ������}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//TextΪ�ø�ʽ#$2+'0:abc'+#$2+'1:def'��ʾ״̬����0����ʾabc,��1����ʾdef,��������
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
  LisConn:string;//Lis�����ַ���,MakeDBConn�����б���ֵ,Ȼ����QC.DLL��CalcItemPro.dll
  
implementation

uses UfrmRequestInfo, UfrmLogin;

{$R *.dfm}

procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunction.dll';
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//����
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
      WriteLog(pchar('������:'+operator_name+'������ExecSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL));
      MESSAGEDLG('����ExecSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0);
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
      WriteLog(pchar('������:'+operator_name+'������ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL));
      MESSAGEDLG('����ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0);
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
  ifIntegrated:boolean;//�Ƿ񼯳ɵ�¼ģʽ

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('����LIS���ݿ�', '������', '');
  initialcatalog := Ini.ReadString('����LIS���ݿ�', '���ݿ�', '');
  ifIntegrated:=ini.ReadBool('����LIS���ݿ�','���ɵ�¼ģʽ',false);
  userid := Ini.ReadString('����LIS���ݿ�', '�û�', '');
  password := Ini.ReadString('����LIS���ݿ�', '����', '107DFC967CDCFAAF');
  Ini.Free;
  //======����password
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
  //Persist Security Info,��ʾADO�����ݿ����ӳɹ����Ƿ񱣴�������Ϣ
  //ADOȱʡΪTrue,ADO.netȱʡΪFalse
  //�����лᴫADOConnection��Ϣ��TADOLYQuery,������ΪTrue
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
    ss:='������'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ݿ�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ɵ�¼ģʽ'+#2+'CheckListBox'+#2+#2+'0'+#2+'���ø�ģʽ,���û�������������д'+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('����LIS���ݿ�','����LIS���ݿ�',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
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
  ifMySQL:=ini.ReadBool('MySQL','����',false);
  ifOracle:=ini.ReadBool('Oracle','����',false);
  ifSQLServer:=ini.ReadBool('SQL Server','����',false);
  ServerMySQL := Ini.ReadString('MySQL', '������', '');
  ServerOracle := Ini.ReadString('Oracle', '������', '');
  ServerSQLServer := Ini.ReadString('SQL Server', '������', '');
  port := Ini.ReadInteger('MySQL', '�˿ں�', -1);
  icMySQL := Ini.ReadString('MySQL', '���ݿ�', '');
  icSQLServer := Ini.ReadString('SQL Server', '���ݿ�', '');
  ifIntegrated:=ini.ReadBool('SQL Server','���ɵ�¼ģʽ',false);
  uidMySQL := Ini.ReadString('MySQL', '�û�', '');
  uidOracle := Ini.ReadString('Oracle', '�û�', '');
  uidSQLServer := Ini.ReadString('SQL Server', '�û�', '');
  pwdMySQL := Ini.ReadString('MySQL', '����', '107DFC967CDCFAAF');
  pwdOracle := Ini.ReadString('Oracle', '����', '107DFC967CDCFAAF');
  pwdSQLServer := Ini.ReadString('SQL Server', '����', '107DFC967CDCFAAF');  
  Ini.Free;
  //======����password
  pInStr:=pchar(pwdMySQL);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(pwdMySQL,length(pDeStr));
  for i :=1  to length(pDeStr) do pwdMySQL[i]:=pDeStr[i-1];
  //==========
  //======����password
  pInStr:=pchar(pwdOracle);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(pwdOracle,length(pDeStr));
  for i :=1  to length(pDeStr) do pwdOracle[i]:=pDeStr[i-1];
  //==========
  //======����password
  pInStr:=pchar(pwdSQLServer);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(pwdSQLServer,length(pDeStr));
  for i :=1  to length(pDeStr) do pwdSQLServer[i]:=pDeStr[i-1];
  //==========

  newconnstr :='';
  if ifMySQL then
  begin
    //Provider NameΪMySQLʱ,�м����������ַ���(��Charset=GBK).����:select���ı�������;�ֶε�����ֵ��ʾ����
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
    //Provider NameΪOracleʱ,Server���Ը�ʽ:Host IP:Port:SID,��10.195.252.13:1521:kthis1
    //Oracle��Ĭ��PortΪ1521
    //��ѯOracle SID:select instance_name from V$instance;
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
    //Persist Security Info,��ʾADO�����ݿ����ӳɹ����Ƿ񱣴�������Ϣ
    //ADOȱʡΪTrue,ADO.netȱʡΪFalse
    //�����лᴫADOConnection��Ϣ��TADOLYQuery,������ΪTrue
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
    ss:='����'+#2+'CheckListBox'+#2+#2+'0'+#2+'֧��5.7����ǰ�汾,8.0���Ժ�汾�ķ��������������'+#2+#3+
        '������'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '�˿ں�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ݿ�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'0'+#2+#2+'1'+#3+
        '����'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
        '������'+#2+'Edit'+#2+#2+'1'+#2+'��ʽ��Host IP:Port:SID��'+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'1'+#2+#2+'1'+#3+
        '����'+#2+'CheckListBox'+#2+#2+'2'+#2+#2+#3+
        '������'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
        '���ݿ�'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
        '���ɵ�¼ģʽ'+#2+'CheckListBox'+#2+#2+'2'+#2+'���ø�ģʽ,���û�������������д'+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'2'+#2+#2+'1';
    if ShowOptionForm('�����ⲿϵͳ���ݿ�','MySQL'+#2+'Oracle'+#2+'SQL Server',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteInteger('Interface','selBRLB',RadioGroup1.ItemIndex);{��¼��������ѡ��}
  configini.WriteInteger('Interface','ifPreview',RadioGroup2.ItemIndex);{��¼�Ƿ��ӡԤ��ģʽ}

  configini.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  configini:tinifile;
begin
  frmLogin.ShowModal;

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  RadioGroup1.ItemIndex:=configini.ReadInteger('Interface','selBRLB',0);{��¼��������ѡ��}
  RadioGroup2.ItemIndex:=configini.ReadInteger('Interface','ifPreview',0);{��¼��ӡԤ����ֱ�Ӵ�ӡ}

  configini.Free;

  DateTimePicker1.Date:=Date-7;
  DateTimePicker2.Date:=Date;
end;

procedure TfrmMain.updatestatusBar(const text: string);
//TextΪ�ø�ʽ#$2+'0:abc'+#$2+'1:def'��ʾ״̬����0����ʾabc,��1����ʾdef,��������
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
  if RadioGroup1.ItemIndex=1 then patient_type:=' and patient_type=''����'' ';
  if RadioGroup1.ItemIndex=2 then patient_type:=' and patient_type=''סԺ'' ';

  UniQuery1.Close;
  UniQuery1.SQL.Clear;
  UniQuery1.SQL.Text:='select req_header_id,patientname as ����,sex as �Ա�,age as ����,ageunit as ���䵥λ,req_time as ����ʱ��,req_dept as �������,req_doc as ����ҽ��,patient_type as �������,'+
                      ' req_detail_id,his_item_no as ��Ŀ����,his_item_name as ��Ŀ����,specimen_type as �������� '+
                      ' from view_test_request where req_time between :DateTimePicker1 and :DateTimePicker2 '+patientname+req_dept+patient_type+' order by req_time desc,req_header_id';
  UniQuery1.ParamByName('DateTimePicker1').Value:=DateTimePicker1.DateTime;//�����Time����Ϊ00:00:00.����,����ѡ������ʱ����ı�Timeֵ
  UniQuery1.ParamByName('DateTimePicker2').Value:=DateTimePicker2.DateTime;//�����Time����Ϊ23:59:59.����,����ѡ������ʱ����ı�Timeֵ
  UniQuery1.Open;
end;

procedure TfrmMain.UniQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  
  DBGridEh1.Columns.Items[0].Width:=110;//req_header_id
  DBGridEh1.Columns.Items[1].Width:=42;//����
  DBGridEh1.Columns.Items[2].Width:=30;//�Ա�
  DBGridEh1.Columns.Items[3].Width:=30;//����
  DBGridEh1.Columns.Items[4].Width:=30;//���䵥λ
  DBGridEh1.Columns.Items[5].Width:=135;//����ʱ��
  DBGridEh1.Columns.Items[6].Width:=60;//��������
  DBGridEh1.Columns.Items[7].Width:=60;//����ҽ��
  DBGridEh1.Columns.Items[8].Width:=60;//�������
  DBGridEh1.Columns.Items[9].Width:=95;//req_detail_id
  DBGridEh1.Columns.Items[10].Width:=60;//��Ŀ����
  DBGridEh1.Columns.Items[11].Width:=60;//��Ŀ����
  DBGridEh1.Columns.Items[12].Width:=60;//��������
end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
var
  i,j:integer;

  Save_Cursor:TCursor;
  OldCurrent:TBookmark;

  Req_Detail_ID, Req_Header_ID, His_Item_No, specimen_type:String;
  patientname,sex,age,ageunit,req_time,req_dept,req_doc,his_item_name,patient_type:String;

  Select_Req_Detail_ID_List:TStrings;
  Select_Req_Detail_ID:String;//��ʽ��('0001','0002','0003'),����ƴ��SQL
  Friend_Req_Detail_ID:String;//�Ѿ�.��ʽ��('0001','0002','0003'),����ƴ��SQL
begin
  if not UniQuery1.Active then exit;
  if UniQuery1.RecordCount=0 then exit;

  if DBGridEh1.SelectedRows.Count<=0 then exit;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  Select_Req_Detail_ID:='';
  Select_Req_Detail_ID_List:=TStringList.Create;

  //Grid��ѡ��¼�жϷ�ʽ�� begin
  //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼����ѭ���������ɡ�ѡ���Req_Detail_ID�б�,�������뼰��ӡ��Ŀ���ڴ˷�Χ�ڣ�
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
  memo1.Lines.Add(DateTimeToStr(now) + ':������������......');
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
  //Grid��ѡ��¼�жϷ�ʽ�� end}
  
  delete(Select_Req_Detail_ID,1,1);//ɾ����һ���ַ���������
  if Select_Req_Detail_ID<>'' then Select_Req_Detail_ID:='('+Select_Req_Detail_ID+')';

  //Grid��ѡ��¼�жϷ�ʽ�� begin
  //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼����ѭ�������������룩
  OldCurrent:=DBGridEh1.DataSource.DataSet.GetBookmark;
  DBGridEh1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGridEh1.SelectedRows.Count-1 do
  begin
    DBGridEh1.DataSource.DataSet.Bookmark:=DBGridEh1.SelectedRows[i];

    Req_Detail_ID:=DBGridEh1.DataSource.DataSet.fieldbyname('Req_Detail_ID').AsString;
    Req_Header_ID:=DBGridEh1.DataSource.DataSet.fieldbyname('Req_Header_ID').AsString;
    His_Item_No:=DBGridEh1.DataSource.DataSet.fieldbyname('��Ŀ����').AsString;
    specimen_type:=DBGridEh1.DataSource.DataSet.fieldbyname('��������').AsString;
    
    patientname:=DBGridEh1.DataSource.DataSet.fieldbyname('����').AsString;
    sex:=DBGridEh1.DataSource.DataSet.fieldbyname('�Ա�').AsString;
    age:=DBGridEh1.DataSource.DataSet.fieldbyname('����').AsString;
    ageunit:=DBGridEh1.DataSource.DataSet.fieldbyname('���䵥λ').AsString;
    req_time:=FormatDatetime('YYYY-MM-DD HH:NN:SS',DBGridEh1.DataSource.DataSet.fieldbyname('����ʱ��').AsDateTime);
    req_dept:=DBGridEh1.DataSource.DataSet.fieldbyname('�������').AsString;
    req_doc:=DBGridEh1.DataSource.DataSet.fieldbyname('����ҽ��').AsString;
    his_item_name:=DBGridEh1.DataSource.DataSet.fieldbyname('��Ŀ����').AsString;
    patient_type:=DBGridEh1.DataSource.DataSet.fieldbyname('�������').AsString;

    Friend_Req_Detail_ID:='';
    for j := 0 to Select_Req_Detail_ID_List.Count-1 do
    begin
      //��ʾ��ѡ�з�Χ���ҵ��Լ����Ѿ�(�Լ�����)
      if(Select_Req_Detail_ID_List.Names[j]<>Req_Detail_ID)and(Select_Req_Detail_ID_List.ValueFromIndex[j]=Req_Header_ID) then
        Friend_Req_Detail_ID:=Friend_Req_Detail_ID+','+''''+Select_Req_Detail_ID_List.Names[j]+'''';
    end;
    delete(Friend_Req_Detail_ID,1,1);//ɾ����һ���ַ���������
    if Friend_Req_Detail_ID<>'' then Friend_Req_Detail_ID:='('+Friend_Req_Detail_ID+')';

    MakeBarcode(Req_Detail_ID,Req_Header_ID,His_Item_No,Friend_Req_Detail_ID,specimen_type,patientname,sex,age,ageunit,req_time,req_dept,req_doc,his_item_name,patient_type);
  end;
  DBGridEh1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGridEh1.DataSource.DataSet.EnableControls;
  //Grid��ѡ��¼�жϷ�ʽ�� end}

  Select_Req_Detail_ID_List.Free;

  //���ڴ�ӡ�����ݼ�,������ͬ����Ŀ�ϲ���һ�� begin
  //����|�Ա�|����|���䵥λ|����ʱ��|�������|�����|��Ŀ����1,��Ŀ����2...
  VirtualTable1.Close;
  VirtualTable1.SQL.Clear;
  VirtualTable1.SQL.Text:='SELECT '+
                          'MIN(patientname) AS ����,'+            //barcode����������һ��patientname
                          'MIN(sex) AS �Ա�,'+                    //barcode����������һ��sex
                          'MIN(age) AS ����,'+                    //barcode����������һ��age
                          'MIN(ageunit) AS ���䵥λ,'+            //barcode����������һ��ageunit
                          'MIN(req_time) AS ����ʱ��,'+           //barcode����������һ��req_time
                          'MIN(req_dept) AS �������,'+           //barcode����������һ��req_dept
                          'barcode as �����,'+
                          'STUFF( '+
                          '  (SELECT '','' + his_item_name '+
                          '   FROM make_barcode b2 '+
                          '   WHERE b2.barcode = b1.barcode '+
                          '   FOR XML PATH(''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), 1, 1, '''') AS ��Ŀ���� '+
                          'FROM make_barcode b1 '+
                          'where barcode<>'' '+
                          'and req_detail_id in '+Select_Req_Detail_ID+
                          'GROUP BY barcode';
  VirtualTable1.Open;
  //���ڴ�ӡ�����ݼ�,������ͬ����Ŀ�ϲ���һ�� end

  //��ӡ begin
  frxReport1.Clear;//�������ģ��
  if not frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'TubeLabels.fr3') then
  begin
    if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
    memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + '���ش�ӡģ��TubeLabels.fr3ʧ��');
    exit;
  end;

  while not VirtualTable1.Eof do
  begin
    if RadioGroup2.ItemIndex=0 then  //Ԥ��ģʽ
      begin frxReport1.PrintOptions.ShowDialog:=true;frxReport1.ShowReport; end
    else  //ֱ�Ӵ�ӡģʽ
    begin
      if frxReport1.PrepareReport then begin frxReport1.PrintOptions.ShowDialog:=false;frxReport1.Print;end;
    end;

    VirtualTable1.Next;
  end;
  //��ӡ end

  Screen.Cursor := Save_Cursor;  { Always restore to normal }
  
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
  memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':��ӡ������ɣ�');
end;

procedure TfrmMain.frxReport1GetValue(const VarName: String; var Value: Variant);
begin
  if VarName='�������' then Value:=VirtualTable1.fieldbyname('�������').AsString;
  if VarName='����' then Value:=VirtualTable1.fieldbyname('����').AsString;
  if VarName='�Ա�' then Value:=VirtualTable1.fieldbyname('�Ա�').AsString;
  if VarName='����' then Value:=VirtualTable1.fieldbyname('����').AsString;
  if VarName='���䵥λ' then Value:=VirtualTable1.fieldbyname('���䵥λ').AsString;
  if VarName='����ʱ��' then Value:=VirtualTable1.fieldbyname('����ʱ��').AsString;
  if VarName='��Ŀ����' then Value:=VirtualTable1.fieldbyname('��Ŀ����').AsString;
  if VarName='�����' then Value:=VirtualTable1.fieldbyname('�����').AsString;//�����,������������Expression����Ϊ<�����>
end;

procedure TfrmMain.MakeBarcode(const AReq_Detail_ID, AReq_Header_ID, AHis_Item_No, AFriend_Req_Detail_ID, ASpecimen_Type: String;const APatientname,ASex,AAge,AAgeunit,AReq_time,AReq_dept,AReq_doc,AHis_item_name,APatient_type:String);
var
  adotemp11,adotemp33,adotemp44,adotemp55,adotemp66:TAdoquery;

  defaultWorkGroup:String;//Ĭ�Ϲ�����
  defaultWorkGroup44:String;//Ĭ�Ϲ�����

  his_item_no:String;
  specimen_type:String;
  ExtSystemId:String;
  barcode:String;
begin
    //make_barcode:�����
    //����:req_detail_id
    //�Ѿ�:ͬһ����(req_header_id)�µ�����req_detail_id
    
    //�����:���ⲿϵͳ���뵥��ͼ���Ƶ�LIS�������������ֶ�
    ADOTemp66:=TADOQuery.Create(nil);
    ADOTemp66.Connection:=ADOConnection1;
    ADOTemp66.Close;
    ADOTemp66.SQL.Clear;
    ADOTemp66.SQL.Text:='select TOP 1 * from make_barcode where req_detail_id='''+AReq_Detail_ID+''' ';
    ADOTemp66.Open;
    barcode:=ADOTemp66.fieldbyname('barcode').AsString;
    if ADOTemp66.RecordCount<=0 then ExecSQLCmd(LisConn,'insert into make_barcode (req_detail_id,req_header_id,operator,patientname,sex,age,ageunit,req_time,req_dept,req_doc,his_item_no,his_item_name,specimen_type,patient_type) values ('''+AReq_Detail_ID+''','''+AReq_Header_ID+''','''+operator_name+''','''+APatientname+''','''+ASex+''','''+AAge+''','''+AAgeunit+''','''+AReq_time+''','''+AReq_dept+''','''+AReq_doc+''','''+AHis_Item_No+''','''+AHis_item_name+''','''+ASpecimen_Type+''','''+APatient_type+''')');
    ADOTemp66.Free;

    //����1:���������ɹ�����
    if barcode<>'' then exit;

    //����2:�Լ����Ѿ���������,���Լ���Ϊ�����ҽ��Լ�д��make_barcode
    //��������1���ж�,�����Լ��϶�������,��ֻ���ж��Ѿ�
    if(AFriend_Req_Detail_ID<>'')and('1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from make_barcode where req_detail_id in '+AFriend_Req_Detail_ID+' and barcode<>'''' ')) then
    begin                                                                                                                                                                                                                
      ExecSQLCmd(LisConn,'update make_barcode set barcode='''+AReq_Detail_ID+''' where req_detail_id='''+AReq_Detail_ID+''' ');
      exit;
    end; 

    //����3:�Ѿ���������,���Ѿ��Ĺ����顢�����������Լ�һ��,��ʹ���Ѿ�������,�ҽ��Ѿ�����д���Լ�������
    if AFriend_Req_Detail_ID<>'' then
    begin
      //��ѯ�ⲿϵͳ���� begin
      ADOTemp55:=TADOQuery.Create(nil);
      ADOTemp55.Connection:=ADOConnection1;
      ADOTemp55.Close;
      ADOTemp55.SQL.Clear;
      ADOTemp55.SQL.Text:='select * from CommCode WITH(NOLOCK) where TypeName=''��������'' ';
      ADOTemp55.Open;
      while not ADOTemp55.Eof do
      begin
        if ADOTemp55.fieldbyname('id').AsString='�ⲿϵͳ����' then ExtSystemId:=ADOTemp55.fieldbyname('Name').AsString;

        ADOTemp55.Next;
      end;
      ADOTemp55.Free;
      if ExtSystemId='' then ExtSystemId:='HIS';
      //��ѯ�ⲿϵͳ���� end

      //��ѯ�Լ��Ĺ����� begin
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
      //��ѯ�Լ��Ĺ����� end

      //��ѯ����������Ѿ�(�������) begin
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
      //��ѯ������make_barcode�е��Ѿ�(�������) end
    end;

    //����4:����������û������,���Լ���Ϊ�����ҽ��Լ�д��make_barcode
    ExecSQLCmd(LisConn,'update make_barcode set barcode='''+AReq_Detail_ID+''' where req_detail_id='''+AReq_Detail_ID+''' ');
end;

end.
