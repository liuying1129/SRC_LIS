unit UfrmHistoryResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, Series,StrUtils, StdCtrls;

type
  TfrmHistoryResult = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Chart1DblClick(Sender: TObject);
  private
    { Private declarations }
    psHistorySeries:string;
  public
    { Public declarations }
  end;

//var
function frmHistoryResult(CONST sHistorySeries:STRING): TfrmHistoryResult;

implementation
var
  ffrmHistoryResult:TfrmHistoryResult;

{$R *.dfm}
function frmHistoryResult(CONST sHistorySeries:STRING): TfrmHistoryResult;
begin
  if ffrmHistoryResult=nil then ffrmHistoryResult:=TfrmHistoryResult.Create(application.mainform);
  ffrmHistoryResult.psHistorySeries:=sHistorySeries;
  result:=ffrmHistoryResult;
end;

procedure TfrmHistoryResult.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmHistoryResult=self then ffrmHistoryResult:=nil;
end;

procedure TfrmHistoryResult.FormShow(Sender: TObject);
var
  iJW,iZJ,iName:integer;
  itemName,s1,sdate,svalue:string;
  fdate:tdatetime;
  fvalue:single;
begin
  iName:=pos(#$1,psHistorySeries);
  //itemName:=leftstr(psHistorySeries,iName);
  itemName:=copy(psHistorySeries,1,iName);
  chart1.Title.Text.Text:='检验项目'''+trim(itemName)+'''的历史检验结果';
  delete(psHistorySeries,1,iName);

  iJW:=pos(#$3,psHistorySeries);
  while iJW<>0 do
  begin
    s1:=leftstr(psHistorySeries,iJW);//一个历史结果，包括日期、结果
    iZJ:=pos(#$2,s1);
    sdate:=leftstr(s1,iZJ);
    delete(s1,1,iZJ);
    svalue:=s1;

    memo1.Lines.Add(trim(sdate)+' '+trim(svalue));
    if trystrtodatetime(trim(sdate),fdate) and trystrtofloat(trim(svalue),fvalue) then
      chart1.Series[0].AddXY(fdate,fvalue,trim(sdate));

    delete(psHistorySeries,1,iJW);
    iJW:=pos(#$3,psHistorySeries);
  end;
end;

procedure TfrmHistoryResult.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=27 then close;
end;

procedure TfrmHistoryResult.Chart1DblClick(Sender: TObject);
begin
  close;
end;

initialization
  ffrmHistoryResult:=nil;

end.
