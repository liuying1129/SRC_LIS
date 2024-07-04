unit UfrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, ToolWin, Grids, DBGrids,
  DB, ADODB,IniFiles,StrUtils, ADOLYGetcode,ShellAPI, FR_Class,Printers,
  FR_DSet, FR_DBSet,Jpeg,Chart,FR_Chart,Series,Math, ActnList,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh, EhLibADO,
  frxClass, frxDBSet, frxExportPDF, frxChart, FileCtrl;

//==Ϊ��ͨ��������Ϣ����������״̬��������==//
const
  WM_UPDATETEXTSTATUS=WM_USER+1;
TYPE
  TWMUpdateTextStatus=TWMSetText;
//=========================================//

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    BitBtn1: TBitBtn;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    RadioGroup3: TRadioGroup;
    ToolButton1: TToolButton;
    SpeedButton4: TSpeedButton;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    Splitter2: TSplitter;
    SpeedButton5: TSpeedButton;
    ToolButton2: TToolButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ADObasic: TADOQuery;
    ADOQuery2: TADOQuery;
    frReport1: TfrReport;
    ado_print: TADOQuery;
    frDBDataSet1: TfrDBDataSet;
    SpeedButton6: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid2: TDBGrid;
    ScrollBoxPicture: TScrollBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    ToolButton5: TToolButton;
    SpeedButton8: TSpeedButton;
    ComboBox1: TComboBox;
    Label3: TLabel;
    LabeledEdit5: TLabeledEdit;
    DBGrid1: TDBGridEh;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxDBDataset2: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    SpeedButton3: TSpeedButton;
    SpeedButton9: TSpeedButton;
    RadioGroup2: TRadioGroup;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LabeledEdit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure ADOQuery2AfterOpen(DataSet: TDataSet);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1BeforePrint(Memo: TStringList; View: TfrView);
    procedure frReport1PrintReport;
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure DBGrid1TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure DBGrid1SelectionChanged(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure frxReport1PrintReport(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure frxReport1BeginDoc(Sender: TObject);
  private
    procedure WriteProfile;
    procedure ReadConfig;
    procedure ReadIni;
    //==Ϊ��ͨ��������Ϣ����������״̬��������==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS��Ϣ������}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//TextΪ�ø�ʽ#$2+'0:abc'+#$2+'1:def'��ʾ״̬����0����ʾabc,��1����ʾdef,��������
    //==========================================//
    procedure ShowPictureValue(const ACheckUnid,AifCompleted: integer);
  public
    procedure Draw_MVIS2035_Curve(Chart_XLB:TChart;const X1,Y1,X2,Y2,X1_MIN,Y1_MIN,X2_MIN,Y2_MIN,
                                                   X1_MAX,Y1_MAX,X2_MAX,Y2_MAX:Real);
    procedure updatechart(ChartHistogram:TChart;const strHistogram:string;const strEnglishName:string;const strXTitle:string);
  end;

var
  frmMain: TfrmMain;

implementation

uses UfrmLogin, UDM, UfrmModifyPwd;
var
  lsGroupShow:TStrings;

{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmLogin.ShowModal;

  PageControl1.ActivePageIndex:=0;
  
  ReadConfig;
  UpdateStatusBar(#$2+'6:'+SCSYDW);
  UpdateStatusBar(#$2+'8:'+gServerName);
  UpdateStatusBar(#$2+'10:'+gDbName);
  
  LoadGroupName(ComboBox1,'select name from CommCode where TypeName=''�������'' group by name');
end;

procedure TfrmMain.ReadConfig;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  RadioGroup2.ItemIndex:=configini.ReadInteger('Interface','ifPreview',0);{��¼��ӡԤ����ֱ�Ӵ�ӡ������PDF}
  DBGrid1.Width:=configini.ReadInteger('Interface','gridBaseInfoWidth',680);{��¼������Ϣ����}
  Memo1.Height:=configini.ReadInteger('Interface','memoLogHeight',150);{��¼�����Ŀѡ���߶�}

  RadioGroup3.ItemIndex:=configini.ReadInteger('Interface','ifPrintRadio',0);

  LabeledEdit4.Text:=configini.ReadString('Interface','check_doctor','');{��¼�ͼ�ҽ��,ʵ�֡������Լ��ͼ������������}
  
  ReadIni();

  configini.Free;
end;

procedure TfrmMain.ReadIni;
var
  configini:tinifile;

  pInStr,pDeStr:Pchar;
  i:integer;
begin
  //��ϵͳ����
  SCSYDW:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''ϵͳ����'' and ReMark=''��Ȩʹ�õ�λ'' ');
  if SCSYDW='' then SCSYDW:='2F3A054F64394BBBE3D81033FDE12313';//'δ��Ȩ��λ'���ܺ���ַ���
  //======����SCSYDW
  pInStr:=pchar(SCSYDW);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(SCSYDW,length(pDeStr));
  for i :=1  to length(pDeStr) do SCSYDW[i]:=pDeStr[i-1];
  //==========
  BASE_URL:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''ϵͳ����'' and ReMark=''Զ�������ַ'' ');
  //if trim(BASE_URL)='' then BASE_URL:='http://211.97.0.5:8080/YkAPI/service';

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  SmoothNum:=configini.ReadInteger('����','ֱ��ͼ�⻬����',0);
  ifShowPrintDialog:=configini.ReadBool('����','��ӡ�Ի���',false);
  ifEnterGetCode:=configini.ReadBool('ѡ��','��д���˻�����Ϣʱ,ֱ�ӻس�����ȡ���',false);
  deptname_match:=configini.ReadString('ѡ��','�ͼ����ȡ���ƥ�䷽ʽ','');
  check_doctor_match:=configini.ReadString('ѡ��','�ͼ�ҽ��ȡ���ƥ�䷽ʽ','');

  WorkGroup_T1:=configini.ReadString('��ӡģ��','����ģ��1������','');
  TempFile_T1:=configini.ReadString('��ӡģ��','����ģ��1�ļ�','');
  WorkGroup_T2:=configini.ReadString('��ӡģ��','����ģ��2������','');
  TempFile_T2:=configini.ReadString('��ӡģ��','����ģ��2�ļ�','');
  WorkGroup_T3:=configini.ReadString('��ӡģ��','����ģ��3������','');
  TempFile_T3:=configini.ReadString('��ӡģ��','����ģ��3�ļ�','');  
  WorkGroup_T4:=configini.ReadString('��ӡģ��','����ģ��4������','');
  TempFile_T4:=configini.ReadString('��ӡģ��','����ģ��4�ļ�','');
  WorkGroup_T5:=configini.ReadString('��ӡģ��','����ģ��5������','');
  TempFile_T5:=configini.ReadString('��ӡģ��','����ģ��5�ļ�','');
  WorkGroup_T6:=configini.ReadString('��ӡģ��','����ģ��6������','');
  TempFile_T6:=configini.ReadString('��ӡģ��','����ģ��6�ļ�','');
  WorkGroup_T7:=configini.ReadString('��ӡģ��','����ģ��7������','');
  TempFile_T7:=configini.ReadString('��ӡģ��','����ģ��7�ļ�','');
  WorkGroup_T8:=configini.ReadString('��ӡģ��','����ģ��8������','');
  TempFile_T8:=configini.ReadString('��ӡģ��','����ģ��8�ļ�','');
  WorkGroup_T9:=configini.ReadString('��ӡģ��','����ģ��9������','');
  TempFile_T9:=configini.ReadString('��ӡģ��','����ģ��9�ļ�','');  
  WorkGroup_T10:=configini.ReadString('��ӡģ��','����ģ��10������','');
  TempFile_T10:=configini.ReadString('��ӡģ��','����ģ��10�ļ�','');
  WorkGroup_T11:=configini.ReadString('��ӡģ��','����ģ��11������','');
  TempFile_T11:=configini.ReadString('��ӡģ��','����ģ��11�ļ�','');
  WorkGroup_T12:=configini.ReadString('��ӡģ��','����ģ��12������','');
  TempFile_T12:=configini.ReadString('��ӡģ��','����ģ��12�ļ�','');
  WorkGroup_T13:=configini.ReadString('��ӡģ��','����ģ��13������','');
  TempFile_T13:=configini.ReadString('��ӡģ��','����ģ��13�ļ�','');
  WorkGroup_T14:=configini.ReadString('��ӡģ��','����ģ��14������','');
  TempFile_T14:=configini.ReadString('��ӡģ��','����ģ��14�ļ�','');
  WorkGroup_T15:=configini.ReadString('��ӡģ��','����ģ��15������','');
  TempFile_T15:=configini.ReadString('��ӡģ��','����ģ��15�ļ�','');  

  GP_WorkGroup_T1:=configini.ReadString('��ӡģ��','����ģ��1������','');
  GP_TempFile_T1:=configini.ReadString('��ӡģ��','����ģ��1�ļ�','');
  GP_WorkGroup_T2:=configini.ReadString('��ӡģ��','����ģ��2������','');
  GP_TempFile_T2:=configini.ReadString('��ӡģ��','����ģ��2�ļ�','');
  GP_WorkGroup_T3:=configini.ReadString('��ӡģ��','����ģ��3������','');
  GP_TempFile_T3:=configini.ReadString('��ӡģ��','����ģ��3�ļ�','');  

  configini.Free;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var                                                                           
  ss:string;
  sWorkGroup:string;
  adotemp3:tadoquery;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='select name from CommCode where TypeName=''�������'' group by name';
  adotemp3.Open;
  while not adotemp3.Eof do
  begin
    sWorkGroup:=sWorkGroup+#13+trim(adotemp3.fieldbyname('name').AsString);
    adotemp3.Next;
  end;
  adotemp3.Free;
  sWorkGroup:=trim(sWorkGroup);

  ss:='ֱ��ͼ�⻬����'+#2+'Edit'+#2+#2+'0'+#2+'ע:����Խ������Խ�⻬,������ƫ��Խ��'+#2+#3+
      '��ӡ�Ի���'+#2+'CheckListBox'+#2+#2+'0'+#2+'��ӡԤ��ģʽ�ĸ߼�ѡ��(��ӡ����ҳ�롢������)'+#2+#3+
      '��д���˻�����Ϣʱ,ֱ�ӻس�����ȡ���'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '�ͼ����ȡ���ƥ�䷽ʽ'+#2+'Combobox'+#2+'ģ��ƥ��'+#13+'��ƥ��'+#13+'��ƥ��'+#13+'ȫƥ��'+#2+'1'+#2+#2+#3+
      '�ͼ�ҽ��ȡ���ƥ�䷽ʽ'+#2+'Combobox'+#2+'ģ��ƥ��'+#13+'��ƥ��'+#13+'��ƥ��'+#13+'ȫƥ��'+#2+'1'+#2+#2+#3+
      '����ģ��1������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��1�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��2������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��2�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��3������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��3�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��4������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��4�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��5������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��5�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��6������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��6�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��7������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��7�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��8������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��8�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��9������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��9�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��10������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��10�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��11������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��11�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��12������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��12�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��13������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��13�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��14������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��14�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��15������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��15�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��1������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��1�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��2������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��2�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '����ģ��3������'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '����ģ��3�ļ�'+#2+'File'+#2+#2+'2'+#2+#2+#3;
  if ShowOptionForm('ѡ��','����'+#2+'ѡ��'+#2+'��ӡģ��',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
	  ReadIni;
end;

procedure TfrmMain.updatestatusBar(const text: string);
//TextΪ�ø�ʽ#$2+'0:abc'+#$2+'1:def'��ʾ״̬����0����ʾabc,��1����ʾdef,��������
var
  i,J2Pos,J2Len,TextLen,j:integer;
  tmpText:string;
begin
  TextLen:=length(text);
  for i :=0 to StatusBar1.Panels.Count-1 do
  begin
    J2Pos:=pos(#$2+inttostr(i)+':',text);
    J2Len:=length(#$2+inttostr(i)+':');
    if J2Pos<>0 then
    begin
      tmpText:=text;
      tmpText:=copy(tmpText,J2Pos+J2Len,TextLen-J2Pos-J2Len+1);
      j:=pos(#$2,tmpText);
      if j<>0 then tmpText:=leftstr(tmpText,j-1);
      StatusBar1.Panels[i].Text:=tmpText;
    end;
  end;
end;

procedure TfrmMain.WMUpdateTextStatus(var message: twmupdatetextstatus);
begin
  UpdateStatusBar(pchar(message.Text));
  message.Result:=-1;
end;

procedure TfrmMain.WriteProfile;
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  if DBGrid1.Width<60 then DBGrid1.Width:=60;
  configini.WriteInteger('Interface','gridBaseInfoWidth',DBGrid1.Width);{��¼������Ϣ����}
  if Memo1.Height<60 then Memo1.Height:=60;
  configini.WriteInteger('Interface','memoLogHeight',Memo1.Height);{��¼�����߶�}
  
  configini.WriteInteger('Interface','ifPrintRadio',RadioGroup3.ItemIndex);
  configini.WriteInteger('Interface','ifPreview',RadioGroup2.ItemIndex);{��¼�Ƿ��ӡԤ��ģʽ}

  configini.WriteString('Interface','check_doctor',LabeledEdit4.Text);{��¼�ͼ�ҽ��,ʵ�֡������Լ��ͼ������������}

  configini.Free;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  WriteProfile;

  lsGroupShow.Free;
end;

procedure TfrmMain.LabeledEdit3KeyDown(Sender: TObject; var Key: Word;
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
  tmpADOLYGetcode.OpenStr:='select name as ���� from CommCode where TypeName=''����'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+21{��ǰ����˵��߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmMain.LabeledEdit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  if check_doctor_match='ȫƥ��' then tmpADOLYGetcode.GetCodePos:=gcAll
    else if check_doctor_match='��ƥ��' then tmpADOLYGetcode.GetCodePos:=gcLeft
      else if check_doctor_match='��ƥ��' then tmpADOLYGetcode.GetCodePos:=gcRight
        else tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as ���� from worker';
  tmpADOLYGetcode.InField:='id,wbm,pinyin';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+21{��ǰ����˵��߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if ShellExecute(Handle, 'Open', Pchar(ExtractFilePath(application.ExeName)+'FrfSet.exe'), '', '', SW_ShowNormal)<=32 then
    MessageDlg((Sender as TSpeedButton).Caption+'(FrfSet.exe)��ʧ��!',mtError,[mbOK],0);
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  strsql22,strsql44,STRSQL45,STRSQL46,STRSQL47,STRSQL48,{STRSQL49,}STRSQL50,STRSQL51,STRSQL55: string;
begin
  strsql44:=' check_date between :P_DateTimePicker1 and :P_DateTimePicker2 and ';  
  if RadioGroup3.ItemIndex=1 then
    STRSQL46:=' isnull((case when len(caseno)=8 and LEFT(caseno,1)=''8'' then 1 else printtimes end),0)<=0 and '
  else STRSQL46:='';
  if trim(ComboBox1.Text)<>'' then STRSQL51:=' combin_id='''+trim(ComboBox1.Text)+''' and '
  else STRSQL51:='';
  if trim(LabeledEdit1.Text)<>'' then STRSQL48:=' Caseno='''+trim(LabeledEdit1.Text)+''' and '
  else STRSQL48:='';
  if trim(LabeledEdit2.Text)<>'' then STRSQL22:=' patientname like ''%'+trim(LabeledEdit2.Text)+'%'' and '
  else STRSQL22:='';
  if trim(LabeledEdit3.Text)<>'' then STRSQL45:=' deptname='''+trim(LabeledEdit3.Text)+''' and '
  else STRSQL45:='';
  if trim(LabeledEdit4.Text)<>'' then STRSQL50:=' check_doctor='''+trim(LabeledEdit4.Text)+''' and '
  else STRSQL50:='';
  if trim(LabeledEdit5.Text)<>'' then STRSQL55:=' WorkCompany like ''%'+trim(LabeledEdit5.Text)+'%'' and '
  else STRSQL55:='';
  STRSQL47:=' isnull(report_doctor,'''')<>'''' ';  
  //if RadioGroup2.ItemIndex=1 then STRSQL49:=' order by caseno '//��ɳ������ҽ��Ҫ�󰴲���������
  //  else if RadioGroup2.ItemIndex=2 then STRSQL49:=' order by WorkCompany '//��������Ҫ��������˾����
  //    else STRSQL49:=' order by patientname ';
  ADObasic.Close;
  ADObasic.SQL.Clear;
  ADObasic.SQL.Add(SHOW_CHK_CON);
  ADObasic.SQL.Add(' where ');
  ADObasic.SQL.Add(strsql44);
  ADObasic.SQL.Add(strsql46);
  ADObasic.SQL.Add(strsql51);
  ADObasic.SQL.Add(strsql48);
  ADObasic.SQL.Add(strsql22);
  ADObasic.SQL.Add(strsql45);
  ADObasic.SQL.Add(strsql50);
  ADObasic.SQL.Add(strsql55);
  ADObasic.SQL.Add(strsql47);
  //ADObasic.SQL.Add(strsql49);
  ADObasic.Parameters.ParamByName('P_DateTimePicker1').Value :=DateTimePicker1.DateTime;//�����Time����Ϊ00:00:00.����,����ѡ������ʱ����ı�Timeֵ
  ADObasic.Parameters.ParamByName('P_DateTimePicker2').Value :=DateTimePicker2.DateTime;//�����Time����Ϊ23:59:59.����,����ѡ������ʱ����ı�Timeֵ
  ADObasic.Open;
end;

procedure TfrmMain.ADObasicAfterScroll(DataSet: TDataSet);
var
  strsql11:string;
begin
  if not ADObasic.Active then exit;

  strsql11:='select '+
            '(case when photo is null then null else ''ͼ'' end) as ͼ,'+
            'combin_Name as �����Ŀ,name as ����,english_name as Ӣ����,itemvalue as ������,'+
            'min_value as ��Сֵ,max_value as ���ֵ,'+
            'unit as ��λ,'+
            'pkcombin_id as �����Ŀ��,itemid as ��Ŀ���,valueid as Ψһ��� '+
            ' from '+
            ifThen(ADObasic.FieldByName('ifCompleted').AsInteger=1,'chk_valu_bak','chk_valu')+
            ' WITH(NOLOCK) where pkunid=:pkunid and issure=1 '+
            ' order by pkcombin_id,printorder ';

  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Text:=strsql11;
  ADOQuery2.Parameters.ParamByName('pkunid').Value:=ADObasic.FieldByName('Ψһ���').AsInteger;
  try
    ADOQuery2.Open;
  except
  end;

  ShowPictureValue(DataSet.fieldbyname('Ψһ���').AsInteger,DataSet.fieldbyname('ifCompleted').AsInteger);
end;

procedure TfrmMain.ADObasicAfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;

  dbgrid1.Columns[0].Width:=42;//����
  dbgrid1.Columns[1].Width:=30;//�Ա�
  dbgrid1.Columns[2].Width:=30;//����
  dbgrid1.Columns[3].Width:=30;//��ӡ����
  dbgrid1.Columns[4].Width:=65;//������
  dbgrid1.Columns[5].Width:=30;//����
  dbgrid1.Columns[6].Width:=60;//�ͼ����
  dbgrid1.Columns[7].Width:=55;//�ͼ�ҽ��
  dbgrid1.Columns[8].Width:=135;//�������
  dbgrid1.Columns[9].Width:=72;//��������
  dbgrid1.Columns[10].Width:=42;//�����
  //dbgrid1.Columns[11].Width:=150;//�����Ŀ��
  dbgrid1.Columns[11].Width:=42;//������
  dbgrid1.Columns[12].Width:=42;//������
  dbgrid1.Columns[13].Width:=60;
  dbgrid1.Columns[14].Width:=60;
  dbgrid1.Columns[15].Width:=60;
  dbgrid1.Columns[16].Width:=60;
  dbgrid1.Columns[17].Width:=60;
  dbgrid1.Columns[18].Width:=60;
  dbgrid1.Columns[19].Width:=60;
  dbgrid1.Columns[20].Width:=60;
  dbgrid1.Columns[21].Width:=60;

  dbgrid1.Columns[0].Title.TitleButton:=true;//����,����
  dbgrid1.Columns[4].Title.TitleButton:=true;//����,������
  dbgrid1.Columns[21].Title.TitleButton:=true;//����,������˾

  dbgrid1.FrozenCols:=1;//��1�ж���
end;

procedure TfrmMain.ADOQuery2AfterOpen(DataSet: TDataSet);
var
  adotemp11:tadoquery;
  strsql11:string;
begin
  //�ò�ͬ����ɫ���з����ʶ(�˹��̷���Ҫ��������ݼ���AfterOpen������)
  strsql11:='select '+
            'DISTINCT pkcombin_id '+
            'from '+
            ifThen(ADObasic.FieldByName('ifCompleted').AsInteger=1,'chk_valu_bak','chk_valu')+
            ' WITH(NOLOCK) where pkunid=:pkunid and issure=1 order by pkcombin_id ';

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:=strsql11;
  adotemp11.Parameters.ParamByName('pkunid').Value :=ADObasic.FieldByName('Ψһ���').AsInteger;
  adotemp11.Open;
  lsGroupShow.Clear;
  while not adotemp11.Eof do
  begin
    lsGroupShow.Add(adotemp11.fieldbyname('pkcombin_id').AsString);

    adotemp11.Next;
  end;
  adotemp11.Free;
  //========================

  if not DataSet.Active then exit;
  
  dbgrid2.Columns[1].Width:=80;//�����Ŀ������
  dbgrid2.Columns[2].Width:=80;//������
  dbgrid2.Columns[3].Width:=50;//Ӣ����
  dbgrid2.Columns[4].Width:=70;//������
    
  dbgrid2.Columns[5].Width:=50;
  dbgrid2.Columns[6].Width:=50;
  dbgrid2.Columns[7].Width:=50;

  VisibleColumn(dbgrid2,'��Ŀ���',false);
  VisibleColumn(dbgrid2,'�����Ŀ��',false);
  VisibleColumn(dbgrid2,'Ψһ���',false);
end;

procedure TfrmMain.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  i:integer;
  ItemChnName,cur_value,min_value,max_value:string;//,nst_value
  sGroup:string;
  adotemp22:tadoquery;
begin
  //======================�����������ο���Χʱ�仯��ɫ======================//
  if (datacol=4) then
  begin
    ItemChnName:=trim(ADOQuery2.fieldbyname('��Ŀ���').AsString);
    cur_value:=trim(ADOQuery2.fieldbyname('������').AsString);
    min_value:=trim(ADOQuery2.fieldbyname('��Сֵ').AsString);
    max_value:=trim(ADOQuery2.fieldbyname('���ֵ').AsString);

    adotemp22:=Tadoquery.Create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:='select dbo.uf_ValueAlarm('''+ItemChnName+''','''+min_value+''','''+max_value+''','''+cur_value+''') as ifValueAlarm';
    try//uf_ValueAlarm�е�convert���������׳��쳣
      adotemp22.Open;
      i:=adotemp22.fieldbyname('ifValueAlarm').AsInteger;
    except
      i:=0;
    end;
    adotemp22.Free;

    if i=1 then
      tdbgrid(sender).Canvas.Font.Color:=clblue
    else if i=2 then
          tdbgrid(sender).Canvas.Font.Color:=clred;
    tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,Grids.TGridDrawState(State));
  end;
  //==========================================================================//

  //�ò�ͬ����ɫ���з����ʶ
  if (datacol=1)and(lsGroupShow.Count>1) then//�����������������ɫ���б�ʶ
  begin
    sGroup:=tdbgrid(sender).DataSource.DataSet.FieldByName('�����Ŀ��').AsString;
    for  i:=0  to lsGroupShow.Count-1 do
    begin
      if sGroup=lsGroupShow[i] then
      begin
        case (i+1) mod 2 = 0  of
          true : tdbgrid(sender).Canvas.Brush.color:=$00AAD5D5;
          false: tdbgrid(sender).Canvas.Brush.color:=clInfoBk;//$00FFD9CE;
        end;
        if ((State = [gdSelected]) or (State=[gdSelected,gdFocused])) then
        begin
            tdbgrid(sender).Canvas.Brush.color:=clhighlight;
            tdbgrid(sender).Canvas.Font.Color:=clwindow;
        end;
        tdbgrid(sender).DefaultDrawColumnCell(Rect,DataCol,Column,Grids.TGridDrawState(State));
        break;
      end;
    end;
  end;
  //========================//}
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lsGroupShow:=tstringlist.Create;
  
  DateTimePicker1.Date:=Date;
  DateTimePicker2.Date:=Date;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  strsqlPrint:string;
  sUnid,sCombin_Id:string;
  iIfCompleted:integer;

  i:integer;

  sPatientname,sSex,sAge:string;
  
  Save_Cursor:TCursor;
  OldCurrent:TBookmark;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  if DBGrid1.SelectedRows.Count<=0 then exit;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  //Grid��ѡ��¼�жϷ�ʽ�� begin
  //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼
  OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
  DBGrid1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGrid1.SelectedRows.Count-1 do
  begin
    DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[i];

    sUnid:=DBGrid1.DataSource.DataSet.fieldbyname('Ψһ���').AsString;
    sCombin_Id:=DBGrid1.DataSource.DataSet.FieldByName('������').AsString;
    iIfCompleted:=DBGrid1.DataSource.DataSet.FieldByName('ifCompleted').AsInteger;
    sPatientname:=trim(DBGrid1.DataSource.DataSet.fieldbyname('����').AsString);
    sSex:=DBGrid1.DataSource.DataSet.fieldbyname('�Ա�').AsString;
    sAge:=DBGrid1.DataSource.DataSet.fieldbyname('����').AsString;

    //�жϸþ�����Ա�Ƿ����δ��˽��START
    if strtoint(ScalarSQLCmd(LisConn,'select count(*) from chk_con where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+''') and isnull(report_doctor,'''')='''' '))>0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':������Ա['+sPatientname+']����δ��˱���!');
      WriteLog(pchar('������Ա['+sPatientname+']����δ��˱���!'));
    end;
    //================================STOP

    if (sCombin_Id=WorkGroup_T1)
      and frReport1.LoadFromFile(TempFile_T1) then//����ģ���ļ��ǲ����ִ�Сд��.���ַ���������ʧ��
    begin
    end else
    if (sCombin_Id=WorkGroup_T2)
      and frReport1.LoadFromFile(TempFile_T2) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T3)
      and frReport1.LoadFromFile(TempFile_T3) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T4)
      and frReport1.LoadFromFile(TempFile_T4) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T5)
      and frReport1.LoadFromFile(TempFile_T5) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T6)
      and frReport1.LoadFromFile(TempFile_T6) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T7)
      and frReport1.LoadFromFile(TempFile_T7) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T8)
      and frReport1.LoadFromFile(TempFile_T8) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T9)
      and frReport1.LoadFromFile(TempFile_T9) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T10)
      and frReport1.LoadFromFile(TempFile_T10) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T11)
      and frReport1.LoadFromFile(TempFile_T11) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T12)
      and frReport1.LoadFromFile(TempFile_T12) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T13)
      and frReport1.LoadFromFile(TempFile_T13) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T14)
      and frReport1.LoadFromFile(TempFile_T14) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T15)
      and frReport1.LoadFromFile(TempFile_T15) then
    begin
    end else
    if not frReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_cur.frf') then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']����Ĭ��ͨ�ô�ӡģ��report_cur.frfʧ�ܣ�������:ѡ��->��ӡģ��');
      WriteLog(pchar('['+sPatientname+']����Ĭ��ͨ�ô�ӡģ��report_cur.frfʧ�ܣ�������:ѡ��->��ӡģ��'));
      
      continue;
    end;

    strsqlPrint:='select itemid as ��Ŀ����,name as ����,english_name as Ӣ����,'+
            ' itemvalue as ������,'+
            ' min_value as ��Сֵ,max_value as ���ֵ,'+
            ' dbo.uf_Reference_Value_B1(min_value,max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(min_value,max_value) as ��βο���Χ,'+
            ' unit as ��λ,'+
            ' min(printorder) as ��ӡ���,'+
            ' min(pkcombin_id) as �����Ŀ��, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' from '+
            ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu')+
            ' WITH(NOLOCK) where pkunid='+sUnid+
            ' and issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
            ' group by itemid,name,english_name,itemvalue,min_value,max_value,unit, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' order by �����Ŀ��,��ӡ��� ';
    ado_print.Close;
    ado_print.SQL.Clear;
    ado_print.SQL.Text:=strsqlPrint;
    ado_print.Open;
    if ADO_print.RecordCount=0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']��Ч���!');
      WriteLog(pchar('['+sPatientname+']��Ч���!'));
      
      continue;
    end;

    if RadioGroup2.ItemIndex=0 then  //Ԥ��ģʽ
      frReport1.ShowReport
    else  //ֱ�Ӵ�ӡģʽ
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;    
  end;
  DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGrid1.DataSource.DataSet.EnableControls;
  //Grid��ѡ��¼�жϷ�ʽ�� end}

  Screen.Cursor := Save_Cursor;  { Always restore to normal }
  
  MessageDlg('��ӡ������ɣ�',mtInformation,[mbOK],0);
