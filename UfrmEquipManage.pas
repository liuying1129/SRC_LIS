unit UfrmEquipManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB;

type
  TfrmEquipManage = class(TForm)
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ComboBox1: TComboBox;
    Label4: TLabel;
    LabeledEdit1: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    procedure UpdateAdoquery1;
    procedure updateEdit;
    procedure ClearEdit;
  public
    { Public declarations }
  end;

//var
function frmEquipManage: TfrmEquipManage;

implementation

uses UDM;

var
  ffrmEquipManage: TfrmEquipManage;
  ifNewAdd:boolean;

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmEquipManage: TfrmEquipManage;
begin
  if ffrmEquipManage=nil then ffrmEquipManage:=TfrmEquipManage.Create(application.mainform);
  result:=ffrmEquipManage;
end;

procedure TfrmEquipManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmEquipManage=self then ffrmEquipManage:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmEquipManage.FormCreate(Sender: TObject);
begin
  adoquery1.Connection:=DM.ADOConnection1;
  
  SetWindowLong(LabeledEdit1.Handle, GWL_STYLE, GetWindowLong(LabeledEdit1.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
end;

procedure TfrmEquipManage.FormShow(Sender: TObject);
begin
  UpdateAdoquery1;
end;

procedure TfrmEquipManage.UpdateAdoquery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select Unid as 唯一编号,OrderNo as 顺序号,Type as 类型,Model as 型号,Remark as 备注,Supplier as 供应商,Brand as 品牌,ManuFacturer as 生产厂家,Create_Date_Time AS 创建时间 from EquipManage ';
  adoquery1.Open;
end;

procedure TfrmEquipManage.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  ifNewAdd:=false;

  updateEdit;
end;

procedure TfrmEquipManage.updateEdit;
begin
  if adoquery1.RecordCount>0 then
  begin
    ComboBox1.Text:=trim(adoquery1.fieldbyname('类型').AsString);
    LabeledEdit2.Text:=trim(adoquery1.fieldbyname('型号').AsString);
    LabeledEdit3.Text:=trim(adoquery1.fieldbyname('备注').AsString);
    LabeledEdit4.Text:=trim(adoquery1.fieldbyname('供应商').AsString);
    LabeledEdit5.Text:=trim(adoquery1.fieldbyname('品牌').AsString);
    LabeledEdit6.Text:=trim(adoquery1.fieldbyname('生产厂家').AsString);
    LabeledEdit1.Text:=trim(adoquery1.fieldbyname('顺序号').AsString);
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmEquipManage.ClearEdit;
begin
  ComboBox1.Text:='';
  LabeledEdit2.Clear;
  LabeledEdit3.Clear;
  LabeledEdit4.Clear;
  LabeledEdit5.Clear;
  LabeledEdit6.Clear;
  LabeledEdit1.Clear;
end;

procedure TfrmEquipManage.BitBtn1Click(Sender: TObject);
begin
  ClearEdit;
  ComboBox1.SetFocus;
  ifNewAdd:=true;
end;

procedure TfrmEquipManage.BitBtn2Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
  iOrderNo:integer;
begin
  if trim(ComboBox1.Text)='' then
  begin
    MESSAGEDLG('设备类型不能为空!',mtWarning,[MBOK],0);
    ComboBox1.SetFocus;
    exit;
  end;

  if trim(LabeledEdit2.Text)='' then
  begin
    MESSAGEDLG('设备型号不能为空!',mtWarning,[MBOK],0);
    LabeledEdit2.SetFocus;
    exit;
  end;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //新增
  begin
    ifNewAdd:=false;

    sqlstr:='Insert into EquipManage ('+
                        ' Type, Model, Remark, Supplier, Brand, ManuFacturer, OrderNo) values ('+
                        ':Type,:Model,:Remark,:Supplier,:Brand,:ManuFacturer,:OrderNo) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('Type').Value:=trim(ComboBox1.Text);
    adotemp11.Parameters.ParamByName('Model').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('Remark').Value:=trim(LabeledEdit3.Text);
    adotemp11.Parameters.ParamByName('Supplier').Value:=trim(LabeledEdit4.Text);
    adotemp11.Parameters.ParamByName('Brand').Value:=trim(LabeledEdit5.Text);
    adotemp11.Parameters.ParamByName('ManuFacturer').Value:=trim(LabeledEdit6.Text);
    if trystrtoint(LabeledEdit1.Text,iOrderNo) then
      adotemp11.Parameters.ParamByName('OrderNo').Value:=iOrderNo
    else adotemp11.Parameters.ParamByName('OrderNo').Value:=null;
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
    Insert_Identity:=ADOQuery1.fieldbyname('唯一编号').AsInteger;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update EquipManage  '+
    '  set Type=:Type,Model=:Model,Remark=:Remark,Supplier=:Supplier,Brand=:Brand,ManuFacturer=:ManuFacturer,OrderNo=:OrderNo '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('Type').Value:=trim(ComboBox1.Text);
    adotemp11.Parameters.ParamByName('Model').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('Remark').Value:=trim(LabeledEdit3.Text);
    adotemp11.Parameters.ParamByName('Supplier').Value:=trim(LabeledEdit4.Text);
    adotemp11.Parameters.ParamByName('Brand').Value:=trim(LabeledEdit5.Text);
    adotemp11.Parameters.ParamByName('ManuFacturer').Value:=trim(LabeledEdit6.Text);
    if trystrtoint(LabeledEdit1.Text,iOrderNo) then
      adotemp11.Parameters.ParamByName('OrderNo').Value:=iOrderNo
    else adotemp11.Parameters.ParamByName('OrderNo').Value:=null;
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    adotemp11.ExecSQL;
    AdoQuery1.Refresh;
  end;

  adotemp11.Free;
  AdoQuery1.Locate('唯一编号',Insert_Identity,[loCaseInsensitive]) ;
  updateEdit;
end;

procedure TfrmEquipManage.BitBtn3Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  
  if (MessageDlg('确实要删除该记录吗？',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

  DBGrid1.DataSource.DataSet.Delete;
end;

procedure TfrmEquipManage.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid1.Columns.Items[0].Width:=55;
  dbgrid1.Columns.Items[1].Width:=45;
  dbgrid1.Columns.Items[2].Width:=150;
  dbgrid1.Columns.Items[3].Width:=60;
  dbgrid1.Columns.Items[4].Width:=150;
  dbgrid1.Columns.Items[5].Width:=150;
  dbgrid1.Columns.Items[6].Width:=150;
end;

initialization
  ffrmEquipManage:=nil;

end.
