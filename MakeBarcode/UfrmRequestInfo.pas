unit UfrmRequestInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Uni, ComCtrls, StrUtils, Grids,
  DBGrids, DB, ADODB, MemDS, VirtualTable, Menus;

type
  TfrmRequestInfo = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    LabeledEdit1: TLabeledEdit;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ADOQuery1: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure VirtualTable1AfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
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
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from make_barcode where req_header_id=:req_header_id';
  ADOQuery1.Parameters.ParamByName('req_header_id').Value :=LabeledEdit1.Text;
  ADOQuery1.Open;
end;

procedure TfrmRequestInfo.N1Click(Sender: TObject);
begin
  if ADOQuery1.RecordCount<=0 then exit;

  ExecSQLCmd(LisConn,'delete from make_barcode where req_detail_id='''+ADOQuery1.fieldbyname('req_detail_id').AsString+''' ');
  ADOQuery1.Refresh;
end;

procedure TfrmRequestInfo.VirtualTable1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
   
  DBGrid1.Columns[0].Width:=100;
  DBGrid1.Columns[1].Width:=100;
  DBGrid1.Columns[2].Width:=100;
  DBGrid1.Columns[3].Width:=200;
end;

procedure TfrmRequestInfo.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=frmMain.ADOConnection1;
end;

initialization
  ffrmRequestInfo:=nil;

end.
