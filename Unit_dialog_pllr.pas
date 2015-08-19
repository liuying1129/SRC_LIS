unit Unit_dialog_pllr;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst, ADODB, DosMove, ActnList,
  DB, ComCtrls,StrUtils, ADOLYGetcode,inifiles;

type
  TForm_pllr = class(TForm)
    CheckListBox1: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    DosMove1: TDosMove;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    RadioGroup2: TRadioGroup;
    LabeledEdit3: TEdit;
    LabeledEdit14: TEdit;
    Edit1: TEdit;
    Label4: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit15KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

//var
function  Form_pllr: TForm_pllr;

implementation

uses  UDM, SDIMAIN;
var
  fForm_pllr: TForm_pllr;

{$R *.dfm}
function  Form_pllr: TForm_pllr;
begin
  if fForm_pllr=nil then fForm_pllr:=tForm_pllr.Create(application.mainform);
  result:=fForm_pllr;
end;

procedure TForm_pllr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if fForm_pllr=self then fForm_pllr:=nil;
end;

procedure TForm_pllr.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TForm_pllr.BitBtn1Click(Sender: TObject);
var
  i,j,k:integer;
  adotemp15:tadoquery;
  sLsh,s2,sCheckid,sLocateNo:string;
  checkunid,b:integer;
  sTemp,LshRange,LocateType:string;
  pLshRange:Pchar;
  sList:tstrings;
//  ini:tinifile;
begin
  sTemp:=ifThen(RadioGroup2.ItemIndex=0,LabeledEdit3.Text,LabeledEdit14.Text);
  if not RangeStrToSql(pchar(sTemp),true,'0',4,pLshRange) then
  begin
    application.messagebox('��Χ����ȷ�����������룡', '��ʾ��Ϣ',MB_OK);
    exit;
  end;

  //=========��pchar���͵�pLshRangeת��Ϊstring���͵�LshRange
  setlength(LshRange,length(pLshRange));
  for k :=1  to length(pLshRange) do LshRange[k]:=pLshRange[k-1];
  //=========================================================

  LshRange:=StringReplace(LshRange,'(','',[rfReplaceAll]);//ȥ����˵�����
  LshRange:=StringReplace(LshRange,')','',[rfReplaceAll]);//ȥ���Ҷ˵�����

  sList:=TStringList.Create;
  ExtractStrings([','],[],PChar(LshRange),sList);

  adotemp15:=tadoquery.Create(nil);
  adotemp15.Connection:=DM.ADOConnection1;
  adotemp15.Close;
  adotemp15.SQL.Clear;
  adotemp15.SQL.Text:='select checkid,lsh,unid from chk_con where (CONVERT(CHAR(10),check_date,121)=:P_check_date)'+
                      ' and (combin_id='''+trim(SDIAppForm.cbxConnChar.Text)+''') '+
                      ' and (diagnosetype='''+ComboBox1.Text+''') ';
  adotemp15.Parameters.ParamByName('P_check_date').Value:=FormatDateTime('YYYY-MM-DD',DateTimePicker1.Date);
  adotemp15.Open;

  if RadioGroup2.ItemIndex=1 then LocateType:='checkid' else LocateType:='lsh';

  for i:=0 to sList.Count-1 do
  begin
     sLsh:=sList[i];
     sLsh:=StringReplace(sLsh,'''','',[rfReplaceAll]);//ȥ�����˵�����
     if RadioGroup2.ItemIndex=1 then sCheckid:=Edit1.Text+sLsh else sCheckid:='';
     if RadioGroup2.ItemIndex=1 then sLocateNo:=sCheckid else sLocateNo:=sLsh;
     if not adotemp15.Locate(LocateType,sLocateNo,[loCaseInsensitive]) then //û��������¼�����
     begin
        SDIAppForm.ifnewadd:=true;
        SDIAppForm.LabeledEdit12.Text:=ComboBox1.Text;//���ȼ����
        SDIAppForm.LabeledEdit16.Text:= sLsh;                //��ˮ�ſ�
        SDIAppForm.LabeledEdit1.Text:=sCheckid;//�����ſ�
        SDIAppForm.LabeledEdit3.Clear;//SDIAppForm.LabeledEdit3.Text:='����';//������.Ϊ��ֹ����ʱ��ʾ����Ϊ��
        SDIAppForm.LabeledEdit6.Text:= LabeledEdit6.Text;   //�ͼ����
        SDIAppForm.LabeledEdit10.Text:= LabeledEdit10.Text; //�ͼ�ҽ��
        SDIAppForm.LabeledEdit8.Text:= LabeledEdit1.Text;   //��������
        SDIAppForm.LabeledEdit9.Text:= LabeledEdit5.Text;   //����״̬
        SDIAppForm.LabeledEdit15.Text:= LabeledEdit15.Text; //��ע
        SDIAppForm.DateTimePicker1.Date := DateTimePicker1.Date; //��������
        SDIAppForm.DateTimePicker2.Date := DateTimePicker1.Date; //�������
        SDIAppForm.suiButton6Click(nil);

        checkunid:=sdiappform.ADObasic.fieldbyname('Ψһ���').AsInteger;
     end else
       checkunid:=adotemp15.fieldbyname('unid').AsInteger;
       
     for j:=0 to checklistbox1.Items.Count-1 do
     begin
       if checklistbox1.Checked[j] then
       begin
         s2:=checklistbox1.Items.Strings[j];
         b:=pos('   ',s2);
         s2:=copy(s2,1,b-1);

         {if ifSaveSuccess then} sdiappform.InsertOrDeleteVaue(s2,true,checkunid,-1);
       end;
     end;

  end;
  adotemp15.Free;
  sList.Free;
  
  //ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
  //ini.WriteString('Interface','�����ŷ�Χ��ĸ',LabeledEdit14.Text);
  //ini.Free;

  close;
