unit UDM;

interface

uses
  WINDOWS,SysUtils, Classes, DB, ADODB,INIFILES,Dialogs{ShowMessage����},Controls,
  ComCtrls, Buttons,StdCtrls, ExtCtrls,MENUS,StrUtils,DBGrids, 
  Forms{Application����},DBCtrls{DBEdit},Mask{TMaskEdit},Imm{ImmGetIMEFileName},
  CheckLst{TCheckListBox}, frxClass, frxExportPDF, frxDBSet,Jpeg,Chart,
  Series, Graphics,Math,Variants;

type
  PDescriptType=^TDescriptType;
  TDescriptType=record
    ID:string;//�������ID
    UpID:String;//�ϼ�����ID
  end;
  
type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    frxPDFExport1: TfrxPDFExport;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxDBDataset2: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure frxReport1PrintReport(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);
    procedure frxReport1BeginDoc(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  //��������ָ��
  //ȡ������ļ򵥰취,��{$...}��$ǰ�����ӵ�ʲô,�������"ע��",Ʃ��:{.$}
  {.$DEFINE VERSION_PEIS}
  {$IFDEF VERSION_PEIS}
    SYSNAME='PEIS';
  {$ELSE}
    SYSNAME='LIS';
  {$ENDIF}

  sDBALIAS='ALIAS_SHHJ';
  CGYXJB='����';//�������ȼ����ַ���

var
  DM: TDM;

  powerstr_js_main:string;
  operator_name:string;
  operator_id:string;
  operator_DeptName:string;//����Ա��������
  operator_ShowAllTj:string;//����Ա�Ƿ�ɲ������п��ҵ������Ŀ

  ifGetBedNoFromCaseNo:boolean;//�Ƿ����"����/סԺ��"��ȡ����
  ifGetDiagnoseFromCaseNo:boolean;//�Ƿ����"����/סԺ��"��ȡ�ٴ����
  ifGetMemoFromCaseNo:boolean;//�Ƿ����"����/סԺ��"��ȡ��ע
  ifSaveSuccess:boolean;//��¼"������鵥F3"�¼��Ƿ�ɹ�,����¼��ʱҪ�õ�
  ifAutoCheck:boolean;//��¼�Ƿ��ӡʱ�Զ���˼��鵥
  deptname_match:string;//��¼�ͼ���ҵ�ȡ��ƥ�䷽ʽ
  check_doctor_match:string;////��¼�ͼ�ҽ����ȡ��ƥ�䷽ʽ
  ifNoResultPrint:boolean;//�Ƿ������޼�������ӡ
  ifShowPrintDialog:boolean;//��ӡ�Ի���
  bRegister:boolean;
  SCSYDW:STRING;//��Ȩʹ�õ�λ
  MakeTjDescDays:integer;//���������ۡ������ƫ������
  bAppendMakeTjDesc:string;//�Ƿ�����׷������������
  SmoothNum:integer;//ֱ��ͼ�⻬����
  LisConn:string;//Lis�����ַ���,MakeDBConn�����б���ֵ,Ȼ����QC.DLL��CalcItemPro.dll
  gServerName:string;//������,������ʾ��״̬��
  gDbName:string;//���ݿ���,������ʾ��״̬��
  ifBatchOperater:boolean;//�Ƿ���������,��������ʱ��������������Ϣ����.����̫��ʱ,ʹ������
  LoginTime:integer;//������¼���ڵ�ʱ��

  WorkGroup_T1:string;
  TempFile_T1:string;
  WorkGroup_T2:string;
  TempFile_T2:string;
  WorkGroup_T3:string;
  TempFile_T3:string;
  GP_WorkGroup_T1:string;//����ģ��1������
  GP_TempFile_T1:string;//����ģ��1�ļ�
  GP_WorkGroup_T2:string;//����ģ��2������
  GP_TempFile_T2:string;//����ģ��2�ļ�
  GP_WorkGroup_T3:string;//����ģ��3������
  GP_TempFile_T3:string;//����ģ��3�ļ�

  ifSearchHistValue:boolean;//�Ƿ������ʷ���

  ifHeightForItemNum:boolean;
  ItemRecNum:integer;
  PageHeigth:integer;

  //��ȡini�ļ��������Ϊ������Ӧ�̵İ����۰汾
  CryptStr:String;//�ӽ�������,�������汾��ʼ��Ϊ'lc'����ǰ�汾Ϊ'YIDA'

//**********************Dll�ӿں�������***************************************//
//�ú�������pSourStr���ж��ٸ�pSS
function ManyStr(const pSS, pSourStr: Pchar): integer;stdcall;external 'LYFunction.dll';
//��Χ�ַ���pRangeStr����5,7-9,11 ת��Ϊ('0005','0007','0008','0009','0011')
function RangeStrToSql(const pRangeStr:Pchar;const ifLPad:boolean;const LPad:Char;const sWidth:integer;var pSqlStr:Pchar):boolean;stdcall;external 'LYFunction.dll';
//��ǿ�͵�Pos����,ȡ��psubStr��pAllstr�е�Times�γ��ֵ�λ��
function PosExt(const psubStr,pAllstr:Pchar;const Times:Byte):integer;stdcall;external 'LYFunction.dll';
//�ҵ����ʽ��С����λ�������ֵ.��56.5*100+23.01��ֵΪ2
function MaxDotLen(const ACalaExp:PChar):integer;stdcall;external 'LYFunction.dll';
function GetHDSn(const RootPath:pchar):pchar;stdcall;external 'LYFunction.dll';
function GetSysCurImeName: pchar;stdcall;external 'LYFunction.dll';//ȡ��ϵͳ��ǰ���������뷨����
function GetVersionLY(const AFileName:pchar):pchar;stdcall;external 'LYFunction.dll';
function CassonEquation(const X1,Y1,X2,Y2:Real;var A,B:Real):boolean;stdcall;external 'LYFunction.dll';//���ɷ���ʽ
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//����
function EnCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//����
function CalParserValue(const CalExpress:Pchar;var ReturnValue:single):boolean;stdcall;external 'CalParser.dll';
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';
//��������Ŀ���ӻ�༭������������
procedure addOrEditCalcItem(const Aadoconnstr:Pchar;const ComboItemID:Pchar;const checkunid: integer);stdcall;external 'CalcItemPro.dll';
//�������������ӻ�༭������������
procedure addOrEditCalcValu(const Aadoconnstr:Pchar;const checkunid: integer;const AifInterface:boolean;const ATransItemidString:pchar);stdcall;external 'CalcItemPro.dll';
function LastPos(const ASubStr,ASourStr:Pchar):integer;stdcall;external 'LYFunction.dll';
procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunction.dll';
procedure RequestForm2Lis(const AAdoconnstr,ARequestJSON,CurrentWorkGroup:PChar);stdcall;external 'Request2Lis.dll';
function UnicodeToChinese(const AUnicodeStr:PChar):PChar;stdcall;external 'LYFunction.dll';
function GetMaxCheckID(const AWorkGroup,APreDate,APreCheckID:PChar):PChar;stdcall;external 'LYFunction.dll';
//****************************************************************************//

procedure SendKeyToControl(const VK:byte;control:Twincontrol);
function ageConvertChinese(agestr: string): string;
function GetServerDate(adoConn:TADOConnection):TDate;
procedure AddPickList(dbgrid: tdbgrid; const FieldIndex: integer;const JoinStr: string);//JoinStr����������ʽ��aa,bb,cc,dd
//����ָ���е���ʾ���
procedure VisibleColumn(dbgrid:tdbgrid;const DisplayName:string;const ifVisible:boolean);
function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
function HasSubInDbf(Node:TTreeNode):Boolean;
function ifRegister:boolean;
Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//��Ҫ�������뷨�Ĵ�������
function SmoothLine(const strHistogram:string;const SmoothNum:byte;var Strings:TStrings;var AMin:single;var AMax:single):integer;
function MakeDBConn:boolean;
procedure LoadGroupName(const comboBox:TcomboBox;const ASel:string);
procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGrid);
function ExecSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):integer;
function ScalarSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):string;
procedure combinchecklistbox(CheckListBox:TCheckListBox);//�������Ŀ�ż����Ƶ���CheckListBox��
function StopTime: integer; //����û�м��̺�����¼���ʱ��
procedure Draw_MVIS2035_Curve(Chart_XLB:TChart;const X1,Y1,X2,Y2,X1_MIN,Y1_MIN,X2_MIN,Y2_MIN,
                                                   X1_MAX,Y1_MAX,X2_MAX,Y2_MAX:Real);
