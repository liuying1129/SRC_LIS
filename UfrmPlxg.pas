unit UfrmPlxg;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst, ADODB, DosMove, ActnList,
  DB, ComCtrls,StrUtils, Grids, DBGrids,inifiles;

type
  TfrmPlxg = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    DosMove1: TDosMove;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    Label3: TLabel;
    Label4: TLabel;
    RadioGroup2: TRadioGroup;
    LabeledEdit3: TEdit;
    LabeledEdit1: TEdit;
    Edit1: TEdit;
    Label6: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

//var
function  frmPlxg: TfrmPlxg;

implementation

uses  UDM, SDIMAIN;
var
  ffrmPlxg: TfrmPlxg;

{$R *.dfm}
function  frmPlxg: TfrmPlxg;
begin
  if ffrmPlxg=nil then ffrmPlxg:=tfrmPlxg.Create(application.mainform);
  result:=ffrmPlxg;
end;

procedure TfrmPlxg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmPlxg=self then ffrmPlxg:=nil;
end;

procedure TfrmPlxg.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmPlxg.BitBtn1Click(Sender: TObject);
var
  k:integer;
  adotemp15,adotemp11,adotemp22,adotemp33:tadoquery;
  sTemp,LshRange:string;
  pLshRange:Pchar;
  l_ReturnValue:single;
  itemvalue:string;
  cfxs,jfxs,ss:string;
