unit UDM;

interface

uses
  WINDOWS,SysUtils, Classes, DB, ADODB,INIFILES,Dialogs{ShowMessage函数},Controls,
  ComCtrls, Buttons,StdCtrls, ExtCtrls,MENUS,StrUtils,DBGrids, 
  Forms{Application变量},DBCtrls{DBEdit},Mask{TMaskEdit},Imm{ImmGetIMEFileName},
  CheckLst{TCheckListBox}, frxClass, frxExportPDF, frxDBSet,Jpeg,Chart,
  Series, Graphics,Math,Variants;

type
  PDescriptType=^TDescriptType;
  TDescriptType=record
    ID:string;//体检类型ID
    UpID:String;//上级类型ID
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
  //条件编译指令
  //取消定义的简单办法,在{$...}的$前面随便加点什么,让它变成"注释",譬如:{.$}
  {.$DEFINE VERSION_PEIS}
  {$IFDEF VERSION_PEIS}
    SYSNAME='PEIS';
  {$ELSE}
    SYSNAME='LIS';
  {$ENDIF}

  sDBALIAS='ALIAS_SHHJ';
  CGYXJB='常规';//常规优先级别字符串

var
  DM: TDM;

  powerstr_js_main:string;
  operator_name:string;
  operator_id:string;
  operator_DeptName:string;//操作员部门名称
  operator_ShowAllTj:string;//操作员是否可操作所有科室的组合项目

  ifGetBedNoFromCaseNo:boolean;//是否根据"门诊/住院号"提取床号
  ifGetDiagnoseFromCaseNo:boolean;//是否根据"门诊/住院号"提取临床诊断
  ifGetMemoFromCaseNo:boolean;//是否根据"门诊/住院号"提取备注
  ifSaveSuccess:boolean;//记录"保存检验单F3"事件是否成功,批量录入时要用到
  ifAutoCheck:boolean;//记录是否打印时自动审核检验单
  deptname_match:string;//记录送检科室的取码匹配方式
  check_doctor_match:string;////记录送检医生的取码匹配方式
  ifNoResultPrint:boolean;//是否允许无检验结果打印
  ifShowPrintDialog:boolean;//打印对话框
  bRegister:boolean;
  SCSYDW:STRING;//授权使用单位
  MakeTjDescDays:integer;//生成体检结论、建议的偏差天数
  bAppendMakeTjDesc:string;//是否允许追加生成体检结论
  SmoothNum:integer;//直方图光滑次数
  LisConn:string;//Lis连接字符串,MakeDBConn过程中被赋值,然后传入QC.DLL、CalcItemPro.dll
  gServerName:string;//服务名,用于显示在状态栏
  gDbName:string;//数据库名,用于显示在状态栏
  ifBatchOperater:boolean;//是否批量操作,批量操作时结果不跟随基本信息滚动.滚动太耗时,使批打慢
  LoginTime:integer;//弹出登录窗口的时间

  WorkGroup_T1:string;
  TempFile_T1:string;
  WorkGroup_T2:string;
  TempFile_T2:string;
  WorkGroup_T3:string;
  TempFile_T3:string;
  GP_WorkGroup_T1:string;//分组模板1工作组
  GP_TempFile_T1:string;//分组模板1文件
  GP_WorkGroup_T2:string;//分组模板2工作组
  GP_TempFile_T2:string;//分组模板2文件
  GP_WorkGroup_T3:string;//分组模板3工作组
  GP_TempFile_T3:string;//分组模板3文件

  ifSearchHistValue:boolean;//是否查找历史结果

  ifHeightForItemNum:boolean;
  ItemRecNum:integer;
  PageHeigth:integer;

  //读取ini文件，则可做为仪器供应商的绑定销售版本
  CryptStr:String;//加解密种子,从市政版本开始改为'lc'，以前版本为'YIDA'

