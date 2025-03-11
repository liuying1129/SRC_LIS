unit UfrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBAccess,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, ADODB, ActnList,
  MemDS, VirtualTable, Grids, DBGrids, ComCtrls, Buttons, GridsEh,
  DBAxisGridsEh, DBGridEh, IniFiles,StrUtils, DBGridEhGrouping,
  Uni, UniProvider, MySQLUniProvider, SQLServerUniProvider, OracleUniProvider;

//==为了通过发送消息更新主窗体状态栏而增加==//
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
    //==为了通过发送消息更新主窗体状态栏而增加==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS消息处理函数}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//Text为该格式#$2+'0:abc'+#$2+'1:def'表示状态栏第0格显示abc,第1格显示def,依此类推
    //==========================================//
    procedure UpdateImportedReq(const AWorkGroup:String);//显示已导入的申请
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

  operator_name:string;
  operator_id:string;
  LisConn:string;//Lis连接字符串,MakeDBConn过程中被赋值,然后传入QC.DLL、CalcItemPro.dll

  function ScalarSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):string;

implementation

uses superobject, UfrmRequestInfo, UfrmLogin;

{$R *.dfm}

procedure RequestForm2Lis(const AAdoconnstr,ARequestJSON,CurrentWorkGroup:PChar);stdcall;external 'Request2Lis.dll';
procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunction.dll';
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//解密
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
     
     comboBox.Items.Clear;//加载前先清除comboBox项

     while not adotemp3.Eof do
     begin
      tempstr:=trim(adotemp3.Fields[0].AsString);

      comboBox.Items.Add(tempstr); //加载到comboBox

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
      if AErrorDlg then MESSAGEDLG('函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL,mtError,[mbOK],0)
        else WriteLog(pchar('操作者:'+operator_name+'。函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL));
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
  ss:='系统设置->通用代码->样本接收'+
      #$D+'外部系统编码：默认值HIS,一般为HIS/PEIS,应与LIS项目对照一致'+
      #$D+'视图名称：默认值view_test_request'+
      #$D+'项目对照：默认值[是],[否]表示HIS与LIS项目代码一致,LIS无需项目对照'+
      #$D+
      #$D+'视图字段如下：'+
      #$D+'条码号(*)：barcode'+
      #$D+'患者姓名：patientname'+
      #$D+'患者性别：sex'+
      #$D+'患者年龄：age'+
      #$D+'年龄单位：ageunit'+
      #$D+'开单时间：req_time'+
      #$D+'开单科室：req_dept'+
      #$D+'开单医生：req_doc'+
      #$D+'HIS检验组合项目代码(*)：his_item_no'+
      #$D+'HIS检验组合项目名称：his_item_name'+
      #$D+'样本类型：specimen_type'+
      #$D+'患者类别：patient_type'+
      #$D+'外部系统唯一编号(可选)：req_header_id'+
      #$D+'外部系统项目申请编号(可选)：req_detail_id';
  MessageDlg(ss,mtInformation,[mbok],0);
end;

procedure TfrmMain.LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ADOTemp22,ADOTemp33:TADOQuery;
  UniQryTemp11:TUniQuery;
  i,j:Integer;
  ini:TIniFile;
  PreWorkGroup:String;//该变量作用:仅保存工作组第一条记录的联机号
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
  ADOTemp22.SQL.Text:='select * from CommCode WITH(NOLOCK) where TypeName=''样本接收'' ';
  ADOTemp22.Open;
  while not ADOTemp22.Eof do
  begin
    if ADOTemp22.fieldbyname('id').AsString='外部系统编码' then ExtSystemId:=ADOTemp22.fieldbyname('Name').AsString;
    if ADOTemp22.fieldbyname('id').AsString='视图名称' then ViewName:=ADOTemp22.fieldbyname('Name').AsString;
    if ADOTemp22.fieldbyname('id').AsString='项目对照' then ifItemCompare:=ADOTemp22.fieldbyname('Name').AsString;
  
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

  PreWorkGroup:='上一个工作组';//初始化为实际情况不可能出现的工作组名称即可

  (Sender as TLabeledEdit).Enabled:=false;//为了防止没处理完又扫描下一个条码

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
  if UniQryTemp11.FieldList.IndexOf('name')>=0        then LabeledEdit2.Text:=UniQryTemp11.fieldbyname('name').AsString;//兼容莱域PEIS 
  LabeledEdit3.Text:=UniQryTemp11.fieldbyname('sex').AsString;
  LabeledEdit4.Text:=UniQryTemp11.fieldbyname('age').AsString;
  if UniQryTemp11.FieldList.IndexOf('ageunit')>=0  then Edit2.Text:=UniQryTemp11.fieldbyname('ageunit').AsString;
  if UniQryTemp11.FieldList.IndexOf('age_unit')>=0 then Edit2.Text:=UniQryTemp11.fieldbyname('age_unit').AsString;//兼容莱域PEIS
  if UniQryTemp11.FieldList.IndexOf('patient_type')>=0 then LabeledEdit9.Text:=UniQryTemp11.fieldbyname('patient_type').AsString;//兼容莱域PEIS,莱域PEIS无此字段
  if UniQryTemp11.FieldList.IndexOf('req_dept')>=0 then LabeledEdit8.Text:=UniQryTemp11.fieldbyname('req_dept').AsString;
  if UniQryTemp11.FieldList.IndexOf('reqdept')>=0  then LabeledEdit8.Text:=UniQryTemp11.fieldbyname('reqdept').AsString;//兼容莱域PEIS
  if UniQryTemp11.FieldList.IndexOf('req_doc')>=0    then LabeledEdit10.Text:=UniQryTemp11.fieldbyname('req_doc').AsString;
  if UniQryTemp11.FieldList.IndexOf('write_name')>=0 then LabeledEdit10.Text:=UniQryTemp11.fieldbyname('write_name').AsString;//兼容莱域PEIS
  if UniQryTemp11.FieldList.IndexOf('req_time')>=0 then LabeledEdit11.Text:=FormatDateTime('yyyy-mm-dd hh:nn:ss',UniQryTemp11.fieldbyname('req_time').AsDateTime);
  if UniQryTemp11.FieldList.IndexOf('write_time')>=0    then LabeledEdit11.Text:=FormatDateTime('yyyy-mm-dd hh:nn:ss',UniQryTemp11.fieldbyname('write_time').AsDateTime);//兼容莱域PEIS
  if UniQryTemp11.FieldList.IndexOf('specimen_type')>=0 then LabeledEdit5.Text:=UniQryTemp11.fieldbyname('specimen_type').AsString;
  if UniQryTemp11.FieldList.IndexOf('SPEC_TYPE')>=0     then LabeledEdit5.Text:=UniQryTemp11.fieldbyname('SPEC_TYPE').AsString;//兼容莱域PEIS
  if UniQryTemp11.FieldList.IndexOf('req_header_id')>=0 then LabeledEdit6.Text:=UniQryTemp11.fieldbyname('req_header_id').AsString;
  if UniQryTemp11.FieldList.IndexOf('REG_ID')>=0        then LabeledEdit6.Text:=UniQryTemp11.fieldbyname('REG_ID').AsString;//兼容莱域PEIS（体检号）

  VirtualTable1.Clear;
  for i:=0 to (DBGrid1.columns.count-1) do DBGrid1.columns[i].readonly:=False;

  while not UniQryTemp11.Eof do
  begin
    if '否'=ifItemCompare then//外部系统申请单的HIS组合项目代码与LIS组合项目代码一致，则LIS无需项目对照
    begin
      //如工作组为空,ini.ReadString报错ntdll.dll,且产生操作人员找不到病人信息的问题
      dept_DfValue:=trim(ScalarSQLCmd(LisConn,'select TOP 1 dept_DfValue from combinitem where Id='''+UniQryTemp11.fieldbyname('his_item_no').AsString+''' '));
      if ''=dept_DfValue then
      begin
        Memo1.Lines.Add(DateTimeToStr(now)+':'+UniQryTemp11.FieldByName('his_item_no').AsString+'【'+UniQryTemp11.FieldByName('his_item_name').AsString+'】在LIS中不存在,或未设置默认工作组');
        UniQryTemp11.Next;
        continue;
      end;
      
      ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
      PreDate:=ini.ReadString(dept_DfValue,'检查日期','');
      PreCheckID:=ini.ReadString(dept_DfValue,'联机号','');
      ini.Free;

      VirtualTable1.Append;
      if UniQryTemp11.FieldList.IndexOf('req_detail_id')>=0 then VirtualTable1.FieldByName('外部系统项目申请编号').AsString:=UniQryTemp11.FieldByName('req_detail_id').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then VirtualTable1.FieldByName('HIS项目代码').AsString:=UniQryTemp11.FieldByName('his_item_no').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_name')>=0 then VirtualTable1.FieldByName('HIS项目名称').AsString:=UniQryTemp11.FieldByName('his_item_name').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then VirtualTable1.FieldByName('LIS项目代码').AsString:=UniQryTemp11.FieldByName('his_item_no').AsString;
      if UniQryTemp11.FieldList.IndexOf('his_item_name')>=0 then VirtualTable1.FieldByName('LIS项目名称').AsString:=UniQryTemp11.FieldByName('his_item_name').AsString;
      VirtualTable1.FieldByName('工作组').AsString:=dept_DfValue;
      VirtualTable1.FieldByName('联机号').AsString:=GetMaxCheckId(PChar(dept_DfValue),PChar(PreDate),PChar(PreCheckID));
      VirtualTable1.Post;
    end else
    begin//外部系统申请单的HIS组合项目代码与LIS组合项目代码不一致，LIS需要项目对照的情况
      ADOTemp33:=TADOQuery.Create(nil);
      ADOTemp33.Connection:=ADOConnection1;
      ADOTemp33.Close;
      ADOTemp33.SQL.Clear;
      ADOTemp33.SQL.Text:='select ci.Id,ci.Name,ci.dept_DfValue '+
                          'from combinitem ci,HisCombItem hci '+
                          'where ci.Unid=hci.CombUnid and hci.ExtSystemId='''+ExtSystemId+
                          ''' and hci.HisItem=:HisItem';
      if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then ADOTemp33.Parameters.ParamByName('HisItem').Value:=UniQryTemp11.fieldbyname('his_item_no').AsString;
      if UniQryTemp11.FieldList.IndexOf('order_id')>=0    then ADOTemp33.Parameters.ParamByName('HisItem').Value:=UniQryTemp11.fieldbyname('order_id').AsString;//兼容莱域PEIS
      ADOTemp33.Open;

      //LIS中没有相对应的项目
      if ADOTemp33.RecordCount<=0 then
      begin
        if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then Memo1.Lines.Add(DateTimeToStr(now)+':'+UniQryTemp11.fieldbyname('his_item_no').AsString+'【'+UniQryTemp11.fieldbyname('his_item_name').AsString+'】在LIS中没有对照');
        if UniQryTemp11.FieldList.IndexOf('order_id')>=0    then Memo1.Lines.Add(DateTimeToStr(now)+':'+UniQryTemp11.fieldbyname('order_id').AsString+'【'+UniQryTemp11.fieldbyname('ITEMNAME').AsString+'】在LIS中没有对照');//兼容莱域PEIS 
      end;

      while not ADOTemp33.Eof do
      begin
        //如工作组为空,ini.ReadString报错ntdll.dll,且产生操作人员找不到病人信息的问题
        if trim(ADOTemp33.FieldByName('dept_DfValue').AsString)='' then
        begin
          Memo1.Lines.Add(DateTimeToStr(now)+':'+ADOTemp33.FieldByName('Id').AsString+'【'+ADOTemp33.FieldByName('Name').AsString+'】未设置默认工作组');
          ADOTemp33.Next;
          continue;
        end;

        ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
        PreDate:=ini.ReadString(ADOTemp33.FieldByName('dept_DfValue').AsString,'检查日期','');
        PreCheckID:=ini.ReadString(ADOTemp33.FieldByName('dept_DfValue').AsString,'联机号','');
        ini.Free;

        VirtualTable1.Append;
        if UniQryTemp11.FieldList.IndexOf('req_detail_id')>=0 then VirtualTable1.FieldByName('外部系统项目申请编号').AsString:=UniQryTemp11.FieldByName('req_detail_id').AsString;
        if UniQryTemp11.FieldList.IndexOf('REQUEST_NO')>=0    then VirtualTable1.FieldByName('外部系统项目申请编号').AsString:=UniQryTemp11.FieldByName('REQUEST_NO').AsString;//兼容莱域PEIS
        if UniQryTemp11.FieldList.IndexOf('his_item_no')>=0 then VirtualTable1.FieldByName('HIS项目代码').AsString:=UniQryTemp11.FieldByName('his_item_no').AsString;
        if UniQryTemp11.FieldList.IndexOf('order_id')>=0    then VirtualTable1.FieldByName('HIS项目代码').AsString:=UniQryTemp11.FieldByName('order_id').AsString;//兼容莱域PEIS
        if UniQryTemp11.FieldList.IndexOf('his_item_name')>=0 then VirtualTable1.FieldByName('HIS项目名称').AsString:=UniQryTemp11.FieldByName('his_item_name').AsString;
        if UniQryTemp11.FieldList.IndexOf('ITEMNAME')>=0      then VirtualTable1.FieldByName('HIS项目名称').AsString:=UniQryTemp11.FieldByName('ITEMNAME').AsString;//兼容莱域PEIS
        VirtualTable1.FieldByName('LIS项目代码').AsString:=ADOTemp33.FieldByName('Id').AsString;
        VirtualTable1.FieldByName('LIS项目名称').AsString:=ADOTemp33.FieldByName('Name').AsString;
        VirtualTable1.FieldByName('工作组').AsString:=ADOTemp33.FieldByName('dept_DfValue').AsString;
        VirtualTable1.FieldByName('联机号').AsString:=GetMaxCheckId(PChar(ADOTemp33.FieldByName('dept_DfValue').AsString),PChar(PreDate),PChar(PreCheckID));
        VirtualTable1.Post;

        ADOTemp33.Next;
      end;
      ADOTemp33.Free;
    end;
    
    UniQryTemp11.Next;
  end;
  UniQryTemp11.Free;

  for i:=0 to (DBGrid1.columns.count-2) do DBGrid1.columns[i].readonly:=True;//仅保留最后1列(联机号)可编辑

  //Grid全选方式二 begin
  DBGrid1.Selection.Rows.SelectAll;
  //Grid全选方式二 end

  if CheckBox1.Checked then
  begin
    //Grid勾选记录判断方式二 begin
    //该方式无需循环全部数据集,只需循环所选记录
    OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
    DBGrid1.DataSource.DataSet.DisableControls;
    for j:=0 to DBGrid1.SelectedRows.Count-1 do
    begin
      DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[j];
      
      SingleRequestForm2Lis(
        DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString,
        LabeledEdit6.Text,
        LabeledEdit2.Text,
        LabeledEdit3.Text,
        LabeledEdit4.Text,
        Edit2.Text,
        LabeledEdit8.Text,
        LabeledEdit10.Text,
        LabeledEdit11.Text,
        LabeledEdit7.Text,
        DBGrid1.DataSource.DataSet.fieldbyname('外部系统项目申请编号').AsString,
        DBGrid1.DataSource.DataSet.fieldbyname('联机号').AsString,
        LabeledEdit5.Text,
        DBGrid1.DataSource.DataSet.fieldbyname('LIS项目代码').AsString,
        LabeledEdit9.Text,
        operator_name
      );

      //保存当前联机号
      if (trim(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString)<>'')and(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString<>PreWorkGroup) then
      begin
        PreWorkGroup:=DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString;
        ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
        ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString,'检查日期',FormatDateTime('YYYY-MM-DD',Date));
        ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString,'联机号',DBGrid1.DataSource.DataSet.fieldbyname('联机号').AsString);
        ini.Free;
      end;
      //==============
    end;
    DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
    DBGrid1.DataSource.DataSet.EnableControls;
    //Grid勾选记录判断方式二 end}

    UpdateImportedReq('');
  end;

  (Sender as TLabeledEdit).Enabled:=true;
  if (Sender as TLabeledEdit).CanFocus then (Sender as TLabeledEdit).SetFocus;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MakeExtSystemDBConn;
  MakeAdoDBConn;

  //设计期设置VirtualTable字段
  VirtualTable1.IndexFieldNames:='工作组';//按工作组排序
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

procedure TfrmMain.VirtualTable1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
   
  DBGrid1.Columns[0].Width:=150;//外部系统项目申请编号
  DBGrid1.Columns[1].Width:=77;//HIS项目代码
  DBGrid1.Columns[2].Width:=100;//HIS项目名称
  DBGrid1.Columns[3].Width:=77;//LIS项目代码
  DBGrid1.Columns[4].Width:=100;//LIS项目名称
  DBGrid1.Columns[5].Width:=80;//工作组
  DBGrid1.Columns[6].Width:=90;//联机号
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  ini:TIniFile;
  PreWorkGroup:String;//该变量作用:仅保存工作组第一条记录的联机号
  OldCurrent:TBookmark;
  i:Integer;
begin
  if not VirtualTable1.Active then exit;
  if VirtualTable1.RecordCount<=0 then exit;

  PreWorkGroup:='上一个工作组';//初始化为实际情况不可能出现的工作组名称即可

  LabeledEdit1.Enabled:=false;//为了防止没处理完又扫描下一个条码
  BitBtn1.Enabled:=false;//为了防止没处理完又点击导入//因定义了ShortCut,故不能使用(Sender as TBitBtn)

  //Grid勾选记录判断方式二 begin
  //该方式无需循环全部数据集,只需循环所选记录
  OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
  DBGrid1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGrid1.SelectedRows.Count-1 do
  begin
    DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[i];
    
    SingleRequestForm2Lis(
      DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString,
      LabeledEdit6.Text,
      LabeledEdit2.Text,
      LabeledEdit3.Text,
      LabeledEdit4.Text,
      Edit2.Text,
      LabeledEdit8.Text,
      LabeledEdit10.Text,
      LabeledEdit11.Text,
      LabeledEdit7.Text,
      DBGrid1.DataSource.DataSet.fieldbyname('外部系统项目申请编号').AsString,
      DBGrid1.DataSource.DataSet.fieldbyname('联机号').AsString,
      LabeledEdit5.Text,
      DBGrid1.DataSource.DataSet.fieldbyname('LIS项目代码').AsString,
      LabeledEdit9.Text,
      operator_name
    );

    //保存当前联机号
    if (trim(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString)<>'')and(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString<>PreWorkGroup) then
    begin
      PreWorkGroup:=DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString;
      ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
      ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString,'检查日期',FormatDateTime('YYYY-MM-DD',Date));
      ini.WriteString(DBGrid1.DataSource.DataSet.fieldbyname('工作组').AsString,'联机号',DBGrid1.DataSource.DataSet.fieldbyname('联机号').AsString);
      ini.Free;
    end;
    //==============
  end;
  DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGrid1.DataSource.DataSet.EnableControls;
  //Grid勾选记录判断方式二 end}

  LabeledEdit1.Enabled:=true;
  if LabeledEdit1.CanFocus then LabeledEdit1.SetFocus; 
  BitBtn1.Enabled:=true;//因定义了ShortCut,故不能使用(Sender as TBitBtn)

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
  ObjectYZMZ.S['联机号'] := checkid;
  ObjectYZMZ.S['LIS组合项目代码'] := pkcombin_id;
  ObjectYZMZ.S['条码号'] := ABarcode;
  ObjectYZMZ.S['样本类型'] := SampleType;
  ObjectYZMZ.S['外部系统项目申请编号'] := Surem1;

  ArrayYZMX.AsArray.Add(ObjectYZMZ);
  ObjectYZMZ:=nil;

  ObjectJYYZ:=SO;
  ObjectJYYZ.S['患者姓名']:=patientname;
  ObjectJYYZ.S['患者性别']:=sex;
  if sex='1' then ObjectJYYZ.S['患者性别']:='男';//兼容莱域PEIS
  if sex='2' then ObjectJYYZ.S['患者性别']:='女';//兼容莱域PEIS
  //    else ObjectJYYZ.S['患者性别']:='未知';
  ObjectJYYZ.S['患者年龄']:=age+age_unit;
  if age_unit='Y' then ObjectJYYZ.S['患者年龄']:=age+'岁';//兼容莱域PEIS
  if age_unit='M' then ObjectJYYZ.S['患者年龄']:=age+'月';//兼容莱域PEIS
  if age_unit='D' then ObjectJYYZ.S['患者年龄']:=age+'天';//兼容莱域PEIS
  ObjectJYYZ.S['申请科室']:=deptname;
  ObjectJYYZ.S['申请医生']:=check_doctor;
  ObjectJYYZ.S['申请日期']:=RequestDate;
  ObjectJYYZ.S['患者类别']:=His_MzOrZy;
  ObjectJYYZ.S['样本接收人']:=PullPress;
  ObjectJYYZ.S['外部系统唯一编号']:=His_Unid;
  ObjectJYYZ.O['医嘱明细']:=ArrayYZMX;
  ArrayYZMX:=nil;

  ArrayJYYZ:=SA([]);
  ArrayJYYZ.AsArray.Add(ObjectJYYZ);
  ObjectJYYZ:=nil;

  BigObjectJYYZ:=SO;
  BigObjectJYYZ.S['JSON数据源']:='HIS';
  BigObjectJYYZ.O['检验医嘱']:=ArrayJYYZ;
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

  configini.WriteBool('Interface','ifDirect2LIS',CheckBox1.Checked);{记录是否扫描后直接导入LIS}

  configini.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  configini:tinifile;
begin
  frmLogin.ShowModal;

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  CheckBox1.Checked:=configini.ReadBool('Interface','ifDirect2LIS',false);{记录是否扫描后直接导入LIS}

  configini.Free;
  
  BitBtn1.Enabled:=not CheckBox1.Checked;

  UpdateImportedReq('');
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

procedure TfrmMain.UpdateImportedReq(const AWorkGroup: String);
var
  ss:String;
begin
  ss:='';
  if trim(AWorkGroup)<>'' then ss:=' and cc.combin_id='''+AWorkGroup+''' '; 
  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Text:=
'select cc.patientname as 姓名,cc.TjJianYan as 条码号,cc.combin_id as 工作组,cc.checkid as 联机号,'+
'  convert(varchar(2000),STUFF('+
'    (SELECT '',''+cv2.combin_Name'+
'	FROM chk_valu cv2'+
'	WHERE cv2.pkunid=cc.UNID'+
'	group by cv2.combin_Name'+
'	FOR XML PATH('''')'+
'    ),1,1,'''')) AS 项目名称,'+
'	cc.unid '+
'from chk_con cc '+
'where cc.check_date>getdate()-7 and isnull(cc.TjJianYan,'''')<>'''' AND ISNULL(cc.report_doctor,'''')='''' '+ss+
'order by cc.unid desc';
  ADOQuery2.Open;
end;

procedure TfrmMain.ADOQuery2AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;

  DBGrid2.Columns[0].Width:=42;//姓名
  DBGrid2.Columns[1].Width:=120;//条码号
  DBGrid2.Columns[2].Width:=60;//工作组
  DBGrid2.Columns[3].Width:=40;//联机号
  DBGrid2.Columns[4].Width:=230;//项目名称
end;

end.
