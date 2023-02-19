unit UfrmFromExcelLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,ComObj,ADODB,ShellAPI;

type
  TfrmFromExcelLoad = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function frmFromExcelLoad: TfrmFromExcelLoad;

implementation

uses UDM, SDIMAIN, superobject;
var
  ffrmFromExcelLoad: TfrmFromExcelLoad;
  
{$R *.dfm}
function frmFromExcelLoad: TfrmFromExcelLoad;
begin
  if ffrmFromExcelLoad=nil then ffrmFromExcelLoad:=TfrmFromExcelLoad.Create(application.mainform);
  result:=ffrmFromExcelLoad;
end;

procedure TfrmFromExcelLoad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmFromExcelLoad=self then ffrmFromExcelLoad:=nil;
end;

procedure TfrmFromExcelLoad.SpeedButton1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then exit;
  LabeledEdit1.Text:=OpenDialog1.FileName;
end;

procedure TfrmFromExcelLoad.BitBtn1Click(Sender: TObject);
var
  excelv,sheetv:variant;
  //(1)占位列,(2)占位列,(3)联机号,(4)病历号,(5)占位列,(6)姓名,
  {LSH,}LJH,BLH,{JCRQ,}XM:string;
  //(7)性别,(8)年龄,(9)床号,(10)送检科室,(11)送检医生, (12)占位列,
  XB,LL,CH,SJKS,SJYS{,CZY}:STRING;
  //(13)占位列,(14)申请日期,(15)优先级别,(16)工作组别,(17)样本类型,
  {SHZ,}SQRQ,YXJB,ZB,YBLX:STRING;
  //(18)样本情况,(19)临床诊断,(20)备注,(21)细菌,(22)所属公司,
  YBQK,LCZD,BZ,{XJ,}SSGS:STRING;
  //(23)所属部门,(24)工种，(25)工号,(26)婚否,(27)籍贯,(28)住址,
  SSBM,GZ,GH,HF,JG,ZZ:STRING;
  //(29)电话，(30)舒张压,(31)收缩压,(32)左眼视力,
  DH{,SZY,SSY,ZYSL}:STRING;
  //(33)右眼视力,(34)身高,(35)体重,(36)既往史,(37)家族史,
  {YYSL,SG,TZ,JWS,JZS:STRING;
  //(38)内科，(39)外科，(40)五官科，(41)妇科，(42)冷强光，
  NK,WK,WGK,FK,LQG:STRING;
  //(43)X光，(44)B超，(45)心电图，(46)检验，(47)结论，(48)建议
  XG,BC,XDT,JY,JL,YSJY:STRING;}
  //(49)项目名称,(50)项目英文名,(51)检验结果,(52)单位
  //XMMC,XMYWM,JYJG,DW:STRING;
  //(53)最小值,(54)最大值,(55)组合项目号,(56)打印编号,(57)项目代码
  {ZXZ,ZDZ,}ZHXMH{,DYBH,XMDM}:STRING;

  i,j:integer;
  Save_Cursor:TCursor;

  ls:TStrings;
  
  ObjectYZMZ:ISuperObject;//医嘱明细对象
  ArrayYZMX:ISuperObject;//医嘱明细数组

  ObjectJYYZ:ISuperObject;//检验医嘱对象
  ArrayJYYZ:ISuperObject;//检验医嘱数组

  BigObjectJYYZ:ISuperObject;//检验医嘱大对象