end;

procedure TfrmMain.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
var
  ItemChnName:string;
  cur_value:string;
  min_value:string;
  max_value:string;
  i:integer;
  adotemp22:Tadoquery;
begin
    if parname='SCSYDW' then ParValue:=SCSYDW;

    if parname='CXZF' then
    BEGIN
      ItemChnName:=trim(ADO_print.fieldbyname('��Ŀ����').AsString);
      cur_value:=trim(ADO_print.fieldbyname('������').AsString);
      min_value:=trim(ADO_print.fieldbyname('��Сֵ').AsString);
      max_value:=trim(ADO_print.fieldbyname('���ֵ').AsString);

      adotemp22:=Tadoquery.Create(nil);
      adotemp22.Connection:=dm.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select dbo.uf_ValueAlarm('''+ItemChnName+''','''+min_value+''','''+max_value+''','''+cur_value+''') as ifValueAlarm';
      try//uf_ValueAlarm�е�convert���������׳��쳣
        adotemp22.Open;
        i:=adotemp22.fieldbyname('ifValueAlarm').AsInteger;
      except
        i:=0;
      end;
      adotemp22.Free;
      if i=1 then
        ParValue := '��'
      else if i=2 then
        ParValue := '��'
      else ParValue:='';
    END;

    if parname='��ӡ��' then ParValue:=operator_name;
    if parname='������˾' then ParValue:=trim(ADObasic.fieldbyname('������˾').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='�Ա�' then ParValue:=trim(ADObasic.fieldbyname('�Ա�').AsString);
    if parname='�������' then ParValue:=ADObasic.fieldbyname('�������').AsDateTime;
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='���' then ParValue:=trim(ADObasic.fieldbyname('���').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='סַ' then ParValue:=trim(ADObasic.fieldbyname('סַ').AsString);
    if parname='�绰' then ParValue:=trim(ADObasic.fieldbyname('�绰').AsString);

    if parname='�����豸' then ParValue:=ScalarSQLCmd(LisConn,'select dbo.uf_GetEquipFromChkUnid('+ADObasic.fieldbyname('ifCompleted').AsString+','+ADObasic.fieldbyname('Ψһ���').AsString+')');
end;

procedure TfrmMain.frReport1BeforePrint(Memo: TStringList; View: TfrView);
var
  adotemp11:tadoquery;
  unid,iIfCompleted:integer;
  
  strsqlPrint,strEnglishName,strHistogram,strXTitle:string;
  MS:tmemorystream;
  tempjpeg:TJPEGImage;
  Chart_ZFT:TChart;

  //Ѫ�������start
  Reserve8_1,Reserve8_2:single;//�б���
  mPa_1,mPa_2:string;//ճ��
  mPa_min_1,mPa_min_2:string;//ճ��
  mPa_max_1,mPa_max_2:string;//ճ��
  Chart_XLB:TChart;
  //Ѫ�������stop
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('Ψһ���').AsInteger;
  iIfCompleted:=ADObasic.FieldByName('ifCompleted').AsInteger;

  //����Ѫ�������ߡ�ֱ��ͼ��ɢ��ͼ start
  if(View is TfrChartView)and(pos('CURVE',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strsqlPrint:='select Reserve8,itemValue,Min_Value,Max_Value '+
       ' from '+
       ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu') +
       ' WITH(NOLOCK) where pkunid=:pkunid '+
       ' and Reserve8 is not null '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    adotemp11.Open;
    if adotemp11.RecordCount=2 then
    begin
      View.Visible:=true;

      Chart_XLB:=TChart.Create(nil);
      Chart_XLB.Visible:=false;
      
      Reserve8_1:=adotemp11.fieldbyname('Reserve8').AsFloat;//�б���
      mPa_1:=adotemp11.fieldbyname('itemValue').AsString;//ճ��
      mPa_min_1:=adotemp11.fieldbyname('Min_Value').AsString;//ճ��
      mPa_max_1:=adotemp11.fieldbyname('Max_Value').AsString;//ճ��
      adotemp11.Next;
      Reserve8_2:=adotemp11.fieldbyname('Reserve8').AsFloat;//�б���
      mPa_2:=adotemp11.fieldbyname('itemValue').AsString;//ճ��
      mPa_min_2:=adotemp11.fieldbyname('Min_Value').AsString;//ճ��
      mPa_max_2:=adotemp11.fieldbyname('Max_Value').AsString;//ճ��
      Draw_MVIS2035_Curve(Chart_XLB,Reserve8_1,strtofloatdef(mPa_1,-1),Reserve8_2,strtofloatdef(mPa_2,-1),
                          Reserve8_1,strtofloatdef(mPa_min_1,-1),Reserve8_2,strtofloatdef(mPa_min_2,-1),
                          Reserve8_1,strtofloatdef(mPa_max_1,-1),Reserve8_2,strtofloatdef(mPa_max_2,-1));
      TfrChartView(View).Assignchart(Chart_XLB);//ָ��ͳ��ͼ�oFastReport

      Chart_XLB.Free;
    end;
    adotemp11.Free;
  end;
    
  if(View is TfrChartView)and(pos('CHART',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strEnglishName:=(View as TfrChartView).Name;
    strEnglishName:=stringreplace(strEnglishName,'Chart','',[rfIgnoreCase]);
    strsqlPrint:='select top 1 histogram,Dosage1 '+
       ' from '+
       ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu') +
       ' WITH(NOLOCK) where pkunid=:pkunid '+
       ' and english_name=:english_name '+
       ' and isnull(histogram,'''')<>'''' '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    adotemp11.Parameters.ParamByName('english_name').Value:=strEnglishName;
    adotemp11.Open;
    strHistogram:=trim(adotemp11.fieldbyname('histogram').AsString);
    strXTitle:=adotemp11.fieldbyname('Dosage1').AsString;
    adotemp11.Free;
    if strHistogram<>'' then
    begin
      View.Visible:=true;

      Chart_ZFT:=TChart.Create(nil);
      Chart_ZFT.Visible:=false;

      updatechart(Chart_ZFT,strHistogram,strEnglishName,strXTitle);
      TfrChartView(View).Assignchart(Chart_ZFT);//ָ��ͳ��ͼ�oFastReport

      Chart_ZFT.Free;
    end;
  end;

  if(View is TfrPictureView)and(pos('PICTURE',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strEnglishName:=(View as TfrPictureView).Name;
    strEnglishName:=stringreplace(strEnglishName,'Picture','',[rfIgnoreCase]);
    strsqlPrint:='select top 1 Photo '+
       ' from '+
       ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu') +
       ' WITH(NOLOCK) where pkunid=:pkunid '+
       //' and english_name=:english_name '+
       ' and itemid=:itemid '+//edit by liuying 20110414
       ' and Photo is not null '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    //adotemp11.Parameters.ParamByName('english_name').Value:=strEnglishName;
    adotemp11.Parameters.ParamByName('itemid').Value:=strEnglishName;//edit by liuying 20110414
    adotemp11.Open;
    if not adotemp11.fieldbyname('photo').IsNull then
    begin
      View.Visible:=true;
      MS:=TMemoryStream.Create;
      TBlobField(adotemp11.fieldbyname('photo')).SaveToStream(MS);
      MS.Position:=0;
      tempjpeg:=TJPEGImage.Create;
      tempjpeg.LoadFromStream(MS);
      MS.Free;
      TfrPictureView(View).Picture.assign(tempjpeg);
      tempjpeg.Free;
    end;
    adotemp11.Free;
  end;
  //����Ѫ�������ߡ�ֱ��ͼ��ɢ��ͼ stop
end;

procedure TfrmMain.frReport1PrintReport;
var
  unid,printtimes,iIfCompleted:integer;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('Ψһ���').AsInteger;
  printtimes:=ADObasic.fieldbyname('��ӡ����').AsInteger;
  iIfCompleted:=ADObasic.FieldByName('ifCompleted').AsInteger;

  if printtimes=0 then//�޸Ĵ�ӡ����
    ExecSQLCmd(LisConn,'update '+ifThen(iIfCompleted=1,'chk_con_bak','chk_con')+' set printtimes='+inttostr(printtimes+1)+' where unid='+inttostr(unid));
  
  ExecSQLCmd(LisConn,'insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values ('+inttostr(unid)+','''+operator_name+''',''Class_Print'',''Nurse'')');
end;

procedure TfrmMain.Draw_MVIS2035_Curve(Chart_XLB: TChart; const X1, Y1, X2,
  Y2, X1_MIN, Y1_MIN, X2_MIN, Y2_MIN, X1_MAX, Y1_MAX, X2_MAX,
  Y2_MAX: Real);
//Ҫ����Chart����ͼƬ,�ʸú�������д��DLL��                                    
VAR
  Y:Array[1..200] of real;
  Y_MIN:Array[1..200] of real;
  Y_MAX:Array[1..200] of real;
  A,B:real;
  A_MIN,B_MIN:real;
  A_MAX,B_MAX:real;
  i:integer;
  rMin,rMax:real;
  Series_Val,Series_Min,Series_Max:TFastLineSeries;
BEGIN
  if not CassonEquation(X1,Y1,X2,Y2,A,B) then exit;
  if not CassonEquation(X1_MIN,Y1_MIN,X2_MIN,Y2_MIN,A_MIN,B_MIN) then exit;
  if not CassonEquation(X1_MAX,Y1_MAX,X2_MAX,Y2_MAX,A_MAX,B_MAX) then exit;

  Chart_XLB.Width:=600;
  Chart_XLB.Height:=250;
  Chart_XLB.View3D:=false;
  Chart_XLB.Legend.Visible:=false;
  Chart_XLB.Color:=clWhite;
  Chart_XLB.BevelOuter:=bvNone;
  Chart_XLB.BottomAxis.Axis.Width:=1;
  Chart_XLB.LeftAxis.Axis.Width:=1;
  Chart_XLB.BackWall.Pen.Visible:=false;//����top��right�Ŀ�
  Chart_XLB.BottomAxis.Grid.Visible:=false;//���غ����GRID��
  Chart_XLB.LeftAxis.Grid.Visible:=false;//���������GRID��
  Chart_XLB.Title.Font.Color:=clBlack;//Ĭ����clBlue
  Chart_XLB.Title.Text.Clear;
  Chart_XLB.Title.Text.Add('ѪҺճ����������');
  Chart_XLB.BottomAxis.Title.Caption:='�б���(1/s)';
  Chart_XLB.LeftAxis.Title.Caption:='ճ��(mPa.s)';
  //for k:=Chart2.SeriesCount-1 downto 0 do Chart2.Series[k].Clear;//��̬������Chart,�϶�ûSerie

  Series_Val:=TFastLineSeries.Create(Chart_XLB);
  Series_Val.ParentChart :=Chart_XLB;
  Series_Val.SeriesColor:=clBlack;//����������ɫ
  Chart_XLB.AddSeries(Series_Val);

  Series_Min:=TFastLineSeries.Create(Chart_XLB);
  Series_Min.ParentChart :=Chart_XLB;
  Series_Min.SeriesColor:=clBtnFace;//����������ɫ
  Series_Min.LinePen.Style:=psDashDotDot;
  Chart_XLB.AddSeries(Series_Min);

  Series_Max:=TFastLineSeries.Create(Chart_XLB);
  Series_Max.ParentChart :=Chart_XLB;
  Series_Max.SeriesColor:=clBtnFace;//����������ɫ
  Series_Max.LinePen.Style:=psDashDotDot;
  Chart_XLB.AddSeries(Series_Max);

  rMin:=0;rMax:=0;
  for i :=1 to 200 do
  begin
    Y[i]:=POWER(A+B*sqrt(1/I),2);
    Y_MIN[i]:=POWER(A_MIN+B_MIN*sqrt(1/I),2);
    Y_MAX[i]:=POWER(A_MAX+B_MAX*sqrt(1/I),2);

    Series_Val.Add(Y[i]);
    Series_Min.Add(Y_min[i]);
    Series_Max.Add(Y_max[i]);

    if i=1 then begin rMin:=Y[i];rMax:=Y[i];end;
    if Y[i]<rMin then rMin:=Y[i];
    if Y[i]>rMax then rMax:=Y[i];
  end;

  Chart_XLB.LeftAxis.Automatic:=false;
  Chart_XLB.LeftAxis.Maximum:=MaxInt;//����������,�¾��п��ܱ���(��Сֵ����=<���ֵ)
  Chart_XLB.LeftAxis.Minimum:=rMin-10*(rMax-rMin)/100;//������10%�Ŀ�
  Chart_XLB.LeftAxis.Maximum:=rMax-10*(rMax-rMin)/100;//�������10%,����ͼ�βŻ��Ӵ�����Ĳ��
END;

procedure TfrmMain.updatechart(ChartHistogram: TChart; const strHistogram,
  strEnglishName, strXTitle: string);
var
    i,k:integer;
    sList:tstrings;
    fMin,fMax:single;
    Series_Val:TFastLineSeries;
begin
    ChartHistogram.Width:=194;
    ChartHistogram.Height:=90;
    ChartHistogram.View3D:=false;
    ChartHistogram.Legend.Visible:=false;
    ChartHistogram.Color:=clWhite;
    ChartHistogram.BevelOuter:=bvNone;//�粻���ø�����,���ӡʱ�ײ����ұ߸���һ����ɫ��
    ChartHistogram.BackWall.Pen.Visible:=false;//����top��right�Ŀ�
    ChartHistogram.BottomAxis.Axis.Width:=1;
    ChartHistogram.LeftAxis.Axis.Width:=1;
    ChartHistogram.BottomAxis.Grid.Visible:=false;//���غ����GRID��
    ChartHistogram.LeftAxis.Grid.Visible:=false;//���������GRID��
    ChartHistogram.BottomAxis.Labels:=false;//����X��Ŀ̶�
    ChartHistogram.LeftAxis.Labels:=false;//����Y��Ŀ̶�
    ChartHistogram.Title.Font.Color:=clBlack;//Ĭ����clBlue
    ChartHistogram.Title.Text.Clear;
    for k:=ChartHistogram.SeriesCount-1 downto 0 do ChartHistogram.Series[k].Clear;
    sList:=TStringList.Create;
    if SmoothLine(strHistogram,SmoothNum,sList,fMin,fMax)=0 then
    begin
      ChartHistogram.AxisVisible:=false;//���ϵ�TitleҲ��֮����
      sList.Free;
      exit;
    end;

    ChartHistogram.Title.Text.Text:=strEnglishName;
    ChartHistogram.BottomAxis.Title.Caption:=strXTitle;
    ChartHistogram.LeftAxis.Automatic:=false;
    ChartHistogram.LeftAxis.Maximum:=MaxInt;//����������,�¾��п��ܱ���(��Сֵ����=<���ֵ)
    ChartHistogram.LeftAxis.Minimum:=fMin-5*(fMax-fMin)/100;//���������ֱ���5%�Ŀ�
    ChartHistogram.LeftAxis.Maximum:=fMax+5*(fMax-fMin)/100;

    Series_Val:=TFastLineSeries.Create(ChartHistogram);
    Series_Val.ParentChart :=ChartHistogram;
    Series_Val.SeriesColor:=clBlack;//����������ɫ
    ChartHistogram.AddSeries(Series_Val);

    for i:=0 to sList.Count-1 do
    begin
      Series_Val.Add(strtofloat(sList[i]));
    end;
    sList.Free;
end;

procedure TfrmMain.SpeedButton6Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sCombin_Id,sReport_Doctor:string;

  i,iIfCompleted:integer;

  sPatientname,sSex,sAge:string;

  Save_Cursor:TCursor;
  OldCurrent:TBookmark;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  if DBGrid1.SelectedRows.Count<=0 then exit;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  //Grid��ѡ��¼�жϷ�ʽ�� begin
  //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼
  OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
  DBGrid1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGrid1.SelectedRows.Count-1 do
  begin
    DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[i];

    sUnid:=DBGrid1.DataSource.DataSet.fieldbyname('Ψһ���').AsString;
    sCombin_Id:=DBGrid1.DataSource.DataSet.FieldByName('������').AsString;
    sReport_Doctor:=trim(DBGrid1.DataSource.DataSet.FieldByName('�����').AsString);
    iIfCompleted:=DBGrid1.DataSource.DataSet.FieldByName('ifCompleted').AsInteger;
    sPatientname:=trim(DBGrid1.DataSource.DataSet.fieldbyname('����').AsString);
    sSex:=DBGrid1.DataSource.DataSet.fieldbyname('�Ա�').AsString;
    sAge:=DBGrid1.DataSource.DataSet.fieldbyname('����').AsString;

    //�жϸþ�����Ա�Ƿ����δ��˽��START
    if strtoint(ScalarSQLCmd(LisConn,'select count(*) from chk_con where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+''') and isnull(report_doctor,'''')='''' '))>0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':������Ա['+sPatientname+']����δ��˱���!');
      WriteLog(pchar('������Ա['+sPatientname+']����δ��˱���!'));
    end;
    //================================STOP

    if (sCombin_Id=GP_WorkGroup_T1)
      and frReport1.LoadFromFile(GP_TempFile_T1) then//����ģ���ļ��ǲ����ִ�Сд��.���ַ���������ʧ��
    begin
    end else
    if (sCombin_Id=GP_WorkGroup_T2)
      and frReport1.LoadFromFile(GP_TempFile_T2) then
    begin
    end else
    if (sCombin_Id=GP_WorkGroup_T3)
      and frReport1.LoadFromFile(GP_TempFile_T3) then
    begin
    end else
    if not frReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_Cur_group.frf') then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']����Ĭ�Ϸ����ӡģ��report_Cur_group.frfʧ�ܣ�������:ѡ��->��ӡģ��');
      WriteLog(pchar('['+sPatientname+']����Ĭ�Ϸ����ӡģ��report_Cur_group.frfʧ�ܣ�������:ѡ��->��ӡģ��'));
      
      continue;
    end;

    strsqlPrint:='select cv.combin_name as name,cv.name as ����,cv.english_name as Ӣ����,cv.itemvalue as ������,'+
      'cv.unit as ��λ,cv.min_value as ��Сֵ,cv.max_value as ���ֵ,'+
      ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as ��βο���Χ,'+
      ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10, '+
      ' cv.itemid as ��Ŀ���� '+//cci.Reserve3,
      ' from '+
      ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu')+
      ' cv WITH(NOLOCK) '+
      ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
      ' where cv.pkunid='+sUnid+
      ' and cv.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
      ' order by cv.pkcombin_id,cv.printorder ';//�����Ŀ��,��ӡ��� '
    ADO_print.Close;
    ADO_print.SQL.Clear;
    ADO_print.SQL.Text:=strsqlPrint;
    ADO_print.Open;
    if ADO_print.RecordCount=0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']��Ч���!');
      WriteLog(pchar('['+sPatientname+']��Ч���!'));
      
      continue;
    end;

    if RadioGroup2.ItemIndex=0 then  //Ԥ��ģʽ
      frReport1.ShowReport
    else  //ֱ�Ӵ�ӡģʽ
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
  end;
  DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGrid1.DataSource.DataSet.EnableControls;
  //Grid��ѡ��¼�жϷ�ʽ�� end}

  Screen.Cursor := Save_Cursor;  { Always restore to normal }

  MessageDlg('��ӡ������ɣ�',mtInformation,[mbOK],0);
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TfrmMain.ShowPictureValue(const ACheckUnid,AifCompleted: integer);
var
  adotemp3:tadoquery;
  i,n,m,k:integer;
  GroupBox:array of TGroupBox;
  Chart:array of TChart;
  MS:tmemorystream;

  //Ѫ�������start
  Reserve8_1,Reserve8_2:single;//�б���
  mPa_1,mPa_2:string;//ճ��
  mPa_min_1,mPa_min_2:string;//ճ��
  mPa_max_1,mPa_max_2:string;//ճ��
begin
  for i :=ScrollBoxPicture.ControlCount-1 downto 0 do
  begin
    if ScrollBoxPicture.Controls[i] is TGroupBox then ScrollBoxPicture.Controls[i].Free;
  end;

  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:=
    'select * from ( '+
      'select ''���''   as PictureType,* from '+ifThen(AifCompleted=1,'chk_valu_bak','chk_valu')+' WITH(NOLOCK) where pkunid='+inttostr(ACheckUnid)+' and isnull(histogram,'''')<>'''' and issure=''1'' '+
      'union all '+
      'select ''ͼƬ''   as PictureType,* from '+ifThen(AifCompleted=1,'chk_valu_bak','chk_valu')+' WITH(NOLOCK) where pkunid='+inttostr(ACheckUnid)+' and Photo is not null and issure=''1'' '+
      'union all '+
      'select ''Ѫ����'' as PictureType,* from '+ifThen(AifCompleted=1,'chk_valu_bak','chk_valu')+' WITH(NOLOCK) where pkunid='+inttostr(ACheckUnid)+' and Reserve8 is not null and issure=''1'' '+
    ' ) TempTable order by pkcombin_id,printorder ';
  adotemp3.Open;
  setlength(GroupBox,adotemp3.RecordCount);
  setlength(Chart,adotemp3.RecordCount);
  n:=0;m:=0;k:=-1;Reserve8_1:=-1;Reserve8_2:=-1;
  while not adotemp3.Eof do
  begin
    GroupBox[n]:=TGroupBox.Create(self);
    GroupBox[n].Parent:=ScrollBoxPicture;
    GroupBox[n].Left:=maxint;//ʹ����Panel������˳������
    GroupBox[n].Align:=alLeft;
    GroupBox[n].Width:=ScrollBoxPicture.Height;
    GroupBox[n].Caption:=adotemp3.FieldByName('name').AsString;
    GroupBox[n].Tag:=adotemp3.FieldByName('valueid').AsInteger;

    if adotemp3.FieldByName('PictureType').AsString='���' then
    begin
      Chart[n]:=TChart.Create(GroupBox[n]);//GroupBox�����ͷ�Chart
      Chart[n].Parent:=GroupBox[n];
      Chart[n].Align:=alClient;
      updatechart(Chart[n],trim(adotemp3.FieldByName('histogram').AsString),adotemp3.FieldByName('english_name').AsString,adotemp3.FieldByName('Dosage1').AsString);
    end;

    if adotemp3.FieldByName('PictureType').AsString='ͼƬ' then
    begin
      if tblobfield(adotemp3.FieldByName('photo')).BlobSize <=0 then begin inc(n);adotemp3.Next;continue;end;
      
      MS:=TMemoryStream.Create;
      TBlobField(adotemp3.fieldbyname('photo')).SaveToStream(MS);
      MS.Position:=0;
      with TImage.Create(GroupBox[n]) do//GroupBox�����ͷ�Image
      begin
        Parent:=GroupBox[n];
        Align:=alClient;
        Stretch:=true;
        Picture.Graphic:=nil;
        Picture.Graphic:=TJpegImage.Create;
        Picture.Graphic.LoadFromStream(MS);
      end;
      MS.Free;
    end;

    if adotemp3.FieldByName('PictureType').AsString='Ѫ����' then
    begin
      inc(m);
      
      if m=1 then
      begin
        Reserve8_1:=adotemp3.fieldbyname('Reserve8').AsFloat;//�б���
        mPa_1:=adotemp3.fieldbyname('itemValue').AsString;//ճ��
        mPa_min_1:=adotemp3.fieldbyname('Min_Value').AsString;//ճ��
        mPa_max_1:=adotemp3.fieldbyname('Max_Value').AsString;//ճ��
      end;
      
      if m=2 then
      begin
        Reserve8_2:=adotemp3.fieldbyname('Reserve8').AsFloat;//�б���
        mPa_2:=adotemp3.fieldbyname('itemValue').AsString;//ճ��
        mPa_min_2:=adotemp3.fieldbyname('Min_Value').AsString;//ճ��
        mPa_max_2:=adotemp3.fieldbyname('Max_Value').AsString;//ճ��
        k:=n;
      end;
    end;

    inc(n);
    adotemp3.Next
  end;
  adotemp3.Free;

  if m=2 then//Ѫ����
  begin
    Chart[k]:=TChart.Create(GroupBox[k]);//GroupBox�����ͷ�Chart
    Chart[k].Parent:=GroupBox[k];
    Chart[k].Align:=alClient;
    Draw_MVIS2035_Curve(Chart[k],Reserve8_1,strtofloatdef(mPa_1,-1),Reserve8_2,strtofloatdef(mPa_2,-1),
                        Reserve8_1,strtofloatdef(mPa_min_1,-1),Reserve8_2,strtofloatdef(mPa_min_2,-1),
                        Reserve8_1,strtofloatdef(mPa_max_1,-1),Reserve8_2,strtofloatdef(mPa_max_2,-1));
  end;
end;

procedure TfrmMain.RadioGroup1Click(Sender: TObject);
begin
  if (Sender as TRadioGroup).ItemIndex=1 then
  begin
    DateTimePicker1.Date:=Date-7;
    DateTimePicker2.Date:=Date;
  end
  else if (Sender as TRadioGroup).ItemIndex=2 then
  begin
    DateTimePicker1.Date:=Date-30;
    DateTimePicker2.Date:=Date;
  end
  else begin
    DateTimePicker1.Date:=Date;
    DateTimePicker2.Date:=Date;
  end;  
end;

procedure TfrmMain.SpeedButton8Click(Sender: TObject);
begin
  frmModifyPwd.ShowModal;
end;

procedure TfrmMain.DBGrid1TitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  //��Ϊ����ʱԭ�еĹ�ѡ���������,�ʵ������ťʱ������������й�ѡ
  //��ע��,�������ť������ADOQuery1AfterOpen�¼�
  DBGrid1.SelectedRows.Clear;
end;

procedure TfrmMain.DBGrid1SelectionChanged(Sender: TObject);
begin
  UpdateStatusBar(#$2+'0:'+IntToStr(DBGrid1.SelectedRows.Count));
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
var
  strsqlPrint:string;
  sUnid,sCombin_Id:string;
  iIfCompleted:integer;

  i:integer;

  sPatientname,sSex,sAge,sCheck_Date:string;
  
  Save_Cursor:TCursor;
  OldCurrent:TBookmark;
  PDFExportPath:String;

  frxMasterData:TfrxMasterData;  
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  if DBGrid1.SelectedRows.Count<=0 then exit;

  if RadioGroup2.ItemIndex=2 then
    if not SelectDirectory('��ѡ��PDF����Ŀ¼','',PDFExportPath) then exit;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  //Grid��ѡ��¼�жϷ�ʽ�� begin
  //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼
  OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
  DBGrid1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGrid1.SelectedRows.Count-1 do
  begin
    DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[i];

    sUnid:=DBGrid1.DataSource.DataSet.fieldbyname('Ψһ���').AsString;
    sCombin_Id:=DBGrid1.DataSource.DataSet.FieldByName('������').AsString;
    iIfCompleted:=DBGrid1.DataSource.DataSet.FieldByName('ifCompleted').AsInteger;
    sPatientname:=trim(DBGrid1.DataSource.DataSet.fieldbyname('����').AsString);
    sSex:=DBGrid1.DataSource.DataSet.fieldbyname('�Ա�').AsString;
    sAge:=DBGrid1.DataSource.DataSet.fieldbyname('����').AsString;
    sCheck_Date:=FormatDateTime('yyyymmdd',DBGrid1.DataSource.DataSet.fieldbyname('�������').AsDateTime);

    //�жϸþ�����Ա�Ƿ����δ��˽��START
    if strtoint(ScalarSQLCmd(LisConn,'select count(*) from chk_con where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+''') and isnull(report_doctor,'''')='''' '))>0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':������Ա['+sPatientname+']����δ��˱���!');
      WriteLog(pchar('������Ա['+sPatientname+']����δ��˱���!'));
    end;
    //================================STOP

    frxReport1.Clear;//�������ģ��
    frxDBDataSet1.UserName:='ADObasic';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ
    frxDBDataSet2.UserName:='ADO_print';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ

    if (sCombin_Id=WorkGroup_T1)
      and frxReport1.LoadFromFile(TempFile_T1) then//����ģ���ļ��ǲ����ִ�Сд��.���ַ���������ʧ��
    begin
    end else
    if (sCombin_Id=WorkGroup_T2)
      and frxReport1.LoadFromFile(TempFile_T2) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T3)
      and frxReport1.LoadFromFile(TempFile_T3) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T4)
      and frxReport1.LoadFromFile(TempFile_T4) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T5)
      and frxReport1.LoadFromFile(TempFile_T5) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T6)
      and frxReport1.LoadFromFile(TempFile_T6) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T7)
      and frxReport1.LoadFromFile(TempFile_T7) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T8)
      and frxReport1.LoadFromFile(TempFile_T8) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T9)
      and frxReport1.LoadFromFile(TempFile_T9) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T10)
      and frxReport1.LoadFromFile(TempFile_T10) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T11)
      and frxReport1.LoadFromFile(TempFile_T11) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T12)
      and frxReport1.LoadFromFile(TempFile_T12) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T13)
      and frxReport1.LoadFromFile(TempFile_T13) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T14)
      and frxReport1.LoadFromFile(TempFile_T14) then
    begin
    end else
    if (sCombin_Id=WorkGroup_T15)
      and frxReport1.LoadFromFile(TempFile_T15) then
    begin
    end else
    if not frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_cur.fr3') then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']����Ĭ��ͨ�ô�ӡģ��report_cur.fr3ʧ�ܣ�������:ѡ��->��ӡģ��');
      WriteLog(pchar('['+sPatientname+']����Ĭ��ͨ�ô�ӡģ��report_cur.fr3ʧ�ܣ�������:ѡ��->��ӡģ��'));
      
      continue;
    end;

    strsqlPrint:='select itemid as ��Ŀ����,name as ����,english_name as Ӣ����,'+
            ' itemvalue as ������,'+
            ' min_value as ��Сֵ,max_value as ���ֵ,'+
            ' dbo.uf_Reference_Value_B1(min_value,max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(min_value,max_value) as ��βο���Χ,'+
            ' unit as ��λ,'+
            ' min(printorder) as ��ӡ���,'+
            ' min(pkcombin_id) as �����Ŀ��, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' from '+
            ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu')+
            ' WITH(NOLOCK) where pkunid='+sUnid+
            ' and issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
            ' group by itemid,name,english_name,itemvalue,min_value,max_value,unit, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' order by �����Ŀ��,��ӡ��� ';
    ado_print.Close;
    ado_print.SQL.Clear;
    ado_print.SQL.Text:=strsqlPrint;
    ado_print.Open;
    if ADO_print.RecordCount=0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']��Ч���!');
      WriteLog(pchar('['+sPatientname+']��Ч���!'));
      
      continue;
    end;

    frxDBDataSet1.DataSet:=ADObasic;//����Fastreport�������TDataset���ݼ�
    frxDBDataSet2.DataSet:=ADO_print;//����Fastreport�������TDataset���ݼ�
    frxReport1.DataSets.Clear;//���ԭ�������ݼ�
    frxReport1.DataSets.Add(frxDBDataSet1);//���ع����õ�TfrxDBDataSet��������
    frxReport1.DataSets.Add(frxDBDataSet2);//���ع����õ�TfrxDBDataSet��������
  
    frxMasterData:=frxReport1.FindObject('MasterData1') as TfrxMasterData;
    if (frxMasterData<>nil) and (frxMasterData is TfrxMasterData) then frxMasterData.DataSet:=frxDBDataSet2;//��̬����MasterData.DataSet
      
    if RadioGroup2.ItemIndex=2 then//����PDF
    begin
      frxReport1.PrepareReport;
      frxPDFExport1.ShowDialog:=False;
      frxPDFExport1.DefaultPath:=PDFExportPath;
      frxPDFExport1.FileName:=sPatientname+'&'+sCheck_Date+'-'+sUnid+'.pdf';
      frxReport1.Export(frxPDFExport1);
    end else
    if RadioGroup2.ItemIndex=0 then  //Ԥ��ģʽ
      begin frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;frxReport1.ShowReport; end
    else  //ֱ�Ӵ�ӡģʽ
    begin
      if frxReport1.PrepareReport then begin frxReport1.PrintOptions.ShowDialog:=false;frxReport1.Print;end;
    end;    
  end;
  DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGrid1.DataSource.DataSet.EnableControls;
  //Grid��ѡ��¼�жϷ�ʽ�� end}

  Screen.Cursor := Save_Cursor;  { Always restore to normal }
  
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
  memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':��ӡ������ɣ�');