procedure updatechart(ChartHistogram:TChart;const strHistogram:string;const strEnglishName:string;const strXTitle:string);


implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  CONFIGINI:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  CryptStr:=CONFIGINI.ReadString('Interface','CompanyId','lc');
  CONFIGINI.Free;

  MakeDBConn;
end;

procedure VisibleColumn(dbgrid:tdbgrid;const DisplayName:string;const ifVisible:boolean);
var
  i:integer;
begin
  if not dbgrid.DataSource.DataSet.Active then exit;
  for i :=0  to dbgrid.Columns.Count-1 do
    if uppercase(dbgrid.Fields[i].DisplayName)=uppercase(DisplayName) then
      dbgrid.Columns[i].Visible:=ifVisible;
end;

procedure AddPickList(dbgrid: tdbgrid; const FieldIndex: integer;
  const JoinStr: string);//JoinStr����������ʽ��aa,bb,cc,dd ע����Ӣ�Ļ�����״̬�Ķ��ŷָ�����
var
  CommaPos:integer;
  s1,s2:string;
begin
  s1:=JoinStr;
  if not dbgrid.DataSource.DataSet.Active then exit;
  if dbgrid.DataSource.DataSet.RecordCount=0 then exit;
  dbgrid.Columns[FieldIndex].PickList.Clear;
  if trim(JoinStr)='' then exit;
  CommaPos:=pos(',',s1);
  while CommaPos<>0 do
  begin
    s2:=trim(copy(s1,1,CommaPos-1));
    if trim(s2)<>'' then dbgrid.Columns[FieldIndex].PickList.add(s2);
    delete(s1,1,CommaPos);
    CommaPos:=pos(',',s1);
  end;
  if trim(s1)<>'' then dbgrid.Columns[FieldIndex].PickList.add(s1);