begin
  if trim(sdiappform.cbxConnChar.Text)='' then
  begin
    showmessage('请选择要导入的工作组!');
    exit;
  end;

  ZB:=sdiappform.cbxConnChar.Text;

  try
    excelv:=CreateOleObject('excel.application');
  except
    on E:Exception do
    begin
      MessageDlg('Execl异常:'+E.Message,mtError,[MBOK],0);
      exit;
    end;
  end;
  try
    excelv.workbooks.open(LabeledEdit1.Text);
  except
    showmessage('此文件不存在!');
    exit;
  end;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try  
    sheetv:=excelv.workbooks[1].worksheets[1];

    i:=2;
    //基本信息
    {TJH:=sheetv.cells[i,1];LSH:=sheetv.cells[i,2];}LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];{JCRQ:=sheetv.cells[i,5];}XM:=sheetv.cells[i,6];
    XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];{CZY:=sheetv.cells[i,12];}
    {SHZ:=sheetv.cells[i,13];}SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
    YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];{XJ:=sheetv.cells[i,21];}SSGS:=sheetv.cells[i,22];
    SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
    DH:=sheetv.cells[i,29];{SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
    YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
    NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
    XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];}
    //检验结果
    //XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
    {ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];}ZHXMH:=sheetv.cells[i,55];{DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];}

    while (XM<>'') do 
    begin
      ArrayYZMX:=SA([]);

      //如果无组合项目,也希望仅导入病人基本信息,按照Request2Lis.dll的约定,需要保证【医嘱明细】至少有一条记录,哪怕是一条无效数据的记录
      if trim(ZHXMH)='' then ZHXMH:='不存在的组合项目代码';//保证至少有一条医嘱明细
      ZHXMH:=StringReplace(ZHXMH,'，',',',[rfReplaceAll]);
      ls:=TStringList.Create;
      ExtractStrings([','],[],Pchar(ZHXMH),ls);
      for j:=0 to ls.Count-1 do
      begin
        ObjectYZMZ:=SO;
        ObjectYZMZ.S['联机号'] := LJH;
        ObjectYZMZ.S['LIS组合项目代码'] := ls[j];
        ObjectYZMZ.S['优先级别'] := YXJB;
        ObjectYZMZ.S['样本类型'] := YBLX;
        ObjectYZMZ.S['样本状态'] := YBQK;

        ArrayYZMX.AsArray.Add(ObjectYZMZ);
      end;
      ls.Free;      

      ObjectJYYZ:=SO;
      ObjectJYYZ.S['病历号']:=BLH;
      ObjectJYYZ.S['患者姓名']:=XM;
      ObjectJYYZ.S['患者性别']:=XB;
      ObjectJYYZ.S['患者年龄']:=LL;
      ObjectJYYZ.S['申请日期']:=SQRQ;
      ObjectJYYZ.S['申请科室']:=SJKS;
      ObjectJYYZ.S['申请医生']:=SJYS;
      ObjectJYYZ.S['床号']:=CH;
      ObjectJYYZ.S['临床诊断']:=LCZD;
      ObjectJYYZ.S['备注']:=BZ;
      ObjectJYYZ.S['所属公司']:=SSGS;
      ObjectJYYZ.S['所属部门']:=SSBM;
      ObjectJYYZ.S['工种']:=GZ;
      ObjectJYYZ.S['工号']:=GH;
      ObjectJYYZ.S['婚否']:=HF;
      ObjectJYYZ.S['籍贯']:=JG;
      ObjectJYYZ.S['住址']:=ZZ;
      ObjectJYYZ.S['电话']:=DH;
      ObjectJYYZ.O['医嘱明细']:=ArrayYZMX;

      ArrayJYYZ:=SA([]);
      ArrayJYYZ.AsArray.Add(ObjectJYYZ);

      BigObjectJYYZ:=SO;
      BigObjectJYYZ.S['JSON数据源']:='Excel';
      BigObjectJYYZ.O['检验医嘱']:=ArrayJYYZ;

      RequestForm2Lis(PChar(LisConn),PChar(UnicodeToChinese(BigObjectJYYZ.AsJson)),PChar(ZB));

      inc(i);
      //基本信息
      {TJH:=sheetv.cells[i,1];LSH:=sheetv.cells[i,2];}LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];{JCRQ:=sheetv.cells[i,5];}XM:=sheetv.cells[i,6];
      XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];{CZY:=sheetv.cells[i,12];}
      {SHZ:=sheetv.cells[i,13];}SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
      YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];{XJ:=sheetv.cells[i,21];}SSGS:=sheetv.cells[i,22];
      SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
      DH:=sheetv.cells[i,29];{SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
      YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
      NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
      XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];}
      //检验结果
      //XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
      {ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];}ZHXMH:=sheetv.cells[i,55];{DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];}
    end;

    //======清除内存
    if not VarIsEmpty(sheetv) then VarClear(sheetv);
    if not VarIsEmpty(excelv) then
    begin
      excelv.DisplayAlerts := False;
      excelv.Quit;
      VarClear(excelv);
    end;
    //=============

  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

  sdiappform.UpdateADObasic;//刷新主界面
  MESSAGEDLG('导入成功!',MTINFORMATION,[MBOK],0);
  close;
end;

procedure TfrmFromExcelLoad.BitBtn2Click(Sender: TObject);
begin
  CLOSE;
end;

procedure TfrmFromExcelLoad.Label18Click(Sender: TObject);
begin
  if ShellExecute(Handle, 'Open', Pchar(ExtractFilePath(application.ExeName)+'Patient2LIS-Template.xls'), '', '', SW_ShowNormal)<=32 then
    MessageDlg('Excel模板打开失败!',mtError,[mbOK],0);
end;

initialization
  ffrmFromExcelLoad:=nil;

end.