//**********************Dll接口函数部分***************************************//
//该函数计算pSourStr中有多少个pSS
function ManyStr(const pSS, pSourStr: Pchar): integer;stdcall;external 'LYFunction.dll';
//范围字符串pRangeStr类似5,7-9,11 转换为('0005','0007','0008','0009','0011')
function RangeStrToSql(const pRangeStr:Pchar;const ifLPad:boolean;const LPad:Char;const sWidth:integer;var pSqlStr:Pchar):boolean;stdcall;external 'LYFunction.dll';
//加强型的Pos函数,取得psubStr在pAllstr中第Times次出现的位置
function PosExt(const psubStr,pAllstr:Pchar;const Times:Byte):integer;stdcall;external 'LYFunction.dll';
//找到表达式中小数点位数的最大值.如56.5*100+23.01的值为2
function MaxDotLen(const ACalaExp:PChar):integer;stdcall;external 'LYFunction.dll';
function GetHDSn(const RootPath:pchar):pchar;stdcall;external 'LYFunction.dll';
function GetSysCurImeName: pchar;stdcall;external 'LYFunction.dll';//取得系统当前的中文输入法名称
function GetVersionLY(const AFileName:pchar):pchar;stdcall;external 'LYFunction.dll';
function CassonEquation(const X1,Y1,X2,Y2:Real;var A,B:Real):boolean;stdcall;external 'LYFunction.dll';//卡松方程式
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//解密
function EnCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//加密
function CalParserValue(const CalExpress:Pchar;var ReturnValue:single):boolean;stdcall;external 'CalParser.dll';
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';
//将计算项目增加或编辑到检验结果表中
procedure addOrEditCalcItem(const Aadoconnstr:Pchar;const ComboItemID:Pchar;const checkunid: integer);stdcall;external 'CalcItemPro.dll';
//将计算数据增加或编辑到检验结果表中
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
procedure AddPickList(dbgrid: tdbgrid; const FieldIndex: integer;const JoinStr: string);//JoinStr是这样的样式：aa,bb,cc,dd
//控制指定列的显示与否
procedure VisibleColumn(dbgrid:tdbgrid;const DisplayName:string;const ifVisible:boolean);
function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
function HasSubInDbf(Node:TTreeNode):Boolean;
function ifRegister:boolean;
Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//需要更改输入法的窗体名称
function SmoothLine(const strHistogram:string;const SmoothNum:byte;var Strings:TStrings;var AMin:single;var AMax:single):integer;
function MakeDBConn:boolean;
procedure LoadGroupName(const comboBox:TcomboBox;const ASel:string);
procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGrid);
function ExecSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):integer;
function ScalarSQLCmd(AConnectionString:string;ASQL:string;AErrorDlg:boolean=True):string;
procedure combinchecklistbox(CheckListBox:TCheckListBox);//将组合项目号及名称导入CheckListBox中
function StopTime: integer; //返回没有键盘和鼠标事件的时间
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
  const JoinStr: string);//JoinStr是这样的样式：aa,bb,cc,dd 注：用英文或中文状态的逗号分隔均可
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
//返回值中包括了日期部分及时间部分
//datetimetostr(返回值)-->2005-8-28 10:05:36
//datetostr(返回值)-->2005-8-28
//timetostr(返回值)-->10:05:36
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
  keybd_event(VK,MapVirtualKey(VK,0),0,0); //指定键被按下
END;

function ageConvertChinese(agestr: string): string;
var
  fagestr:single;
begin
    agestr:=uppercase(agestr);
    result:='';
    if (agestr='') then begin result:=''; exit;end;
    if UpperCase(agestr)='C' then begin result:='成'; exit;end;
    if trystrtofloat(agestr,fagestr) then begin result:=agestr+'岁';exit;end;
    result:=StringReplace(agestr,'N','分钟',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'Y','岁',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'M','月',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'D','天',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'H','小时',[rfReplaceAll,rfIgnoreCase]);
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
  //===============超级用户例外=================//
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
      messagedlg('对不起，您没有该权限！',mtinformation,[mbok],0);
end;

