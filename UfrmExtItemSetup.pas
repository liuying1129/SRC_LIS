unit UfrmExtItemSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, DB, ADODB, DosMove,StrUtils,
  ULYDataToExcel, ComCtrls;

type
  TfrmExtItemSetup = class(TForm)
    DosMove1: TDosMove;
    BitBtn2: TBitBtn;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit4: TMemo;
    Label1: TLabel;
    LabeledEdit5: TMemo;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
  private
    { Private declarations }
    procedure updateEdit;
  public
    { Public declarations }
  end;

//var
function  frmExtItemSetup(Const Item_Unid:integer): TfrmExtItemSetup;

implementation

uses    UDM, SDIMAIN;
var
  ffrmExtItemSetup: TfrmExtItemSetup;
  pItem_Unid:integer;
  
{$R *.dfm}
function  frmExtItemSetup(Const Item_Unid:integer): TfrmExtItemSetup;
begin
  if ffrmExtItemSetup=nil then ffrmExtItemSetup:=TfrmExtItemSetup.Create(application.mainform);
  pItem_Unid:=Item_Unid;
  result:=ffrmExtItemSetup;
end;

procedure TfrmExtItemSetup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmExtItemSetup=self then ffrmExtItemSetup:=nil;
end;

procedure TfrmExtItemSetup.FormShow(Sender: TObject);
begin
  updateEdit;
end;

procedure TfrmExtItemSetup.updateEdit;
var
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select Reserve1 as ±£Áô×Ö¶Î1,Reserve2 as ±£Áô×Ö¶Î2,Dosage1 as ±£Áô×Ö¶Î3,Dosage2 as ±£Áô×Ö¶Î4,'+
  'Reserve5 as ±£Áô×Ö¶Î5,Reserve6 as ±£Áô×Ö¶Î6,Reserve7 as ±£Áô×Ö¶Î7,Reserve8 as ±£Áô×Ö¶Î8,'+
  'Reserve9 as ±£Áô×Ö¶Î9,Reserve10 as ±£Áô×Ö¶Î10 from clinicchkitem WHERE unid='+inttostr(pItem_Unid);
  adotemp11.Open;
  LabeledEdit4.Text:=trim(adotemp11.fieldbyname('±£Áô×Ö¶Î1').AsString);
  LabeledEdit5.Text:=trim(adotemp11.fieldbyname('±£Áô×Ö¶Î2').AsString);
  LabeledEdit6.Text:=adotemp11.fieldbyname('±£Áô×Ö¶Î3').AsString;
  LabeledEdit7.Text:=trim(adotemp11.fieldbyname('±£Áô×Ö¶Î4').AsString);
  LabeledEdit8.Text:=adotemp11.fieldbyname('±£Áô×Ö¶Î5').AsString;
  LabeledEdit9.Text:=adotemp11.fieldbyname('±£Áô×Ö¶Î6').AsString;
  LabeledEdit10.Text:=adotemp11.fieldbyname('±£Áô×Ö¶Î7').AsString;
  LabeledEdit11.Text:=adotemp11.fieldbyname('±£Áô×Ö¶Î8').AsString;
  LabeledEdit12.Text:=adotemp11.fieldbyname('±£Áô×Ö¶Î9').AsString;
  LabeledEdit13.Text:=adotemp11.fieldbyname('±£Áô×Ö¶Î10').AsString;
  adotemp11.Free;
end;

procedure TfrmExtItemSetup.BitBtn2Click(Sender: TObject);
var
  adotemp11:tadoquery;
  iReserve5,iReserve6:integer;
  iReserve7,iReserve8:single;
  iReserve9,iReserve10:TDateTime;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update clinicchkitem  '+
    '  set Reserve1=:Reserve1,Reserve2=:Reserve2,Dosage1=:Reserve3,Dosage2=:Reserve4,Reserve5=:Reserve5,Reserve6=:Reserve6,Reserve7=:Reserve7,Reserve8=:Reserve8,Reserve9=:Reserve9,Reserve10=:Reserve10  '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('Reserve1').Value:=trim(LabeledEdit4.Text);
    adotemp11.Parameters.ParamByName('Reserve2').Value:=trim(LabeledEdit5.Text);
    adotemp11.Parameters.ParamByName('Reserve3').Value:=LabeledEdit6.Text;
    adotemp11.Parameters.ParamByName('Reserve4').Value:=trim(LabeledEdit7.Text);
    if trystrtoint(LabeledEdit8.Text,iReserve5) then
      adotemp11.Parameters.ParamByName('Reserve5').Value:=iReserve5
    else adotemp11.Parameters.ParamByName('Reserve5').Value:=null;
    if trystrtoint(LabeledEdit9.Text,iReserve6) then
      adotemp11.Parameters.ParamByName('Reserve6').Value:=iReserve6
    else adotemp11.Parameters.ParamByName('Reserve6').Value:=null;
    if trystrtofloat(LabeledEdit10.Text,iReserve7) then
      adotemp11.Parameters.ParamByName('Reserve7').Value:=iReserve7
    else adotemp11.Parameters.ParamByName('Reserve7').Value:=null;
    if trystrtofloat(LabeledEdit11.Text,iReserve8) then
      adotemp11.Parameters.ParamByName('Reserve8').Value:=iReserve8
    else adotemp11.Parameters.ParamByName('Reserve8').Value:=null;
    if trystrtodatetime(LabeledEdit12.Text,iReserve9) then
      adotemp11.Parameters.ParamByName('Reserve9').Value:=iReserve9
    else adotemp11.Parameters.ParamByName('Reserve9').Value:=null;
    if trystrtodatetime(LabeledEdit13.Text,iReserve10) then
      adotemp11.Parameters.ParamByName('Reserve10').Value:=iReserve10
    else adotemp11.Parameters.ParamByName('Reserve10').Value:=null;
    adotemp11.Parameters.ParamByName('Unid').Value:=pItem_Unid;
    adotemp11.ExecSQL;
  adotemp11.Free;
end;

procedure TfrmExtItemSetup.DateTimePicker1Change(Sender: TObject);
begin
  LabeledEdit12.Text:=datetostr((sender as TDateTimePicker).date);
end;

procedure TfrmExtItemSetup.DateTimePicker2Change(Sender: TObject);
begin
  LabeledEdit13.Text:=datetostr((sender as TDateTimePicker).date);
end;

initialization
  ffrmExtItemSetup:=nil;

end.
