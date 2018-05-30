unit UfrmLeakItemWarning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB;

type
  TfrmLeakItemWarning = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmLeakItemWarning: TfrmLeakItemWarning;

function frmLeakItemWarning: TfrmLeakItemWarning;    {��̬�������庯��}

implementation

uses UDM;

var
  ffrmLeakItemWarning: TfrmLeakItemWarning;           {���صĴ������,���رմ����ͷ��ڴ�ʱ����}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmLeakItemWarning: TfrmLeakItemWarning;    {��̬�������庯��}
begin
  if ffrmLeakItemWarning=nil then ffrmLeakItemWarning:=TfrmLeakItemWarning.Create(application.mainform);
  result:=ffrmLeakItemWarning;
end;

procedure TfrmLeakItemWarning.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmLeakItemWarning=self then ffrmLeakItemWarning:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmLeakItemWarning.FormShow(Sender: TObject);
begin
  ADOQuery1.Connection := DM.ADOConnection1;

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from view_LeakItem_Warning ';
  ADOQuery1.Open;  
end;

procedure TfrmLeakItemWarning.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid1.Columns[0].Width:=86;//�ܼ�걾ΨһID
  dbgrid1.Columns[1].Width:=62;//�ܼ�������
  dbgrid1.Columns[2].Width:=70;//������
  dbgrid1.Columns[3].Width:=75;//�����Ŀ����
  dbgrid1.Columns[4].Width:=75;//�����Ŀ����
  dbgrid1.Columns[5].Width:=149;//����������ĿС��Ŀ����
  dbgrid1.Columns[6].Width:=149;//���õ������ĿС��Ŀ����
end;

initialization
  ffrmLeakItemWarning:=nil;
end.