function HasSubInDbf(Node:TTreeNode):Boolean;
//检查节点Node有无子节点,有则返回True,反之返回False
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
  
  HDSn:=GetHDSn('C:\')+'-'+GetHDSn('D:\');//函数返回的Pchar类型还真能直接赋值给string!!!

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  RegisterNum:=CONFIGINI.ReadString('Register','RegisterNum','');
  CONFIGINI.Free;
  pEnHDSn:=EnCryptStr(Pchar(HDSn),Pchar(CryptStr));
  EnHDSn:=StrPas(pEnHDSn);

  if Uppercase(EnHDSn)=Uppercase(RegisterNum) then result:=true;

  if not result then messagedlg('对不起,您没有注册或注册码错误,请注册!',mtinformation,[mbok],0);
end;

Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//需要更改输入法的窗体名称
//输入法自动切换过程
//20051104 by 刘鹰
//解决思路:
//程序员只需要将窗体中该输入中文的控件的imemode=imOpen,然后在每个窗体里
//create(或active)事件里调用本人编写的方法ChangeYouFormAllControlIme(Self)即可.
//在程序中提供一个用户输入法选项供用户选择自己喜欢的输入法,
//调用显示FrmImeNameList窗体即可!
//注意：在"选择输入法后"要再次调用ChangeYouFormAllControlIme(Self)方法哦:)
var
  StrImeName:string;
  procedure JugeClassType(PClass:Tcontrol);
  //虽然麻烦,但必须具体判断,下面将 dephi可更改的控件几乎都包含了,没有包含的是使用价值不大.
  begin
    if pclass is TEdit then//更改Tedit类控件,以下同理
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
  DefaultImeName='中文 (简体) - 智能 ABC';
var
  i:integer;
  ChildControl:TControl;
  ConfigIni:tinifile;
  YouFormOrOTher:Twincontrol;
begin
  YouFormOrOTher:=YFormName;

  //读取保存的用户选择的输入法,用单元全局变量 StrImeName 保存
  //主窗体Create时调用该过程,此时UDM没被创建,故用"ExtractFilePath(application.ExeName)"代替AppPath变量
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    StrImeName:=ConfigIni.ReadString('输入法选择','默认中文输入法',DefaultImeName);
  finally
    ConfigIni.Free;
  end;

  //调用方法 JugeClassType(ChildControl) 更改窗体中控件的 ImeMode
  for i:=0 to YouFormOrOTher.ControlCount-1 do
  begin
   ChildControl:=YouFormOrOTher.Controls[i];
   JugeClassType(ChildControl);

   //如果控件包含控件,更改被包含的控件
   if ChildControl is TWinControl then ChangeYouFormAllControlIme(ChildControl as TWinControl);
  end;
end;

function SmoothLine(const strHistogram:string;const SmoothNum:byte;var Strings:TStrings;var AMin:single;var AMax:single):integer;
//strHistogram格式:'2 3 5.5 2.3'
//返回值:Strings的元素个数.调用时先判断返回值,大于零才有效
//SmoothNum:平滑处理的次数.次数越多曲线越光滑,但曲线偏离越多
//Strings:返回的点
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

  for i :=0  to t-1 do//如有无效点，则返回false
    if not trystrtofloat(ls[i],fdotData) then begin ls.Free;exit;end;

  setlength(cc,t);

  for i :=1  to SmoothNum do//平滑处理的次数
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
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('连接数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接数据库','集成登录模式',false);
  userid := Ini.ReadString('连接数据库', '用户', '');
  password := Ini.ReadString('连接数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
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
  //Persist Security Info,表示ADO在数据库连接成功后是否保存密码信息
  //ADO缺省为True,ADO.net缺省为False
  //程序中会传ADOConnection信息给TADOLYQuery,故设置为True
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
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+'启用该模式,则用户及口令无需填写'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接数据库','连接数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
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
     
     comboBox.Items.Clear;//加载前先清除comboBox项

     while not adotemp3.Eof do
     begin
      tempstr:=trim(adotemp3.Fields[0].AsString);

      comboBox.Items.Add(tempstr); //加载到comboBox

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGrid);
//使dbGrid的内容自动适应他的宽度{如为DBGridEh则将改为：(objDBGrid:TDBGridEh);}
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
  //取标题字段的长度
  for i:=0 to  cc do
  begin
    aDgCLength[i]:= length(objDbGrid.Columns[i].Title.Caption);
  end; 

  objDataSet.First;
  while not objDataSet.Eof do
  begin
    //取列中每个字段的长度
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
      if AErrorDlg then MESSAGEDLG('函数ExecSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL,mtError,[mbOK],0)
        else WriteLog(pchar('操作者:'+operator_name+'。函数ExecSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL));
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
      if AErrorDlg then MESSAGEDLG('函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL,mtError,[mbOK],0)
        else WriteLog(pchar('操作者:'+operator_name+'。函数ScalarSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL));
      Qry.Free;
      Conn.Free;
      exit;
    end;
  end;
  Result:=Qry.Fields[0].AsString;
  Qry.Free;
  Conn.Free;
end;

procedure combinchecklistbox(CheckListBox:TCheckListBox);//将组合项目号及名称导入CheckListBox中
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
//返回没有键盘和鼠标事件的时间
var
  LInput: TLastInputInfo;
begin
  LInput.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(LInput);
  Result := (GetTickCount() - LInput.dwTime) div 1000;//微秒换成秒
end;

//生成曲线图 start
procedure Draw_MVIS2035_Curve(Chart_XLB:TChart;const X1,Y1,X2,Y2,X1_MIN,Y1_MIN,X2_MIN,Y2_MIN,
                                               X1_MAX,Y1_MAX,X2_MAX,Y2_MAX:Real);
//要利用Chart生成图片,故该函数不能写在DLL中                                    
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
  Chart_XLB.BackWall.Pen.Visible:=false;//隐藏top、right的框
  Chart_XLB.BottomAxis.Grid.Visible:=false;//隐藏横向的GRID线
  Chart_XLB.LeftAxis.Grid.Visible:=false;//隐藏纵向的GRID线
  Chart_XLB.Title.Font.Color:=clBlack;//默认是clBlue
  Chart_XLB.Title.Text.Clear;
  Chart_XLB.Title.Text.Add('血液粘度特性曲线');
  Chart_XLB.BottomAxis.Title.Caption:='切变率(1/s)';
  Chart_XLB.LeftAxis.Title.Caption:='粘度(mPa.s)';
  //for k:=Chart2.SeriesCount-1 downto 0 do Chart2.Series[k].Clear;//动态创建的Chart,肯定没Serie

  Series_Val:=TFastLineSeries.Create(Chart_XLB);
  Series_Val.ParentChart :=Chart_XLB;
  Series_Val.SeriesColor:=clBlack;//设置曲线颜色
  Chart_XLB.AddSeries(Series_Val);

  Series_Min:=TFastLineSeries.Create(Chart_XLB);
  Series_Min.ParentChart :=Chart_XLB;
  Series_Min.SeriesColor:=clBtnFace;//设置曲线颜色
  Series_Min.LinePen.Style:=psDashDotDot;
  Chart_XLB.AddSeries(Series_Min);

  Series_Max:=TFastLineSeries.Create(Chart_XLB);
  Series_Max.ParentChart :=Chart_XLB;
  Series_Max.SeriesColor:=clBtnFace;//设置曲线颜色
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
  Chart_XLB.LeftAxis.Maximum:=MaxInt;//如果不加这句,下句有可能报错(最小值必须=<最大值)
  Chart_XLB.LeftAxis.Minimum:=rMin-10*(rMax-rMin)/100;//下面留10%的空
  Chart_XLB.LeftAxis.Maximum:=rMax-10*(rMax-rMin)/100;//上面减少10%,这样图形才机子打出来的差不多
END;
//生成曲线图 stop

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
    ChartHistogram.BevelOuter:=bvNone;//如不设置该属性,则打印时底部、右边各有一条灰色线
    ChartHistogram.BackWall.Pen.Visible:=false;//隐藏top、right的框
    ChartHistogram.BottomAxis.Axis.Width:=1;
    ChartHistogram.LeftAxis.Axis.Width:=1;
    ChartHistogram.BottomAxis.Grid.Visible:=false;//隐藏横向的GRID线
    ChartHistogram.LeftAxis.Grid.Visible:=false;//隐藏纵向的GRID线
    ChartHistogram.BottomAxis.Labels:=false;//隐藏X轴的刻度
    ChartHistogram.LeftAxis.Labels:=false;//隐藏Y轴的刻度
    ChartHistogram.Title.Font.Color:=clBlack;//默认是clBlue
    ChartHistogram.Title.Text.Clear;
    for k:=ChartHistogram.SeriesCount-1 downto 0 do ChartHistogram.Series[k].Clear;
    sList:=TStringList.Create;
    if SmoothLine(strHistogram,SmoothNum,sList,fMin,fMax)=0 then
    begin
      ChartHistogram.AxisVisible:=false;//轴上的Title也随之隐藏
      sList.Free;
      exit;
    end;

    ChartHistogram.Title.Text.Text:=strEnglishName;
    ChartHistogram.BottomAxis.Title.Caption:=strXTitle;
    ChartHistogram.LeftAxis.Automatic:=false;
    ChartHistogram.LeftAxis.Maximum:=MaxInt;//如果不加这句,下句有可能报错(最小值必须=<最大值)
    ChartHistogram.LeftAxis.Minimum:=fMin-5*(fMax-fMin)/100;//上面和下面分别留5%的空
    ChartHistogram.LeftAxis.Maximum:=fMax+5*(fMax-fMin)/100;

    Series_Val:=TFastLineSeries.Create(ChartHistogram);
    Series_Val.ParentChart :=ChartHistogram;
    Series_Val.SeriesColor:=clBlack;//设置曲线颜色
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

  //血流变变量start
  Reserve8_1,Reserve8_2:single;//切变率
  mPa_1,mPa_2:string;//粘度
  mPa_min_1,mPa_min_2:string;//粘度
  mPa_max_1,mPa_max_2:string;//粘度
  Chart_XLB:TChart;
  //血流变变量stop

  mvPictureTitle :TfrxMemoView;
begin
  if not frxDBDataset1.GetDataSet.Active then exit;//ADObasic
  if not frxDBDataset1.GetDataSet.RecordCount=0 then exit;//ADObasic

  unid:=frxDBDataset1.GetDataSet.fieldbyname('唯一编号').AsInteger;
  report_doctor:=trim(frxDBDataset1.GetDataSet.fieldbyname('审核者').AsString);

  //加载血流变曲线、直方图、散点图 start
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
      
      Reserve8_1:=adotemp11.fieldbyname('Reserve8').AsFloat;//切变率
      mPa_1:=adotemp11.fieldbyname('itemValue').AsString;//粘度
      mPa_min_1:=adotemp11.fieldbyname('Min_Value').AsString;//粘度
      mPa_max_1:=adotemp11.fieldbyname('Max_Value').AsString;//粘度
      adotemp11.Next;
      Reserve8_2:=adotemp11.fieldbyname('Reserve8').AsFloat;//切变率
      mPa_2:=adotemp11.fieldbyname('itemValue').AsString;//粘度
      mPa_min_2:=adotemp11.fieldbyname('Min_Value').AsString;//粘度
      mPa_max_2:=adotemp11.fieldbyname('Max_Value').AsString;//粘度
      Draw_MVIS2035_Curve(Chart_XLB,Reserve8_1,strtofloatdef(mPa_1,-1),Reserve8_2,strtofloatdef(mPa_2,-1),
                          Reserve8_1,strtofloatdef(mPa_min_1,-1),Reserve8_2,strtofloatdef(mPa_min_2,-1),
                          Reserve8_1,strtofloatdef(mPa_max_1,-1),Reserve8_2,strtofloatdef(mPa_max_2,-1));
      TfrxPictureView(Sender).Picture.Assign(Chart_XLB.TeeCreateMetafile(False,Rect(0,0,Round(Sender.Width),Round(Sender.Height))));//指定统计图給FastReport

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
      TfrxPictureView(Sender).Picture.Assign(Chart_ZFT.TeeCreateMetafile(False,Rect(0,0,Round(Sender.Width),Round(Sender.Height))));//指定统计图給FastReport

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
      
      //显示图片标题begin
      mvPictureTitle:=TfrxMemoView(frxReport1.FindObject('mv'+Sender.Name));
      if (mvPictureTitle<>nil) and (mvPictureTitle is TfrxMemoView) then
      begin
        mvPictureTitle.AutoWidth:=True;
        mvPictureTitle.Font.Name:='宋体';
        mvPictureTitle.SetBounds((Sender as TfrxPictureView).Left, (Sender as TfrxPictureView).Top-20, 50, 20);
        mvPictureTitle.Text:=adotemp11.fieldbyname('english_name').AsString;
        mvPictureTitle.Visible:=true;
      end;
      //显示图片标题end
    end;
    adotemp11.Free;
  end;
  //加载血流变曲线、直方图、散点图 stop

  //可能要打印审核者，故只能在BeforePrint事件中处理.(其实在PrintReport中处理更合理)
  if(ifAutoCheck)and(report_doctor='') then//修改审核者
  begin
    //chk_con_bak均为已审核记录,故无需处理
    ExecSQLCmd(LisConn,'update chk_con set report_doctor='''+operator_name+''',Audit_Date=getdate() where unid='+inttostr(unid));
    frxDBDataset1.GetDataSet.Refresh;//更新显示审核者.此处frxDBDataset1.GetDataSet即SDIAppForm.adobasic
  end;
end;

procedure TDM.frxReport1BeginDoc(Sender: TObject);
var
  j,k:integer;
  mvPictureTitle:TfrxMemoView;
begin
  //动态创建图片标题begin
  //待处理问题:是否需要释放mvPictureTitle?何时释放?
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
  //动态创建图片标题end
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
      ItemChnName:=trim(frxDBDataset2.GetDataSet.fieldbyname('项目代码').AsString);
      cur_value:=trim(frxDBDataset2.GetDataSet.fieldbyname('检验结果').AsString);
      min_value:=trim(frxDBDataset2.GetDataSet.fieldbyname('最小值').AsString);
      max_value:=trim(frxDBDataset2.GetDataSet.fieldbyname('最大值').AsString);

      adotemp22:=Tadoquery.Create(nil);
      adotemp22.Connection:=dm.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select dbo.uf_ValueAlarm('''+ItemChnName+''','''+min_value+''','''+max_value+''','''+cur_value+''') as ifValueAlarm';
      try//uf_ValueAlarm中的convert函数可能抛出异常
        adotemp22.Open;
        i:=adotemp22.fieldbyname('ifValueAlarm').AsInteger;
      except
        i:=0;
      end;
      adotemp22.Free;
      if i=1 then
      begin
        if VarIsNull(frxReport1.Variables['SymbolLow']) then Value:='↓'//报表模板中未定义变量SymbolLow或变量未赋值
        else Value := frxReport1.Variables['SymbolLow'];
      end else if i=2 then
      begin
        if VarIsNull(frxReport1.Variables['SymbolHigh']) then Value:='↑'//报表模板中未定义变量SymbolHigh或变量未赋值
        else Value := frxReport1.Variables['SymbolHigh'];
      end else Value:='';
    END;

    if VarName='打印者' then Value:=operator_name;
    if VarName='所属公司' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('所属公司').AsString);
    if VarName='姓名' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('姓名').AsString);
    if VarName='性别' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('性别').AsString);
    if VarName='体检日期' then Value:=frxDBDataset1.GetDataSet.fieldbyname('检查日期').AsDateTime;
    if VarName='年龄' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('年龄').AsString);
    if VarName='婚否' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('婚否').AsString);
    if VarName='工种' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('工种').AsString);
    if VarName='籍贯' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('籍贯').AsString);
    if VarName='住址' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('住址').AsString);
    if VarName='电话' then Value:=trim(frxDBDataset1.GetDataSet.fieldbyname('电话').AsString);
    
    if VarName='检验设备' then Value:=ScalarSQLCmd(LisConn,'select dbo.uf_GetEquipFromChkUnid(0,'+frxDBDataset1.GetDataSet.fieldbyname('唯一编号').AsString+')');
end;

procedure TDM.frxReport1PrintReport(Sender: TObject);
var
  unid,printtimes:integer;
  TableName:String;
begin
  if not frxDBDataset1.GetDataSet.Active then exit;
  if not frxDBDataset1.GetDataSet.RecordCount=0 then exit;

  unid:=frxDBDataset1.GetDataSet.fieldbyname('唯一编号').AsInteger;
  printtimes:=frxDBDataset1.GetDataSet.fieldbyname('打印次数').AsInteger;

  ExecSQLCmd(LisConn,'insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values ('+inttostr(unid)+','''+operator_name+''',''Class_Print'',''Lab'')');

  if LowerCase(frxDBDataset1.GetDataSet.Owner.Name)='sdiappform' then TableName:='chk_con'
    else if LowerCase(frxDBDataset1.GetDataSet.Owner.Name)='frmcommquery' then TableName:='chk_con_bak'
      else exit;

  if printtimes=0 then//修改打印次数
  begin
    ExecSQLCmd(LisConn,'update '+TableName+' set printtimes='+inttostr(printtimes+1)+' where unid='+inttostr(unid));
    frxDBDataset1.GetDataSet.Refresh;//打印后要显示红色
  end;
end;

end.
