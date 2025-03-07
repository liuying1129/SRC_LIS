unit UfrmRequestInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  ExtCtrls, StdCtrls, Buttons, DB, Grids, DBGrids,
  DBAccess, Uni, MemDS, ComCtrls;

type
  TfrmRequestInfo = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    UniQuery1: TUniQuery;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UniQuery1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  frmRequestInfo: TfrmRequestInfo;

implementation

uses UfrmMain;

var
  ffrmRequestInfo: TfrmRequestInfo;
  
{$R *.dfm}

function  frmRequestInfo: TfrmRequestInfo;
begin
  if ffrmRequestInfo=nil then ffrmRequestInfo:=TfrmRequestInfo.Create(application.mainform);
  result:=ffrmRequestInfo;
end;

procedure TfrmRequestInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmRequestInfo=self then ffrmRequestInfo:=nil;
end;

procedure TfrmRequestInfo.BitBtn1Click(Sender: TObject);
//因【查看申请单】功能一般仅在调试时使用，故该功能并未兼容莱域PEIS
var
  ssName,ssBarcode:String;
  ViewName:String;
begin
  ViewName:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''样本接收'' and id=''视图名称'' ');
  if ViewName='' then ViewName:='view_test_request';
  
  ssName:='';
  ssBarcode:='';
  if trim(LabeledEdit1.Text)<>'' then ssName:=' and patientname='''+LabeledEdit1.Text+''' ';
  if trim(LabeledEdit2.Text)<>'' then ssBarcode:=' and barcode='''+LabeledEdit2.Text+''' ';

  UniQuery1.Close;
  UniQuery1.SQL.Clear;
  UniQuery1.SQL.Text:='select * from '+ViewName+' where req_time between :DateTimePicker1 and :DateTimePicker2'+ssName+ssBarcode;
  UniQuery1.ParamByName('DateTimePicker1').Value:=DateTimePicker1.DateTime;
  UniQuery1.ParamByName('DateTimePicker2').Value:=DateTimePicker2.DateTime;
  UniQuery1.Open;
end;

procedure TfrmRequestInfo.FormShow(Sender: TObject);
begin
  UniQuery1.Connection:=frmMain.UniConnExtSystem;

  DateTimePicker1.Date:=Date-1;
  DateTimePicker2.Date:=Date;
end;

procedure TfrmRequestInfo.UniQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  
  dbgrid1.Columns[0].Width:=60;
  dbgrid1.Columns[1].Width:=60;
  dbgrid1.Columns[2].Width:=60;
  dbgrid1.Columns[3].Width:=60;
  dbgrid1.Columns[4].Width:=60;
  dbgrid1.Columns[5].Width:=60;
  dbgrid1.Columns[6].Width:=60;
  dbgrid1.Columns[7].Width:=60;
  dbgrid1.Columns[8].Width:=60;
  dbgrid1.Columns[9].Width:=60;
end;

initialization
  ffrmRequestInfo:=nil;

end.
