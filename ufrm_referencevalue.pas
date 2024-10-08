unit ufrm_referencevalue;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, ADODB, DosMove,
  ActnList, inifiles,StrUtils;

type
  Tfrm_referencevalue = class(TForm)
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    LabeledEdit2: TLabeledEdit;
    ADOQuery2: TADOQuery;
    DataSource2: TDataSource;
    DosMove1: TDosMove;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    BitBtn6: TBitBtn;
    ComboBox1: TComboBox;
    Label4: TLabel;
    LabeledEdit4: TMemo;
    LabeledEdit5: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    ComboBox2: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    LabeledEdit3: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label5: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Edit2: TEdit;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure LabeledEdit2Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOQuery2AfterScroll(DataSet: TDataSet);
    procedure BitBtn6Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure ComboBox2DropDown(Sender: TObject);
    procedure LabeledEdit3Exit(Sender: TObject);
  private
    { Private declarations }
    procedure updatedbgrid2;
    procedure updateedit;
    procedure update_adoquery2;
  public
    { Public declarations }
  end;

//var
function  frm_referencevalue: Tfrm_referencevalue;

implementation

uses ufrmItemsetup, UDM;
var
  ffrm_referencevalue: Tfrm_referencevalue;

{$R *.dfm}

function  frm_referencevalue: Tfrm_referencevalue;
begin
  if ffrm_referencevalue=nil then ffrm_referencevalue:=Tfrm_referencevalue.Create(application.mainform);
  result:=ffrm_referencevalue;
end;

procedure Tfrm_referencevalue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrm_referencevalue=self then ffrm_referencevalue:=nil;
end;

procedure Tfrm_referencevalue.FormShow(Sender: TObject);
begin
        dbgrid2.ReadOnly:=true;
        adoquery2.Connection:=DM.ADOConnection1;

  update_adoquery2;
end;

procedure Tfrm_referencevalue.BitBtn1Click(Sender: TObject);
var
  ini:tinifile;
begin
      adoquery2.Edit;
      adoquery2.Append;
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  ComboBox1.Text:=ini.ReadString('Interface','参考值的样本类型','');
  ini.Free;
      ComboBox1.SetFocus;
end;

procedure Tfrm_referencevalue.updatedbgrid2;
begin
  if not adoquery2.Active then exit;
        VisibleColumn(dbgrid2,'id',false);
        dbgrid2.Columns.Items[1].Width:=65;
        dbgrid2.Columns.Items[2].Width:=60;
        dbgrid2.Columns.Items[3].Width:=72;
        dbgrid2.Columns.Items[4].Width:=72;
        dbgrid2.Columns.Items[5].Width:=190;
        dbgrid2.Columns.Items[6].Width:=190;
        VisibleColumn(dbgrid2,'age_low',false);
        VisibleColumn(dbgrid2,'age_high',false);
end;

procedure Tfrm_referencevalue.LabeledEdit2Exit(Sender: TObject);
begin
  tLabeledEdit(sender).Text:=ageConvertChinese(trim(tLabeledEdit(sender).Text));
end;

procedure Tfrm_referencevalue.LabeledEdit3Exit(Sender: TObject);
begin
  tLabeledEdit(sender).Text:=ageConvertChinese(trim(tLabeledEdit(sender).Text));
end;

procedure Tfrm_referencevalue.BitBtn2Click(Sender: TObject);
var
  age_low,age_high:single;
  adotemp11:tadoquery;
  ini:tinifile;
begin
  if (trim(LabeledEdit4.Text)='') and (trim(LabeledEdit5.Text)='') then//上、下限都为空了，还要这条记录干嘛呢
  begin
    MessageDlg('【最小值、最大值】至少填写一个！',mtError,[MBOK],0);
    LabeledEdit4.SetFocus;
    exit;
  end;

  try
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=dm.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.text:='select dbo.uf_GetAgeReal('''+ifThen(trim(LabeledEdit2.Text)<>'',trim(LabeledEdit2.Text))+''') as age_low';
    adotemp11.Open;
    age_low:=adotemp11.fieldbyname('age_low').AsFloat;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.text:='select dbo.uf_GetAgeReal('''+ifThen(trim(LabeledEdit3.Text)<>'',trim(LabeledEdit3.Text),'200')+''') as age_high';
    adotemp11.Open;
    age_high:=adotemp11.fieldbyname('age_high').AsFloat;
    adotemp11.Free;

    adoquery2.Edit;
    adoquery2.FieldByName('id').AsString:=frmitemsetup.ADOQuery1.fieldbyname('项目代码').Value;
    adoquery2.FieldByName('性别').AsString:=trim(ComboBox2.Text);
    adoquery2.FieldByName('年龄下限').AsString:=trim(LabeledEdit2.Text);
    adoquery2.FieldByName('年龄上限').AsString:=trim(LabeledEdit3.Text);
    adoquery2.FieldByName('最小值').AsString:=trim(LabeledEdit4.Text);
    adoquery2.FieldByName('最大值').AsString:=trim(LabeledEdit5.Text);
    adoquery2.FieldByName('age_low').AsFloat:=age_low;
    adoquery2.FieldByName('age_high').AsFloat:=age_high;
    adoquery2.FieldByName('样本类型').AsString:=trim(ComboBox1.Text);
    adoquery2.Post;
  except
    showmessage('输入不符合要求，请看注意事项！');
  end;

  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  ini.WriteString('Interface','参考值的样本类型',ComboBox1.Text);
  ini.Free;
end;

procedure Tfrm_referencevalue.BitBtn3Click(Sender: TObject);
begin
      if messagedlg('是否要真的删除?',mtWarning	,mbOKCancel	,0)=mrOK then
      adoquery2.Delete;
end;

procedure Tfrm_referencevalue.updateedit;
begin
       ComboBox2.Text:=trim(adoquery2.fieldbyname('性别').AsString);
       LabeledEdit2.Text:=trim(adoquery2.fieldbyname('年龄下限').AsString);
       LabeledEdit3.Text:=trim(adoquery2.fieldbyname('年龄上限').AsString);
       LabeledEdit4.Text:=trim(adoquery2.fieldbyname('最小值').AsString);
       LabeledEdit5.Text:=trim(adoquery2.fieldbyname('最大值').AsString);
       ComboBox1.Text:=trim(adoquery2.FieldByName('样本类型').AsString);
end;

procedure Tfrm_referencevalue.update_adoquery2;
var
  sql:string;
begin
  sql:=' select id,flagetype as 样本类型,sex as 性别,age_low_display as 年龄下限,age_high_display as 年龄上限,'+
     ' minvalue as 最小值,maxvalue as 最大值,age_low,age_high from referencevalue where id=:p_id'+
     ' order by sex,age_low,age_high';
  adoquery2.Close;
  adoquery2.SQL.Clear;
  adoquery2.SQL.Text:=sql;
  adoquery2.Parameters.ParamByName('p_id').Value:=frmitemsetup.ADOQuery1.fieldbyname('项目代码').Value;
  adoquery2.Open;
  if adoquery2.RecordCount=0 then dbgrid2.ReadOnly:=true;

  updatedbgrid2;
  updateedit;
end;

procedure Tfrm_referencevalue.ADOQuery2AfterScroll(DataSet: TDataSet);
begin
  updateedit;
end;

procedure Tfrm_referencevalue.BitBtn6Click(Sender: TObject);
begin
  close;
end;

procedure Tfrm_referencevalue.ComboBox1DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''样本类型'' ');
end;

procedure Tfrm_referencevalue.ComboBox2DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''性别'' ');
end;

initialization
  ffrm_referencevalue:=nil;

end.