end;

procedure TfrmMain.SpeedButton9Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sCombin_Id,sReport_Doctor:string;

  i,iIfCompleted:integer;

  sPatientname,sSex,sAge,sCheck_Date:string;

  Save_Cursor:TCursor;
  OldCurrent:TBookmark;
  PDFExportPath:String;

  frxMasterData:TfrxMasterData;  
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  if DBGrid1.SelectedRows.Count<=0 then exit;

  if RadioGroup2.ItemIndex=2 then
    if not SelectDirectory('��ѡ��PDF����Ŀ¼','',PDFExportPath) then exit;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  //Grid��ѡ��¼�жϷ�ʽ�� begin
  //�÷�ʽ����ѭ��ȫ�����ݼ�,ֻ��ѭ����ѡ��¼
  OldCurrent:=DBGrid1.DataSource.DataSet.GetBookmark;
  DBGrid1.DataSource.DataSet.DisableControls;
  for i:=0 to DBGrid1.SelectedRows.Count-1 do
  begin
    DBGrid1.DataSource.DataSet.Bookmark:=DBGrid1.SelectedRows[i];

    sUnid:=DBGrid1.DataSource.DataSet.fieldbyname('Ψһ���').AsString;
    sCombin_Id:=DBGrid1.DataSource.DataSet.FieldByName('������').AsString;
    sReport_Doctor:=trim(DBGrid1.DataSource.DataSet.FieldByName('�����').AsString);
    iIfCompleted:=DBGrid1.DataSource.DataSet.FieldByName('ifCompleted').AsInteger;
    sPatientname:=trim(DBGrid1.DataSource.DataSet.fieldbyname('����').AsString);
    sSex:=DBGrid1.DataSource.DataSet.fieldbyname('�Ա�').AsString;
    sAge:=DBGrid1.DataSource.DataSet.fieldbyname('����').AsString;
    sCheck_Date:=FormatDateTime('yyyymmdd',DBGrid1.DataSource.DataSet.fieldbyname('�������').AsDateTime);

    //�жϸþ�����Ա�Ƿ����δ��˽��START
    if strtoint(ScalarSQLCmd(LisConn,'select count(*) from chk_con where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+''') and isnull(report_doctor,'''')='''' '))>0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':������Ա['+sPatientname+']����δ��˱���!');
      WriteLog(pchar('������Ա['+sPatientname+']����δ��˱���!'));
    end;
    //================================STOP

    frxReport1.Clear;//�������ģ��
    frxDBDataSet1.UserName:='ADObasic';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ
    frxDBDataSet2.UserName:='ADO_print';//����ģ���ļ�ǰ���ñ���.��Ϊһ�����ģ���ļ�ʱ�Ѿ������˱�����Ϣ

    if (sCombin_Id=GP_WorkGroup_T1)
      and frxReport1.LoadFromFile(GP_TempFile_T1) then//����ģ���ļ��ǲ����ִ�Сд��.���ַ���������ʧ��
    begin
    end else
    if (sCombin_Id=GP_WorkGroup_T2)
      and frxReport1.LoadFromFile(GP_TempFile_T2) then
    begin
    end else
    if (sCombin_Id=GP_WorkGroup_T3)
      and frxReport1.LoadFromFile(GP_TempFile_T3) then
    begin
    end else
    if not frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_Cur_group.fr3') then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']����Ĭ�Ϸ����ӡģ��report_Cur_group.frfʧ�ܣ�������:ѡ��->��ӡģ��');
      WriteLog(pchar('['+sPatientname+']����Ĭ�Ϸ����ӡģ��report_Cur_group.fr3ʧ�ܣ�������:ѡ��->��ӡģ��'));
      
      continue;
    end;

    strsqlPrint:='select cv.combin_name as name,cv.name as ����,cv.english_name as Ӣ����,cv.itemvalue as ������,'+
      'cv.unit as ��λ,cv.min_value as ��Сֵ,cv.max_value as ���ֵ,'+
      ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as ǰ�βο���Χ,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as ��βο���Χ,'+
      ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10, '+
      ' cv.itemid as ��Ŀ���� '+//cci.Reserve3,
      ' from '+
      ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu')+
      ' cv WITH(NOLOCK) '+
      ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
      ' where cv.pkunid='+sUnid+
      ' and cv.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
      ' order by cv.pkcombin_id,cv.printorder ';//�����Ŀ��,��ӡ��� '
    ADO_print.Close;
    ADO_print.SQL.Clear;
    ADO_print.SQL.Text:=strsqlPrint;
    ADO_print.Open;
    if ADO_print.RecordCount=0 then
    begin
      if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
      memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':['+sPatientname+']��Ч���!');
      WriteLog(pchar('['+sPatientname+']��Ч���!'));
      
      continue;
    end;

    frxDBDataSet1.DataSet:=ADObasic;//����Fastreport�������TDataset���ݼ�
    frxDBDataSet2.DataSet:=ADO_print;//����Fastreport�������TDataset���ݼ�
    frxReport1.DataSets.Clear;//���ԭ�������ݼ�
    frxReport1.DataSets.Add(frxDBDataSet1);//���ع����õ�TfrxDBDataSet��������
    frxReport1.DataSets.Add(frxDBDataSet2);//���ع����õ�TfrxDBDataSet��������
  
    frxMasterData:=frxReport1.FindObject('MasterData1') as TfrxMasterData;
    if (frxMasterData<>nil) and (frxMasterData is TfrxMasterData) then frxMasterData.DataSet:=frxDBDataSet2;//��̬����MasterData.DataSet
      
    if RadioGroup2.ItemIndex=2 then//����PDF
    begin
      frxReport1.PrepareReport;
      frxPDFExport1.ShowDialog:=False;
      frxPDFExport1.DefaultPath:=PDFExportPath;
      frxPDFExport1.FileName:=sPatientname+'&'+sCheck_Date+'-'+sUnid+'.pdf';
      frxReport1.Export(frxPDFExport1);
    end else
    if RadioGroup2.ItemIndex=0 then  //Ԥ��ģʽ
      begin frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;frxReport1.ShowReport; end
    else  //ֱ�Ӵ�ӡģʽ
    begin
      if frxReport1.PrepareReport then begin frxReport1.PrintOptions.ShowDialog:=false;frxReport1.Print;end;
    end;
  end;
  DBGrid1.DataSource.DataSet.GotoBookmark(OldCurrent);
  DBGrid1.DataSource.DataSet.EnableControls;
  //Grid��ѡ��¼�жϷ�ʽ�� end}

  Screen.Cursor := Save_Cursor;  { Always restore to normal }

  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memoֻ�ܽ���64K���ַ�
  memo1.Lines.Add(FormatDatetime('YYYY-MM-DD HH:NN:SS', Now) + ':��ӡ������ɣ�');
