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
    tsDBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
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
  DateTimePicker1.Date := date-30;

  ADO_temp.Connection:=DM.ADOConnection1;
end;

procedure TFormstatic.BitBtn1Click(Sender: TObject);
VAR
  Save_Cursor:TCursor;
begin
  ado_temp.Close;
  ado_temp.SQL.Clear;
  ado_temp.SQL.Add('pro_Static :P_DateTimePicker1,:P_DateTimePicker2,'+INTTOSTR(RadioGroup1.ItemIndex));
  ado_temp.Parameters.ParamByName('P_DateTimePicker1').Value:=DateTimePicker1.DateTime;//设计期Time设置为00:00:00.放心,下拉选择日期时不会改变Time值
  ado_temp.Parameters.ParamByName('P_DateTimePicker2').Value:=DateTimePicker2.DateTime;//设计期Time设置为23:59:59.放心,下拉选择日期时不会改变Time值

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
  LYDataToExcel1.ExcelTitel:=SCSYDW+'检验统计';
  LYDataToExcel1.Execute;
end;

procedure TFormstatic.ADO_tempAfterOpen(DataSet: TDataSet);
begin
  tsDBGrid1.Columns[0].Width:=100;
  tsDBGrid1.Columns[1].Width:=100;
end;

initialization
  fFormstatic:=nil;
end.

