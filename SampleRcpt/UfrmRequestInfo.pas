unit UfrmRequestInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Uni, ComCtrls, StrUtils,DB, ADODB,
  Grids, DBGrids, MemDS, DBAccess;

type
  TfrmRequestInfo = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

initialization
  ffrmRequestInfo:=nil;

end.
