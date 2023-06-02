unit UfrmBatchSpecNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB,inifiles, DosMove,StrUtils,
  FR_Class, ComCtrls;

type
  TfrmBatchSpecNo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADOQuery1: TADOQuery;
    DosMove1: TDosMove;
    RadioGroup1: TRadioGroup;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    RadioGroup2: TRadioGroup;
    LabeledEdit3: TEdit;
    LabeledEdit1: TEdit;
    Edit1: TEdit;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure LabeledEdit2Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { Private declarations }
    //20230602ɾ��������ӡ����.ת�����д�ӡ
    pPLLX:integer; //0:����� 1:����ӡ 2:����ɾ��
  public
    { Public declarations }
  end;

function  frmBatchSpecNo(const PLLX:integer): TfrmBatchSpecNo;

implementation
uses UDM, SDIMAIN;
var
  ffrmBatchSpecNo: TfrmBatchSpecNo;

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
  ifBatchOperater:=false;
  
  action:=cafree;
  if ffrmBatchSpecNo=self then ffrmBatchSpecNo:=nil;
end;

procedure TfrmBatchSpecNo.BitBtn1Click(Sender: TObject);
var
  ssql:string;
  k:integer;
  adotemp2,adotemp4:tadoquery;
  xx:integer;
  s0,s1,ss:string;
  sTemp,LshRange:string;
  pLshRange:Pchar;
  ini:tinifile;
  Save_Cursor:TCursor;
begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }

  sTemp:=ifThen(RadioGroup2.ItemIndex=0,LabeledEdit3.Text,LabeledEdit1.Text);
  if not RangeStrToSql(pchar(sTemp),true,'0',4,pLshRange) then
  begin
    application.messagebox('��Χ����ȷ�����������룡', '��ʾ��Ϣ',MB_OK);
    exit;
  end;

  //=========��pchar���͵�pLshRangeת��Ϊstring���͵�LshRange
  setlength(LshRange,length(pLshRange));
  for k :=1  to length(pLshRange) do LshRange[k]:=pLshRange[k-1];
  //=========================================================

  if RadioGroup2.ItemIndex=1 then
  begin
    LshRange:=StringReplace(LshRange,'(''','('''+Edit1.Text,[rfReplaceAll]);//����������ĸ
    LshRange:=StringReplace(LshRange,',''',','''+Edit1.Text,[rfReplaceAll]);//����������ĸ
    ss:=' (checkid in '+LshRange+') and ';
  end else ss:=' (lsh in '+LshRange+') and ';

  s0:='select unid from chk_con where '+
      ss+
      ' (CONVERT(CHAR(10),check_date,121)='''+FormatDateTime('YYYY-MM-DD',DateTimePicker1.Date)+
      ''') and (isnull(diagnosetype,'''')='''+trim(ComboBox1.Text)+''') and (combin_id='''+SDIAppForm.cbxConnChar.Text+''')'; //ֻ�г��浥������������
  if RadioGroup2.ItemIndex=0 then s1:=' order by lsh ' else s1:=' order by checkid ';

  ifBatchOperater:=true;
  
  if   pPLLX=0 then  //0:����� 1:����ӡ
  begin
    adotemp2:=tadoquery.Create(nil);
    adotemp2.Connection:=DM.ADOConnection1;
    ssql:=s0+' AND ((report_doctor IS NULL) OR (report_doctor='''')) ';
    adotemp2.Close;
    adotemp2.SQL.Clear;
    adotemp2.SQL.Text:=ssql;
    adotemp2.Open;
    if adotemp2.RecordCount=0 then begin application.messagebox('��ѡ��Χ�ڼ�¼����Ϊ�㣬���������룡', '��ʾ��Ϣ',MB_OK); adotemp2.Free;exit; end;
    adotemp2.first;     //��Ҫ��˵����ݼ�(���˻�����Ϣ)
    while not adotemp2.Eof do
    begin
      if '1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_valu where pkunid='+adotemp2.fieldbyname('unid').AsString+' and issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' ') then//adotemp3.RecordCount=0
      begin
        adotemp2.next;
        continue;//�����û�м���������Ŀ
      end;

      ExecSQLCmd(LisConn,'update chk_con set report_doctor='''+operator_name+''',Audit_Date=getdate() where unid='+adotemp2.fieldbyname('unid').AsString);

      adotemp2.Next;
    end;
    adotemp2.Free;

    SDIAppForm.ADObasic.Refresh;//ˢ�½���
    
    MessageDlg('����������!', mtInformation, [mbYes], 0);
  end;

  if pPLLX=1 then   //0:����� 1:����ӡ
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
             if RadioGroup1.ItemIndex=0 then SDIAppForm.ToolButton8Click(SDIAppForm.ToolButton8);
             if RadioGroup1.ItemIndex=1 then SDIAppForm.suiButton1Click(SDIAppForm.suiButton1);
          end;
        adotemp4.Next;
    end;
    adotemp4.Free;
    SDIAppForm.update_Ado_dtl;

    ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
    ini.WriteInteger('Interface','������ӡ��ʽ',RadioGroup1.ItemIndex);
    ini.Free;
  end;

  if pPLLX=2 then   //0:����� 1:����ӡ 2:����ɾ��
  begin
    adotemp4:=tadoquery.Create(nil);
    adotemp4.Connection:=DM.ADOConnection1;
    adotemp4.Close;
    adotemp4.SQL.Clear;
    adotemp4.SQL.Text:=s0;
    adotemp4.Open;
    if adotemp4.RecordCount=0 then begin application.messagebox('��ѡ��Χ�ڼ�¼����Ϊ�㣬���������룡', '��ʾ��Ϣ',MB_OK); adotemp4.Free; exit; end;
    if (MessageDlg('�Ƿ���Ҫ����ɾ����¼��', mtConfirmation, [mbYes, mbNo], 0)<> mrYes) then BEGIN adotemp4.Free; exit;END;

    adotemp4.First;
    while not adotemp4.Eof do
    begin
        xx:=adotemp4.fieldbyname('unid').AsInteger;
        if SDIAppForm.ADObasic.Locate('Ψһ���',xx,[loCaseInsensitive]) then
          if(SDIAppForm.ADObasic.FieldByName('�����').AsString=operator_name)
            OR(TRIM(SDIAppForm.ADObasic.FieldByName('�����').AsString)='') then
          begin

            adotemp4.Delete;

            CONTINUE;
          end ;
        adotemp4.Next;
    end;
    adotemp4.Free;

    sdiappform.suiButton8Click(nil);
  end;
  
  Screen.Cursor := Save_Cursor;  { Always restore to normal }

  close;
end;

procedure TfrmBatchSpecNo.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmBatchSpecNo.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=DM.ADOConnection1;

  //SetWindowLong(LabeledEdit1.Handle, GWL_STYLE, GetWindowLong(LabeledEdit1.Handle, GWL_STYLE) or ES_NUMBER);//ֻ����������
  //SetWindowLong(LabeledEdit2.Handle, GWL_STYLE, GetWindowLong(LabeledEdit2.Handle, GWL_STYLE) or ES_NUMBER);//ֻ����������
end;

procedure TfrmBatchSpecNo.LabeledEdit1Exit(Sender: TObject);
begin
   TLabeledEdit(SENDER).Text:= RightStr('0000'+TRIM(TLabeledEdit(SENDER).Text),4);
end;

procedure TfrmBatchSpecNo.LabeledEdit2Exit(Sender: TObject);
begin
   TLabeledEdit(SENDER).Text:= RightStr('0000'+TRIM(TLabeledEdit(SENDER).Text),4);
end;

procedure TfrmBatchSpecNo.FormShow(Sender: TObject);
var
  ini:tinifile;
begin
  //ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
  //LabeledEdit1.Text:=trim(ini.ReadString('Interface','�����ŷ�Χ��ĸ',''));
  //ini.Free;

  if pPLLX=1 then
  begin
    RadioGroup1.Visible:=true;
    ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
    RadioGroup1.ItemIndex:=ini.ReadInteger('Interface','������ӡ��ʽ',0);
    ini.Free;
  end else
  begin RadioGroup1.Visible:=false;end;
  
  DateTimePicker1.DateTime:=SDIAppForm.ADObasic.FieldByName('�������').AsDateTime;//date();
end;

procedure TfrmBatchSpecNo.RadioGroup2Click(Sender: TObject);
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
  ffrmBatchSpecNo:=nil;
end.