end;

procedure TfrmMain.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  adotemp11:tadoquery;
  unid,iIfCompleted:integer;
  
  strsqlPrint,strEnglishName,strHistogram,strXTitle:string;
  MS:tmemorystream;
  tempjpeg:TJPEGImage;
  Chart_ZFT:TChart;

  //Ѫ�������start
  Reserve8_1,Reserve8_2:single;//�б���
  mPa_1,mPa_2:string;//ճ��
  mPa_min_1,mPa_min_2:string;//ճ��
  mPa_max_1,mPa_max_2:string;//ճ��
  Chart_XLB:TChart;
  //Ѫ�������stop

  mvPictureTitle:TfrxMemoView;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('Ψһ���').AsInteger;
  iIfCompleted:=ADObasic.FieldByName('ifCompleted').AsInteger;

  //����Ѫ�������ߡ�ֱ��ͼ��ɢ��ͼ start
  if(Sender is TfrxPictureView)and(pos('CURVE',uppercase(Sender.Name))>0)then
  begin
    Sender.Visible:=false;
    strsqlPrint:='select Reserve8,itemValue,Min_Value,Max_Value '+
       ' from '+
       ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu') +
       ' WITH(NOLOCK) where pkunid=:pkunid '+
       ' and Reserve8 is not null '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    adotemp11.Open;
    if adotemp11.RecordCount=2 then
    begin
      Sender.Visible:=true;

      Chart_XLB:=TChart.Create(nil);
      Chart_XLB.Visible:=false;
      
      Reserve8_1:=adotemp11.fieldbyname('Reserve8').AsFloat;//�б���
      mPa_1:=adotemp11.fieldbyname('itemValue').AsString;//ճ��
      mPa_min_1:=adotemp11.fieldbyname('Min_Value').AsString;//ճ��
      mPa_max_1:=adotemp11.fieldbyname('Max_Value').AsString;//ճ��
      adotemp11.Next;
      Reserve8_2:=adotemp11.fieldbyname('Reserve8').AsFloat;//�б���
      mPa_2:=adotemp11.fieldbyname('itemValue').AsString;//ճ��
      mPa_min_2:=adotemp11.fieldbyname('Min_Value').AsString;//ճ��
      mPa_max_2:=adotemp11.fieldbyname('Max_Value').AsString;//ճ��
      Draw_MVIS2035_Curve(Chart_XLB,Reserve8_1,strtofloatdef(mPa_1,-1),Reserve8_2,strtofloatdef(mPa_2,-1),
                          Reserve8_1,strtofloatdef(mPa_min_1,-1),Reserve8_2,strtofloatdef(mPa_min_2,-1),
                          Reserve8_1,strtofloatdef(mPa_max_1,-1),Reserve8_2,strtofloatdef(mPa_max_2,-1));
      TfrxPictureView(Sender).Picture.Assign(Chart_XLB.TeeCreateMetafile(False,Rect(0,0,Round(Sender.Width),Round(Sender.Height))));//ָ��ͳ��ͼ�oFastReport

      Chart_XLB.Free;
    end;
    adotemp11.Free;
  end;
    
  if(Sender is TfrxPictureView)and(pos('CHART',uppercase(Sender.Name))>0)then
  begin
    Sender.Visible:=false;
    strEnglishName:=(Sender as TfrxPictureView).Name;
    strEnglishName:=stringreplace(strEnglishName,'Chart','',[rfIgnoreCase]);
    strsqlPrint:='select top 1 histogram,Dosage1 '+
       ' from '+
       ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu') +
       ' WITH(NOLOCK) where pkunid=:pkunid '+
       ' and english_name=:english_name '+
       ' and isnull(histogram,'''')<>'''' '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    adotemp11.Parameters.ParamByName('english_name').Value:=strEnglishName;
    adotemp11.Open;
    strHistogram:=trim(adotemp11.fieldbyname('histogram').AsString);
    strXTitle:=adotemp11.fieldbyname('Dosage1').AsString;
    adotemp11.Free;
    if strHistogram<>'' then
    begin
      Sender.Visible:=true;

      Chart_ZFT:=TChart.Create(nil);
      Chart_ZFT.Visible:=false;

      updatechart(Chart_ZFT,strHistogram,strEnglishName,strXTitle);
      TfrxPictureView(Sender).Picture.Assign(Chart_ZFT.TeeCreateMetafile(False,Rect(0,0,Round(Sender.Width),Round(Sender.Height))));//ָ��ͳ��ͼ�oFastReport

      Chart_ZFT.Free;
    end;
  end;

  if(Sender is TfrxPictureView)and(pos('PICTURE',uppercase(Sender.Name))>0)then
  begin
    Sender.Visible:=false;
    strEnglishName:=(Sender as TfrxPictureView).Name;
    strEnglishName:=stringreplace(strEnglishName,'Picture','',[rfIgnoreCase]);
    strsqlPrint:='select top 1 Photo,english_name '+
       ' from '+
       ifThen(iIfCompleted=1,'chk_valu_bak','chk_valu') +
       ' WITH(NOLOCK) where pkunid=:pkunid '+
       ' and itemid=:itemid '+//edit by liuying 20110414
       ' and Photo is not null '+
       ' and issure=1 ';
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=strsqlPrint;
    adotemp11.Parameters.ParamByName('pkunid').Value:=unid;
    adotemp11.Parameters.ParamByName('itemid').Value:=strEnglishName;//edit by liuying 20110414
    adotemp11.Open;
    if not adotemp11.fieldbyname('photo').IsNull then
    begin
      Sender.Visible:=true;
      MS:=TMemoryStream.Create;
      TBlobField(adotemp11.fieldbyname('photo')).SaveToStream(MS);
      MS.Position:=0;
      tempjpeg:=TJPEGImage.Create;
      tempjpeg.LoadFromStream(MS);
      MS.Free;
      TfrxPictureView(Sender).Picture.assign(tempjpeg);
      tempjpeg.Free;
      
      //��ʾͼƬ����begin
      mvPictureTitle:=TfrxMemoView(frxReport1.FindObject('mv'+Sender.Name));
      if (mvPictureTitle<>nil) and (mvPictureTitle is TfrxMemoView) then
      begin
        mvPictureTitle.AutoWidth:=True;
        mvPictureTitle.Font.Name:='����';
        mvPictureTitle.SetBounds((Sender as TfrxPictureView).Left, (Sender as TfrxPictureView).Top-20, 50, 20);
        mvPictureTitle.Text:=adotemp11.fieldbyname('english_name').AsString;
        mvPictureTitle.Visible:=true;
      end;
      //��ʾͼƬ����end
    end;
    adotemp11.Free;
  end;
  //����Ѫ�������ߡ�ֱ��ͼ��ɢ��ͼ stop
