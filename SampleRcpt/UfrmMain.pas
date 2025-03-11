unit UfrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBAccess,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, ADODB, ActnList,
  MemDS, VirtualTable, Grids, DBGrids, ComCtrls, Buttons, GridsEh,
  DBAxisGridsEh, DBGridEh, IniFiles,StrUtils, DBGridEhGrouping,
  Uni, UniProvider, MySQLUniProvider, SQLServerUniProvider, OracleUniProvider;

//==Ϊ��ͨ��������Ϣ����������״̬��������==//
const
  WM_UPDATETEXTSTATUS=WM_USER+1;
TYPE
  TWMUpdateTextStatus=TWMSetText;
//=========================================//

type
  TfrmMain = class(TForm)
    ADOConnection1: TADOConnection;
    GroupBox1: TGroupBox;
    DataSource1: TDataSource;
    VirtualTable1: TVirtualTable;
    Panel3: TPanel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    Panel4: TPanel;
    Label1: TLabel;
    ActionList1: TActionList;
    Action1: TAction;
    LabeledEdit9: TLabeledEdit;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    DBGrid1: TDBGridEh;
    UniConnExtSystem: TUniConnection;
    Edit2: TEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    DataSource2: TDataSource;
    ADOQuery2: TADOQuery;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    CheckBox1: TCheckBox;
    SpeedButton2: TSpeedButton;
    LabeledEdit6: TLabeledEdit;
    BitBtn1: TSpeedButton;
    procedure LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure VirtualTable1AfterOpen(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOQuery2AfterOpen(DataSet: TDataSet);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    function MakeExtSystemDBConn:boolean;
    function MakeAdoDBConn:boolean;
    procedure SingleRequestForm2Lis(const WorkGroup,His_Unid,patientname,sex,age,age_unit,deptname,check_doctor,RequestDate:String;const ABarcode,Surem1,checkid,SampleType,pkcombin_id,His_MzOrZy,PullPress:String);
    //==Ϊ��ͨ��������Ϣ����������״̬��������==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS��Ϣ������}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//TextΪ�ø�ʽ#$2+'0:abc'+#$2+'1:def'��ʾ״̬����0����ʾabc,��1����ʾdef,��������
    //==========================================//
    procedure UpdateImportedReq(const AWorkGroup:String);//��ʾ�ѵ��������
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

  operator_name:string;
  operator_id:string;
  LisConn:string;//Lis�����ַ���,MakeDBConn�����б���ֵ,Ȼ����QC.DLL��CalcItemPro.dll

  function ScalarSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):string;

implementation

uses superobject, UfrmRequestInfo, UfrmLogin;

{$R *.dfm}

procedure RequestForm2Lis(const AAdoconnstr,ARequestJSON,CurrentWorkGroup:PChar);stdcall;external 'Request2Lis.dll';
procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunction.dll';
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//����
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';
function GetMaxCheckID(const AWorkGroup,APreDate,APreCheckID:PChar):PChar;stdcall;external 'LYFunction.dll';

const
  CryptStr='lc';

procedure LoadGroupName(const comboBox:TcomboBox;const ASel:string);
var
  adotemp3:tadoquery;
  tempstr:string;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=frmMain.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=ASel;
     adotemp3.Open;
     
     comboBox.Items.Clear;//����ǰ�����comboBox��

     while not adotemp3.Eof do
     begin
      tempstr:=trim(adotemp3.Fields[0].AsString);

      comboBox.Items.Add(tempstr); //���ص�comboBox

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

function ScalarSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):string;
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
      if AErrorDlg then MESSAGEDLG('����ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0)
        else WriteLog(pchar('������:'+operator_name+'������ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL));
      Qry.Free;
      Conn.Free;
      exit;
    end;
  end;
  Result:=Qry.Fields[0].AsString;
  Qry.Free;
  Conn.Free;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
var
  ss:String;
begin
  ss:='ϵͳ����->ͨ�ô���->��������'+
      #$D+'�ⲿϵͳ���룺Ĭ��ֵHIS,һ��ΪHIS/PEIS,Ӧ��LIS��Ŀ����һ��'+
      #$D+'��ͼ���ƣ�Ĭ��ֵview_test_request'+
      #$D+'��Ŀ���գ�Ĭ��ֵ[��],[��]��ʾHIS��LIS��Ŀ����һ��,LIS������Ŀ����'+
      #$D+
      #$D+'��ͼ�ֶ����£�'+
      #$D+'�����(*)��barcode'+
      #$D+'����������patientname'+
      #$D+'�����Ա�sex'+
      #$D+'�������䣺age'+
      #$D+'���䵥λ��ageunit'+
      #$D+'����ʱ�䣺req_time'+
      #$D+'�������ң�req_dept'+
      #$D+'����ҽ����req_doc'+
      #$D+'HIS���������Ŀ����(*)��his_item_no'+
      #$D+'HIS���������Ŀ���ƣ�his_item_name'+
      #$D+'�������ͣ�specimen_type'+
      #$D+'�������patient_type'+
      #$D+'�ⲿϵͳΨһ���(��ѡ)��req_header_id'+
      #$D+'�ⲿϵͳ��Ŀ������(��ѡ)��req_detail_id';
  MessageDlg(ss,mtInformation,[mbok],0);
end;

procedure TfrmMain.LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADOTemp22,ADOTemp33:TADOQuery;
  UniQryTemp11:TUniQuery;
  i,j:Integer;
  ini:TIniFile;
  PreWorkGroup:String;//�ñ�������:�����湤�����һ����¼��������
  PreDate,PreCheckID:String;
  OldCurrent:TBookmark;

  ExtSystemId:String;
  ViewName:String;
  ifItemCompare:String;
  RowsSQL1,RowsSQL2:String;

  dept_DfValue:String;
begin
  if key<>13 then exit;

  if trim((Sender as TLabeledEdit).Text)='' then exit;

  ExtSystemId:='HIS';
  ViewName:='view_test_request';
  
  ADOTemp22:=TADOQuery.Create(nil);
  ADOTemp22.Connection:=ADOConnection1;
  ADOTemp22.Close;
  ADOTemp22.SQL.Clear;
  ADOTemp22.SQL.Text:='select * from CommCode WITH(NOLOCK) where TypeName=''��������'' ';
  ADOTemp22.Open;
  while not ADOTemp22.Eof do
  begin
    if ADOTemp22.fieldbyname('id').AsString='�ⲿϵͳ����' then ExtSystemId:=ADOTemp22.fieldbyname('Name').AsString;
    if ADOTemp22.fieldbyname('id').AsString='��ͼ����' then ViewName:=ADOTemp22.fieldbyname('Name').AsString;
    if ADOTemp22.fieldbyname('id').AsString='��Ŀ����' then ifItemCompare:=ADOTemp22.fieldbyname('Name').AsString;
  
    ADOTemp22.Next;
  end;
  ADOTemp22.Free;

  if SameText(UniConnExtSystem.ProviderName,'MySQL') then
  begin
    RowsSQL1:='';
    RowsSQL2:=' LIMIT 100 ';
  end;
  if SameText(UniConnExtSystem.ProviderName,'Oracle') then
  begin
    RowsSQL1:='';
    RowsSQL2:=' and ROWNUM<100 ';
  end;
  if SameText(UniConnExtSystem.ProviderName,'SQL Server') then
  begin
    RowsSQL1:=' TOP 100 ';
    RowsSQL2:='';
  end;

  PreWorkGroup:='��һ��������';//��ʼ��Ϊʵ����������ܳ��ֵĹ��������Ƽ���

  (Sender as TLabeledEdit).Enabled:=false;//Ϊ�˷�ֹû��������ɨ����һ������

  UniQryTemp11:=TUniQuery.Create(nil);
  UniQryTemp11.Connection:=UniConnExtSystem;
  UniQryTemp11.Close;
  UniQryTemp11.SQL.Clear;
  UniQryTemp11.SQL.Text:='select '+RowsSQL1+' * from '+ViewName+' where barcode=:barcode '+RowsSQL2;;
  UniQryTemp11.ParamByName('barcode').Value:=(Sender as TLabeledEdit).Text;
  UniQryTemp11.Open;

  (Sender as TLabeledEdit).Clear;

  LabeledEdit7.Text:=UniQryTemp11.fieldbyname('barcode').AsString;
  if UniQryTemp11.FieldList.IndexOf('patientname')>=0 then LabeledEdit2.Text:=UniQryTemp11.fieldbyname('patientname').AsString;
  if UniQryTemp11.FieldList.IndexOf('name')>=0        then LabeledEdit2.Text:=UniQryTemp11.fieldbyname('name').AsString;//��������PEIS 
  LabeledEdit3.Text:=UniQryTemp11.fieldbyname('sex').AsString;
  LabeledEdit4.Text:=UniQryTemp11.fieldbyname('age').AsString;
  if UniQryTemp11.FieldList.IndexOf('ageunit')>=0  then Edit2.Text:=UniQryTemp11.fieldbyname('ageunit').AsString;
  if UniQryTemp11.FieldList.IndexOf('age_unit')>=0 then Edit2.Text:=UniQryTemp11.fieldbyname('age_unit').AsString;//��������PEIS
  if UniQryTemp11.FieldList.IndexOf('patient_type')>=0 then LabeledEdit9.Text:=UniQryTemp11.fieldbyname('patient_type').AsString;//��������PEIS,����PEIS�޴��ֶ�
  if UniQryTemp11.FieldList.IndexOf('req_dept')>=0 then LabeledEdit8.Text:=UniQryTemp11.fieldbyname('req_dept').AsString;
  if UniQryTemp11.FieldList.IndexOf('reqdept')>=0  then LabeledEdit8.Text:=UniQryTemp11.fieldbyname('reqdept').AsString;//��������PEIS
  if UniQryTemp11.FieldList.IndexOf('req_doc')>=0    then LabeledEdit10.Text:=UniQryTemp11.fieldbyname('req_doc').AsString;
  if UniQryTemp11.FieldList.IndexOf('write_name')>=0 then LabeledEdit10.Text:=UniQryTemp11.fieldbyname('write_name').AsString;//��������PEIS
  if UniQryTemp11.FieldList.IndexOf('req_time')>=0 then LabeledEdit11.Text:=FormatDateTime('yyyy-mm-dd hh:nn:ss',UniQryTemp11.fieldbyname('req_time').AsDateTime);
  if UniQryTemp11.FieldList.IndexOf('write_time')>=0    then LabeledEdit11.Text:=FormatDateTime('yyyy-mm-dd hh:nn:ss',UniQryTemp11.fieldbyname('write_time').AsDateTime);//��������PEIS
  if UniQryTemp11.FieldList.IndexOf('specimen_type')>=0 then LabeledEdit5.Text:=UniQryTemp11.fieldbyname('specimen_type').AsString;
  if UniQryTemp11.FieldList.IndexOf('SPEC_TYPE')>=0     then LabeledEdit5.Text:=UniQryTemp11.fieldbyname('SPEC_TYPE').AsString;//��������PEIS
  if UniQryTemp11.FieldList.IndexOf('req_header_id')>=0 then LabeledEdit6.Text:=UniQryTemp11.fieldbyname('req_header_id').AsString;
  if UniQryTemp11.FieldList.IndexOf('REG_ID')>=0        then LabeledEdit6.Text:=UniQryTemp11.fieldbyname('REG_ID').AsString;//��������PEIS�����ţ�

  VirtualTable1.Clear;
  for i:=0 to (DBGrid1.columns.count-1) do DBGrid1.columns[i].readonly:=False;

  while not UniQryTemp11.Eof do
  begin
    if '��'=ifItemCompare then//�ⲿϵͳ���뵥��HIS�����Ŀ������LIS�����Ŀ����һ�£���LIS������Ŀ����
    begin
      //�繤����Ϊ��,ini.ReadString����ntdll.dll,�Ҳ���������Ա�Ҳ���������Ϣ������
      dept_DfValue:=trim(ScalarSQLCmd(LisConn,'select TOP 1 dept_DfValue from combinitem where Id='''+UniQryTemp11.fieldbyname('his_item_no').AsString+''' '));
      if ''=dept_DfValue then
      begin
        Memo1.Lines.Add(DateTimeToStr(now)+':'+UniQryTemp11.FieldByName('his_item_no').AsString+'��'+UniQryTemp11.FieldByName('his_item_name').AsString+'����LIS�в�����,��δ����Ĭ�Ϲ�����');
        UniQryTemp11.Next;
        continue;
      end;
      
      ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
      PreDate:=ini.ReadString(dept_DfValue,'�������','');
      PreCheckID:=ini.ReadString(dept_DfValue,'������','');
      ini.Free;

      VirtualTable1.Append;
      if UniQryTemp11.FieldList.IndexOf('req_detail_id')>=0 then VirtualTable1.FieldByName('�ⲿϵͳ��Ŀ������').AsString:=UniQryTemp11.FieldByName('req_detail_id').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then VirtualTable1.FieldByName('HIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('his_item_no').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_name')>=0 then VirtualTable1.FieldByName('HIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('his_item_name').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then VirtualTable1.FieldByName('LIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('his_item_no').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_name')>=0 then VirtualTable1.FieldByName('LIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('his_item_name').AsString;
      VirtualTable1.FieldByName('������').AsString:=dept_DfValue;
      VirtualTable1.FieldByName('������').AsString:=GetMaxCheckId(PChar(dept_DfValue),PChar(PreDate),PChar(PreCheckID));
      VirtualTable1.Post;
    end else
    begin//�ⲿϵͳ���뵥��HIS�����Ŀ������LIS�����Ŀ���벻һ�£�LIS��Ҫ��Ŀ���յ����
      ADOTemp33:=TADOQuery.Create(nil);
      ADOTemp33.Connection:=ADOConnection1;
      ADOTemp33.Close;
      ADOTemp33.SQL.Clear;
      ADOTemp33.SQL.Text:='select ci.Id,ci.Name,ci.dept_DfValue '+
                          'from combinitem ci,HisCombItem hci '+
                          'where ci.Unid=hci.CombUnid and hci.ExtSystemId='''+ExtSystemId+
                          ''' and hci.HisItem=:HisItem';
      if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then ADOTemp33.Parameters.ParamByName('HisItem').Value:=UniQryTemp11.fieldbyname('his_item_no').AsString;
      if UniQryTemp11.FieldList.IndexOf('order_id')>=0    then ADOTemp33.Parameters.ParamByName('HisItem').Value:=UniQryTemp11.fieldbyname('order_id').AsString;//��������PEIS
      ADOTemp33.Open;

      //LIS��û�����Ӧ����Ŀ
      if ADOTemp33.RecordCount<=0 then
      begin
        if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then Memo1.Lines.Add(DateTimeToStr(now)+':'+UniQryTemp11.fieldbyname('his_item_no').AsString+'��'+UniQryTemp11.fieldbyname('his_item_name').AsString+'����LIS��û�ж���');
        if UniQryTemp11.FieldList.IndexOf('order_id')>=0    then Memo1.Lines.Add(DateTimeToStr(now)+':'+UniQryTemp11.fieldbyname('order_id').AsString+'��'+UniQryTemp11.fieldbyname('ITEMNAME').AsString+'����LIS��û�ж���');//��������PEIS 
      end;

      while not ADOTemp33.Eof do
      begin
        //�繤����Ϊ��,ini.ReadString����ntdll.dll,�Ҳ���������Ա�Ҳ���������Ϣ������
        if trim(ADOTemp33.FieldByName('dept_DfValue').AsString)='' then
        begin
          Memo1.Lines.Add(DateTimeToStr(now)+':'+ADOTemp33.FieldByName('Id').AsString+'��'+ADOTemp33.FieldByName('Name').AsString+'��δ����Ĭ�Ϲ�����');
          ADOTemp33.Next;
          continue;
        end;

        ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
        PreDate:=ini.ReadString(ADOTemp33.FieldByName('dept_DfValue').AsString,'�������','');
        PreCheckID:=ini.ReadString(ADOTemp33.FieldByName('dept_DfValue').AsString,'������','');
        ini.Free;

        VirtualTable1.Append;
        if UniQryTemp11.FieldList.IndexOf('req_detail_id')>=0 then VirtualTable1.FieldByName('�ⲿϵͳ��Ŀ������').AsString:=UniQryTemp11.FieldByName('req_detail_id').AsString;
        if UniQryTemp11.FieldList.IndexOf('REQUEST_NO')>=0    then VirtualTable1.FieldByName('�ⲿϵͳ��Ŀ������').AsString:=UniQryTemp11.FieldByName('REQUEST_NO').AsString;//��������PEIS
        if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then VirtualTable1.FieldByName('HIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('his_item_no').AsString;
        if UniQryTemp11.FieldList.IndexOf('order_id')>=0    then VirtualTable1.FieldByName('HIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('order_id').AsString;//��������PEIS
        if UniQryTemp11.FieldList.IndexOf('his_item_name')>=0 then VirtualTable1.FieldByName('HIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('his_item_name').AsString;
        if UniQryTemp11.FieldList.IndexOf('ITEMNAME')>=0      then VirtualTable1.FieldByName('HIS��Ŀ����').AsString:=UniQryTemp11.FieldByName('ITEMNAME').AsString;//��������PEIS
        VirtualTable1.FieldByName('LIS��Ŀ����').AsString:=ADOTemp33.FieldByName('Id').AsString;
        VirtualTable1.FieldByName('LIS��Ŀ����').AsString:=ADOTemp33.FieldByName('Name').AsString;
        VirtualTable1.FieldByName('������').AsString:=ADOTemp33.FieldByName('dept_DfValue').AsString;
        VirtualTable1.FieldByName('������').AsString:=GetMaxCheckId(PChar(ADOTemp33.FieldByName('dept_DfValue').AsString),PChar(PreDate),PChar(PreCheckID));
        VirtualTable1.Post;

        ADOTemp33.Next;
      end;
      ADOTemp33.Free;
    end;
    
    UniQryTemp11.Next;
  end;
  UniQryTemp11.Free;

  for i:=0 to (DBGrid1.columns.count-2) do DBGrid1.columns[i].readonly:=True;//���������1��(������)�ɱ༭

  //Gridȫѡ��ʽ�� begin
  DBGrid1.Selection.Rows.SelectAll;
  //Gridȫѡ��ʽ�� end

  if CheckBox1.Checked then
  begin
    //Grid��ѡ��¼�жϷ�ʽ�� begin
    //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼
    OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
    DBGrid1.DataSource.DataSet.DisableControls;
    for j:=0 to DBGrid1.SelectedRows.Count-1 do
    begin
      DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[j];
      
      SingleRequestForm2Lis(
        DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,
        LabeledEdit6.Text,
        LabeledEdit2.Text,
        LabeledEdit3.Text,
        LabeledEdit4.Text,
        Edit2.Text,
        LabeledEdit8.Text,
        LabeledEdit10.Text,
        LabeledEdit11.Text,
        LabeledEdit7.Text,
        DBGrid1.DataSource.DataSet.fieldbyname('�ⲿϵͳ��Ŀ������').AsString,
        DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,
        LabeledEdit5.Text,
        DBGrid1.DataSource.DataSet.fieldbyname('LIS��Ŀ����').AsString,
        LabeledEdit9.Text,
        operator_name
      );

      //���浱ǰ������
      if (trim(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString)<>'')and(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString<>PreWorkGroup) then
      begin
        PreWorkGroup:=DBGrid1.DataSource.DataSet.fieldbyname('������').AsString;
        ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
        ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,'�������',FormatDateTime('YYYY-MM-DD',Date));
        ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,'������',DBGrid1.DataSource.DataSet.fieldbyname('������').AsString);
        ini.Free;
      end;
      //==============
    end;
    DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
    DBGrid1.DataSource.DataSet.EnableControls;
    //Grid��ѡ��¼�жϷ�ʽ�� end}

    UpdateImportedReq('');
  end;

  (Sender as TLabeledEdit).Enabled:=true;
  if (Sender as TLabeledEdit).CanFocus then (Sender as TLabeledEdit).SetFocus;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MakeExtSystemDBConn;
  MakeAdoDBConn;

  //���������VirtualTable�ֶ�
  VirtualTable1.IndexFieldNames:='������';//������������
  VirtualTable1.Open;
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

procedure TfrmMain.VirtualTable1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
   
  DBGrid1.Columns[0].Width:=150;//�ⲿϵͳ��Ŀ������
  DBGrid1.Columns[1].Width:=77;//HIS��Ŀ����
  DBGrid1.Columns[2].Width:=100;//HIS��Ŀ����
  DBGrid1.Columns[3].Width:=77;//LIS��Ŀ����
  DBGrid1.Columns[4].Width:=100;//LIS��Ŀ����
  DBGrid1.Columns[5].Width:=80;//������
  DBGrid1.Columns[6].Width:=90;//������
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  ini:TIniFile;
  PreWorkGroup:String;//�ñ�������:�����湤�����һ����¼��������
  OldCurrent:TBookmark;
  i:Integer;
begin
  if not VirtualTable1.Active then exit;
  if VirtualTable1.RecordCount<=0 then exit;

  PreWorkGroup:='��һ��������';//��ʼ��Ϊʵ����������ܳ��ֵĹ��������Ƽ���

  LabeledEdit1.Enabled:=false;//Ϊ�˷�ֹû��������ɨ����һ������
  BitBtn1.Enabled:=false;//Ϊ�˷�ֹû�������ֵ������//������ShortCut,�ʲ���ʹ��(Sender as TBitBtn)

  //Grid��ѡ��¼�жϷ�ʽ�� begin
  //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼
  OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
  DBGrid1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGrid1.SelectedRows.Count-1 do
  begin
    DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[i];
    
    SingleRequestForm2Lis(
      DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,
      LabeledEdit6.Text,
      LabeledEdit2.Text,
      LabeledEdit3.Text,
      LabeledEdit4.Text,
      Edit2.Text,
      LabeledEdit8.Text,
      LabeledEdit10.Text,
      LabeledEdit11.Text,
      LabeledEdit7.Text,
      DBGrid1.DataSource.DataSet.fieldbyname('�ⲿϵͳ��Ŀ������').AsString,
      DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,
      LabeledEdit5.Text,
      DBGrid1.DataSource.DataSet.fieldbyname('LIS��Ŀ����').AsString,
      LabeledEdit9.Text,
      operator_name
    );

    //���浱ǰ������
    if (trim(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString)<>'')and(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString<>PreWorkGroup) then
    begin
      PreWorkGroup:=DBGrid1.DataSource.DataSet.fieldbyname('������').AsString;
      ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
      ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,'�������',FormatDateTime('YYYY-MM-DD',Date));
      ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('������').AsString,'������',DBGrid1.DataSource.DataSet.fieldbyname('������').AsString);
      ini.Free;
    end;
    //==============
  end;
  DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGrid1.DataSource.DataSet.EnableControls;
  //Grid��ѡ��¼�жϷ�ʽ�� end}

  LabeledEdit1.Enabled:=true;
  if LabeledEdit1.CanFocus then LabeledEdit1.SetFocus; 
  BitBtn1.Enabled:=true;//������ShortCut,�ʲ���ʹ��(Sender as TBitBtn)

  UpdateImportedReq('');
end;

procedure TfrmMain.SingleRequestForm2Lis(const WorkGroup, His_Unid, patientname, sex,
  age, age_unit, deptname, check_doctor, RequestDate, ABarcode, Surem1,
  checkid, SampleType, pkcombin_id, His_MzOrZy, PullPress: String);
var
  ObjectYZMZ:ISuperObject;
  ArrayYZMX:ISuperObject;
  ObjectJYYZ:ISuperObject;
  ArrayJYYZ:ISuperObject;
  BigObjectJYYZ:ISuperObject;
begin
  if trim(WorkGroup)='' then exit;
  if trim(pkcombin_id)='' then exit;

  ArrayYZMX:=SA([]);

  ObjectYZMZ:=SO;
  ObjectYZMZ.S['������'] := checkid;
  ObjectYZMZ.S['LIS�����Ŀ����'] := pkcombin_id;
  ObjectYZMZ.S['�����'] := ABarcode;
  ObjectYZMZ.S['��������'] := SampleType;
  ObjectYZMZ.S['�ⲿϵͳ��Ŀ������'] := Surem1;

  ArrayYZMX.AsArray.Add(ObjectYZMZ);
  ObjectYZMZ:=nil;

  ObjectJYYZ:=SO;
  ObjectJYYZ.S['��������']:=patientname;
  ObjectJYYZ.S['�����Ա�']:=sex;
  if sex='1' then ObjectJYYZ.S['�����Ա�']:='��';//��������PEIS
  if sex='2' then ObjectJYYZ.S['�����Ա�']:='Ů';//��������PEIS
  //    else ObjectJYYZ.S['�����Ա�']:='δ֪';
  ObjectJYYZ.S['��������']:=age+age_unit;
  if age_unit='Y' then ObjectJYYZ.S['��������']:=age+'��';//��������PEIS
  if age_unit='M' then ObjectJYYZ.S['��������']:=age+'��';//��������PEIS
  if age_unit='D' then ObjectJYYZ.S['��������']:=age+'��';//��������PEIS
  ObjectJYYZ.S['�������']:=deptname;
  ObjectJYYZ.S['����ҽ��']:=check_doctor;
  ObjectJYYZ.S['��������']:=RequestDate;
  ObjectJYYZ.S['�������']:=His_MzOrZy;
  ObjectJYYZ.S['����������']:=PullPress;
  ObjectJYYZ.S['�ⲿϵͳΨһ���']:=His_Unid;
  ObjectJYYZ.O['ҽ����ϸ']:=ArrayYZMX;
  ArrayYZMX:=nil;

  ArrayJYYZ:=SA([]);
  ArrayJYYZ.AsArray.Add(ObjectJYYZ);
  ObjectJYYZ:=nil;

  BigObjectJYYZ:=SO;
  BigObjectJYYZ.S['JSON����Դ']:='HIS';
  BigObjectJYYZ.O['����ҽ��']:=ArrayJYYZ;
  ArrayJYYZ:=nil;

  RequestForm2Lis(PChar(AnsiString(ADOConnection1.ConnectionString)),PChar(AnsiString(BigObjectJYYZ.AsJson)),'');
  BigObjectJYYZ:=nil;
end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  BitBtn1.Enabled:=not (Sender as TCheckBox).Checked;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteBool('Interface','ifDirect2LIS',CheckBox1.Checked);{��¼�Ƿ�ɨ���ֱ�ӵ���LIS}

  configini.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  configini:tinifile;
begin
  frmLogin.ShowModal;

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  CheckBox1.Checked:=configini.ReadBool('Interface','ifDirect2LIS',false);{��¼�Ƿ�ɨ���ֱ�ӵ���LIS}

  configini.Free;
  
  BitBtn1.Enabled:=not CheckBox1.Checked;

  UpdateImportedReq('');
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

procedure TfrmMain.UpdateImportedReq(const AWorkGroup: String);
var
  ss:String;
begin
  ss:='';
  if trim(AWorkGroup)<>'' then ss:=' and cc.combin_id='''+AWorkGroup+''' '; 
  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Text:=
'select cc.patientname as ����,cc.TjJianYan as �����,cc.combin_id as ������,cc.checkid as ������,'+
'  convert(varchar(2000),STUFF('+
'    (SELECT '',''+cv2.combin_Name'+
'	FROM chk_valu cv2'+
'	WHERE cv2.pkunid=cc.UNID'+
'	group by cv2.combin_Name'+
'	FOR XML PATH('''')'+
'    ),1,1,'''')) AS ��Ŀ����,'+
'	cc.unid '+
'from chk_con cc '+
'where cc.check_date>getdate()-7 and isnull(cc.TjJianYan,'''')<>'''' AND ISNULL(cc.report_doctor,'''')='''' '+ss+
'order by cc.unid desc';
  ADOQuery2.Open;
end;

procedure TfrmMain.ADOQuery2AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;

  DBGrid2.Columns[0].Width:=42;//����
  DBGrid2.Columns[1].Width:=120;//�����
  DBGrid2.Columns[2].Width:=60;//������
  DBGrid2.Columns[3].Width:=40;//������
  DBGrid2.Columns[4].Width:=230;//��Ŀ����
end;

end.
