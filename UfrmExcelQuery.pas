unit UfrmExcelQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,ADODB,StrUtils,
  FR_DSet, FR_DBSet, FR_Class, TeEngine, Series, TeeProcs, Chart,fr_chart,
  UADOLYQuery, ULYDataToExcel;

type
  TfrmExcelQuery = class(TForm)
    pnlCommQryTop: TPanel;
    DBGridResult: TDBGrid;
    BitBtnCommQry: TBitBtn;
    BitBtnCommQryClose: TBitBtn;
    BitBtn1: TBitBtn;
    Masterquery: TADOQuery;
    LYQuery1: TADOLYQuery;
    MasterDataSource: TDataSource;
    LYDataToExcel1: TLYDataToExcel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure BitBtnCommQryCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure MasterqueryAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmCommQuery: TfrmCommQuery;

function frmExcelQuery:TfrmExcelQuery;    {��̬�������庯��}

implementation
uses  UDM;

var
  ffrmExcelQuery:TfrmExcelQuery;           {���صĴ������,���رմ����ͷ��ڴ�ʱ����}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmExcelQuery:TfrmExcelQuery;    {��̬�������庯��}
begin
  if ffrmExcelQuery=nil then ffrmExcelQuery:=TfrmExcelQuery.Create(application.mainform);
  result:=ffrmExcelQuery;
end;

procedure TfrmExcelQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmExcelQuery=self then ffrmExcelQuery:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmExcelQuery.BitBtnCommQryClick(Sender: TObject);
const
  sqlstr1='select Z.lsh as ��ˮ��,Z.checkid as ������,Z.caseno as ������,Z.check_date as �������,Z.patientname as ����,'+
    'Z.sex as �Ա�,'+
    'Z.age as ����,Z.bedno as ����,Z.deptname as �ͼ����,'+
    'Z.check_doctor as �ͼ�ҽ��,Z.operator as ������,Z.report_doctor as �����,Z.report_date as ��������,'+
    'Z.diagnosetype as ���ȼ���,Z.combin_id as �������,'+
    'Z.flagetype as ��������,Z.typeflagcase as �������,Z.diagnose as �ٴ����,'+
    'Z.issure as ��ע1z2y3xTABLENAME1T2S3RZ,Z.germname as ϸ��, '+
    'Z.WorkCompany as ������˾,Z.WorkDepartment as ��������,Z.WorkCategory as ����,Z.WorkID as ����,Z.ifMarry as ���,Z.OldAddress as ����,'+
    'Z.Address as סַ,Z.Telephone as �绰,Z.PushPress as �����ͽ���,Z.PullPress as ����������,'+
    'Z.LeftEyesight as ��������,Z.RightEyesight as ��������,Z.Stature as ��������ʱ��,Z.Weight as ����״̬,'+
    'Z.TjJiWangShi as ����ʷ,Z.TjJiaZuShi as ����ʷ,Z.TjNeiKe as �ڿ�,Z.TjWaiKe as ���,Z.TjWuGuanKe as ��ٿ�,'+
    'Z.TjFuKe as ����,Z.TjLengQiangGuang as ��ǿ��,Z.TjXGuang as X��,Z.TjBChao as Σ��ֵ����ʱ��,Z.TjXinDianTu as Σ��ֵ������,TjJianYan as �����,'+
    'Z.TjDescription as ����,Z.TJAdvice as ����, '+
    ' C.name as ��Ŀ����,C.english_name as ��ĿӢ����,C.itemvalue as ������,C.unit as ��λ,'+
    ' C.min_value as ��Сֵ,C.max_value as ���ֵ,C.pkcombin_id as �����Ŀ��,C.printorder as ��ӡ���,C.itemid AS ��Ŀ����,Z.Audit_Date as ���ʱ��,c.combin_name as �����Ŀ���� '+
    ' from chk_con_BAK Z,chk_valu_bak C '+
    ' WHERE Z.UNID=C.PKUNID '+
    ' order by �������,��ˮ��,�����Ŀ��,��ӡ��� ';
VAR
  Save_Cursor:TCursor;
begin
  lyquery1.Connection:=DM.ADOConnection1;
  lyquery1.SelectString:=sqlstr1;
  if lyquery1.Execute then
  begin
    MasterQuery.SQL.Text:=lyquery1.ResultSelect;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    { Show hourglass cursor }
    try
      MasterQuery.Open;
    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;
  end;
end;

procedure TfrmExcelQuery.BitBtnCommQryCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmExcelQuery.FormCreate(Sender: TObject);
begin
  Masterquery.Connection:=DM.ADOConnection1;
end;

procedure TfrmExcelQuery.BitBtn1Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= Masterquery;                     
  //LYDataToExcel1.ExcelTitel:=BBBT;                      
  LYDataToExcel1.Execute;
end;

procedure TfrmExcelQuery.MasterqueryAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
    for i :=0  to DBGridResult.Columns.Count-1 do
    begin
       DBGridResult.Columns[i].Width:=55;
       if (i=3)or(i=12)or(i=2) then dbgridresult.Columns[i].Width:=70;//������ڣ���������,������
    end;
end;

initialization
  ffrmExcelQuery:=nil;
end.
