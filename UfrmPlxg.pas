unit UfrmPlxg;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ADODB, 
  DB, ComCtrls,StrUtils, Grids, DBGrids;

type
  TfrmPlxg = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    Label4: TLabel;
    LabeledEdit3: TEdit;
    Edit2: TEdit;
    LabeledEdit1: TEdit;
    Edit1: TEdit;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure LabeledEdit3Enter(Sender: TObject);
    procedure LabeledEdit1Enter(Sender: TObject);
  private
    { Private declarations }
  public

  end;

//var
function  frmPlxg: TfrmPlxg;

var
  ffrmPlxg: TfrmPlxg;//20250627Ϊʵ��������˫��������Ϣ��ֵ,��Ϊȫ�ֱ���

implementation

uses  UDM, SDIMAIN;

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
  adotemp15,adotemp11,adotemp22,adotemp33,adotemp4:tadoquery;
  l_ReturnValue:single;
  itemvalue:string;
  cfxs,jfxs:string;
  iMaxDotLen:integer;//С������λ��
  selectOK:boolean;
begin
  adotemp4:=tadoquery.Create(nil);
  adotemp4.clone(SDIAppForm.ADObasic);
  if not adotemp4.Locate('Ψһ���',Edit2.Text,[loCaseInsensitive]) then
  begin
    adotemp4.Free;
    MESSAGEDLG('��˫��ѡ��ʼ�ļ��鵥!',mtError,[MBOK],0);
    exit;
  end;
  if not adotemp4.Locate('Ψһ���',Edit1.Text,[loCaseInsensitive]) then
  begin
    adotemp4.Free;
    MESSAGEDLG('��˫��ѡ������ļ��鵥!',mtError,[MBOK],0);
    exit;
  end;
  selectOK:=false;  
  adotemp4.Locate('Ψһ���',Edit2.Text,[loCaseInsensitive]);
  while not adotemp4.Eof do
  begin
    if adotemp4.FieldByName('Ψһ���').AsString=Edit1.Text then selectOK:=true;
    adotemp4.Next;
  end;
  adotemp4.Free;

  if not selectOK then
  begin
    MESSAGEDLG('ѡ��ķ�Χ����ȷ!',mtError,[MBOK],0);
    exit;
  end;

  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount=0 then exit;
  if ADOQuery1.State=dsEdit then ADOQuery1.Post;

  adotemp15:=tadoquery.Create(nil);//��Ҫ����Ĳ���
  adotemp15.clone(SDIAppForm.ADObasic);
  adotemp15.Locate('Ψһ���',Edit2.Text,[loCaseInsensitive]);
  while not adotemp15.Eof do
  begin
    adotemp11:=tadoquery.Create(nil);//����Ҫ�������Ŀ
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

      adotemp22:=tadoquery.Create(nil);
      adotemp22.Connection:=DM.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select itemvalue from chk_valu where pkunid=:pkunid and itemid=:itemid and issure=1 ';
      adotemp22.Parameters.ParamByName('pkunid').Value:=adotemp15.fieldbyname('Ψһ���').AsInteger;
      adotemp22.Parameters.ParamByName('itemid').Value:=adotemp11.fieldbyname('itemid').AsString;
      adotemp22.Open;//�����ڲ�ͬ�����,ͬһ����Ŀ�ŵĽ��ҲӦ��һ��,����ͼ�����
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
        adotemp33.Parameters.ParamByName('pkunid').Value:=adotemp15.fieldbyname('Ψһ���').AsInteger;
        adotemp33.Parameters.ParamByName('itemid').Value:=adotemp11.fieldbyname('itemid').AsString;
        adotemp33.ExecSQL;//�����ڲ�ͬ�����,ͬһ����Ŀ�ŵĽ��ҲӦ��һ��,����ͼ�����
        adotemp33.Free;
      end;

      adotemp11.Next;
    end;

    adotemp11.Free;
    
    if adotemp15.FieldByName('Ψһ���').AsString=Edit1.Text then break;
    
    adotemp15.Next;
  end;

  adotemp15.Free;

  SDIAppForm.update_Ado_dtl;

  close;
end;


procedure TfrmPlxg.FormShow(Sender: TObject);
begin
  if LabeledEdit3.CanFocus then LabeledEdit3.SetFocus;

  ExecSQLCmd(LisConn,'update clinicchkitem set cfxs=null,jfxs=null');

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select ci.Name as �����Ŀ,cci.name as ����Ŀ,CFXS as ϵ��,JFXS as ����ֵ '+
                      'from CombSChkItem csci,clinicchkitem cci,combinitem ci '+
                      'where csci.ItemUnid=cci.unid and ci.Unid=csci.CombUnid '+
                      'order by ci.Id,cci.printorder';
  ADOQuery1.Open;
end;

procedure TfrmPlxg.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=dm.ADOConnection1;
end;

procedure TfrmPlxg.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
  for i:=0 to (dbgrid1.columns.count-1) do dbgrid1.columns[i].readonly:=TRUE;
  dbgrid1.columns[2].readonly:=FALSE;//�˷�ϵ��
  dbgrid1.columns[3].readonly:=FALSE;//�ӷ�ϵ��

  dbgrid1.Columns[0].Width:=80;
  dbgrid1.Columns[1].Width:=105;
  dbgrid1.Columns[2].Width:=42;
  dbgrid1.Columns[3].Width:=42;
end;

procedure TfrmPlxg.LabeledEdit3Enter(Sender: TObject);
begin
  TEdit(Sender).Color := clYellow;
  LabeledEdit1.Color := clWindow;
  Label3.Caption:='��˫��ѡ�����ڿ�ʼ�ļ��鵥';
end;

procedure TfrmPlxg.LabeledEdit1Enter(Sender: TObject);
begin
  TEdit(Sender).Color := clYellow;
  LabeledEdit3.Color := clWindow;
  Label3.Caption:='��˫��ѡ�����ڽ����ļ��鵥';
end;

initialization
  ffrmPlxg:=nil;

end.