end;

function GetServerDate(adoConn:TADOConnection):TDate;
//����ֵ�а��������ڲ��ּ�ʱ�䲿��
//datetimetostr(����ֵ)-->2005-8-28 10:05:36
//datetostr(����ֵ)-->2005-8-28
//timetostr(����ֵ)-->10:05:36
var
  adotempDate:tadoquery;
begin
  adotempDate:=tadoquery.Create(NIL);
  ADOTEMPDATE.Connection:=adoConn;
  ADOTEMPDATE.Close;
  ADOTEMPDATE.SQL.Clear;
  ADOTEMPDATE.SQL.Text:='SELECT GETDATE() as ServerDate ';
  ADOTEMPDATE.Open;
  result:=ADOTEMPDATE.fieldbyname('ServerDate').AsDateTime;
  ADOTEMPDATE.Free;  //}
end;

procedure SendKeyToControl(const VK:byte;control:Twincontrol);
BEGIN
  control.SetFocus;
  keybd_event(VK,MapVirtualKey(VK,0),0,0); //ָ����������
END;

function ageConvertChinese(agestr: string): string;
var
  fagestr:single;
begin
    agestr:=uppercase(agestr);
    result:='';
    if (agestr='') then begin result:=''; exit;end;
    if UpperCase(agestr)='C' then begin result:='��'; exit;end;
    if trystrtofloat(agestr,fagestr) then begin result:=agestr+'��';exit;end;
    result:=StringReplace(agestr,'N','����',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'Y','��',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'M','��',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'D','��',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'H','Сʱ',[rfReplaceAll,rfIgnoreCase]);
end;

function haspower(powerstr_cur, menuname,sDatabaseName: string): boolean;
var
  jsmc:string;
  plusPos:integer;
  aa,bb:string;
  menuname_js:string;
  ADOquery_ryjs,ADOquery_menuitem:tADOquery;
  user_powerstr:string;
  ado_super:tadoquery;
