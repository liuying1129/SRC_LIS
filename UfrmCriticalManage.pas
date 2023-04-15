unit UfrmCriticalManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB, StrUtils,
  DosMove;

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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DosMove1: TDosMove;
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
  
  dbgrid1.Columns.Items[0].Width:=30;
  dbgrid1.Columns.Items[1].Width:=60;
  dbgrid1.Columns.Items[2].Width:=60;
  dbgrid1.Columns.Items[3].Width:=75;
  dbgrid1.Columns.Items[4].Width:=200;
end;

procedure TfrmCriticalManage.BitBtn3Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  
  if (MessageDlg('确实要删除该记录吗？',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

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
  ComboBox1.Text:='';
  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  ComboBox2.ItemIndex:=-1;
  LabeledEdit3.Clear;
end;

procedure TfrmCriticalManage.FormShow(Sender: TObject);
begin
  UpdateAdoquery1;
  
  LoadGroupName(ComboBox1,'select name from CommCode where TypeName=''性别'' ');
end;

procedure TfrmCriticalManage.UpdateAdoquery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select sex as 性别,age_low_display as 年龄下限,age_high_display as 年龄上限,'+
                      'MatchMode as 匹配方式,CriticalValue as 危急值,'+
                      'age_low,age_high,Unid '+
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
    ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf(adoquery1.fieldbyname('匹配方式').AsString);
    LabeledEdit1.Text:=adoquery1.fieldbyname('年龄下限').AsString;
    LabeledEdit2.Text:=adoquery1.fieldbyname('年龄上限').AsString;
    ComboBox1.Text:=adoquery1.fieldbyname('性别').AsString;
    LabeledEdit3.Text:=adoquery1.fieldbyname('危急值').AsString;
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmCriticalManage.BitBtn2Click(Sender: TObject);
var
  adotemp11,adotemp22:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
  age_low,age_high,ff:single;
begin
  if ComboBox2.Text='' then
  begin
    MESSAGEDLG('匹配方式不能为空!',mtError,[MBOK],0);
    exit;
  end;

  if trim(LabeledEdit3.Text)='' then
  begin
    MESSAGEDLG('危急值不能为空!',mtError,[MBOK],0);
    exit;
  end;

  if(ComboBox2.Text='≤')or(ComboBox2.Text='＜')or(ComboBox2.Text='≥')or(ComboBox2.Text='＞')or(ComboBox2.Text='=')then
  begin
    if not TryStrToFloat(LabeledEdit3.Text,ff) then
    begin
      MESSAGEDLG('匹配方式为≤、＜、≥、＞、=时,危急值必须为数值!',mtError,[MBOK],0);
      exit;
    end;
  end;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=dm.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.text:='select dbo.uf_GetAgeReal('''+ifThen(trim(LabeledEdit1.Text)<>'',trim(LabeledEdit1.Text))+''') as age_low';
  adotemp22.Open;
  age_low:=adotemp22.fieldbyname('age_low').AsFloat;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.text:='select dbo.uf_GetAgeReal('''+ifThen(trim(LabeledEdit2.Text)<>'',trim(LabeledEdit2.Text),'200')+''') as age_high';
  adotemp22.Open;
  age_high:=adotemp22.fieldbyname('age_high').AsFloat;
  adotemp22.Free;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //新增
  begin
    ifNewAdd:=false;

    sqlstr:='Insert into ItemCriticalValue ('+
                        ' ItemUnid, sex, age_low, age_high, age_low_display, age_high_display, MatchMode, CriticalValue) values ('+
                        ':ItemUnid,:sex,:age_low,:age_high,:age_low_display,:age_high_display,:MatchMode,:CriticalValue) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('ItemUnid').Value:=pItemUnid;
    adotemp11.Parameters.ParamByName('sex').Value:=ComboBox1.Text;
    adotemp11.Parameters.ParamByName('age_low').Value:=age_low;
    adotemp11.Parameters.ParamByName('age_high').Value:=age_high;
    adotemp11.Parameters.ParamByName('age_low_display').Value:=LabeledEdit1.Text;
    adotemp11.Parameters.ParamByName('age_high_display').Value:=LabeledEdit2.Text;
    adotemp11.Parameters.ParamByName('MatchMode').Value:=ComboBox2.Text;
    adotemp11.Parameters.ParamByName('CriticalValue').Value:=LabeledEdit3.Text;
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
    adotemp11.SQL.Text:=' Update ItemCriticalValue  '+
    '  set MatchMode=:MatchMode,CriticalValue=:CriticalValue,sex=:sex,age_low=:age_low,age_high=:age_high,age_low_display=:age_low_display,age_high_display=:age_high_display '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('sex').Value:=ComboBox1.Text;
    adotemp11.Parameters.ParamByName('age_low').Value:=age_low;
    adotemp11.Parameters.ParamByName('age_high').Value:=age_high;
    adotemp11.Parameters.ParamByName('age_low_display').Value:=LabeledEdit1.Text;
    adotemp11.Parameters.ParamByName('age_high_display').Value:=LabeledEdit2.Text;
    adotemp11.Parameters.ParamByName('MatchMode').Value:=ComboBox2.Text;
    adotemp11.Parameters.ParamByName('CriticalValue').Value:=LabeledEdit3.Text;
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
