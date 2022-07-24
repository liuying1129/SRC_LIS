unit UfrmStaticCombItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB,inifiles, ComCtrls, StdCtrls, Buttons, Grids, DBGrids,
  ExtCtrls, ULYDataToExcel;

type
  TfrmStaticCombItem = class(TForm)
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    BitBtn2: TBitBtn;
    LYDataToExcel1: TLYDataToExcel;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    HBsAg: TComboBox;
    HBsAb: TComboBox;
    HBeAg: TComboBox;
    HBeAb: TComboBox;
    HBcAb: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  frmStaticCombItem: TfrmStaticCombItem;

implementation

uses UDM;
var
  ffrmStaticCombItem: TfrmStaticCombItem;

{$R *.dfm}

function  frmStaticCombItem: TfrmStaticCombItem;
begin
  if ffrmStaticCombItem=nil then ffrmStaticCombItem:=tfrmStaticCombItem.Create(application.mainform);
  result:=ffrmStaticCombItem;
end;

procedure TfrmStaticCombItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmStaticCombItem=self then ffrmStaticCombItem:=nil;
end;

procedure TfrmStaticCombItem.FormCreate(Sender: TObject);
Begin
  adoquery1.Connection:=DM.ADOConnection1;
end;

procedure TfrmStaticCombItem.BitBtn1Click(Sender: TObject);
VAR
  Save_Cursor:TCursor;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='dbo.pro_StaticCombItem :P_DateTimePicker1,:P_DateTimePicker2,'''+ComboBox1.Text+''' ';
  adoquery1.Parameters.ParamByName('P_DateTimePicker1').Value:=DateTimePicker1.DateTime;//设计期Time设置为00:00:00.放心,下拉选择日期时不会改变Time值
  adoquery1.Parameters.ParamByName('P_DateTimePicker2').Value:=DateTimePicker2.DateTime;//设计期Time设置为23:59:59.放心,下拉选择日期时不会改变Time值

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    adoquery1.Open;
  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;
end;

procedure TfrmStaticCombItem.BitBtn2Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= adoQuery1;
  LYDataToExcel1.ExcelTitel:='标题';
  LYDataToExcel1.Execute;
end;

procedure TfrmStaticCombItem.FormShow(Sender: TObject);
const
  StaticFlag='if @in_StaticType=''';//存储过程中表示统计类型的行。大小写无所谓
var
  adotemp11:Tadoquery;
  sStaticType:string;

  ConfigIni:tinifile;
begin
  DateTimePicker2.Date := date;
  DateTimePicker1.Date := date-30;

  //加载统计类型start
  ComboBox1.Clear;
  adotemp11:=Tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='sp_helptext ''dbo.pro_StaticCombItem'' ';
  adotemp11.Open;
  while not adotemp11.Eof do
  begin
    sStaticType:=adotemp11.fieldbyname('Text').AsString;

    if pos(uppercase(StaticFlag),uppercase(sStaticType))<=0 then
    begin
      adotemp11.Next;
      continue;
    end;
    
    sStaticType:=copy(sStaticType,pos(uppercase(StaticFlag),uppercase(sStaticType)),MaxInt);
    sStaticType:=copy(sStaticType,length(StaticFlag)+1,MaxInt);
    sStaticType:=copy(sStaticType,1,pos('''',sStaticType)-1);
    ComboBox1.Items.Add(sStaticType);

    adotemp11.Next;
  end;
  adotemp11.Free;
  //加载统计类型stop

  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  ComboBox1.Text:=CONFIGINI.ReadString('Interface','StaticType','');
  configini.Free;
end;

procedure TfrmStaticCombItem.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  dbgrid1.Columns[0].Width:=100;
  dbgrid1.Columns[1].Width:=100;
  dbgrid1.Columns[2].Width:=100;
  //dbgrid1.Columns[3].Width:=100;
end;

procedure TfrmStaticCombItem.BitBtn3Click(Sender: TObject);
VAR
  Save_Cursor:TCursor;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='dbo.pro_StaticHBV :P_DateTimePicker1,:P_DateTimePicker2,'''+HBsAg.Text+''','''+HBsAb.Text+''','''+HBeAg.Text+''','''+HBeAb.Text+''','''+HBcAb.Text+''' ';
  adoquery1.Parameters.ParamByName('P_DateTimePicker1').Value:=DateTimePicker1.DateTime;//设计期Time设置为00:00:00.放心,下拉选择日期时不会改变Time值
  adoquery1.Parameters.ParamByName('P_DateTimePicker2').Value:=DateTimePicker2.DateTime;//设计期Time设置为23:59:59.放心,下拉选择日期时不会改变Time值

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    adoquery1.Open;
  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;
end;

procedure TfrmStaticCombItem.FormDestroy(Sender: TObject);
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  configini.WriteString('Interface','StaticType',ComboBox1.Text);
  configini.Free;
end;

initialization
  ffrmStaticCombItem:=nil;

end.