end;


procedure TForm_pllr.FormShow(Sender: TObject);
//var
//  ini:tinifile;
begin
  //ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
  //LabeledEdit14.Text:=trim(uppercase(ini.ReadString('Interface','�����ŷ�Χ��ĸ','s')));
  //ini.Free;

  SDIAppForm.combinchecklistbox(CheckListBox1);

  if (not SDIAppForm.ADObasic.Active)or(SDIAppForm.ADObasic.RecordCount=0) then
    DateTimePicker1.DateTime:=date()
  else DateTimePicker1.DateTime := SDIAppForm.ADObasic.FieldByName('�������').AsDateTime;
  
  LabeledEdit3.SetFocus;
end;


procedure TForm_pllr.BitBtn3Click(Sender: TObject); //ȫѡ
var   i:integer;
begin
  for i:=0 to checklistbox1.Items.Count-1 do checklistbox1.Checked[i]:=true;
end;

procedure TForm_pllr.BitBtn4Click(Sender: TObject); //��ѡ
var i:integer;
begin
  for i:=0 to checklistbox1.Items.Count-1 do checklistbox1.Checked[i]:=not checklistbox1.Checked[i];
end;

procedure TForm_pllr.LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as ���� from CommCode where TypeName=''��������'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TForm_pllr.LabeledEdit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as ���� from CommCode where TypeName=''����״̬'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TForm_pllr.LabeledEdit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  if deptname_match='ȫƥ��' then tmpADOLYGetcode.GetCodePos:=gcAll
    else if deptname_match='��ƥ��' then tmpADOLYGetcode.GetCodePos:=gcLeft
      else if deptname_match='��ƥ��' then tmpADOLYGetcode.GetCodePos:=gcRight
        else tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.IfShowDialogZeroRecord:=true;
  tmpADOLYGetcode.OpenStr:='select name as ���� from CommCode where TypeName=''����'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TForm_pllr.LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.OpenStr:='select name as ���� from worker';
  tmpADOLYGetcode.InField:='id,wbm,pinyin';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TForm_pllr.LabeledEdit15KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.IfShowDialogZeroRecord:=true;
  tmpADOLYGetcode.OpenStr:='select name as ���� from CommCode where TypeName=''��ע'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TForm_pllr.ComboBox1Change(Sender: TObject);
begin
  LabeledEdit3.text:=ScalarSQLCmd(LisConn,' select dbo.uf_GetNextSerialNum('''+trim(SDIAppForm.cbxConnChar.Text)+''','''+FormatDateTime('YYYY-MM-DD',DateTimePicker1.Date)+''','''+trim((SENDER AS TComboBox).Text)+''') ');
  // getmaxid(trim(SDIAppForm.cbxConnChar.Text),DateTimePicker1.Date,trim((SENDER AS TComboBox).Text));
end;

procedure TForm_pllr.DateTimePicker1Change(Sender: TObject);
begin
  LabeledEdit3.text:=ScalarSQLCmd(LisConn,' select dbo.uf_GetNextSerialNum('''+trim(SDIAppForm.cbxConnChar.Text)+''','''+FormatDateTime('YYYY-MM-DD',(SENDER AS TDateTimePicker).Date)+''','''+trim(ComboBox1.Text)+''') ');
  //getmaxid(trim(SDIAppForm.cbxConnChar.Text),(SENDER AS TDateTimePicker).Date,ComboBox1.Text);
end;

procedure TForm_pllr.RadioGroup2Click(Sender: TObject);
begin
  if (sender as TRadioGroup).ItemIndex=0 then
  begin
    LabeledEdit3.Enabled:=true;
    LabeledEdit3.SetFocus;
    Edit1.Enabled:=false;
    Edit1.Clear;
    LabeledEdit14.Enabled:=false;
    LabeledEdit14.Clear;
  end else if (sender as TRadioGroup).ItemIndex=1 then
  begin
    LabeledEdit3.Enabled:=false;
    LabeledEdit3.Clear;
    Edit1.Enabled:=true;
    Edit1.SetFocus;
    LabeledEdit14.Enabled:=true;
  end;
end;

initialization
  fForm_pllr:=nil;

end.