begin
  result:=false;
  //===============�����û�����=================//
  ado_super:=tadoquery.Create(nil);
  ado_super.Connection:=DM.ADOConnection1;
  ado_super.SQL.Clear;
  ado_super.SQL.Text:='select * from worker where ifSuperUser=''1'' ';
  ado_super.Open;
  ado_super.First;
  if ado_super.Locate('id',operator_id,[loCaseInsensitive]) then
  begin
    result:=true;
    ado_super.Free;
    exit;
  end;
  //=======================================================//
  aa:='';bb:='';
  user_powerstr:=powerstr_cur;

  ADOquery_ryjs:=tADOquery.Create(nil);
  ADOquery_ryjs.Connection:=DM.ADOConnection1;
  ADOquery_ryjs.SQL.Clear;
  ADOquery_ryjs.SQL.Text:='select * from ryjs';
  ADOquery_ryjs.Open;

  ADOquery_menuitem:=tADOquery.Create(nil);
  ADOquery_menuitem.Connection:=DM.ADOConnection1;
  ADOquery_menuitem.SQL.Clear;
  ADOquery_menuitem.SQL.Text:='select * from menuitem WHERE SYSNAME='''+SYSNAME+''' ';
  ADOquery_menuitem.Open;

  while length(user_powerstr)>=3 do
  begin
    plusPos:=posExt('+',Pchar(user_powerstr),2);
    jsmc:=copy(user_powerstr,2,pluspos-2);
    try
      aa:=aa+ADOquery_ryjs.Lookup('jsmc',jsmc,'jsqx');
    except
      aa:=aa+'';
    end;
    delete(user_powerstr,1,pluspos);
  end;

  while length(aa)>=3 do
  begin
    bb:=copy(aa,1,3);
    if ADOquery_menuitem.Locate('bm',bb,[loCaseInsensitive]) then
        menuname_js:=trim(ADOquery_menuitem.fieldbyname('menuname').AsString)
    else  menuname_js:='';

    if  UpperCase(menuname_js)= UpperCase(Trim(menuname)) then
    begin
      result:=true;
      ADOquery_ryjs.Free;
      ADOquery_menuitem.Free;
      exit;
    end;
    delete(aa,1,3);
  end;

  if ADOquery_ryjs<>nil then ADOquery_ryjs.Free;
  if ADOquery_menuitem<>nil then ADOquery_menuitem.Free;
  if ado_super<>nil then ado_super.Free;
end;

function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
begin
  result:=true;

  if sender is tmenuitem then
  begin
    if not haspower(powerstr_js,tmenuitem(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is ttoolbutton then
  begin
    if not haspower(powerstr_js,ttoolbutton(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tbutton then
  begin
    if not haspower(powerstr_js,tbutton(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tpanel then
  begin
    if not haspower(powerstr_js,tpanel(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tspeedbutton then
  begin
    if not haspower(powerstr_js,tspeedbutton(sender).Caption,sDBALIAS) then result:=false;
  end;//}

  if sender is tcombobox then  
  begin
    if not haspower(powerstr_js,inttostr(tcombobox(sender).tag),sDBALIAS) then result:=false;
  end;

  if sender is tedit then
  begin
    if not haspower(powerstr_js,inttostr(tedit(sender).tag),sDBALIAS) then result:=false;
  end;

  if sender is tLabeledEdit then
  begin
    if not haspower(powerstr_js,tLabeledEdit(sender).EditLabel.Caption,sDBALIAS) then result:=false;
  end;

  if not result then
      messagedlg('�Բ�����û�и�Ȩ�ޣ�',mtinformation,[mbok],0);
end;

function HasSubInDbf(Node:TTreeNode):Boolean;
//���ڵ�Node�����ӽڵ�,���򷵻�True,��֮����False
var
  adotemp22:tadoquery;
begin
  result:=false;
  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=dm.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select * from RisDescriptType where UpID='''+PDescriptType(Node.Data)^.ID+'''';
  adotemp22.Open;
  if adotemp22.RecordCount<>0 then result:= True;
  adotemp22.Free;
end;

function ifRegister:boolean;
var
  HDSn,RegisterNum,EnHDSn:string;
  configini:tinifile;
  pEnHDSn:Pchar;
begin
  result:=false;
  
  HDSn:=GetHDSn('C:\')+'-'+GetHDSn('D:\');//�������ص�Pchar���ͻ�����ֱ�Ӹ�ֵ��string!!!

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  RegisterNum:=CONFIGINI.ReadString('Register','RegisterNum','');
  CONFIGINI.Free;
  pEnHDSn:=EnCryptStr(Pchar(HDSn),Pchar(CryptStr));
  EnHDSn:=StrPas(pEnHDSn);

  if Uppercase(EnHDSn)=Uppercase(RegisterNum) then result:=true;

  if not result then messagedlg('�Բ���,��û��ע���ע�������,��ע��!',mtinformation,[mbok],0);
end;

Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//��Ҫ�������뷨�Ĵ�������
//���뷨�Զ��л�����
//20051104 by ��ӥ
//���˼·:
//����Աֻ��Ҫ�������и��������ĵĿؼ���imemode=imOpen,Ȼ����ÿ��������
//create(��active)�¼�����ñ��˱�д�ķ���ChangeYouFormAllControlIme(Self)����.
//�ڳ������ṩһ���û����뷨ѡ��û�ѡ���Լ�ϲ�������뷨,
//������ʾFrmImeNameList���弴��!
//ע�⣺��"ѡ�����뷨��"Ҫ�ٴε���ChangeYouFormAllControlIme(Self)����Ŷ:)
var
  StrImeName:string;
  procedure JugeClassType(PClass:Tcontrol);
  //��Ȼ�鷳,����������ж�,���潫 dephi�ɸ��ĵĿؼ�������������,û�а�������ʹ�ü�ֵ����.
  begin
    if pclass is TEdit then//����Tedit��ؼ�,����ͬ��
    begin
      if TEdit(pclass).ImeMode=imOpen then
        TEdit(pclass).ImeName:=StrImeName
      else
        TEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TLabeledEdit then
    begin
      if TLabeledEdit(pclass).ImeMode=imOpen then
        TLabeledEdit(pclass).ImeName:=StrImeName
      else
        TLabeledEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TMemo then
    begin
      if TMemo(pclass).ImeMode=imOpen then
       TMemo(pclass).ImeName:=StrImeName
      else
       TMemo(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TComboBox then
    begin
      if TComboBox(pclass).ImeMode=imOpen then
       TComboBox(pclass).ImeName:=StrImeName
      else
       TComboBox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TRichEdit then
    begin
      if TRichEdit(pclass).ImeMode=imOpen then
       TRichEdit(pclass).ImeName:=StrImeName
      else
       TRichEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDBGrid then
    begin
      if TDBGrid(pclass).ImeMode=imOpen then
       TDBGrid(pclass).ImeName:=StrImeName
      else
       TDBGrid(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDBEdit then
    begin
      if TDBEdit(pclass).ImeMode=imOpen then
       TDBEdit(pclass).ImeName:=StrImeName
      else
       TDBEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDbMemo then
    begin
      if TDbMemo(pclass).ImeMode=imOpen then
       TDbMemo(pclass).ImeName:=StrImeName
      else
       TDbMemo(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDbcombobox then
    begin
      if TDbcombobox(pclass).ImeMode=imOpen then
       TDbcombobox(pclass).ImeName:=StrImeName
      else
       TDbcombobox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is Tdblookupcombobox then
    begin
      if Tdblookupcombobox(pclass).ImeMode=imOpen then
       Tdblookupcombobox(pclass).ImeName:=StrImeName
      else
       Tdblookupcombobox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is Tdbrichedit then
    begin
      if Tdbrichedit(pclass).ImeMode=imOpen then
       Tdbrichedit(pclass).ImeName:=StrImeName
      else
       Tdbrichedit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TMaskEdit then
    begin
      if TMaskEdit(pclass).ImeMode=imOpen then
        TMaskEdit(pclass).ImeName:=StrImeName
      else
        TMaskEdit(pclass).ImeMode:=imClose;
      exit;
    end;
  end;
const
  DefaultImeName='���� (����) - ���� ABC';
var
  i:integer;
  ChildControl:TControl;
  ConfigIni:tinifile;
  YouFormOrOTher:Twincontrol;
begin
  YouFormOrOTher:=YFormName;

  //��ȡ������û�ѡ������뷨,�õ�Ԫȫ�ֱ��� StrImeName ����
  //������Createʱ���øù���,��ʱUDMû������,����"ExtractFilePath(application.ExeName)"����AppPath����
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    StrImeName:=ConfigIni.ReadString('���뷨ѡ��','Ĭ���������뷨',DefaultImeName);
  finally
    ConfigIni.Free;
  end;

  //���÷��� JugeClassType(ChildControl) ���Ĵ����пؼ��� ImeMode
  for i:=0 to YouFormOrOTher.ControlCount-1 do
  begin
   ChildControl:=YouFormOrOTher.Controls[i];
   JugeClassType(ChildControl);

   //����ؼ������ؼ�,���ı������Ŀؼ�
   if ChildControl is TWinControl then ChangeYouFormAllControlIme(ChildControl as TWinControl);
  end;
end;

function SmoothLine(const strHistogram:string;const SmoothNum:byte;var Strings:TStrings;var AMin:single;var AMax:single):integer;
//strHistogram��ʽ:'2 3 5.5 2.3'
//����ֵ:Strings��Ԫ�ظ���.����ʱ���жϷ���ֵ,���������Ч
//SmoothNum:ƽ������Ĵ���.����Խ������Խ�⻬,������ƫ��Խ��
//Strings:���صĵ�
var
  ls:TStrings;
  t,i,j:integer;
  cc:array of single;
  fdotData:single;
begin
  result:=0;
  AMin:=0;AMax:=0;

  if Strings = nil then Exit;
  ls:=TStringList.Create;
  t:=ExtractStrings([' '],[],Pchar(trim(strHistogram)),ls);
  if t=0 then begin ls.Free;exit;end;

  for i :=0  to t-1 do//������Ч�㣬�򷵻�false
    if not trystrtofloat(ls[i],fdotData) then begin ls.Free;exit;end;

  setlength(cc,t);

  for i :=1  to SmoothNum do//ƽ������Ĵ���
  begin
    for j:=2 to t-1 do
    begin
      cc[j-1]:=(strtofloat(ls[j-2])+strtofloat(ls[j-1])+strtofloat(ls[j]))/3;
    end;
    cc[0]:=strtofloat(ls[0]);
    cc[t-1]:=strtofloat(ls[t-1]);
    
    for j:=0 to t-1 do ls[j]:=floattostr(cc[j]);
  end;

  for j:=0 to t-1 do
  begin
    Strings.Add(ls[j]);
    if j=0 then begin AMin:=strtofloat(ls[j]);AMax:=strtofloat(ls[j]);end;
    if strtofloat(ls[j])<AMin then AMin:=strtofloat(ls[j]);
    if strtofloat(ls[j])>AMax then AMax:=strtofloat(ls[j]);
  end;
  ls.Free;

  result:=t;
end;

function MakeDBConn:boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  userid, password, datasource, initialcatalog: string;{, provider}
  ifIntegrated:boolean;//�Ƿ񼯳ɵ�¼ģʽ

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('�������ݿ�', '������', '');
  initialcatalog := Ini.ReadString('�������ݿ�', '���ݿ�', '');
  ifIntegrated:=ini.ReadBool('�������ݿ�','���ɵ�¼ģʽ',false);
  userid := Ini.ReadString('�������ݿ�', '�û�', '');
  password := Ini.ReadString('�������ݿ�', '����', '107DFC967CDCFAAF');
  Ini.Free;
  //======����password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  newconnstr :='';
  newconnstr := newconnstr + 'user id=' + UserID + ';';
  newconnstr := newconnstr + 'password=' + Password + ';';
  newconnstr := newconnstr + 'data source=' + datasource + ';';
  newconnstr := newconnstr + 'Initial Catalog=' + initialcatalog + ';';
  newconnstr := newconnstr + 'provider=' + 'SQLOLEDB.1' + ';';
  //Persist Security Info,��ʾADO�����ݿ����ӳɹ����Ƿ񱣴�������Ϣ
  //ADOȱʡΪTrue,ADO.netȱʡΪFalse
  //�����лᴫADOConnection��Ϣ��TADOLYQuery,������ΪTrue
  newconnstr := newconnstr + 'Persist Security Info=True;';
  if ifIntegrated then
    newconnstr := newconnstr + 'Integrated Security=SSPI;';
  try
    dm.ADOConnection1.Connected := false;
    dm.ADOConnection1.ConnectionString := newconnstr;
    dm.ADOConnection1.Connected := true;
    result:=true;
    LisConn:=newconnstr;
    gServerName:=datasource;
    gDbName:=initialcatalog;
  except
  end;
  if not result then
  begin
    ss:='������'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ݿ�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ɵ�¼ģʽ'+#2+'CheckListBox'+#2+#2+'0'+#2+'���ø�ģʽ,���û�������������д'+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('�������ݿ�','�������ݿ�',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure LoadGroupName(const comboBox:TcomboBox;const ASel:string);
var
  adotemp3:tadoquery;
  tempstr:string;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=ASel;
     adotemp3.Open;
     
     comboBox.Items.Clear;//����ǰ�����comboBox��

     while not adotemp3.Eof do
     begin
      tempstr:=trim(adotemp3.Fields[0].AsString);

      comboBox.Items.Add(tempstr); //���ص�comboBox

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGrid);
//ʹdbGrid�������Զ���Ӧ���Ŀ��{��ΪDBGridEh�򽫸�Ϊ��(objDBGrid:TDBGridEh);}
var
  cc:integer;
  i,tmpLength:integer;
  objDataSet:TAdoquery;
  aDgCLength:array of integer;
begin
  cc:=objDbGrid.Columns.Count-1;

  objDataSet:=TAdoquery.Create(nil);
  //objDataSet.Clone(objDBGrid.DataSource.DataSet);

  setlength(aDgCLength,cc+1);
  //ȡ�����ֶεĳ���
  for i:=0 to  cc do
  begin
    aDgCLength[i]:= length(objDbGrid.Columns[i].Title.Caption);
  end; 

  objDataSet.First;
  while not objDataSet.Eof do
  begin
    //ȡ����ÿ���ֶεĳ���
    for i:=0 to  cc do
    begin
      tmpLength:=length(objDataSet.Fields.Fields[i].AsString);
      if tmpLength>aDgCLength[i] then aDgCLength[i]:=tmpLength;
    end;
    objDataSet.Next;
  end; 

  for i:=0 to  cc do
  begin
    objDbGrid.Columns[i].Width:=aDgCLength[i]*8;
  end;
end;

function ExecSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):integer;
var
  Conn:TADOConnection;
  Qry:TAdoQuery;
begin
  Conn:=TADOConnection.Create(nil);
  Conn.LoginPrompt:=false;
  Conn.ConnectionString:=AConnectionString;
  Qry:=TAdoQuery.Create(nil);
  Qry.Connection:=Conn;
  Qry.Close;
  Qry.SQL.Clear;
  Qry.SQL.Text:=ASQL;
  Try
    Result:=Qry.ExecSQL;
  except
    on E:Exception do
    begin
      if AErrorDlg then MESSAGEDLG('����ExecSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0)
        else WriteLog(pchar('������:'+operator_name+'������ExecSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL));
      Result:=-1;
    end;
  end;
  Qry.Free;
  Conn.Free;
end;

function ScalarSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):string;
var
  Conn:TADOConnection;
  Qry:TAdoQuery;
begin
  Result:='';
  Conn:=TADOConnection.Create(nil);
  Conn.LoginPrompt:=false;
  Conn.ConnectionString:=AConnectionString;
  Qry:=TAdoQuery.Create(nil);
  Qry.Connection:=Conn;
  Qry.Close;
  Qry.SQL.Clear;
  Qry.SQL.Text:=ASQL;
  Try
    Qry.Open;
  except
    on E:Exception do
    begin
      if AErrorDlg then MESSAGEDLG('����ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0)
        else WriteLog(pchar('������:'+operator_name+'������ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL));
      Qry.Free;
      Conn.Free;
      exit;
    end;
  end;
  Result:=Qry.Fields[0].AsString;
  Qry.Free;
  Conn.Free;
end;

procedure combinchecklistbox(CheckListBox:TCheckListBox);//�������Ŀ�ż����Ƶ���CheckListBox��
var
  adotemp3:tadoquery;
begin
     CheckListBox.Items.Clear;

     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:='select id,name from combinitem where sysname='''+SYSNAME+''' order by id';
     adotemp3.Open;
     while not adotemp3.Eof do
     begin
      CheckListBox.Items.Add(trim(adotemp3.fieldbyname('id').AsString)+'   '+adotemp3.fieldbyname('name').AsString);
      adotemp3.Next;
     end;
     adotemp3.Free;
end;

function StopTime: integer;
//����û�м��̺�����¼���ʱ��
var
  LInput: TLastInputInfo;
begin
  LInput.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(LInput);
  Result := (GetTickCount() - LInput.dwTime) div 1000;//΢�뻻����
end;

//��������ͼ start
procedure Draw_MVIS2035_Curve(Chart_XLB:TChart;const X1,Y1,X2,Y2,X1_MIN,Y1_MIN,X2_MIN,Y2_MIN,
                                               X1_MAX,Y1_MAX,X2_MAX,Y2_MAX:Real);
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
//��������ͼ stop

procedure updatechart(ChartHistogram:TChart;const strHistogram:string;const strEnglishName:string;const strXTitle:string);
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

procedure TDM.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  adotemp11:tadoquery;
  unid:integer;
  report_doctor:string;
  
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

  mvPictureTitle :TfrxMemoView;
begin
  if not frxDBDataset1.GetDataSet.Active then exit;//ADObasic
  if not frxDBDataset1.GetDataSet.RecordCount=0 then exit;//ADObasic

  unid:=frxDBDataset1.GetDataSet.fieldbyname('Ψһ���').AsInteger;
  report_doctor:=trim(frxDBDataset1.GetDataSet.fieldbyname('�����').AsString);

  //����Ѫ�������ߡ�ֱ��ͼ��ɢ��ͼ start
  if(Sender is TfrxPictureView)and(pos('CURVE',uppercase(Sender.Name))>0)then
  begin
    Sender.Visible:=false;
    strsqlPrint:='select Reserve8,itemValue,Min_Value,Max_Value '+
       ' from chk_valu WITH(NOLOCK) '+
       ' where pkunid=:pkunid '+
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
       ' from chk_valu WITH(NOLOCK) '+
       ' where pkunid=:pkunid '+
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
       ' from chk_valu WITH(NOLOCK) '+
       ' where pkunid=:pkunid '+
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

  //����Ҫ��ӡ����ߣ���ֻ����BeforePrint�¼��д���.(��ʵ��PrintReport�д��������)
  if(ifAutoCheck)and(report_doctor='') then//�޸������
  begin
    //chk_con_bak��Ϊ����˼�¼,�����账��
    ExecSQLCmd(LisConn,'update chk_con set report_doctor='''+operator_name+''',Audit_Date=getdate() where unid='+inttostr(unid));
    frxDBDataset1.GetDataSet.Refresh;//������ʾ�����.�˴�frxDBDataset1.GetDataSet��SDIAppForm.adobasic
  end;
end;

procedure TDM.frxReport1BeginDoc(Sender: TObject);
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

procedure TDM.frxReport1GetValue(const VarName: String;
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
      ItemChnName:=trim(frxDBDataset2.GetDataSet.fieldbyname('��Ŀ����').AsString);
      cur_value:=trim(frxDBDataset2.GetDataSet.fieldbyname('������').AsString);
      min_value:=trim(frxDBDataset2.GetDataSet.fieldbyname('��Сֵ').AsString);
      max_value:=trim(frxDBDataset2.GetDataSet.fieldbyname('���ֵ').AsString);

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
    if VarName='������˾' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('������˾').AsString);
    if VarName='����' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('����').AsString);
    if VarName='�Ա�' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('�Ա�').AsString);
    if VarName='�������' then Value:=frxDBDataset1.GetDataSet.fieldbyname('�������').AsDateTime;
    if VarName='����' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('����').AsString);
    if VarName='���' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('���').AsString);
    if VarName='����' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('����').AsString);
    if VarName='����' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('����').AsString);
    if VarName='סַ' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('סַ').AsString);
    if VarName='�绰' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('�绰').AsString);
    
    if VarName='�����豸' then Value:=ScalarSQLCmd(LisConn,'select dbo.uf_GetEquipFromChkUnid(0,'+frxDBDataset1.GetDataSet.fieldbyname('Ψһ���').AsString+')');
end;

procedure TDM.frxReport1PrintReport(Sender: TObject);
var
  unid,printtimes:integer;
  TableName:String;
begin
  if not frxDBDataset1.GetDataSet.Active then exit;
  if not frxDBDataset1.GetDataSet.RecordCount=0 then exit;

  unid:=frxDBDataset1.GetDataSet.fieldbyname('Ψһ���').AsInteger;
  printtimes:=frxDBDataset1.GetDataSet.fieldbyname('��ӡ����').AsInteger;

  ExecSQLCmd(LisConn,'insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values ('+inttostr(unid)+','''+operator_name+''',''Class_Print'',''Lab'')');

  if LowerCase(frxDBDataset1.GetDataSet.Owner.Name)='sdiappform' then TableName:='chk_con'
    else if LowerCase(frxDBDataset1.GetDataSet.Owner.Name)='frmcommquery' then TableName:='chk_con_bak'
      else exit;

  if printtimes=0 then//�޸Ĵ�ӡ����
  begin
    ExecSQLCmd(LisConn,'update '+TableName+' set printtimes='+inttostr(printtimes+1)+' where unid='+inttostr(unid));
    frxDBDataset1.GetDataSet.Refresh;//��ӡ��Ҫ��ʾ��ɫ
  end;
end;

end.
