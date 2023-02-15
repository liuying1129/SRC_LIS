unit UfrmCommQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,ADODB,StrUtils,
  FR_DSet, FR_DBSet, FR_Class, TeEngine, Series, TeeProcs, Chart,fr_chart,
  UADOLYQuery,ComObj,Jpeg, Menus,inifiles,Printers, ULYDataToExcel;

type
  TfieldList=array of string;
  
type
  TfrmCommQuery = class(TForm)
    pnlCommQryTop: TPanel;
    DBGridResult: TDBGrid;
    pnlCommQryBotton: TPanel;
    BitBtnCommQry: TBitBtn;
    BitBtnCommQryClose: TBitBtn;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    frReport1: TfrReport;
    ADObasic: TADOQuery;
    frDBDataSet2: TfrDBDataSet;
    ADO_print: TADOQuery;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    LYQuery1: TADOLYQuery;
    MasterDataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Label3: TLabel;
    BitBtn5: TBitBtn;
    RadioGroup1: TRadioGroup;
    LYDataToExcel1: TLYDataToExcel;
    N4: TMenuItem;
    Excel1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure BitBtnCommQryCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure frReport1BeforePrint(Memo: TStringList; View: TfrView);
    procedure BitBtn5Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure frReport1PrintReport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmCommQuery: TfrmCommQuery;

function frmCommQuery:TfrmCommQuery;    {��̬�������庯��}

implementation
uses  UDM,SDIMAIN;

const
  //��ϸsql��䣬��ѯ��������EXCEL�о�Ҫ�õ����ʶ���Ϊ��Ԫ��ȫ�ֱ���
  MXSqlstr1='select name ����,english_name as Ӣ����,itemvalue as ������,unit as ��λ,'+
          ' min_value as ��Сֵ,max_value as ���ֵ,printorder as ��ӡ���,'+
          ' issure as �Ƿ�ȷ��,itemid as ��Ŀ���,pkcombin_id as �����Ŀ��,'+
          ' valueid as Ψһ���,pkunid as ������ϢΨһ���,IsEdited as �޸ı�־ from chk_valu_bak ';
  MXSqlstr2=' order by ������ϢΨһ���,�����Ŀ��,��ӡ��� ';


var
  ffrmCommQuery:TfrmCommQuery;           {���صĴ������,���رմ����ͷ��ڴ�ʱ����}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmCommQuery:TfrmCommQuery;    {��̬�������庯��}
begin
  if ffrmCommQuery=nil then ffrmCommQuery:=TfrmCommQuery.Create(application.mainform);
  result:=ffrmCommQuery;
end;

procedure TfrmCommQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCommQuery=self then ffrmCommQuery:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmCommQuery.BitBtnCommQryClick(Sender: TObject);
var
  sqlstr1:string;
  Save_Cursor:TCursor;
begin
  sqlstr1:='select lsh as ��ˮ��,checkid as ������,caseno as ������,check_date as �������,patientname as ����,'+
    'sex as �Ա�,'+
    'age as ����,bedno as ����,deptname as �ͼ����,'+
    'check_doctor as �ͼ�ҽ��,operator as ������,report_doctor as �����,Audit_Date as ���ʱ��,'+
    'report_date as ��������,'+
    'diagnosetype as ���ȼ���,combin_id as ���,'+
    'flagetype as ��������,typeflagcase as �������,diagnose as �ٴ����,'+
    'issure as ��ע,germname as ϸ��,'+
    ' WorkCompany as ������˾,WorkDepartment as ��������,WorkCategory as ����,WorkID as ����,ifMarry as ���,OldAddress as ����,Address as סַ,Telephone as �绰, '+
    ' PushPress as ����ѹ,PullPress as ����ѹ,LeftEyesight as ��������,RightEyesight as ��������,Stature as ���,Weight as ����, '+
    ' TjJiWangShi as ����ʷ,TjJiaZuShi as ����ʷ,TjNeiKe as �ڿ�,TjWaiKe as ���,TjWuGuanKe as ��ٿ�,TjFuKe as ����,TjLengQiangGuang as ��ǿ��,TjXGuang as X��,TjBChao as B��,TjXinDianTu as �ĵ�ͼ,TjJianYan as ����,TjDescription as ����,TJAdvice as ����, '+
    ' printtimes as ��ӡ����,unid as Ψһ��� '+
    ' from chk_con_bak order by unid';
  
  lyquery1.Connection:=DM.ADOConnection1;
  lyquery1.SelectString:=sqlstr1;
  if lyquery1.Execute then
  begin
    ADObasic.SQL.Text:=lyquery1.ResultSelect;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    { Show hourglass cursor }
    try
      ADObasic.Open;
    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;
  end;
