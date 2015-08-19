unit UfrmHisCombItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, ActnList;

type
  TfrmHisCombItem = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    LabeledEdit1: TLabeledEdit;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    BitBtn4: TBitBtn;
    LabeledEdit2: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
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
    pCombUnid:integer;
    procedure UpdateAdoquery1;
    procedure updateEdit;
    procedure ClearEdit;
  public
    { Public declarations }
  end;

//var
function frmHisCombItem(const ACombUnid:integer): TfrmHisCombItem;

implementation

uses UDM;
var
  ffrmHisCombItem: TfrmHisCombItem;
  ifNewAdd:boolean;

{$R *.dfm}

function frmHisCombItem(const ACombUnid:integer): TfrmHisCombItem;
begin
  if ffrmHisCombItem=nil then ffrmHisCombItem:=TfrmHisCombItem.Create(application.mainform);
  result:=ffrmHisCombItem;
  frmHisCombItem.pCombUnid:=ACombUnid;
end;

procedure TfrmHisCombItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmHisCombItem=self then ffrmHisCombItem:=nil;
end;

procedure TfrmHisCombItem.UpdateAdoquery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select HisItem as �ⲿϵͳ�շ���Ŀ����,HisItemName as �ⲿϵͳ�շ���Ŀ����,ExtSystemId as �ⲿϵͳ��ʶ,Unid from HisCombItem where CombUnid=:CombUnid ';
  adoquery1.Parameters.ParamByName('CombUnid').Value:=pCombUnid;
  adoquery1.Open;
end;

procedure TfrmHisCombItem.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  ifNewAdd:=false;

  updateEdit;
end;

procedure TfrmHisCombItem.updateEdit;
begin
  if adoquery1.RecordCount>0 then
  begin
    LabeledEdit1.Text:=trim(adoquery1.fieldbyname('�ⲿϵͳ�շ���Ŀ����').AsString);
    LabeledEdit2.Text:=trim(adoquery1.fieldbyname('�ⲿϵͳ�շ���Ŀ����').AsString);
    ComboBox1.Text:=trim(adoquery1.fieldbyname('�ⲿϵͳ��ʶ').AsString);
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmHisCombItem.FormShow(Sender: TObject);
begin
  UpdateAdoquery1;
end;

procedure TfrmHisCombItem.FormCreate(Sender: TObject);
begin
  adoquery1.Connection:=DM.ADOConnection1;
end;

procedure TfrmHisCombItem.BitBtn1Click(Sender: TObject);
begin
  ClearEdit;
  LabeledEdit1.SetFocus;
  ifNewAdd:=true;
end;

procedure TfrmHisCombItem.ClearEdit;
begin
  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  ComboBox1.Text:='';
end;

procedure TfrmHisCombItem.BitBtn2Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //����
  begin
    ifNewAdd:=false;

    sqlstr:='Insert into HisCombItem ('+
                        ' CombUnid,HisItem,HisItemName,ExtSystemId) values ('+
                        ' :CombUnid,:HisItem,:HisItemName,:ExtSystemId) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('CombUnid').Value:=pCombUnid;
    adotemp11.Parameters.ParamByName('HisItem').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('HisItemName').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('ExtSystemId').Value:=trim(ComboBox1.Text);
    adotemp11.Open;
    ADOQuery1.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //�޸�
  begin
    IF AdoQuery1.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('û�м�¼�����޸ģ���Ҫ���������ȵ��"������ť"��');
      EXIT;
    END;
    Insert_Identity:=ADOQuery1.fieldbyname('Unid').AsInteger;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update HisCombItem  '+
    '  set HisItem=:HisItem,HisItemName=:HisItemName,ExtSystemId=:ExtSystemId '+
    '  Where    Unid=:Unid      ';
    //adotemp11.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;//ItemUnid=:ItemUnid,
    adotemp11.Parameters.ParamByName('HisItem').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('HisItemName').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('ExtSystemId').Value:=trim(ComboBox1.Text);
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    adotemp11.ExecSQL;
    AdoQuery1.Refresh;
  end;

  adotemp11.Free;
  AdoQuery1.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
  updateEdit;
end;

procedure TfrmHisCombItem.BitBtn3Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  
  if (MessageDlg('ȷʵҪɾ���ü�¼��',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

  DBGrid1.DataSource.DataSet.Delete;
end;

procedure TfrmHisCombItem.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid1.Columns.Items[0].Width:=110;
  dbgrid1.Columns.Items[1].Width:=205;
  dbgrid1.Columns.Items[2].Width:=100;
end;

procedure TfrmHisCombItem.BitBtn4Click(Sender: TObject);
begin
  close;
end;

initialization
  ffrmHisCombItem:=nil;

end.
