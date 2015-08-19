unit UfrmCommValue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, ActnList;

type
  TfrmCommValue = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    CheckBox1: TCheckBox;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    BitBtn4: TBitBtn;
    LabeledEdit1: TMemo;
    Label1: TLabel;
    Label7: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
    pItemUnid:integer;
    procedure UpdateAdoquery1;
    procedure updateEdit;
    procedure ClearEdit;
  public
    { Public declarations }
  end;

//var
function  frmCommValue(const AItemUnid:integer): TfrmCommValue;

implementation

uses UDM;
var
  ffrmCommValue: TfrmCommValue;
  ifNewAdd:boolean;

{$R *.dfm}

function frmCommValue(const AItemUnid:integer): TfrmCommValue;
begin
  if ffrmCommValue=nil then ffrmCommValue:=TfrmCommValue.Create(application.mainform);
  result:=ffrmCommValue;
  frmCommValue.pItemUnid:=AItemUnid;
end;

procedure TfrmCommValue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCommValue=self then ffrmCommValue:=nil;
end;

procedure TfrmCommValue.UpdateAdoquery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select sValue as 常见结果,dfValue as 默认结果,Unid from CommValue where ItemUnid=:ItemUnid ';
  adoquery1.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;
  adoquery1.Open;
end;

procedure TfrmCommValue.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  ifNewAdd:=false;

  updateEdit;
end;

procedure TfrmCommValue.updateEdit;
begin
  if adoquery1.RecordCount>0 then
  begin
    LabeledEdit1.Text:=trim(adoquery1.fieldbyname('常见结果').AsString);
    CheckBox1.Checked:=adoquery1.fieldbyname('默认结果').AsBoolean;
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmCommValue.FormShow(Sender: TObject);
begin
  UpdateAdoquery1;
end;

procedure TfrmCommValue.FormCreate(Sender: TObject);
begin
  adoquery1.Connection:=DM.ADOConnection1;
end;

procedure TfrmCommValue.BitBtn1Click(Sender: TObject);
begin
  ClearEdit;
  LabeledEdit1.SetFocus;
  ifNewAdd:=true;
end;

procedure TfrmCommValue.ClearEdit;
begin
  LabeledEdit1.Clear;
  CheckBox1.Checked:=false;
end;

procedure TfrmCommValue.BitBtn2Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //新增
  begin
    ifNewAdd:=false;

    sqlstr:='Insert into CommValue ('+
                        ' ItemUnid,sValue,dfValue) values ('+
                        ' :ItemUnid,:sValue,:dfValue) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;
    adotemp11.Parameters.ParamByName('sValue').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('dfValue').Value:=CheckBox1.Checked;
    adotemp11.Open;
    ADOQuery1.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //修改
  begin
    IF AdoQuery1.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('没有记录供你修改，若要新增，请先点击"新增按钮"！');
      EXIT;
    END;
    Insert_Identity:=ADOQuery1.fieldbyname('Unid').AsInteger;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update CommValue  '+
    '  set sValue=:sValue,dfValue=:dfValue '+
    '  Where    Unid=:Unid      ';
    //adotemp11.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;//ItemUnid=:ItemUnid,
    adotemp11.Parameters.ParamByName('sValue').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('dfValue').Value:=CheckBox1.Checked;
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    adotemp11.ExecSQL;
    AdoQuery1.Refresh;
  end;

  adotemp11.Free;
  AdoQuery1.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
  updateEdit;
end;

procedure TfrmCommValue.BitBtn3Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  
  if (MessageDlg('确实要删除该记录吗？',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

  DBGrid1.DataSource.DataSet.Delete;
end;

procedure TfrmCommValue.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid1.Columns.Items[0].Width:=360;
end;

procedure TfrmCommValue.BitBtn4Click(Sender: TObject);
begin
  close;
end;

initialization
  ffrmCommValue:=nil;

end.
