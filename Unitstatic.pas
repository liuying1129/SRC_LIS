unit Unitstatic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,ComCtrls, DB,
  ADODB, ToolWin,  Grids, DBGrids, Buttons,
  ULYDataToExcel, TeeProcs, TeEngine, Chart, Series;

type
  TFormstatic = class(TForm)
    suiFormstatic: TPanel;
    GroupBox1: TGroupBox;
    ADOcombin_dtl: TADOQuery;
    DScombin_dtl: TDataSource;
    DS_static: TDataSource;
    ADO_static: TADOQuery;
    ADO_temp: TADOQuery;
    ds_temp: TDataSource;
    tsDBGrid1: TDBGrid;
    Panel2: TPanel;
    GroupBox3: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    LYDataToExcel1: TLYDataToExcel;
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Chart1: TChart;
    Series1: TBarSeries;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure ADO_tempAfterOpen(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure tsDBGrid1DblClick(Sender: TObject);
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
  
  ADOcombin_dtl.Connection := DM.ADOConnection1;
  ADO_static.Connection:=DM.ADOConnection1;
  ADO_temp.Connection:=DM.ADOConnection1;
  ADO_static.Open;
  ADOcombin_dtl.Open;
end;

procedure TFormstatic.DBGrid1DblClick(Sender: TObject);
VAR
  ADOTEMP11:TADOQUERY;
begin
  if not ADOcombin_dtl.Active then exit;
  if ADOcombin_dtl.RecordCount=0 then exit;
  
  ADOTEMP11:=TADOQUERY.Create(NIL);
  ADOTEMP11.Connection:=DM.ADOConnection1;
  ADOTEMP11.Close;
  ADOTEMP11.SQL.Clear;
  ADOTEMP11.SQL.Add('insert into static_temp(name,itemid)'+
          ' values(:name,:itemid)');
  ADOTEMP11.Parameters.ParamByName('name').Value:=
          ADOcombin_dtl.Fieldbyname('项目名称').AsString;
  ADOTEMP11.Parameters.ParamByName('itemid').Value:=
          ADOcombin_dtl.Fieldbyname('项目代码').AsString;
  try
    ADOTEMP11.ExecSQL;
  except
    showmessage('该项目已在统计列表中！');
  end;
  ADOTEMP11.Free;

  ADO_static.Close;
  ADO_static.Open;
end;

procedure TFormstatic.DBGrid2DblClick(Sender: TObject);
begin
  if((not ADO_static.Active) or (ADO_static.RecordCount<1)) then
    exit;
  ADO_static.Delete;
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
  LYDataToExcel1.ExcelTitel:=SCSYDW+'检验统计';
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
var
  adotemp11:tadoquery;
  sAnomalyRate:string;
  fAnomalyRate:single;
begin
  tsDBGrid1.Columns[0].Width:=60;
  tsDBGrid1.Columns[1].Width:=60;

  //========================绘制异常率柱状图==================================//
  Series1.Clear;
  
  if(RadioGroup1.ItemIndex=2) then
  begin
    adotemp11:=tadoquery.Create(nil);
    adotemp11.clone(ADO_temp);
    adotemp11.First;
    while not adotemp11.Eof do
    begin
      sAnomalyRate:=stringreplace(adotemp11.fieldbyname('异常率').AsString,'%','',[rfReplaceAll,rfIgnoreCase]);
      if not trystrtofloat(sAnomalyRate,fAnomalyRate) then begin adotemp11.Next;continue;end;
      Series1.AddBar(fAnomalyRate,adotemp11.fieldbyname('项目名称').AsString,clTeeColor);
      adotemp11.Next;
    end;
    adotemp11.Free;
  end;
  //==========================================================================//
end;

procedure TFormstatic.SpeedButton1Click(Sender: TObject);
VAR
  ADOTEMP11:TADOQUERY;
begin
  SpeedButton2Click(SpeedButton2); //先清除所有项目

  ADOTEMP11:=TADOQUERY.Create(NIL);
  ADOTEMP11.Connection:=DM.ADOConnection1;
  ADOTEMP11.Close;
  ADOTEMP11.SQL.Clear;
  ADOTEMP11.SQL.text:='insert into static_temp(name,itemid)'+
          ' select distinct name,itemid from chk_valu_bak ';     
  try
    ADOTEMP11.ExecSQL;
  except
    showmessage('该项目已在统计列表中！');
  end;
  ADOTEMP11.Free;

  ADO_static.Close;
  ADO_static.Open;
end;

procedure TFormstatic.SpeedButton2Click(Sender: TObject);
begin
  ExecSQLCmd(LisConn,'delete from static_temp');
  
  ADO_static.Close;
  ADO_static.Open;
end;

procedure TFormstatic.tsDBGrid1DblClick(Sender: TObject);
var
  adotemp11:tadoquery;
  sAnomalyRate:string;
  fAnomalyRate:single;
  itemname:string;
begin
  //========================绘制异常率柱状图==================================//
  Series1.Clear;

  if not tsDBGrid1.DataSource.DataSet.Active then exit;
  if tsDBGrid1.DataSource.DataSet.RecordCount=0 then exit;

  itemname:=tsDBGrid1.DataSource.DataSet.fieldbyname('项目名称').AsString;

  if(RadioGroup1.ItemIndex=5) then
  begin
    adotemp11:=tadoquery.Create(nil);
    adotemp11.clone(ADO_temp);
    adotemp11.First;
    while not adotemp11.Eof do
    begin
      sAnomalyRate:=stringreplace(adotemp11.fieldbyname('异常率').AsString,'%','',[rfReplaceAll,rfIgnoreCase]);
      if not trystrtofloat(sAnomalyRate,fAnomalyRate) then begin adotemp11.Next;continue;end;
      if adotemp11.fieldbyname('项目名称').AsString<>itemname then begin adotemp11.Next;continue;end;

      Series1.AddBar(fAnomalyRate,adotemp11.fieldbyname('所属部门').AsString,clTeeColor);
      adotemp11.Next;
    end;
    adotemp11.Free;
  end;  

  if(RadioGroup1.ItemIndex=6) then
  begin
    adotemp11:=tadoquery.Create(nil);
    adotemp11.clone(ADO_temp);
    adotemp11.First;
    while not adotemp11.Eof do
    begin
      sAnomalyRate:=stringreplace(adotemp11.fieldbyname('异常率').AsString,'%','',[rfReplaceAll,rfIgnoreCase]);
      if not trystrtofloat(sAnomalyRate,fAnomalyRate) then begin adotemp11.Next;continue;end;
      if adotemp11.fieldbyname('项目名称').AsString<>itemname then begin adotemp11.Next;continue;end;

      Series1.AddBar(fAnomalyRate,adotemp11.fieldbyname('所属工种').AsString,clTeeColor);
      adotemp11.Next;
    end;
    adotemp11.Free;
  end;  
  //==========================================================================//
end;

initialization
  fFormstatic:=nil;
end.

