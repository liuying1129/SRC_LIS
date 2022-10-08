unit Unitstatic;

interface

uses
  Windows, Messages, SysUtils, Forms, Buttons, ULYDataToExcel, Grids, DBGrids,
  StdCtrls, ExtCtrls, ComCtrls, DB, ADODB, Classes, Controls;

type
  TFormstatic = class(TForm)
    suiFormstatic: TPanel;
    ADO_temp: TADOQuery;
    ds_temp: TDataSource;
    LYDataToExcel1: TLYDataToExcel;
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    tsDBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure ADO_tempAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  Formstatic: TFormstatic;

implementation

uses  UDM;
var
  fFormstatic: TFormstatic;

{$R *.dfm}

function  Formstatic: TFormstatic;
begin
  if fFormstatic=nil then fFormstatic:=tFormstatic.Create(application.mainform);
  result:=fFormstatic;
end;

procedure TFormstatic.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if fFormstatic=self then fFormstatic:=nil;
end;

procedure TFormstatic.FormCreate(Sender: TObject);
begin
  DateTimePicker2.Date := date;
  LabeledEdit2.Text:=datetostr(date);
  DateTimePicker1.Date := date-30;
  LabeledEdit1.Text:=datetostr(date-30);
  
  ADO_temp.Connection:=DM.ADOConnection1;
end;

procedure TFormstatic.BitBtn1Click(Sender: TObject);
VAR
  Save_Cursor:TCursor;
begin
  ado_temp.Close;
  ado_temp.SQL.Clear;
  ado_temp.SQL.Add('pro_Static '''+trim(LabeledEdit1.Text)+''','''+trim(LabeledEdit2.Text)+''','+INTTOSTR(RadioGroup1.ItemIndex));

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    ado_temp.Open;
   finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;
end;

procedure TFormstatic.BitBtn2Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= ADO_temp;                     
  LYDataToExcel1.ExcelTitel:=SCSYDW+'ºÏ—ÈÕ≥º∆';
  LYDataToExcel1.Execute;
end;

procedure TFormstatic.DateTimePicker1Change(Sender: TObject);
begin
  LabeledEdit1.Text := Datetostr(tDateTimePicker(sender).Date);
end;

procedure TFormstatic.DateTimePicker2Change(Sender: TObject);
begin
  LabeledEdit2.Text := Datetostr(tDateTimePicker(sender).Date);
end;

procedure TFormstatic.ADO_tempAfterOpen(DataSet: TDataSet);
begin
  tsDBGrid1.Columns[0].Width:=100;
  tsDBGrid1.Columns[1].Width:=100;
end;

initialization
  fFormstatic:=nil;
end.