end;

procedure TfrmCommQuery.BitBtnCommQryCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCommQuery.FormCreate(Sender: TObject);
begin
  ADObasic.Connection:=DM.ADOConnection1;
  ADOQuery1.Connection:=DM.ADOConnection1;
  ADO_PRINT.Connection:=DM.ADOConnection1;
end;

procedure TfrmCommQuery.BitBtn1Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sCombin_Id:string;

  //���ձ��Ա�����ĺϲ�������ӡ��� ����
  sPatientname,sSex,sAge,sCheck_Date:string;
  //===============================  

  i,j:integer;
  mvPictureTitle:TfrMemoView;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('Ψһ���').AsString;//��ֹ�����ӡ�����Ͻ�����Ƶ���һ��������Ϣ�ϡ���д����ǰ��
  sCombin_Id:=adobasic.FieldByName('���').AsString;  

  sPatientname:=trim(adobasic.fieldbyname('����').AsString);
  sSex:=adobasic.fieldbyname('�Ա�').AsString;
  sAge:=adobasic.fieldbyname('����').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('�������').AsDateTime);
  
  if (sCombin_Id=WorkGroup_T1)
    and (frReport1.LoadFromFile(TempFile_T1)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T2)
    and (frReport1.LoadFromFile(TempFile_T2)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T3)
    and (frReport1.LoadFromFile(TempFile_T3)) then
  begin
  end else
  if not frReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_cur.frf') then
  begin
    showmessage('����Ĭ��ͨ�ô�ӡģ��report_cur.frfʧ�ܣ�������:ϵͳ����->ѡ��->��ӡģ��');
    exit;
  end;

  //��̬����ͼƬ����begin
  //����������:�Ƿ���Ҫ�ͷ�mvPictureTitle?��ʱ�ͷ�?
  for j:=0 to frReport1.Pages.Count-1 do
  begin
    for i:=0 to frReport1.Pages[j].Objects.Count-1 do
    begin
      if TObject(frReport1.Pages[j].Objects.Items[i]) is TfrPictureView then
      begin
        if uppercase(leftstr(TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name,7))='PICTURE' then
        begin
          mvPictureTitle:=TfrMemoView.Create;
          frReport1.Pages[j].Objects.Add(mvPictureTitle);
          mvPictureTitle.Name:='mv'+TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name;
          mvPictureTitle.Visible:=false;
        end;
      end;
    end;
  end;
  //��̬����ͼƬ����end
  
  if (SDIAppForm.N64.Checked)and(sPatientname<>'') then//���ձ��Ա�����ϲ���ӡ//ֻ�д�������ʱ�źϲ�
    strsqlPrint:='select cv.itemid as ��Ŀ����,cv.name as ����,cv.english_name as Ӣ����,'+
          ' cv.itemvalue as ������,'+
          ' cv.min_value as ��Сֵ,cv.max_value as ���ֵ,'+
          ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as ��βο���Χ,'+
          ' cv.unit as ��λ,min(cv.printorder) as ��ӡ���,'+
          ' min(cv.pkcombin_id) as �����Ŀ��, '+
          ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10 '+
          ' from chk_valu_bak cv '+
          ' inner join chk_con_bak cc on cv.pkunid=cc.unid '+
          ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
          ' where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+
          ''') and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
          ' and CONVERT(CHAR(10),cc.check_date,121)>=DATEADD(day,'+inttostr(-1*MergePrintDays)+','''+sCheck_Date+''') '+
          ' and CONVERT(CHAR(10),cc.check_date,121)<=DATEADD(day,'+inttostr(MergePrintDays)+','''+sCheck_Date+''') '+
          ' and cci.sysname='''+SYSNAME+''' '+
          ' group by cv.itemid,cv.name,cv.english_name,cv.itemvalue,cv.min_value,cv.max_value,cv.unit, '+
          ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10 '+
          ' order by �����Ŀ��,��ӡ��� '
  else
    strsqlPrint:='select itemid as ��Ŀ����,name as ����,english_name as Ӣ����,'+
            ' itemvalue as ������,'+
            ' min_value as ��Сֵ,max_value as ���ֵ,'+
            ' dbo.uf_Reference_Value_B1(min_value,max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(min_value,max_value) as ��βο���Χ,'+
            ' unit as ��λ,min(printorder) as ��ӡ���,'+
            ' min(pkcombin_id) as �����Ŀ��, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' from chk_valu_bak '+
            ' where pkunid='+sUnid+
            ' and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
            ' group by itemid,name,english_name,itemvalue,min_value,max_value,unit, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' order by �����Ŀ��,��ӡ��� ';
    ado_print.Close;
    ado_print.SQL.Clear;
    ado_print.SQL.Text:=strsqlPrint;
    ado_print.Open;
    if (ADO_print.RecordCount=0) and (not ifNoResultPrint) then exit;

  if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm

  if sdiappform.n9.Checked then  //Ԥ��ģʽ
  begin
    frReport1.ShowPrintDialog:=ifShowPrintDialog;
    frReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //ֱ�Ӵ�ӡģʽ
  begin
    if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
  end;
end;

procedure TfrmCommQuery.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
var
  ItemChnName:string;
  cur_value:string;
  min_value:string;
  max_value:string;
  i:integer;
  adotemp22:tadoquery;
begin
    if parname='SCSYDW' then ParValue:=SCSYDW;
    
    if parname='CXZF' then
    BEGIN
      ItemChnName:=trim(ADO_print.fieldbyname('��Ŀ����').AsString);
      cur_value:=trim(ADO_print.fieldbyname('������').AsString);
      min_value:=trim(ADO_print.fieldbyname('��Сֵ').AsString);
      max_value:=trim(ADO_print.fieldbyname('���ֵ').AsString);

      adotemp22:=Tadoquery.Create(nil);
      adotemp22.Connection:=dm.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select dbo.uf_ValueAlarm('''+ItemChnName+''','''+min_value+''','''+max_value+''','''+cur_value+''') as ifValueAlarm';
      try//uf_ValueAlarm�е�convert���������׳��쳣
        adotemp22.Open;
        i:=adotemp22.fieldbyname('ifValueAlarm').AsInteger;
      except
        i:=0;
      end;
      adotemp22.Free;
      if i=1 then
        ParValue := TRIM(COPY(CXZF,3,2))
      else if i=2 then
        ParValue := TRIM(COPY(CXZF,1,2))
      else ParValue:='';
    END;

    if parname='��ӡ��' then ParValue:=operator_name;
    if parname='������˾' then ParValue:=trim(ADObasic.fieldbyname('������˾').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='�Ա�' then ParValue:=trim(ADObasic.fieldbyname('�Ա�').AsString);
    if parname='�������' then ParValue:=ADObasic.fieldbyname('�������').AsDateTime;
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='���' then ParValue:=trim(ADObasic.fieldbyname('���').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='סַ' then ParValue:=trim(ADObasic.fieldbyname('סַ').AsString);
    if parname='�绰' then ParValue:=trim(ADObasic.fieldbyname('�绰').AsString);
    {if parname='����ѹ' then ParValue:=trim(ADObasic.fieldbyname('����ѹ').AsString);
    if parname='����ѹ' then ParValue:=trim(ADObasic.fieldbyname('����ѹ').AsString);
    if parname='��������' then ParValue:=trim(ADObasic.fieldbyname('��������').AsString);
    if parname='��������' then ParValue:=trim(ADObasic.fieldbyname('��������').AsString);
    if parname='���' then ParValue:=trim(ADObasic.fieldbyname('���').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='����ʷ' then ParValue:=ADObasic.fieldbyname('����ʷ').AsString;
    if parname='����ʷ' then ParValue:=ADObasic.fieldbyname('����ʷ').AsString;
    if parname='�ڿ�' then ParValue:=ADObasic.fieldbyname('�ڿ�').AsString;
    if parname='���' then ParValue:=ADObasic.fieldbyname('���').AsString;
    if parname='��ٿ�' then ParValue:=ADObasic.fieldbyname('��ٿ�').AsString;
    if parname='����' then ParValue:=ADObasic.fieldbyname('����').AsString;
    if parname='��ǿ��' then ParValue:=ADObasic.fieldbyname('��ǿ��').AsString;
    if parname='X��' then ParValue:=ADObasic.fieldbyname('X��').AsString;
    if parname='B��' then ParValue:=ADObasic.fieldbyname('B��').AsString;
    if parname='�ĵ�ͼ' then ParValue:=ADObasic.fieldbyname('�ĵ�ͼ').AsString;
    if parname='����' then ParValue:=ADObasic.fieldbyname('����').AsString;
    if parname='����' then ParValue:=ADObasic.fieldbyname('����').AsString;
    if parname='����' then ParValue:=ADObasic.fieldbyname('����').AsString;//}
    
    if parname='�����豸' then ParValue:=ScalarSQLCmd(LisConn,'select dbo.uf_GetEquipFromChkUnid(1,'+ADObasic.fieldbyname('Ψһ���').AsString+')');
end;

procedure TfrmCommQuery.BitBtn2Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  dbgridresult.ReadOnly:=false;
end;

procedure TfrmCommQuery.BitBtn4Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  dbgrid1.ReadOnly:=false;

end;

procedure TfrmCommQuery.BitBtn3Click(Sender: TObject);
var
  strsqlPrint:string;
  frGH: TfrBandView;//����ͷ

  sUnid:string;

  //���ձ��Ա�����ĺϲ�������ӡ��� ����
  sPatientname,sSex,sAge,sCheck_Date,sMergePrintWorkGroupRange,sCombin_Id:string;
  //===============================  

  i,j:integer;
  mvPictureTitle:TfrMemoView;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('Ψһ���').AsString;//��ֹ�����ӡ�����Ͻ�����Ƶ���һ��������Ϣ�ϡ���д����ǰ��
  
  sPatientname:=trim(adobasic.fieldbyname('����').AsString);
  sSex:=adobasic.fieldbyname('�Ա�').AsString;
  sAge:=adobasic.fieldbyname('����').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('�������').AsDateTime);
  sCombin_Id:=adobasic.FieldByName('���').AsString;
  
  if (sCombin_Id=GP_WorkGroup_T1)
    and frReport1.LoadFromFile(GP_TempFile_T1) then//����ģ���ļ��ǲ����ִ�Сд��.���ַ���������ʧ��
  begin
  end else
  if (sCombin_Id=GP_WorkGroup_T2)
    and frReport1.LoadFromFile(GP_TempFile_T2) then
  begin
  end else
  if (sCombin_Id=GP_WorkGroup_T3)
    and frReport1.LoadFromFile(GP_TempFile_T3) then
  begin
  end else
  if not frReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_Cur_group.frf') then
  begin
    showmessage('����Ĭ�Ϸ����ӡģ��report_Cur_group.frfʧ�ܣ�������:ϵͳ����->ѡ��->��ӡģ��');
    exit;
  end;

  frGH := TfrBandView(frReport1.FindObject('GroupHeader1'));
  if(frGH=nil)then
  begin
    showmessage('����ģ����û�з���GroupHeader1');
    exit;
  end;

  if SDIAppForm.N25.Checked then//�����ҳ
    frGH.Prop['formnewpage'] := True
  else
    frGH.Prop['formnewpage'] := false;

  //��̬����ͼƬ����begin
  //����������:�Ƿ���Ҫ�ͷ�mvPictureTitle?��ʱ�ͷ�?
  for j:=0 to frReport1.Pages.Count-1 do
  begin
    for i:=0 to frReport1.Pages[j].Objects.Count-1 do
    begin
      if TObject(frReport1.Pages[j].Objects.Items[i]) is TfrPictureView then
      begin
        if uppercase(leftstr(TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name,7))='PICTURE' then
        begin
          mvPictureTitle:=TfrMemoView.Create;
          frReport1.Pages[j].Objects.Add(mvPictureTitle);
          mvPictureTitle.Name:='mv'+TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name;
          mvPictureTitle.Visible:=false;
        end;
      end;
    end;
  end;
  //��̬����ͼƬ����end
  
  if MergePrintWorkGroupRange<>'' then
    sMergePrintWorkGroupRange:=' and cc.combin_id in ('+MergePrintWorkGroupRange+') ';
  if (SDIAppForm.N64.Checked)and(sPatientname<>'') then//���ձ��Ա�����ϲ���ӡ//ֻ�д�������ʱ�źϲ�
    strsqlPrint:='select cv.combin_name as name,cv.name as ����,cv.english_name as Ӣ����,cv.itemvalue as ������,'+//combinitem.name
    'cv.unit as ��λ,cv.min_value as ��Сֵ,cv.max_value as ���ֵ,'+
    ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as ��βο���Χ,'+
    ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10, '+
    ' cv.itemid as ��Ŀ���� '+//cci.Reserve3,
    ' from chk_valu_bak cv '+//combinitem,�������Ŀ��ȡ�����Ŀ���ƣ��п��ܴ�����ˣ�ȡ����������
    ' inner join chk_con_bak cc on cv.pkunid=cc.unid '+
    ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
    ' where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+
    ''') and cv.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
    ' and CONVERT(CHAR(10),cc.check_date,121)>=DATEADD(day,'+inttostr(-1*MergePrintDays)+','''+sCheck_Date+''') '+
    ' and CONVERT(CHAR(10),cc.check_date,121)<=DATEADD(day,'+inttostr(MergePrintDays)+','''+sCheck_Date+''') '+
    ' and cci.sysname='''+SYSNAME+''' '+
    sMergePrintWorkGroupRange+
    ' order by cv.pkcombin_id,cv.printorder '//�����Ŀ��,��ӡ��� '
  else
    strsqlPrint:='select cv.combin_name as name,cv.name as ����,cv.english_name as Ӣ����,cv.itemvalue as ������,'+
    'cv.unit as ��λ,cv.min_value as ��Сֵ,cv.max_value as ���ֵ,'+
    ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as ��βο���Χ,'+
    ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10, '+
    ' cv.itemid as ��Ŀ���� '+//cci.Reserve3,
    ' from chk_valu_bak cv '+
    ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
    ' where cv.pkunid='+sUnid+
    ' and cv.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
    ' order by cv.pkcombin_id,cv.printorder ';//�����Ŀ��,��ӡ��� '
  ADO_print.Close;
  ADO_print.SQL.Clear;
  ADO_print.SQL.Text:=strsqlPrint;
  ADO_print.Open;
  if (ADO_print.RecordCount=0) and (not ifNoResultPrint) then exit;

  if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm

  if sdiappform.n9.Checked then  //Ԥ��ģʽ
  begin
    frReport1.ShowPrintDialog:=ifShowPrintDialog;
    frReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //ֱ�Ӵ�ӡģʽ
  begin
    if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
  end;
end;

procedure TfrmCommQuery.ADObasicAfterScroll(DataSet: TDataSet);
const
  sqlstr1=' where pkunid=:pkunid and issure=1 ';
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=MXSqlstr1+sqlstr1+MXSqlstr2;
  ADOQuery1.Parameters.ParamByName('pkunid').Value:=
    masterDataSource.DataSet.fieldbyname('Ψһ���').AsInteger;
  ADOQuery1.Open;
end;

procedure TfrmCommQuery.ADObasicAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
    VisibleColumn(dbgridresult,'Ψһ���',false);
    for i :=0  to dbgridresult.Columns.Count-1 do
    begin
       dbgridresult.Columns[i].Width:=55;
       if (i=3)or(i=12)or(i=2)or(i=13) then dbgridresult.Columns[i].Width:=70;//������ڣ���������,�����ţ����ʱ��
    end;

    label2.Caption:=inttostr(DataSet.RecordCount);//��ʾ�˴�
end;

procedure TfrmCommQuery.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
    VisibleColumn(dbgrid1,'��ӡ���',false);
    VisibleColumn(dbgrid1,'�Ƿ�ȷ��',false);
    VisibleColumn(dbgrid1,'��Ŀ���',false);
    VisibleColumn(dbgrid1,'�����Ŀ��',false);
    VisibleColumn(dbgrid1,'��Ŀ���',false);
    VisibleColumn(dbgrid1,'������ϢΨһ���',false);
    for i :=0  to dbgrid1.Columns.Count-1 do
    begin
       dbgrid1.Columns[i].Width:=65;
    end;
end;

procedure TfrmCommQuery.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  ItemChnName,IsEdited:string;
  cur_value:string;
  min_value:string; 
  max_value:string; 
  i:integer;
  adotemp22:Tadoquery;
begin
  //======================�����������ο���Χʱ�仯��ɫ======================//
  if (datacol=2) then
  begin
    ItemChnName:=trim(ADOQuery1.fieldbyname('��Ŀ���').AsString);
    cur_value:=trim(ADOQuery1.fieldbyname('������').AsString);
    min_value:=trim(ADOQuery1.fieldbyname('��Сֵ').AsString);
    max_value:=trim(ADOQuery1.fieldbyname('���ֵ').AsString);

    adotemp22:=Tadoquery.Create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:='select dbo.uf_ValueAlarm('''+ItemChnName+''','''+min_value+''','''+max_value+''','''+cur_value+''') as ifValueAlarm';
    try//uf_ValueAlarm�е�convert���������׳��쳣
      adotemp22.Open;
      i:=adotemp22.fieldbyname('ifValueAlarm').AsInteger;
    except
      i:=0;
    end;
    adotemp22.Free;

    if i=1 then
      tdbgrid(sender).Canvas.Font.Color:=clblue
    else if i=2 then
          tdbgrid(sender).Canvas.Font.Color:=clred;
    tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
  end;
  //==========================================================================//

  //======================�޸Ĺ��ļ������仯��ɫ============================//
  if (datacol=2) then
  begin
    IsEdited:=ADOQuery1.fieldbyname('�޸ı�־').AsString;
    if IsEdited='1' then
    begin
      (Sender as TDBGrid).Canvas.Pen.Color := clRed; //���廭����ɫ(��ɫ)
      (Sender as TDBGrid).Canvas.MoveTo(Rect.Right, Rect.Top); //���ʶ�λ
      (Sender as TDBGrid).Canvas.LineTo(Rect.Right, Rect.Bottom); //����ɫ������
    end; 
  end;
  //==========================================================================//
end;

{//�����¼��˵�
procedure TfrmCommQuery.N1Click(Sender: TObject);
TYPE
  TDLLProc=function(AHandle:THandle;ABasicDs:TAdoquery;AImeName:Pchar;AifCurTab:boolean;AOperator_ID:Pchar):boolean;stdcall;
VAR
  DLLProc:TDLLProc;
  HTJLIB:THandle;
  
  ConfigIni:tinifile;
  StrImeName:string;
  FExecute:boolean;
  ff:integer;
begin
  if not ifhaspower(BitBtn2,powerstr_js_main) then exit;//Ȩ����"�޸Ļ�����Ϣ"��ť��Ȩ��һ��

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;
  
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    StrImeName:=ConfigIni.ReadString('���뷨ѡ��','Ĭ���������뷨','���� (����) - ���� ABC');
  finally
    ConfigIni.Free;
  end;

  HTJLIB:=LOADLIBRARY('TJ.dll');
  IF HTJLIB=0 THEN BEGIN SHOWMESSAGE('�Բ���,��ʹ�õİ汾�޴˹���!');EXIT; END;//��̬���ӿ�TJ.DLL������
  DLLProc:=TDLLProc(GETPROCADDRESS(HTJLIB,'ShowTJForm'));
  IF @DLLProc=NIL THEN BEGIN SHOWMESSAGE('����ShowTJForm������!');EXIT; END;
  FExecute:=DLLProc(Application.Handle,ADObasic,Pchar(StrImeName),false,Pchar(operator_id));
  FreeLIBRARY(HTJLIB);

  if FExecute then
  begin
    ff:=adobasic.fieldbyname('Ψһ���').AsInteger;
    ADObasic.Requery();//ˢ��
    adobasic.Locate('Ψһ���',ff,[loCaseInsensitive]);
  end;
end;//}

procedure TfrmCommQuery.frReport1BeforePrint(Memo: TStringList;
  View: TfrView);
var
  adotemp11:tadoquery;
  unid:integer;

  strsqlPrint,strEnglishName,strHistogram,strXTitle:string;
  MS:tmemorystream;
  tempjpeg:TJPEGImage;
  Chart_ZFT:TChart;

  //Ѫ�������start
  Reserve8_1,Reserve8_2:single;//�б���
  mPa_1,mPa_2:string;//ճ��
  mPa_min_1,mPa_min_2:string;//ճ��
  mPa_max_1,mPa_max_2:string;//ճ��
  Chart_XLB:TChart;
  //Ѫ�������stop

  mvPictureTitle :TfrView;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('Ψһ���').AsInteger;

  //����Ѫ�������ߡ�ֱ��ͼ��ɢ��ͼ start
  if(View is TfrChartView)and(pos('CURVE',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strsqlPrint:='select Reserve8,itemValue,Min_Value,Max_Value '+
       ' from chk_valu_bak '+
       ' where pkunid=:pkunid '+
       ' and Reserve8 is not null '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    adotemp11.Open;
    if adotemp11.RecordCount=2 then
    begin
      View.Visible:=true;

      Chart_XLB:=TChart.Create(nil);
      Chart_XLB.Visible:=false;
      
      Reserve8_1:=adotemp11.fieldbyname('Reserve8').AsFloat;//�б���
      mPa_1:=adotemp11.fieldbyname('itemValue').AsString;//ճ��
      mPa_min_1:=adotemp11.fieldbyname('Min_Value').AsString;//ճ��
      mPa_max_1:=adotemp11.fieldbyname('Max_Value').AsString;//ճ��
      adotemp11.Next;
      Reserve8_2:=adotemp11.fieldbyname('Reserve8').AsFloat;//�б���
      mPa_2:=adotemp11.fieldbyname('itemValue').AsString;//ճ��
      mPa_min_2:=adotemp11.fieldbyname('Min_Value').AsString;//ճ��
      mPa_max_2:=adotemp11.fieldbyname('Max_Value').AsString;//ճ��
      sdiappform.Draw_MVIS2035_Curve(Chart_XLB,Reserve8_1,strtofloatdef(mPa_1,-1),Reserve8_2,strtofloatdef(mPa_2,-1),
                          Reserve8_1,strtofloatdef(mPa_min_1,-1),Reserve8_2,strtofloatdef(mPa_min_2,-1),
                          Reserve8_1,strtofloatdef(mPa_max_1,-1),Reserve8_2,strtofloatdef(mPa_max_2,-1));
      TfrChartView(View).Assignchart(Chart_XLB);//ָ��ͳ��ͼ�oFastReport

      Chart_XLB.Free;
    end;
    adotemp11.Free;
  end;

  if(View is TfrChartView)and(pos('CHART',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strEnglishName:=(View as TfrChartView).Name;
    strEnglishName:=stringreplace(strEnglishName,'Chart','',[rfIgnoreCase]);
    strsqlPrint:='select top 1 histogram,Dosage1 '+
       ' from chk_valu_bak '+
       ' where pkunid=:pkunid '+
       ' and english_name=:english_name '+
       ' and isnull(histogram,'''')<>'''' '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    adotemp11.Parameters.ParamByName('english_name').Value:=strEnglishName;
    adotemp11.Open;
    strHistogram:=trim(adotemp11.fieldbyname('histogram').AsString);
    strXTitle:=adotemp11.fieldbyname('Dosage1').AsString;
    adotemp11.Free;
    if strHistogram<>'' then
    begin
      View.Visible:=true;
      
      Chart_ZFT:=TChart.Create(nil);
      Chart_ZFT.Visible:=false;

      sdiappform.updatechart(Chart_ZFT,strHistogram,strEnglishName,strXTitle);
      TfrChartView(View).Assignchart(Chart_ZFT);//ָ��ͳ��ͼ�oFastReport
        
      Chart_ZFT.Free;
    end;
  end;

  if(View is TfrPictureView)and(pos('PICTURE',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strEnglishName:=(View as TfrPictureView).Name;
    strEnglishName:=stringreplace(strEnglishName,'Picture','',[rfIgnoreCase]);
    strsqlPrint:='select top 1 Photo,english_name '+
       ' from chk_valu_bak '+
       ' where pkunid=:pkunid '+
       //' and english_name=:english_name '+
       ' and itemid=:itemid '+//edit by liuying 20110414
       ' and Photo is not null '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    //adotemp11.Parameters.ParamByName('english_name').Value:=strEnglishName;
    adotemp11.Parameters.ParamByName('itemid').Value:=strEnglishName;//edit by liuying 20110414
    adotemp11.Open;
    if not adotemp11.fieldbyname('photo').IsNull then
    begin
      View.Visible:=true;
      MS:=TMemoryStream.Create;
      TBlobField(adotemp11.fieldbyname('photo')).SaveToStream(MS);
      MS.Position:=0;
      tempjpeg:=TJPEGImage.Create;
      tempjpeg.LoadFromStream(MS);
      MS.Free;
      TfrPictureView(View).Picture.assign(tempjpeg);
      tempjpeg.Free;

      //��ʾͼƬ����begin
      mvPictureTitle:=frReport1.FindObject('mv'+(View as TfrPictureView).Name);
      if (mvPictureTitle<>nil) and (mvPictureTitle is TfrMemoView) then
      begin
        mvPictureTitle.Prop['AutoWidth']:=True;
        TfrMemoView(mvPictureTitle).Font.Name:='����';
        mvPictureTitle.SetBounds((View as TfrPictureView).Prop['left'], (View as TfrPictureView).Prop['top']-20, 50, 20);
        mvPictureTitle.Memo.Text:=adotemp11.fieldbyname('english_name').AsString;
        mvPictureTitle.Visible:=true;
      end;
      //��ʾͼƬ����end
    end;
    adotemp11.Free;
  end;
  //����Ѫ�������ߡ�ֱ��ͼ��ɢ��ͼ stop
end;

procedure TfrmCommQuery.frReport1PrintReport;
var
  unid,printtimes:integer;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('Ψһ���').AsInteger;
  printtimes:=ADObasic.fieldbyname('��ӡ����').AsInteger;
  
  if printtimes=0 then//�޸Ĵ�ӡ����
    ExecSQLCmd(LisConn,'update chk_con_bak set printtimes='+inttostr(printtimes+1)+' where unid='+inttostr(unid));
  
  ExecSQLCmd(LisConn,'insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values ('+inttostr(unid)+','''+operator_name+''',''Class_Print'',''Lab'')');
end;

procedure TfrmCommQuery.BitBtn5Click(Sender: TObject);
begin
  ADObasic.First;
  while not ADObasic.Eof do
  begin
    if RadioGroup1.ItemIndex=0 then BitBtn1Click(nil);
    if RadioGroup1.ItemIndex=1 then BitBtn3Click(nil);

    ADObasic.Next;
  end;
end;

procedure TfrmCommQuery.Excel1Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= ADObasic;
  //LYDataToExcel1.ExcelTitel:=BBBT;
  LYDataToExcel1.Execute;
end;

initialization
  ffrmCommQuery:=nil;
end.
