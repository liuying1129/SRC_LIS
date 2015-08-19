unit UfrmExceptionValue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, ActnList;

type
  TfrmExceptionValue = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    BitBtn4: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    LabeledEdit1: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
function frmExceptionValue(const AItemUnid:integer): TfrmExceptionValue;

implementation

uses UDM;
var
  ffrmExceptionValue: TfrmExceptionValue;
  ifNewAdd:boolean;

{$R *.dfm}

function frmExceptionValue(const AItemUnid:integer): TfrmExceptionValue;
begin
  if ffrmExceptionValue=nil then ffrmExceptionValue:=TfrmExceptionValue.Create(application.mainform);
  result:=ffrmExceptionValue;
  frmExceptionValue.pItemUnid:=AItemUnid;
end;

procedure TfrmExceptionValue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmExceptionValue=self then ffrmExceptionValue:=nil;
end;

procedure TfrmExceptionValue.UpdateAdoquery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select (case MatchMode when 0 then ''模糊匹配'' when 1 then ''左匹配'' when 2 then ''右匹配'' when 3 then ''全匹配'' end) as 匹配方式,'+
                      'ItemValue as 结果值,'+
                      '(case HighOrLowFlag when 1 then ''偏低'' when 2 then ''偏高'' end) as 超限标识,'+
                      'Unid,MatchMode as 匹配方式代码,HighOrLowFlag as 超限标识代码 '+
                      'from ItemExceptionValue where ItemUnid=:ItemUnid ';
  adoquery1.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;
  adoquery1.Open;
end;

procedure TfrmExceptionValue.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  ifNewAdd:=false;

  updateEdit;
end;

procedure TfrmExceptionValue.updateEdit;
begin
  if adoquery1.RecordCount>0 then
  begin
    ComboBox1.ItemIndex:=adoquery1.fieldbyname('匹配方式代码').AsInteger;
    LabeledEdit1.Text:=trim(adoquery1.fieldbyname('结果值').AsString);
    ComboBox2.ItemIndex:=adoquery1.fieldbyname('超限标识代码').AsInteger;
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmExceptionValue.FormShow(Sender: TObject);
begin
  UpdateAdoquery1;
end;

procedure TfrmExceptionValue.FormCreate(Sender: TObject);
begin
  adoquery1.Connection:=DM.ADOConnection1;
end;

procedure TfrmExceptionValue.BitBtn1Click(Sender: TObject);
begin
  ClearEdit;
  ComboBox1.SetFocus;
  ifNewAdd:=true;
end;

procedure TfrmExceptionValue.ClearEdit;
begin
  ComboBox1.ItemIndex:=-1;
  LabeledEdit1.Clear;
  ComboBox2.ItemIndex:=-1;
end;

procedure TfrmExceptionValue.BitBtn2Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
begin
  if (ComboBox1.ItemIndex<>0) and (ComboBox1.ItemIndex<>1) and (ComboBox1.ItemIndex<>2) and (ComboBox1.ItemIndex<>3) then
  begin
    MESSAGEDLG('请选择正确的匹配方式!',mtError,[MBOK],0);
    exit;
  end;

  if trim(LabeledEdit1.Text)='' then
  begin
    MESSAGEDLG('结果值不能为空!',mtError,[MBOK],0);
    exit;
  end;

  if (ComboBox2.ItemIndex<>1) and (ComboBox2.ItemIndex<>2) then
  begin
    MESSAGEDLG('请选择正确的超限标识!',mtError,[MBOK],0);
    exit;
  end;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //新增
  begin
    ifNewAdd:=false;

    sqlstr:='Insert into ItemExceptionValue ('+
                        ' ItemUnid,MatchMode,ItemValue,HighOrLowFlag) values ('+
                        ' :ItemUnid,:MatchMode,:ItemValue,:HighOrLowFlag) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;
    adotemp11.Parameters.ParamByName('MatchMode').Value:=ComboBox1.ItemIndex;
    adotemp11.Parameters.ParamByName('ItemValue').Value:=LabeledEdit1.Text;
    adotemp11.Parameters.ParamByName('HighOrLowFlag').Value:=ComboBox2.ItemIndex;
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
    adotemp11.SQL.Text:=' Update ItemExceptionValue  '+
    '  set MatchMode=:MatchMode,ItemValue=:ItemValue,HighOrLowFlag=:HighOrLowFlag '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('MatchMode').Value:=ComboBox1.ItemIndex;
    adotemp11.Parameters.ParamByName('ItemValue').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('HighOrLowFlag').Value:=ComboBox2.ItemIndex;
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    adotemp11.ExecSQL;
    AdoQuery1.Refresh;
  end;

  adotemp11.Free;
  AdoQuery1.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
  updateEdit;
end;

procedure TfrmExceptionValue.BitBtn3Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  
  if (MessageDlg('确实要删除该记录吗？',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

  DBGrid1.DataSource.DataSet.Delete;
end;

procedure TfrmExceptionValue.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid1.Columns.Items[1].Width:=190;
end;

procedure TfrmExceptionValue.BitBtn4Click(Sender: TObject);
begin
  close;
end;

initialization
  ffrmExceptionValue:=nil;

end.