end;

procedure TfrmMain.frxReport1BeginDoc(Sender: TObject);
var
  j,k:integer;
  mvPictureTitle:TfrxMemoView;
begin
  //��̬����ͼƬ����begin
  //����������:�Ƿ���Ҫ�ͷ�mvPictureTitle?��ʱ�ͷ�?
  for j:=0 to (Sender as TfrxReport).PagesCount-1 do
  begin
    for k:=0 to (Sender as TfrxReport).Pages[j].Objects.Count-1 do
    begin
      if TObject((Sender as TfrxReport).Pages[j].Objects.Items[k]) is TfrxPictureView then
      begin
        if uppercase(leftstr(TfrxPictureView((Sender as TfrxReport).Pages[j].Objects.Items[k]).Name,7))='PICTURE' then
        begin
          mvPictureTitle:=TfrxMemoView.Create((Sender as TfrxReport).Pages[j]);
          mvPictureTitle.Name:='mv'+TfrxPictureView((Sender as TfrxReport).Pages[j].Objects.Items[k]).Name;
          mvPictureTitle.Visible:=false;
        end;
      end;
    end;
  end;
  //��̬����ͼƬ����end
end;

procedure TfrmMain.frxReport1GetValue(const VarName: String;
  var Value: Variant);
var
  ItemChnName:string;
  cur_value:string;
  min_value:string;
  max_value:string;
  i:integer;
  adotemp22:Tadoquery;
