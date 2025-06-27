unit UfrmBatchSpecNo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB, StrUtils,
  ComCtrls;

type
  TfrmBatchSpecNo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit3: TEdit;
    LabeledEdit1: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabeledEdit3Enter(Sender: TObject);
    procedure LabeledEdit1Enter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    //20230602ɾ��������ӡ����.ת�����д�ӡ
    pPLLX:integer; //0:����� 1:����ӡ 2:����ɾ��
  public
    { Public declarations }
  end;

function  frmBatchSpecNo(const PLLX:integer): TfrmBatchSpecNo;

var
  ffrmBatchSpecNo: TfrmBatchSpecNo;//20250611Ϊʵ��������˫��������Ϣ��ֵ,��Ϊȫ�ֱ���

implementation
uses UDM, SDIMAIN;

{$R *.dfm}

function  frmBatchSpecNo(const PLLX:integer): TfrmBatchSpecNo;
begin
  if ffrmBatchSpecNo=nil then ffrmBatchSpecNo:=tfrmBatchSpecNo.Create(application.mainform);
  result:=ffrmBatchSpecNo;
  frmBatchSpecNo.pPLLX:=PLLX;
end;

procedure TfrmBatchSpecNo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmBatchSpecNo=self then ffrmBatchSpecNo:=nil;
end;

procedure TfrmBatchSpecNo.BitBtn1Click(Sender: TObject);
var
  adotemp2,adotemp4:tadoquery;
  Save_Cursor:TCursor;
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

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }

  if pPLLX=0 then  //0:����� 1:����ӡ
  begin
    adotemp2:=tadoquery.Create(nil);
    adotemp2.clone(SDIAppForm.ADObasic);
    adotemp2.Locate('Ψһ���',Edit2.Text,[loCaseInsensitive]);
    while not adotemp2.Eof do
    begin
      if '1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_valu where pkunid='+adotemp2.fieldbyname('Ψһ���').AsString+' and issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' ') then
      begin
        adotemp2.next;
        continue;//�����û�м���������Ŀ
      end;
      
      ExecSQLCmd(LisConn,'update chk_con set report_doctor='''+operator_name+''',Audit_Date=getdate() where unid='+adotemp2.fieldbyname('Ψһ���').AsString+' AND ((report_doctor IS NULL) OR (report_doctor='''')) ');

      if adotemp2.FieldByName('Ψһ���').AsString=Edit1.Text then break;
      
      adotemp2.Next;
    end;    
    adotemp2.Free;

    SDIAppForm.ADObasic.Refresh;//ˢ�½���
    
    MessageDlg('����������!', mtInformation, [mbYes], 0);
  end;

  {if pPLLX=1 then   //0:����� 1:����ӡ
  begin
    adotemp4:=tadoquery.Create(nil);
    adotemp4.Connection:=DM.ADOConnection1;
    adotemp4.Close;
    adotemp4.SQL.Clear;
    adotemp4.SQL.Text:=s0+s1;
    adotemp4.Open;
    if adotemp4.RecordCount=0 then begin application.messagebox('��ѡ��Χ�ڼ�¼����Ϊ�㣬���������룡', '��ʾ��Ϣ',MB_OK); adotemp4.Free; exit; end;
    while not adotemp4.Eof do
    begin
        xx:=adotemp4.fieldbyname('unid').AsInteger;
        if SDIAppForm.ADObasic.Locate('Ψһ���',xx,[loCaseInsensitive]) then
          begin
             //if RadioGroup1.ItemIndex=0 then SDIAppForm.ToolButton8Click(SDIAppForm.ToolButton8);
             //if RadioGroup1.ItemIndex=1 then SDIAppForm.suiButton1Click(SDIAppForm.suiButton1);
          end;
        adotemp4.Next;
    end;
    adotemp4.Free;
    SDIAppForm.update_Ado_dtl;

    ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
    //ini.WriteInteger('Interface','������ӡ��ʽ',RadioGroup1.ItemIndex);
    ini.Free;
  end;//}

  if pPLLX=2 then   //0:����� 1:����ӡ 2:����ɾ��
  begin
    if (MessageDlg('ȷ������ɾ����¼��', mtConfirmation, [mbYes, mbNo], 0)<> mrYes) then
    begin
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
      exit;
    end;

    adotemp2:=tadoquery.Create(nil);
    adotemp2.clone(SDIAppForm.ADObasic);
    adotemp2.Locate('Ψһ���',Edit2.Text,[loCaseInsensitive]);
    while not adotemp2.Eof do
    begin
      if(adotemp2.FieldByName('�����').AsString=operator_name)OR(TRIM(adotemp2.FieldByName('�����').AsString)='') then
        ExecSQLCmd(LisConn,'delete from chk_con where unid='+adotemp2.fieldbyname('Ψһ���').AsString);

      if adotemp2.FieldByName('Ψһ���').AsString=Edit1.Text then break;

      adotemp2.Next;
    end;
    adotemp2.Free;

    sdiappform.suiButton8Click(nil);
  end;
  
  Screen.Cursor := Save_Cursor;  { Always restore to normal }

  close;
end;

procedure TfrmBatchSpecNo.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmBatchSpecNo.LabeledEdit3Enter(Sender: TObject);
begin
  TEdit(Sender).Color := clYellow;
  LabeledEdit1.Color := clWindow;
  Label3.Caption:='��˫��ѡ�����ڿ�ʼ�ļ��鵥';
end;

procedure TfrmBatchSpecNo.LabeledEdit1Enter(Sender: TObject);
begin
  TEdit(Sender).Color := clYellow;
  LabeledEdit3.Color := clWindow;
  Label3.Caption:='��˫��ѡ�����ڽ����ļ��鵥';
end;

procedure TfrmBatchSpecNo.FormShow(Sender: TObject);
begin
  if LabeledEdit3.CanFocus then LabeledEdit3.SetFocus;
end;

initialization
  ffrmBatchSpecNo:=nil;
end.
