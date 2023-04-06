unit UfrmCriticalManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB;

type
  TfrmCriticalManage = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    ComboBox2: TComboBox;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure LabeledEdit2Exit(Sender: TObject);
  private
    { Private declarations }
    pItemUnid:integer;
    procedure ClearEdit;
    procedure UpdateAdoquery1;
    procedure updateEdit;
  public
    { Public declarations }
  end;

//var
function  frmCriticalManage(const AItemUnid:integer): TfrmCriticalManage;

implementation

uses UDM;

var
  ffrmCriticalManage: TfrmCriticalManage;
  
  ifNewAdd:boolean;
{$R *.dfm}

function frmCriticalManage(const AItemUnid:integer): TfrmCriticalManage;
begin
  if ffrmCriticalManage=nil then ffrmCriticalManage:=TfrmCriticalManage.Create(application.mainform);
  result:=ffrmCriticalManage;
  frmCriticalManage.pItemUnid:=AItemUnid;
end;

procedure TfrmCriticalManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCriticalManage=self then ffrmCriticalManage:=nil;
end;

procedure TfrmCriticalManage.FormCreate(Sender: TObject);
begin
  adoquery1.Connection:=DM.ADOConnection1;
end;

procedure TfrmCriticalManage.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid1.Columns.Items[1].Width:=190;
end;

procedure TfrmCriticalManage.BitBtn3Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  
  if (MessageDlg('ȷʵҪɾ���ü�¼��',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

  DBGrid1.DataSource.DataSet.Delete;
end;

procedure TfrmCriticalManage.BitBtn1Click(Sender: TObject);
begin
  ClearEdit;
  ComboBox1.SetFocus;
  ifNewAdd:=true;
end;

procedure TfrmCriticalManage.ClearEdit;
begin
  ComboBox1.ItemIndex:=-1;
  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  ComboBox2.ItemIndex:=-1;
  LabeledEdit3.Clear;
end;

procedure TfrmCriticalManage.FormShow(Sender: TObject);
begin
  UpdateAdoquery1;
  
  LoadGroupName(ComboBox1,'select name from CommCode where TypeName=''�Ա�'' ');
end;

procedure TfrmCriticalManage.UpdateAdoquery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select (case MatchMode when 0 then ''ģ��ƥ��'' when 1 then ''��ƥ��'' when 2 then ''��ƥ��'' when 3 then ''ȫƥ��'' end) as ƥ�䷽ʽ,'+
                      'ItemValue as ���ֵ,'+
                      '(case HighOrLowFlag when 1 then ''ƫ��'' when 2 then ''ƫ��'' end) as ���ޱ�ʶ,'+
                      'Unid,MatchMode as ƥ�䷽ʽ����,HighOrLowFlag as ���ޱ�ʶ���� '+
                      'from ItemCriticalValue where ItemUnid=:ItemUnid ';
  adoquery1.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;
  adoquery1.Open;
end;

procedure TfrmCriticalManage.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  ifNewAdd:=false;

  updateEdit;
end;

procedure TfrmCriticalManage.updateEdit;
begin
  if adoquery1.RecordCount>0 then
  begin
    ComboBox1.ItemIndex:=adoquery1.fieldbyname('ƥ�䷽ʽ����').AsInteger;
    LabeledEdit1.Text:=trim(adoquery1.fieldbyname('���ֵ').AsString);
    LabeledEdit2.Text:=trim(adoquery1.fieldbyname('���ֵ').AsString);
    ComboBox2.ItemIndex:=adoquery1.fieldbyname('���ޱ�ʶ����').AsInteger;
    LabeledEdit3.Text:=trim(adoquery1.fieldbyname('���ֵ').AsString);
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmCriticalManage.BitBtn2Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
begin
  if (ComboBox1.ItemIndex<>0) and (ComboBox1.ItemIndex<>1) and (ComboBox1.ItemIndex<>2) and (ComboBox1.ItemIndex<>3) then
  begin
    MESSAGEDLG('��ѡ����ȷ��ƥ�䷽ʽ!',mtError,[MBOK],0);
    exit;
  end;

  if trim(LabeledEdit1.Text)='' then
  begin
    MESSAGEDLG('���ֵ����Ϊ��!',mtError,[MBOK],0);
    exit;
  end;

  if (ComboBox2.ItemIndex<>1) and (ComboBox2.ItemIndex<>2) then
  begin
    MESSAGEDLG('��ѡ����ȷ�ĳ��ޱ�ʶ!',mtError,[MBOK],0);
    exit;
  end;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //����
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

procedure TfrmCriticalManage.LabeledEdit1Exit(Sender: TObject);
begin
  tlabelededit(sender).Text:=ageConvertChinese(trim(tlabelededit(sender).Text));
end;

procedure TfrmCriticalManage.LabeledEdit2Exit(Sender: TObject);
begin
  tlabelededit(sender).Text:=ageConvertChinese(trim(tlabelededit(sender).Text));
end;

initialization
  ffrmCriticalManage:=nil;

end.