begin
    if VarName='SCSYDW' then Value:=SCSYDW;

    if VarName='CXZF' then
    BEGIN
      ItemChnName:=trim(ADO_print.fieldbyname('��Ŀ����').AsString);
      cur_value:=trim(ADO_print.fieldbyname('������').AsString);
      min_value:=trim(ADO_print.fieldbyname('��Сֵ').AsString);
      max_value:=trim(ADO_print.fieldbyname('���ֵ').AsString);

      adotemp22:=Tadoquery.Create(nil);
      adotemp22.Connection:=dm.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select dbo.uf_ValueAlarm('''+ItemChnName+''','''+min_value+''','''+max_value+''','''+cur_value+''') as ifValueAlarm';
      try//uf_ValueAlarm�е�convert���������׳��쳣
        adotemp22.Open;
        i:=adotemp22.fieldbyname('ifValueAlarm').AsInteger;
      except
        i:=0;
      end;
      adotemp22.Free;
      if i=1 then
      begin
        if VarIsNull(frxReport1.Variables['SymbolLow']) then Value:='��'//����ģ����δ�������SymbolLow�����δ��ֵ
        else Value := frxReport1.Variables['SymbolLow'];
      end else if i=2 then
      begin
        if VarIsNull(frxReport1.Variables['SymbolHigh']) then Value:='��'//����ģ����δ�������SymbolHigh�����δ��ֵ
        else Value := frxReport1.Variables['SymbolHigh'];
      end else Value:='';
    END;

    if VarName='��ӡ��' then Value:=operator_name;
    if VarName='������˾' then Value:=trim(ADObasic.fieldbyname('������˾').AsString);
    if VarName='����' then Value:=trim(ADObasic.fieldbyname('����').AsString);
    if VarName='�Ա�' then Value:=trim(ADObasic.fieldbyname('�Ա�').AsString);
    if VarName='�������' then Value:=ADObasic.fieldbyname('�������').AsDateTime;
    if VarName='����' then Value:=trim(ADObasic.fieldbyname('����').AsString);
    if VarName='���' then Value:=trim(ADObasic.fieldbyname('���').AsString);
    if VarName='����' then Value:=trim(ADObasic.fieldbyname('����').AsString);
    if VarName='����' then Value:=trim(ADObasic.fieldbyname('����').AsString);
    if VarName='סַ' then Value:=trim(ADObasic.fieldbyname('סַ').AsString);
    if VarName='�绰' then Value:=trim(ADObasic.fieldbyname('�绰').AsString);

    if VarName='�����豸' then Value:=ScalarSQLCmd(LisConn,'select dbo.uf_GetEquipFromChkUnid('+ADObasic.fieldbyname('ifCompleted').AsString+','+ADObasic.fieldbyname('Ψһ���').AsString+')');
end;

procedure TfrmMain.frxReport1PrintReport(Sender: TObject);
var
  unid,printtimes,iIfCompleted:integer;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('Ψһ���').AsInteger;
  printtimes:=ADObasic.fieldbyname('��ӡ����').AsInteger;
  iIfCompleted:=ADObasic.FieldByName('ifCompleted').AsInteger;

  if printtimes=0 then//�޸Ĵ�ӡ����
    ExecSQLCmd(LisConn,'update '+ifThen(iIfCompleted=1,'chk_con_bak','chk_con')+' set printtimes='+inttostr(printtimes+1)+' where unid='+inttostr(unid));
  
  ExecSQLCmd(LisConn,'insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values ('+inttostr(unid)+','''+operator_name+''',''Class_Print'',''Nurse'')');
end;

end.

