program MakeBarcode;

uses
  Forms,
  UfrmMain in 'UfrmMain.pas' {frmMain},
  UfrmRequestInfo in 'UfrmRequestInfo.pas' {frmRequestInfo},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