//  ini:tinifile;
  iMaxDotLen:integer;//小数点后的位数
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount=0 then exit;
  if ADOQuery1.State=dsEdit then ADOQuery1.Post;

  sTemp:=ifThen(RadioGroup2.ItemIndex=0,LabeledEdit3.Text,LabeledEdit1.Text);

    if not RangeStrToSql(pchar(sTemp),true,'0',4,pLshRange) then
    begin
      application.messagebox('范围不正确，请重新输入！', '提示信息',MB_OK);
      exit;
    end;

  //=========将pchar类型的pLshRange转换为string类型的LshRange
  setlength(LshRange,length(pLshRange));
  for k :=1  to length(pLshRange) do LshRange[k]:=pLshRange[k-1];
  //=========================================================

  if RadioGroup2.ItemIndex=1 then
  begin
    LshRange:=StringReplace(LshRange,'(''','('''+Edit1.Text,[rfReplaceAll]);//加入联机字母
    LshRange:=StringReplace(LshRange,',''',','''+Edit1.Text,[rfReplaceAll]);//加入联机字母
    ss:=' (checkid in '+LshRange+') and ';
  end else ss:=' (lsh in '+LshRange+') and ';

  adotemp15:=tadoquery.Create(nil);//所有要计算的病人
  adotemp15.Connection:=DM.ADOConnection1;
  adotemp15.Close;
  adotemp15.SQL.Clear;
  adotemp15.SQL.Text:='select unid from chk_con where '+
      ss+
      ' (CONVERT(CHAR(10),check_date,121)='''+FormatDateTime('YYYY-MM-DD',DateTimePicker1.Date)+''') '+
      ' and (combin_id='''+trim(SDIAppForm.cbxConnChar.Text)+''') '+
      ' and (diagnosetype like ''%'+ComboBox1.Text+'%'') ';
  adotemp15.Open;

  while not adotemp15.Eof do
  begin
    adotemp11:=tadoquery.Create(nil);//所有要计算的项目
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:='select itemid,cfxs,jfxs from clinicchkitem where ltrim(rtrim(isnull(cfxs,'''')))<>'''' or ltrim(rtrim(isnull(jfxs,'''')))<>'''' ';
    adotemp11.Open;
    while not adotemp11.Eof do
    begin
      cfxs:=adotemp11.fieldbyname('cfxs').AsString;
      if cfxs='' then cfxs:='1';
      jfxs:=adotemp11.fieldbyname('jfxs').AsString;
      if jfxs='' then jfxs:='0';

      adotemp22:=tadoquery.Create(nil);//
      adotemp22.Connection:=DM.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select itemvalue from chk_valu where pkunid=:pkunid and itemid=:itemid and issure=1 ';
      adotemp22.Parameters.ParamByName('pkunid').Value:=adotemp15.fieldbyname('unid').AsInteger;
      adotemp22.Parameters.ParamByName('itemid').Value:=adotemp11.fieldbyname('itemid').AsString;
      adotemp22.Open;//就算在不同的组合,同一个项目号的结果也应该一样,否则就见鬼了
      itemvalue:=adotemp22.fieldbyname('itemvalue').AsString;
      adotemp22.Free;
      
      if CalParserValue(pchar(itemvalue+'*'+cfxs+'+('+jfxs+')'),l_ReturnValue) then
      begin
        iMaxDotLen:=MaxDotLen(pchar(itemvalue));
        adotemp33:=tadoquery.Create(nil);
        adotemp33.Connection:=DM.ADOConnection1;
        adotemp33.Close;
        adotemp33.SQL.Clear;
        adotemp33.SQL.Text:='update chk_valu set itemvalue='''+format('%.'+inttostr(iMaxDotLen)+'f',[l_ReturnValue])+''' where pkunid=:pkunid and itemid=:itemid ';
        adotemp33.Parameters.ParamByName('pkunid').Value:=adotemp15.fieldbyname('unid').AsInteger;
        adotemp33.Parameters.ParamByName('itemid').Value:=adotemp11.fieldbyname('itemid').AsString;
        adotemp33.ExecSQL;//就算在不同的组合,同一个项目号的结果也应该一样,否则就见鬼了
        adotemp33.Free;
      end;

      adotemp11.Next;
    end;


    adotemp11.Free;
    
    adotemp15.Next;
  end;

  adotemp15.Free;

  SDIAppForm.update_Ado_dtl;

  //ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
  //ini.WriteString('Interface','联机号范围字母',LabeledEdit1.Text);
  //ini.Free;

  close;
end;


procedure TfrmPlxg.FormShow(Sender: TObject);
begin
  //ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
  //LabeledEdit1.Text:=trim(ini.ReadString('Interface','联机号范围字母',''));
  //ini.Free;


  //ServerDate:=GetServerDate(DM.ADOConnection1);
  DateTimePicker1.DateTime := SDIAppForm.ADObasic.FieldByName('检查日期').AsDateTime;//ServerDate;

  ExecSQLCmd(LisConn,'update clinicchkitem set cfxs='''',jfxs='''' ');

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select name as 名称,english_name as 英文名,CFXS as 系数,JFXS as 附加值 FROM clinicchkitem ORDER BY printorder ';
  ADOQuery1.Open;

  
  if LabeledEdit3.CanFocus then LabeledEdit3.SetFocus else LabeledEdit1.SetFocus;
end;


procedure TfrmPlxg.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=dm.ADOConnection1;
end;

procedure TfrmPlxg.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
  for i:=0 to (dbgrid1.columns.count-1) do
   dbgrid1.columns[i].readonly:=TRUE;
  dbgrid1.columns[2].readonly:=FALSE;//乘法系数
  dbgrid1.columns[3].readonly:=FALSE;//加法系数

  dbgrid1.Columns[0].Width:=125;
  dbgrid1.Columns[1].Width:=45;
  dbgrid1.Columns[2].Width:=42;
  dbgrid1.Columns[3].Width:=42;
end;

procedure TfrmPlxg.RadioGroup2Click(Sender: TObject);
begin
  if (sender as TRadioGroup).ItemIndex=0 then
  begin
    LabeledEdit3.Enabled:=true;
    LabeledEdit3.SetFocus;
    Edit1.Enabled:=false;
    Edit1.Clear;
    LabeledEdit1.Enabled:=false;
    LabeledEdit1.Clear;
  end else if (sender as TRadioGroup).ItemIndex=1 then
  begin
    LabeledEdit3.Enabled:=false;
    LabeledEdit3.Clear;
    Edit1.Enabled:=true;
    Edit1.SetFocus;
    LabeledEdit1.Enabled:=true;
  end;
end;

initialization
  ffrmPlxg:=nil;

end.

