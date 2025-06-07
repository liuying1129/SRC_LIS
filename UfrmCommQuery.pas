unit UfrmCommQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,ADODB,StrUtils,
  Series, Chart,
  UADOLYQuery,ComObj,Jpeg, Menus,inifiles,Printers, ULYDataToExcel,
  frxClass;

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
    ADObasic: TADOQuery;
    ADO_print: TADOQuery;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    LYQuery1: TADOLYQuery;
    MasterDataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Label3: TLabel;
    N4: TMenuItem;
    Excel1: TMenuItem;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    LYDataToExcel1: TLYDataToExcel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure BitBtnCommQryCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Excel1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
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
    ' PushPress as �����ͽ���,PullPress as ����������,LeftEyesight as ��������,RightEyesight as ��������,Stature as ��������ʱ��,Weight as ����״̬, '+
    ' TjJiWangShi as ����ʷ,TjJiaZuShi as ����ʷ,TjNeiKe as �ڿ�,TjWaiKe as ���,TjWuGuanKe as ��ٿ�,TjFuKe as ����,TjLengQiangGuang as ��ǿ��,TjXGuang as X��,TjBChao as Σ��ֵ����ʱ��,TjXinDianTu as Σ��ֵ������,TjJianYan as �����,'+
    ' TjDescription as ����,TJAdvice as ����, '+
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

procedure TfrmCommQuery.Excel1Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= ADObasic;
  //LYDataToExcel1.ExcelTitel:=BBBT;
  LYDataToExcel1.Execute;
end;

procedure TfrmCommQuery.BitBtn6Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sCombin_Id:string;

  //���ձ��Ա�����ĺϲ�������ӡ��� ����
  sPatientname,sSex,sAge,sCheck_Date:string;
  //===============================  

  frxMasterData:TfrxMasterData;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('Ψһ���').AsString;//��ֹ�����ӡ�����Ͻ�����Ƶ���һ��������Ϣ�ϡ���д����ǰ��
  sCombin_Id:=adobasic.FieldByName('���').AsString;  

  sPatientname:=trim(adobasic.fieldbyname('����').AsString);
  sSex:=adobasic.fieldbyname('�Ա�').AsString;
  sAge:=adobasic.fieldbyname('����').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('�������').AsDateTime);
  
  DM.frxReport1.Clear;//�������ģ��
  DM.frxDBDataSet1.UserName:='ADObasic';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ
  DM.frxDBDataSet2.UserName:='ADO_print';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ

  if (sCombin_Id=WorkGroup_T1)
    and (DM.frxReport1.LoadFromFile(TempFile_T1)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T2)
    and (DM.frxReport1.LoadFromFile(TempFile_T2)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T3)
    and (DM.frxReport1.LoadFromFile(TempFile_T3)) then
  begin
  end else
  if not DM.frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_cur.fr3') then
  begin
    showmessage('����Ĭ��ͨ�ô�ӡģ��report_cur.fr3ʧ�ܣ�������:ϵͳ����->ѡ��->��ӡģ��');
    exit;
  end;

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

  {if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm}

  DM.frxDBDataSet1.DataSet:=ADObasic;//����Fastreport�������TDataset���ݼ�
  DM.frxDBDataSet2.DataSet:=ADO_print;//����Fastreport�������TDataset���ݼ�
  DM.frxReport1.DataSets.Clear;//���ԭ�������ݼ�
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet1);//���ع����õ�TfrxDBDataSet��������
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet2);//���ع����õ�TfrxDBDataSet��������
  
  frxMasterData:=DM.frxReport1.FindObject('MasterData1') as TfrxMasterData;
  if (frxMasterData<>nil) and (frxMasterData is TfrxMasterData) then frxMasterData.DataSet:=DM.frxDBDataSet2;//��̬����MasterData.DataSet
      
  if sdiappform.n9.Checked then  //Ԥ��ģʽ
  begin
    DM.frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;
    DM.frxReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //ֱ�Ӵ�ӡģʽ
  begin
    if DM.frxReport1.PrepareReport then begin DM.frxReport1.PrintOptions.ShowDialog:=false;DM.frxReport1.Print;end;
  end;
end;

procedure TfrmCommQuery.BitBtn7Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid:string;

  sPatientname,sSex,sAge,sCheck_Date,sCombin_Id:string;

  frxMasterData:TfrxMasterData;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('Ψһ���').AsString;//��ֹ�����ӡ�����Ͻ�����Ƶ���һ��������Ϣ�ϡ���д����ǰ��
  
  sPatientname:=trim(adobasic.fieldbyname('����').AsString);
  sSex:=adobasic.fieldbyname('�Ա�').AsString;
  sAge:=adobasic.fieldbyname('����').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('�������').AsDateTime);
  sCombin_Id:=adobasic.FieldByName('���').AsString;
  
  DM.frxReport1.Clear;//�������ģ��
  DM.frxDBDataSet1.UserName:='ADObasic';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ
  DM.frxDBDataSet2.UserName:='ADO_print';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ

  if (sCombin_Id=GP_WorkGroup_T1)
    and DM.frxReport1.LoadFromFile(GP_TempFile_T1) then//����ģ���ļ��ǲ����ִ�Сд��.���ַ���������ʧ��
  begin
  end else
  if (sCombin_Id=GP_WorkGroup_T2)
    and DM.frxReport1.LoadFromFile(GP_TempFile_T2) then
  begin
  end else
  if (sCombin_Id=GP_WorkGroup_T3)
    and DM.frxReport1.LoadFromFile(GP_TempFile_T3) then
  begin
  end else
  if not DM.frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_Cur_group.fr3') then
  begin
    showmessage('����Ĭ�Ϸ����ӡģ��report_Cur_group.fr3ʧ�ܣ�������:ϵͳ����->ѡ��->��ӡģ��');
    exit;
  end;

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

  {if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm}

  DM.frxDBDataSet1.DataSet:=ADObasic;//����Fastreport�������TDataset���ݼ�
  DM.frxDBDataSet2.DataSet:=ADO_print;//����Fastreport�������TDataset���ݼ�
  DM.frxReport1.DataSets.Clear;//���ԭ�������ݼ�
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet1);//���ع����õ�TfrxDBDataSet��������
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet2);//���ع����õ�TfrxDBDataSet��������
  
  frxMasterData:=DM.frxReport1.FindObject('MasterData1') as TfrxMasterData;
  if (frxMasterData<>nil) and (frxMasterData is TfrxMasterData) then frxMasterData.DataSet:=DM.frxDBDataSet2;//��̬����MasterData.DataSet
      
  if sdiappform.n9.Checked then  //Ԥ��ģʽ
  begin
    DM.frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;
    DM.frxReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //ֱ�Ӵ�ӡģʽ
  begin
    if DM.frxReport1.PrepareReport then begin DM.frxReport1.PrintOptions.ShowDialog:=false;DM.frxReport1.Print;end;
  end;
end;

initialization
  ffrmCommQuery:=nil;
end.
