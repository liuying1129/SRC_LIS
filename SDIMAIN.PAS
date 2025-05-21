unit SDIMAIN;

interface

uses Windows,Messages, Classes,SysUtils, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls,CheckLst, ComCtrls, ImgList, StdActns,
  ActnList, ToolWin, DosMove,ADODB, Grids, DBGrids,
  DB,inifiles,FR_DBSet, FR_Class, LYAboutBox,Printers,
  StrUtils,  TeEngine, Series, TeeProcs, Chart,fr_chart,shellapi{ShellExecute}, 
  DateUtils, FR_DSet, ADOLYGetcode,Math, UfrmLocateRecord,
  UADOLYQuery, LYLed, frxClass, ExtDlgs,Variants,Jpeg;

//==为了通过发送消息更新主窗体状态栏而增加==//
const
  WM_UPDATETEXTSTATUS=WM_USER+1;
TYPE
  TWMUpdateTextStatus=TWMSetText;
//=========================================//

type
  TSDIAppForm = class(TForm)
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action4: TAction;
    ImageList1: TImageList;
    ADObasic: TADOQuery;
    DSbasic: TDataSource;
    ADO_dtl: TADOQuery;
    DS_dtl: TDataSource;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    N1: TMenuItem;
    FileOpenItem: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N10: TMenuItem;
    N4: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N5: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    LYAboutBox1: TLYAboutBox;
    LJ1: TMenuItem;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    N28: TMenuItem;
    ADO_print: TADOQuery;
    Q1: TMenuItem;
    N14: TMenuItem;
    Action10: TAction;
    N30: TMenuItem;
    N12: TMenuItem;
    N41: TMenuItem;
    N46: TMenuItem;
    N50: TMenuItem;
    O1: TMenuItem;
    Excel1: TMenuItem;
    PopupMenu1: TPopupMenu;
    N39: TMenuItem;
    N43: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N61: TMenuItem;
    pmChangeGroup: TPopupMenu;
    N38: TMenuItem;
    N40: TMenuItem;
    N11: TMenuItem;
    N22: TMenuItem;
    Y1: TMenuItem;
    N27: TMenuItem;
    frReport1: TfrReport;
    frDB_ADO_print: TfrDBDataSet;
    N31: TMenuItem;
    Excel2: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    M1: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TSpeedButton;
    suiButton8: TSpeedButton;
    ToolButton4: TToolButton;
    suiButton3: TSpeedButton;
    suiButton4: TSpeedButton;
    ToolButton6: TToolButton;
    ToolButton8: TSpeedButton;
    suiButton1: TSpeedButton;
    Panel1: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    LabeledEdit13: TLabeledEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Panel6: TPanel;
    Label2: TLabel;
    cbxConnChar: TComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    suiButton6: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit16: TLabeledEdit;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    N37: TMenuItem;
    DosMove1: TDosMove;
    N42: TMenuItem;
    N26: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N47: TMenuItem;
    N49: TMenuItem;
    SpeedButton1: TSpeedButton;
    ToolButton2: TToolButton;
    TimerIdleTracker: TTimer;
    SpeedButton5: TSpeedButton;
    CheckBox1: TCheckBox;
    Action3: TAction;
    N65: TMenuItem;
    N16: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    Label5: TLabel;
    Label6: TLabel;
    PopupMenu2: TPopupMenu;
    N23: TMenuItem;
    N45: TMenuItem;
    N48: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid2: TDBGrid;
    TabSheet2: TTabSheet;
    N73: TMenuItem;
    N74: TMenuItem;
    Action8: TAction;
    ScrollBoxPicture: TScrollBox;
    N66: TMenuItem;
    N71: TMenuItem;
    TabSheet3: TTabSheet;
    ImageBarcode2D: TImage;
    N29: TMenuItem;
    N72: TMenuItem;
    TabSheet4: TTabSheet;
    meValueDesc: TMemo;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn2: TBitBtn;
    N76: TMenuItem;
    lbedtWorkID: TLabeledEdit;
    lbedtWorkCompany: TLabeledEdit;
    lbedtWorkDepartment: TLabeledEdit;
    lbedtWorkCategory: TLabeledEdit;
    lbedtifMarry: TLabeledEdit;
    lbedtOldAddress: TLabeledEdit;
    lbedtAddress: TLabeledEdit;
    lbedtTelephone: TLabeledEdit;
    N77: TMenuItem;
    N78: TMenuItem;
    N79: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    N83: TMenuItem;
    N84: TMenuItem;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    clbCommUsed: TCheckListBox;
    clbNoCommUsed: TCheckListBox;
    PopupMenu3: TPopupMenu;
    N17: TMenuItem;
    N60: TMenuItem;
    N75: TMenuItem;
    ToolButton5: TToolButton;
    LYLed2: TLYLed;
    TimerMakeTjDescription: TTimer;
    N85: TMenuItem;
    N86: TMenuItem;
    N19: TMenuItem;
    N32: TMenuItem;
    LabeledEdit12: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    LabeledEdit4: TComboBox;
    Label11: TLabel;
    LabeledEdit6: TComboBox;
    Label12: TLabel;
    LabeledEdit10: TComboBox;
    Label13: TLabel;
    LabeledEdit8: TComboBox;
    Label14: TLabel;
    LabeledEdit9: TComboBox;
    N33: TMenuItem;
    ToolButton3: TToolButton;
    LYLed1: TLYLed;
    TimerCriticalValue: TTimer;
    SpeedButton2: TSpeedButton;
    SpeedButton8: TSpeedButton;
    ToolButton7: TToolButton;
    View1: TMenuItem;
    N6: TMenuItem;
    N24: TMenuItem;
    Action9: TAction;
    SpeedButton3: TSpeedButton;
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure UpdateADObasic;//全部检验单事件
    procedure ToolButton8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbCommUsedClickCheck(Sender: TObject);
    procedure LJ1Click(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure suiButton6Click(Sender: TObject);
    procedure suiButton6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N28Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure LabeledEdit13KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit5Exit(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure ADO_dtlAfterOpen(DataSet: TDataSet);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Q1Click(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure N30Click(Sender: TObject);
    procedure N39Click(Sender: TObject);
    procedure suiButton8Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure cbxConnCharChange(Sender: TObject);
    procedure ADO_dtlAfterPost(DataSet: TDataSet);
    procedure N46Click(Sender: TObject);
    procedure LabeledEdit16Exit(Sender: TObject);
    procedure N50Click(Sender: TObject);
    procedure DBGrid2Exit(Sender: TObject);
    procedure O1Click(Sender: TObject);
    procedure ADO_dtlAfterScroll(DataSet: TDataSet);
    procedure LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit12KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit9KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit14KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxConnCharEnter(Sender: TObject);
    procedure LabeledEdit15KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Excel1Click(Sender: TObject);
    procedure N43Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N52Click(Sender: TObject);
    procedure N53Click(Sender: TObject);
    procedure N54Click(Sender: TObject);
    procedure N55Click(Sender: TObject);
    procedure N56Click(Sender: TObject);
    procedure N57Click(Sender: TObject);
    procedure N58Click(Sender: TObject);
    procedure N59Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure LabeledEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Y1Click(Sender: TObject);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure N31Click(Sender: TObject);
    procedure Excel2Click(Sender: TObject);
    procedure N63Click(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N42Click(Sender: TObject);
    procedure ADO_dtlBeforeClose(DataSet: TDataSet);
    procedure pmChangeGroupPopup(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N47Click(Sender: TObject);
    procedure N49Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frReport1BeforePrint(Memo: TStringList; View: TfrView);
    procedure LabeledEdit3Change(Sender: TObject);
    procedure TimerIdleTrackerTimer(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N69Click(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N48Click(Sender: TObject);
    procedure N74Click(Sender: TObject);
    procedure ADO_dtlBeforePost(DataSet: TDataSet);
    procedure N71Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure N76Click(Sender: TObject);
    procedure N77Click(Sender: TObject);
    procedure N78Click(Sender: TObject);
    procedure N79Click(Sender: TObject);
    procedure N80Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N82Click(Sender: TObject);
    procedure N83Click(Sender: TObject);
    procedure N84Click(Sender: TObject);
    procedure lbedtifMarryExit(Sender: TObject);
    procedure lbedtWorkCompanyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbedtWorkDepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbedtWorkCategoryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N17Click(Sender: TObject);
    procedure N75Click(Sender: TObject);
    procedure frReport1PrintReport;
    procedure TimerMakeTjDescriptionTimer(Sender: TObject);
    procedure N85Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure TimerCriticalValueTimer(Sender: TObject);
    procedure LYLed1DblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure LabeledEdit12DropDown(Sender: TObject);
    procedure LabeledEdit4DropDown(Sender: TObject);
    procedure LabeledEdit6DropDown(Sender: TObject);
    procedure LabeledEdit10DropDown(Sender: TObject);
    procedure LabeledEdit8DropDown(Sender: TObject);
    procedure LabeledEdit9DropDown(Sender: TObject);
    procedure cbxConnCharDropDown(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure CheckTheListBox;//根据当前病人的结果在checklistbox1中打钩
    procedure WriteProfile;
    procedure ReadConfig;
    procedure ReadIni;
    procedure updateDBGrid2;
    procedure GetCopyData (var Msg: TWmCopyData);message WM_COPYDATA;
    function CheckMan: boolean;
    procedure ClearAll(CONST Clear_TYPE:integer);
    //==为了通过发送消息更新主窗体状态栏而增加==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS消息处理函数}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//Text为该格式#$2+'0:abc'+#$2+'1:def'表示状态栏第0格显示abc,第1格显示def,依此类推
    //==========================================//
    procedure pmChangeGroupItemClick(Sender: TObject);
    function CompletionJob:boolean;//结束检验工作
    procedure LoadToolMenu(const ToolMenuItem:TMenuItem;const ASel:string);
    procedure miToolItemClick(Sender: TObject);
    procedure ShowPictureValue(const ACheckUnid:integer);
    procedure ShowBarcode2D(const ACheckUnid:integer);
  public
      { Public declarations }
    ifnewadd:boolean;
    procedure FillBasic;
    procedure MakeCombinChecklistbox;//将组合项目号及名称导入CheckListBox中
    procedure InsertOrDeleteVaue(const ComboItemID:string;const ifAddorDel:boolean;const checkunid:integer;const AChk_Valu_His_ValueId:integer);
    procedure updatedbgrid1;
    procedure update_Ado_dtl;
    procedure WndProc (var Msg: TMessage);override;
    procedure NewAddStatus;
    function AddValetudinarianBasicInfo(const PLSH,pcheckid,Ppatientname,Psex,
      Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
      PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,pGermName,pTjDescription,
      pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone:string;
      Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
      var ValetudinarianInfoId:integer):boolean;//UfrmCopyInfo要调用该函数,故放在public中
    function UpdateValetudinarianBasicInfo(Punid:integer;const PLSH,pcheckid,Ppatientname,Psex,
      Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
      PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pGermName,pTjDescription,pHis_MzOrZy,
      pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone:string;
      Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
      var ValetudinarianInfoId:integer):boolean;//UfrmCopyInfo要调用该函数,故放在public中
  end;

var
  SDIAppForm: TSDIAppForm;

implementation

uses  Unit_dialog_pllr,
   Unitstatic, UfrmCommQuery,
   UfrmLogin, 
   UfrmBatchSpecNo,
  ufrm_referencevalue,ufrmItemSetup,
  Ufrmdocset,
  UfrmHistoryResult,
  UfrmExcelQuery, UfrmStaticCombItem,
  UDM, UfrmFromExcelLoad,
  UfrmXDepictType, UfrmXDepict, UfrmCommCode, UfrmPlxg, UfrmCopyInfo,
  UfrmPhoto, uQRCode,
  UfrmModifyPwd, UfrmEquipManage, UfrmSJ_JBXX, softMeter_globalVar,
  UfrmHorizontalExport, UfrmCriticalValueDetail;

var
    copyName,copySex,copyage,copyCaseno,copyBedno,copydeptname,copycheck_doctor:string;//复制的病人基本信息，仅粘贴时有用
    HQCLIB:THANDLE;
    lsGroupShow:TStrings;
    lsTransUnid:TStringList;//仪器传输（需刷新）的病人基本资料UNID列表
    bFirstOverWorkTips:boolean;//是否第一次提示【结束当批检验工作】

{$R *.dfm}
//自定义资源文件，源代码为YkLisCustom.rc
{$R YkLisCustom.RES}

procedure TSDIAppForm.NewAddStatus;
begin
  if ifnewadd then exit;

  ClearAll(1);

  LabeledEdit16.text:=ScalarSQLCmd(LisConn,' select dbo.uf_GetNextSerialNum('''+trim(cbxConnChar.Text)+''',CONVERT(CHAR(10),getdate(),121),'''+trim(LabeledEdit12.Text)+''') ');
  //LabeledEdit16.Text:=getmaxid(trim(cbxConnChar.Text),GetServerDate(DM.ADOConnection1),trim(LabeledEdit12.Text));
  if LabeledEdit1.CanFocus then LabeledEdit1.SetFocus;

  ifnewadd:=true;
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.HelpAbout1Execute(Sender: TObject);
var
  ini:tinifile;
  sWeChat:String;
begin
  LYAboutBox1.ProcuctName:=Caption;
  LYAboutBox1.Version:=GetVersionLY(pchar(APPLICATION.ExeName));//函数返回的Pchar类型还真能直接赋值给string!!!
  LYAboutBox1.Copyright:='版权所有,严禁反编译，反汇编';
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  LYAboutBox1.Comments:=ini.ReadString('Interface','companyname','广东誉凯软件工作室');
  LYAboutBox1.Author:=ini.ReadString('Interface','companytel','13710248644、QQ:46524223');
  LYAboutBox1.WebPage:=ini.ReadString('Interface','companywww','http://yklis.ys168.com');//会员帐号:yklis;密码是:liu771129
  sWeChat:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''系统代码'' and ReMark=''微信公众号'' ');
  LYAboutBox1.WeChat:=ifThen(sWeChat='','http://weixin.qq.com/r/GDvN1Y7EmtPlrcq2924K',sWeChat);
  ini.Free;
  LYAboutBox1.Execute;
end;

procedure TSDIAppForm.FormShow(Sender: TObject);
var
  ini:tinifile;
begin
  if ifRegister then bRegister:=true else bRegister:=false;
  
  frmLogin.ShowModal;

  ADO_dtl.Connection := DM.ADOConnection1;
  ADObasic.Connection := DM.ADOConnection1;
  ADO_print.Connection:=DM.ADOConnection1;

  PageControl2.ActivePageIndex:=0;
  MakeCombinChecklistbox;

  ReadConfig;
  UpdateStatusBar(#$2+'6:'+SCSYDW);
  UpdateStatusBar(#$2+'0:'+SYSNAME);
  UpdateStatusBar(#$2+'8:'+gServerName);
  UpdateStatusBar(#$2+'10:'+gDbName);

  UpdateADObasic;
  update_Ado_dtl;

  LoadToolMenu(N65,'select name from CommCode where TypeName=''工具菜单'' order by ID');

  TimerIdleTracker.Enabled:=true;//TimerIdleTrackerTimer事件中需用到配置文件变量LoginTime

  //用户在登录界面【退出】,该语句也会执行(出乎我的意料),此时operator_id为空
  dllSoftMeter.sendPageview(PChar(ChangeFileExt(ExtractFileName(Application.ExeName),'')+'/'+UTF8Encode(SCSYDW)+'/'+UTF8Encode(operator_id)),'frmMain Show Event');

  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  Caption:=ini.ReadString('Interface','companycaption','誉凯检验信息管理系统V7.0');
  ini.Free;
end;

procedure TSDIAppForm.ClearAll(CONST Clear_TYPE:integer);
//Clear_TYPE:1---新增清空
//Clear_TYPE:2---换组清空
var
  ServerDate:tdate;
  ini:tinifile;
  PreDate,PreCheckID:String;
begin
  ServerDate:=GetServerDate(DM.ADOConnection1);

  labelededit1.Clear;
  labelededit2.Clear;
  labelededit3.Clear;
  labelededit5.Clear;
  labelededit7.Clear;
  if Clear_TYPE=2 then labelededit8.Text:=''; //样本类型 注：换组后样本类型一般不会相同，故清空
  labelededit14.Clear;
  if Clear_TYPE=2 then labelededit15.Clear; //备注 注：小林要求换组后清空备注20080423
  DateTimePicker1.DateTime := IncMinute(ServerDate,-10);//申请日期
  DateTimePicker2.DateTime := ServerDate;//检查日期
  DateTimePicker3.DateTime:=IncMinute(ServerDate,-10);   //申请时间
  DateTimePicker4.DateTime:=ServerDate;   //检查时间
  
  lbedtWorkID.Clear;
  lbedtWorkCompany.Clear;
  lbedtWorkDepartment.Clear;
  lbedtWorkCategory.Clear;
  lbedtifMarry.Clear;
  lbedtOldAddress.Clear;
  lbedtAddress.Clear;
  lbedtTelephone.Clear;

  //获取优先级别
  ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  LabeledEdit12.Text:=ini.ReadString('Interface','当前保存的优先级别','');
  if trim(cbxConnChar.Text)<>'' then
  begin
    //如trim(cbxConnChar.Text)='',ReadString报错ntdll.dll
    PreDate:=ini.ReadString(cbxConnChar.Text,'检查日期','');
    PreCheckID:=ini.ReadString(cbxConnChar.Text,'联机号','');
  end;
  ini.Free;
  //==========
  
  //获取联机号
  labelededit1.Text:=GetMaxCheckId(PChar(cbxConnChar.Text),PChar(PreDate),PChar(PreCheckID));
  //==========
end;

procedure tsdiappform.FillBasic;
begin
  if ((not ADObasic.Active) or (ADObasic.RecordCount < 1)) then exit;
  
  LabeledEdit1.Text := trim(ADObasic.FieldByName('联机号').AsString);
  LabeledEdit2.Text := trim(ADObasic.FieldByName('病历号').AsString);
  LabeledEdit3.Text := trim(ADObasic.FieldByName('姓名').AsString);
  LabeledEdit4.Text := trim(ADObasic.FieldByName('性别').AsString);
  LabeledEdit5.Text := trim(ADObasic.FieldByName('年龄').AsString);
  LabeledEdit6.Text := trim(ADObasic.FieldByName('送检科室').AsString);
  LabeledEdit7.Text := trim(ADObasic.FieldByName('床号').AsString);
  LabeledEdit8.Text := trim(ADObasic.FieldByName('样本类型').AsString);
  LabeledEdit9.Text := trim(ADObasic.FieldByName('样本情况').AsString);
  LabeledEdit10.Text := trim(ADObasic.FieldByName('送检医生').AsString);
  DateTimePicker1.Date := ADObasic.FieldByName('申请日期').AsDateTime;
  DateTimePicker2.Date := ADObasic.FieldByName('检查日期').AsDateTime;
  LabeledEdit12.Text := trim(ADObasic.FieldByName('优先级别').AsString);
  LabeledEdit14.Text := trim(ADObasic.FieldByName('临床诊断').AsString);
  LabeledEdit15.Text := trim(ADObasic.FieldByName('备注').AsString);
  LabeledEdit16.Text := trim(ADObasic.FieldByName('流水号').AsString);
  DateTimePicker3.Time:=ADObasic.FieldByName('申请日期').AsDateTime;
  DateTimePicker4.Time:=ADObasic.FieldByName('检查日期').AsDateTime;

  lbedtWorkID.Text := trim(ADObasic.FieldByName('工号').AsString);
  lbedtWorkCompany.Text := trim(ADObasic.FieldByName('所属公司').AsString);
  lbedtWorkDepartment.Text := trim(ADObasic.FieldByName('所属部门').AsString);
  lbedtWorkCategory.Text := trim(ADObasic.FieldByName('工种').AsString);
  lbedtifMarry.Text := trim(ADObasic.FieldByName('婚否').AsString);
  lbedtOldAddress.Text := trim(ADObasic.FieldByName('籍贯').AsString);
  lbedtAddress.Text := trim(ADObasic.FieldByName('住址').AsString);
  lbedtTelephone.Text := trim(ADObasic.FieldByName('电话').AsString);  
end;

procedure TSDIAppForm.N8Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  (Sender as TMenuItem).Checked := true;
end;

procedure TSDIAppForm.N9Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  (Sender as TMenuItem).Checked := true;
end;

procedure TSDIAppForm.ToolButton1Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    exit;
  end;
  if (MessageDlg('是否真要删除当前记录？', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  DBGrid1.DataSource.DataSet.Delete;
end;

procedure TSDIAppForm.N3Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  Form_pllr.ShowModal;
end;

procedure TSDIAppForm.UpdateADObasic;  //全部检验单事件
var
  strsql22,strsql,strsql44,STRSQL45,STRSQL47: string;
begin
  if bRegister then strsql22:='select ' else strsql22:='select top 2 ';//未注册版本只能显示前两条记录
  strsql:=' lsh as 流水号,checkid as 联机号,patientname as 姓名,report_doctor as 审核者,'+
        ' (case when printtimes>0 then ''√'' end) as 打印,caseno as 病历号,sex as 性别,'+
        ' age as 年龄,bedno as 床号,deptname as 送检科室,'+
        ' check_date as 检查日期,check_doctor as 送检医生,'+
        ' report_date as 申请日期,'+
        ' operator as 操作者,diagnosetype as 优先级别,'+
        ' flagetype as 样本类型,diagnose as 临床诊断,typeflagcase as 样本情况,'+
        ' issure as 备注,unid as 唯一编号,combin_id as 组别,germname as 细菌, '+
        ' His_Unid as His唯一编号,His_MzOrZy as His门诊或住院, '+
        ' WorkDepartment as 所属部门,WorkCategory as 工种,WorkID as 工号,ifMarry as 婚否,OldAddress as 籍贯,Address as 住址,Telephone as 电话,WorkCompany as 所属公司, '+
        ' PushPress as 样本送交人,PullPress as 样本接收人,LeftEyesight as 左眼视力,RightEyesight as 右眼视力,Stature as 样本接收时间,Weight as 单据状态, '+
        ' TjJiWangShi as 既往史,TjJiaZuShi as 家族史,TjNeiKe as 内科,TjWaiKe as 外科,TjWuGuanKe as 五官科,TjFuKe as 妇科,TjLengQiangGuang as 冷强光,TjXGuang as X光,TjBChao as 危急值报告时间,TjXinDianTu as 危急值报告人,TjJianYan as 条码号,'+
        ' TjDescription as 结论,TJAdvice as 建议,printtimes as 打印次数, '+
        ' Audit_Date as 审核时间 '+
        ' from chk_con where ';
  if trim(cbxConnChar.Text)='' then   //所有检验单
    strsql44:=''
  else strsql44:=' combin_id='''+trim(cbxConnChar.Text)+''' and ';
  STRSQL47:=' 1=1 ';
  STRSQL45:=' order by CONVERT(CHAR(10),check_date,121),优先级别,'+ifThen(N6.Checked,'right(''0000''+lsh,4)','LEFT(checkid,1)+RIGHT(''000000000000000''+SUBSTRING(checkid,2,50),15)');
  ADObasic.Close;
  ADObasic.SQL.Clear;
  ADObasic.SQL.Add(strsql22);
  ADObasic.SQL.Add(strsql);
  ADObasic.SQL.Add(strsql44);
  ADObasic.SQL.Add(strsql47);
  ADObasic.SQL.Add(strsql45);
  ADObasic.Open;
end;

procedure TSDIAppForm.suiButton8Click(Sender: TObject); //刷新按钮事件
var ff:integer;
begin
  if not adobasic.Active then exit;
   
  ff:=adobasic.fieldbyname('唯一编号').AsInteger;
  UpdateADObasic;
  if not suiButton8.Glyph.Empty then suiButton8.Glyph:=nil;
  lsTransUnid.Clear;
  adobasic.Locate('唯一编号',ff,[loCaseInsensitive]);
end;

procedure TSDIAppForm.ToolButton8Click(Sender: TObject);
var
  strsqlPrint:string;
  sUnid,sReport_Doctor,sCombin_Id:string;
  
  //对姓别性别年龄的合并项做打印标记 变量
  sPatientname,sSex,sAge:string;
  //===============================

  i,j:integer;
  mvPictureTitle:TfrMemoView;  
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  sReport_Doctor:=trim(ADObasic.FieldByName('审核者').AsString);
  sCombin_Id:=adobasic.FieldByName('组别').AsString;

  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;
  
   if not ifAutoCheck then  //打印前要检查是否已被审核
   begin
     if sReport_Doctor='' then
     begin
      MessageBox(Handle, '请先审核！', '系统提示', MB_ICONASTERISK);
      exit;
     end;
   end;

  if (sCombin_Id=WorkGroup_T1)
    and frReport1.LoadFromFile(TempFile_T1) then//加载模板文件是不区分大小写的.空字符串将加载失败
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
  if not frReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_cur.frf') then
  begin
    showmessage('加载默认通用打印模板report_cur.frf失败，请设置:系统设置->选项->打印模板');
    exit;
  end;

  //动态创建图片标题begin
  //待处理问题:是否需要释放mvPictureTitle?何时释放?
  for j:=0 to frReport1.Pages.Count-1 do
  begin
    for i:=0 to frReport1.Pages[j].Objects.Count-1 do
    begin
      if TObject(frReport1.Pages[j].Objects.Items[i]) is TfrPictureView then
      begin
        if SameText(leftstr(TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name,7),'PICTURE') then
        begin
          mvPictureTitle:=TfrMemoView.Create;
          frReport1.Pages[j].Objects.Add(mvPictureTitle);
          mvPictureTitle.Name:='mv'+TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name;
          mvPictureTitle.Visible:=false;
        end;
      end;
    end;
  end;
  //动态创建图片标题end
  
    strsqlPrint:='select itemid as 项目代码,name as 名称,english_name as 英文名,'+
          ' itemvalue as 检验结果,'+
          ' min_value as 最小值,max_value as 最大值,'+
          ' dbo.uf_Reference_Value_B1(chk_valu.min_value,chk_valu.max_value) as 前段参考范围,dbo.uf_Reference_Value_B2(chk_valu.min_value,chk_valu.max_value) as 后段参考范围,'+
          ' unit as 单位,min(printorder) as 打印编号,'+
          ' min(pkcombin_id) as 组合项目号, '+
          ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
          ' from chk_valu WITH(NOLOCK) where pkunid='+sUnid+
          ' and chk_valu.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
          ' group by itemid,name,english_name,itemvalue,min_value,max_value,unit, '+
          ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
          ' order by 组合项目号,打印编号 ';
  ado_print.Close;
  ado_print.SQL.Clear;
  ado_print.SQL.Text:=strsqlPrint;
  ado_print.Open;
  if (ADO_print.RecordCount=0) and (not ifNoResultPrint) then exit;

  if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm

  if n9.Checked then  //预览模式
  begin
    frReport1.ShowPrintDialog:=ifShowPrintDialog;
    frReport1.ShowReport;
  end;
  if n8.Checked then  //直接打印模式
  begin
    if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
  end;
end;

procedure TSDIAppForm.FormCreate(Sender: TObject);
var
  ini:tinifile;
  
  esXPIRE_DATE,dsXPIRE_DATE:string;
  pdsXPIRE_DATE:Pchar;
  dXPIRE_DATE:TDateTime;
  i:integer;
  fs:TFormatSettings;
Begin
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  Caption:=ini.ReadString('Interface','lisformcaption','誉凯检验信息管理系统V7.0');
  ini.Free;

  ChangeYouFormAllControlIme(Self);//设置中文输入法

  SetWindowLong(LabeledEdit16.Handle, GWL_STYLE, GetWindowLong(LabeledEdit16.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
  
  lsGroupShow:=tstringlist.Create;
  lsTransUnid:=TStringList.Create;
  lsTransUnid.Sorted:=true;//设置Sorted为true,下面的Duplicates属性才生效
  lsTransUnid.Duplicates:=dupIgnore;//忽略重复项

  //试用版有效期控制 start
  esXPIRE_DATE:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''系统代码'' and ReMark=''软件过期时间'' ');
  //======解密sXPIRE_DATE
  pdsXPIRE_DATE:=DeCryptStr(pchar(esXPIRE_DATE),pchar(CryptStr));
  setlength(dsXPIRE_DATE,length(pdsXPIRE_DATE));
  for i :=1  to length(pdsXPIRE_DATE) do dsXPIRE_DATE[i]:=pdsXPIRE_DATE[i-1];
  //==========
  fs.DateSeparator:='-';
  fs.ShortDateFormat:='YYYY-MM-DD';
  if trystrtodatetime(dsXPIRE_DATE,dXPIRE_DATE,fs) then
  begin
    if dXPIRE_DATE<now then
    begin
      MESSAGEDLG('试用版已到期,请联系软件供应商!',mtError,[MBOK],0);
      application.Terminate;
    end;
  end else
  begin
    MESSAGEDLG('有效期'+esXPIRE_DATE+'被非法修改,请联系软件供应商!',mtError,[MBOK],0);
    application.Terminate;
  end;
  //试用版有效期控制 stop

  bFirstOverWorkTips:=true;
end;

procedure TSDIAppForm.N4Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if '1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from Chk_Con cc WITH(NOLOCK),chk_valu cv WITH(NOLOCK) where cc.unid=cv.pkunid and cc.combin_id='''+cbxConnChar.Text+''' and isnull(cc.TjXinDianTu,'''')='''' and dbo.uf_CriticalValueAlarm(cv.itemid,cc.sex,cc.age,cv.itemvalue)=1') then
  begin
    LYLed1.Value:=true;
    MESSAGEDLG('存在未报告的危急值,不允许结束操作!',mtWarning,[MBOK],0);
    exit;
  end;

  if (MessageDlg('是否结束目前所作的工作，这将把当前的全部工作作为历史记录保存?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  CompletionJob;

  UpdateADObasic;
  update_Ado_dtl;
end;

procedure TSDIAppForm.FileOpenItemClick(Sender: TObject);
begin
  close;
end;

procedure TSDIAppForm.N20Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  Formstatic.ShowModal;
end;

procedure TSDIAppForm.FileNewItemClick(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TSDIAppForm.suiButton3Click(Sender: TObject);
var
  unid:integer;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('唯一编号').AsInteger;

  if '1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_valu where pkunid='+inttostr(unid)+' and issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' ') then
  begin
    MESSAGEDLG('无效结果,不允许审核!',mtError,[mbOK],0);
    exit;
  end;

   if (trim(adobasic.FieldByName('审核者').AsString)<>operator_name) and (trim(adobasic.FieldByName('审核者').AsString)<>'') then
   begin
      if MessageDlg('已被审核过，想修改审核者？', mtWarning	, [mbNo,mbYes], 0 ) = mrNo then  exit;
   end;

  ExecSQLCmd(LisConn,'update chk_con set report_doctor='''+operator_name+''',Audit_Date=getdate() where unid='+inttostr(unid));

  ADObasic.Refresh; //刷新界面
end;

procedure TSDIAppForm.suiButton4Click(Sender: TObject);
var
  unid:integer;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;
  if trim(DBGrid1.DataSource.DataSet.FieldByName('审核者').AsString)='' then exit;//20080130

  unid:=ADObasic.fieldbyname('唯一编号').AsInteger;

  if not checkman then
  begin
          MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
          exit;
  end;

  ExecSQLCmd(LisConn,'update chk_con set report_doctor='''',Audit_Date=null where unid='+inttostr(unid));

  ADObasic.Refresh; //刷新界面
end;

procedure TSDIAppForm.ReadConfig;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  IF CONFIGINI.ReadBool('Interface','ifPreview',TRUE) THEN
  begin
    n9.Checked:=TRUE;   //打印预览
    n8.Checked:=false;  //直接打印
  end ELSE
  begin
    n9.Checked:=false;
    n8.Checked:=TRUE;
  end;

  n41.Checked:=configini.ReadBool('Interface','ifRTTransData',true);
  cbxConnChar.Text:=trim(CONFIGINI.ReadString('Interface','ShowReportType',ScalarSQLCmd(LisConn,'select TOP 1 name from CommCode WITH(NOLOCK) where TypeName=''检验组别'' AND SysName='''+SYSNAME+'''')));
  n50.Checked:=configini.ReadBool('Interface','ifShowEnglish',true);
  n36.Checked:=configini.ReadBool('Interface','ifShowMinValue',true);{记录是否显示项目最小值}
  n47.Checked:=configini.ReadBool('Interface','ifShowMaxValue',true);{记录是否显示项目最大值}
  n49.Checked:=configini.ReadBool('Interface','ifShowUnit',true);{记录是否显示项目单位}
  PageControl2.Height:=configini.ReadInteger('Interface','clbCombItemHeight',150);{记录组合项目选择框高度}
  Panel7.Width:=configini.ReadInteger('Interface','gridBaseInfoWidth',490);{记录基本信息框宽度}
  CheckBox1.Checked:=configini.ReadBool('Interface','ifContinuousEdit',false);{记录是否连续录入基本信息}
  PageControl1.ActivePageIndex:=configini.ReadInteger('Interface','ValueActivePageIndex',0);{记录结果框PageControl1的活动Page}

  IF CONFIGINI.ReadBool('Interface','ifLSHOrder',TRUE) THEN
  begin
    n6.Checked:=TRUE;   //流水号排序
    n24.Checked:=false;  //联机号排序
  end ELSE
  begin
    n6.Checked:=false;
    n24.Checked:=TRUE;
  end;

  LabeledEdit16.Enabled:=configini.ReadBool('EditEnabled','LSH',true);
  LabeledEdit2.Enabled:=configini.ReadBool('EditEnabled','Caseno',true);
  LabeledEdit6.Enabled:=configini.ReadBool('EditEnabled','deptname',true);
  LabeledEdit7.Enabled:=configini.ReadBool('EditEnabled','bedno',true);
  LabeledEdit10.Enabled:=configini.ReadBool('EditEnabled','check_doctor',true);
  LabeledEdit8.Enabled:=configini.ReadBool('EditEnabled','flagetype',true);
  LabeledEdit9.Enabled:=configini.ReadBool('EditEnabled','typeflagcase',true);
  LabeledEdit14.Enabled:=configini.ReadBool('EditEnabled','diagnose',true);
  DateTimePicker1.Enabled:=configini.ReadBool('EditEnabled','report_date',true);
  DateTimePicker3.Enabled:=configini.ReadBool('EditEnabled','SJSJ',true);
  DateTimePicker2.Enabled:=configini.ReadBool('EditEnabled','check_date',true);
  DateTimePicker4.Enabled:=configini.ReadBool('EditEnabled','JCSJ',true);
  LabeledEdit15.Enabled:=configini.ReadBool('EditEnabled','issure',true);

  lbedtWorkID.Enabled:=configini.ReadBool('EditEnabled','WorkID',true);
  lbedtWorkCompany.Enabled:=configini.ReadBool('EditEnabled','WorkCompany',true);
  lbedtWorkDepartment.Enabled:=configini.ReadBool('EditEnabled','WorkDepartment',true);
  lbedtWorkCategory.Enabled:=configini.ReadBool('EditEnabled','WorkCategory',true);
  lbedtifMarry.Enabled:=configini.ReadBool('EditEnabled','ifMarry',true);
  lbedtOldAddress.Enabled:=configini.ReadBool('EditEnabled','OldAddress',true);
  lbedtAddress.Enabled:=configini.ReadBool('EditEnabled','Address',true);
  lbedtTelephone.Enabled:=configini.ReadBool('EditEnabled','Telephone',true);
  
  ReadIni();

  configini.Free;
end;

procedure TSDIAppForm.WriteProfile;
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteBool('Interface','ifPreview',n9.Checked);{记录是否打印预览模式}
  ConfigIni.WriteBool('Interface','ifRTTransData',n41.Checked); {记录是否实时显示传输数据}
  ConfigIni.WriteString('Interface','ShowReportType',trim(cbxConnChar.Text)); {记录主界面中要显示的检验单类型}
  configini.WriteBool('Interface','ifShowEnglish',n50.Checked);{记录是否显示项目英文名}
  configini.WriteBool('Interface','ifShowMinValue',n36.Checked);{记录是否显示项目最小值}
  configini.WriteBool('Interface','ifShowMaxValue',n47.Checked);{记录是否显示项目最大值}
  configini.WriteBool('Interface','ifShowUnit',n49.Checked);{记录是否显示项目单位}
  if PageControl2.Height<60 then PageControl2.Height:=60;
  configini.WriteInteger('Interface','clbCombItemHeight',PageControl2.Height);{记录组合项目选择框高度}
  configini.WriteInteger('Interface','gridBaseInfoWidth',Panel7.Width);{记录基本信息框宽度}
  configini.WriteBool('Interface','ifContinuousEdit',CheckBox1.Checked);{记录是否连续录入基本信息}
  configini.WriteInteger('Interface','ValueActivePageIndex',PageControl1.ActivePageIndex);{记录结果框PageControl1的活动Page}
  configini.WriteBool('Interface','ifLSHOrder',n6.Checked);{记录是否流水号排序}

  configini.WriteBool('EditEnabled','LSH',LabeledEdit16.Enabled);
  configini.WriteBool('EditEnabled','Caseno',LabeledEdit2.Enabled);
  configini.WriteBool('EditEnabled','deptname',LabeledEdit6.Enabled);
  configini.WriteBool('EditEnabled','bedno',LabeledEdit7.Enabled);
  configini.WriteBool('EditEnabled','check_doctor',LabeledEdit10.Enabled);
  configini.WriteBool('EditEnabled','flagetype',LabeledEdit8.Enabled);
  configini.WriteBool('EditEnabled','typeflagcase',LabeledEdit9.Enabled);
  configini.WriteBool('EditEnabled','diagnose',LabeledEdit14.Enabled);
  configini.WriteBool('EditEnabled','report_date',DateTimePicker1.Enabled);
  configini.WriteBool('EditEnabled','SJSJ',DateTimePicker3.Enabled);
  configini.WriteBool('EditEnabled','check_date',DateTimePicker2.Enabled);
  configini.WriteBool('EditEnabled','JCSJ',DateTimePicker4.Enabled);
  configini.WriteBool('EditEnabled','issure',LabeledEdit15.Enabled);

  configini.WriteBool('EditEnabled','WorkID',lbedtWorkID.Enabled);
  configini.WriteBool('EditEnabled','WorkCompany',lbedtWorkCompany.Enabled);
  configini.WriteBool('EditEnabled','WorkDepartment',lbedtWorkDepartment.Enabled);
  configini.WriteBool('EditEnabled','WorkCategory',lbedtWorkCategory.Enabled);
  configini.WriteBool('EditEnabled','ifMarry',lbedtifMarry.Enabled);
  configini.WriteBool('EditEnabled','OldAddress',lbedtOldAddress.Enabled);
  configini.WriteBool('EditEnabled','Address',lbedtAddress.Enabled);
  configini.WriteBool('EditEnabled','Telephone',lbedtTelephone.Enabled);

  configini.Free;
end;

procedure TSDIAppForm.FormDestroy(Sender: TObject);
begin
  WriteProfile;

  lsGroupShow.free;
  lsTransUnid.Free;
end;

procedure TSDIAppForm.frReport1GetValue(const ParName: String;
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
      ItemChnName:=trim(ADO_print.fieldbyname('项目代码').AsString);
      cur_value:=trim(ADO_print.fieldbyname('检验结果').AsString);
      min_value:=trim(ADO_print.fieldbyname('最小值').AsString);
      max_value:=trim(ADO_print.fieldbyname('最大值').AsString);

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
        ParValue := '↓'
      else if i=2 then
        ParValue := '↑'
      else ParValue:='';
    END;

    if parname='打印者' then ParValue:=operator_name;
    if parname='所属公司' then ParValue:=trim(ADObasic.fieldbyname('所属公司').AsString);
    if parname='姓名' then ParValue:=trim(ADObasic.fieldbyname('姓名').AsString);
    if parname='性别' then ParValue:=trim(ADObasic.fieldbyname('性别').AsString);
    if parname='体检日期' then ParValue:=ADObasic.fieldbyname('检查日期').AsDateTime;
    if parname='年龄' then ParValue:=trim(ADObasic.fieldbyname('年龄').AsString);
    if parname='婚否' then ParValue:=trim(ADObasic.fieldbyname('婚否').AsString);
    if parname='工种' then ParValue:=trim(ADObasic.fieldbyname('工种').AsString);
    if parname='籍贯' then ParValue:=trim(ADObasic.fieldbyname('籍贯').AsString);
    if parname='住址' then ParValue:=trim(ADObasic.fieldbyname('住址').AsString);
    if parname='电话' then ParValue:=trim(ADObasic.fieldbyname('电话').AsString);
    {if parname='舒张压' then ParValue:=trim(ADObasic.fieldbyname('舒张压').AsString);
    if parname='收缩压' then ParValue:=trim(ADObasic.fieldbyname('收缩压').AsString);
    if parname='左眼视力' then ParValue:=trim(ADObasic.fieldbyname('左眼视力').AsString);
    if parname='右眼视力' then ParValue:=trim(ADObasic.fieldbyname('右眼视力').AsString);
    if parname='身高' then ParValue:=trim(ADObasic.fieldbyname('身高').AsString);
    if parname='体重' then ParValue:=trim(ADObasic.fieldbyname('体重').AsString);
    if parname='既往史' then ParValue:=ADObasic.fieldbyname('既往史').AsString;
    if parname='家族史' then ParValue:=ADObasic.fieldbyname('家族史').AsString;
    if parname='内科' then ParValue:=ADObasic.fieldbyname('内科').AsString;
    if parname='外科' then ParValue:=ADObasic.fieldbyname('外科').AsString;
    if parname='五官科' then ParValue:=ADObasic.fieldbyname('五官科').AsString;
    if parname='妇科' then ParValue:=ADObasic.fieldbyname('妇科').AsString;
    if parname='冷强光' then ParValue:=ADObasic.fieldbyname('冷强光').AsString;
    if parname='X光' then ParValue:=ADObasic.fieldbyname('X光').AsString;
    if parname='B超' then ParValue:=ADObasic.fieldbyname('B超').AsString;
    if parname='心电图' then ParValue:=ADObasic.fieldbyname('心电图').AsString;
    if parname='检验' then ParValue:=ADObasic.fieldbyname('检验').AsString;
    if parname='结论' then ParValue:=ADObasic.fieldbyname('结论').AsString;
    if parname='建议' then ParValue:=ADObasic.fieldbyname('建议').AsString;//}
    
    if parname='检验设备' then ParValue:=ScalarSQLCmd(LisConn,'select dbo.uf_GetEquipFromChkUnid(0,'+ADObasic.fieldbyname('唯一编号').AsString+')');
end;

procedure TSDIAppForm.updateDBGrid2;
var
  i:integer;
  ConfigIni:tinifile;
  colValueWidth:integer;
begin
  if not dbgrid2.DataSource.DataSet.Active then exit;
  dbgrid2.Columns[2].Width:=80;//中文名
  dbgrid2.Columns[3].Width:=50;//英文名

  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  colValueWidth:=configini.ReadInteger('Interface','colValueWidth',70);{记录检验结果列的宽度}
  configini.Free;
  dbgrid2.Columns[4].Width:=ifThen(colValueWidth<=0,70,colValueWidth);
    
  dbgrid2.Columns[5].Width:=50;
  dbgrid2.Columns[6].Width:=50;
  dbgrid2.Columns[7].Width:=50;
  dbgrid2.Columns[8].Width:=50;
  dbgrid2.Columns[9].Width:=50;
  dbgrid2.Columns[10].Width:=50;

  for i:=0 to (dbgrid2.columns.count-1) do
   dbgrid2.columns[i].readonly:=TRUE;
  dbgrid2.columns[4].readonly:=FALSE;

  VisibleColumn(dbgrid2,'英文名',N50.Checked);
  VisibleColumn(dbgrid2,'最小值',N36.Checked);
  VisibleColumn(dbgrid2,'最大值',N47.Checked);
  VisibleColumn(dbgrid2,'单位',N49.Checked);
  
  VisibleColumn(dbgrid2,'项目编号',false);
  VisibleColumn(dbgrid2,'组合项目号',false);
  VisibleColumn(dbgrid2,'唯一编号',false);
  VisibleColumn(dbgrid2,'修改标志',false);
end;

procedure TSDIAppForm.updatedbgrid1;
begin
  if not dbgrid1.DataSource.DataSet.Active then exit;
  dbgrid1.Columns[0].Width:=40;//流水号
  dbgrid1.Columns[1].Width:=40;//联机号
  dbgrid1.Columns[2].Width:=42;//姓名
  dbgrid1.Columns[3].Width:=42;//审核者
  dbgrid1.Columns[4].Width:=30;//打印次数
  dbgrid1.Columns[5].Width:=65;//病历号
  dbgrid1.Columns[6].Width:=30;//性别
  dbgrid1.Columns[7].Width:=30;//年龄
  dbgrid1.Columns[8].Width:=30;//床号
  dbgrid1.Columns[9].Width:=60;//送检科室
  dbgrid1.Columns[10].Width:=72;//检查日期
  dbgrid1.Columns[11].Width:=55;//送检医生
  dbgrid1.Columns[12].Width:=72;//申请日期

  VisibleColumn(dbgrid1,'流水号',N6.Checked);//按流水号排序时显示流水号,否则(联机号)不显示流水号
end;

procedure TSDIAppForm.clbCommUsedClickCheck(Sender: TObject);
var
  i,b,checkunid:integer;
  s2:string;
begin
  i:=(Sender as TCheckListBox).ItemIndex;

  if (not dsbasic.DataSet.Active) or (dsbasic.DataSet.RecordCount <= 0) then
  begin
    Application.MessageBox('请先录入基本信息', '提示信息',MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
    (Sender as TCheckListBox).Checked[i]:=false;
    exit;
  end;

  if not checkman then
  begin
    (Sender as TCheckListBox).Checked[i]:=not (Sender as TCheckListBox).Checked[i];
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    exit;
  end;

  checkunid:=dsbasic.DataSet.fieldbyname('唯一编号').AsInteger;

  s2:=(Sender as TCheckListBox).Items.Strings[i];
  b:=pos('   ',s2);
  s2:=copy(s2,1,b-1);

  InsertOrDeleteVaue(s2,(Sender as TCheckListBox).Checked[i],checkunid,-1);
end;

procedure TSDIAppForm.LJ1Click(Sender: TObject);
TYPE
  TDLLProc=procedure(AppHandle:THandle;AConnString:Pchar;AbRegister:boolean);stdcall;
VAR
  DLLProc:TDLLProc;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  HQCLIB:=LOADLIBRARY('QC.dll');
  IF HQCLIB=0 THEN BEGIN SHOWMESSAGE('对不起,您使用的版本无此功能!');EXIT; END;//动态链接库QC.DLL不存在
  DLLProc:=TDLLProc(GETPROCADDRESS(HQCLIB,'ShowQCForm'));
  IF @DLLProc=NIL THEN BEGIN SHOWMESSAGE('函数ShowQCForm不存在!');EXIT; END;
  DLLProc(handle,Pointer(LisConn),bRegister);
end;

procedure TSDIAppForm.WndProc(var Msg: TMessage);
begin
  case   Msg.Msg   of
    WM_USER   +   2://QC.DLL发送的消息
      FreeLIBRARY(HQCLIB);
  end;
  inherited;
end;

procedure TSDIAppForm.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  i:integer;
  ItemChnName,cur_value,min_value,max_value:string;//,nst_value
  sGroup,IsEdited:string;
  adotemp22:tadoquery;
begin
  //======================检验结果超出参考范围时变化颜色======================//
  if (datacol=4) then
  begin
    ItemChnName:=trim(tdbgrid(sender).DataSource.DataSet.fieldbyname('项目编号').AsString);
    cur_value:=trim(tdbgrid(sender).DataSource.DataSet.fieldbyname('检验结果').AsString);
    min_value:=trim(tdbgrid(sender).DataSource.DataSet.fieldbyname('最小值').AsString);
    max_value:=trim(tdbgrid(sender).DataSource.DataSet.fieldbyname('最大值').AsString);

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
      tdbgrid(sender).Canvas.Font.Color:=clblue
    else if i=2 then
          tdbgrid(sender).Canvas.Font.Color:=clred;
    tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
  end;
  //==========================================================================//

  //用不同的颜色进行分组标识
  if (datacol=2)and(lsGroupShow.Count>1) then//起码有两个组才用颜色进行标识
  begin
    sGroup:=tdbgrid(sender).DataSource.DataSet.FieldByName('组合项目号').AsString;
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
        tdbgrid(sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
        break;
      end;
    end;
  end;
  //========================

  //======================修改过的检验结果变化颜色============================//
  if (datacol=4) then
  begin
    IsEdited:=tdbgrid(sender).DataSource.DataSet.fieldbyname('修改标志').AsString;
    if IsEdited='1' then
    begin
      (Sender as TDBGrid).Canvas.Pen.Color := clRed; //定义画笔颜色(绿色)
      (Sender as TDBGrid).Canvas.MoveTo(Rect.Right, Rect.Top); //画笔定位
      (Sender as TDBGrid).Canvas.LineTo(Rect.Right, Rect.Bottom); //画绿色的竖线
    end; 
  end;
  //==========================================================================//
end;

procedure TSDIAppForm.CheckTheListBox;//根据当前病人的结果在checklistbox1中打钩
var
  i:integer;
  b:integer;
  ss,sss:string;
  adotemp2:tadoquery;
begin
    adotemp2:=tadoquery.Create(nil);
    adotemp2.Connection:=DM.ADOConnection1;
    ADOtemp2.Close;
    ADOtemp2.SQL.Clear;
    ADOtemp2.SQL.Text:=ado_dtl.SQL.Text;
    ADOtemp2.Parameters.ParamByName('pkunid').Value :=
          ADObasic.FieldByName('唯一编号').AsInteger;
    ADOtemp2.Open;

    for i:=0 to clbCommUsed.Items.Count-1 do clbCommUsed.Checked[i]:=false;
    for i:=0 to clbNoCommUsed.Items.Count-1 do clbNoCommUsed.Checked[i]:=false;

    while not ADOtemp2.Eof do
    begin
      for i:=0 to clbCommUsed.Items.Count-1 do
      begin
        ss:=clbCommUsed.Items.Strings[i];
        b:=pos('   ',ss);
        sss:=copy(ss,1,b-1);
        if trim(ADOtemp2.FieldByName('组合项目号').AsString)=trim(sss) then
        begin
          clbCommUsed.Checked[i]:=true;
          break;
        end;
      end;

      for i:=0 to clbNoCommUsed.Items.Count-1 do
      begin
        ss:=clbNoCommUsed.Items.Strings[i];
        b:=pos('   ',ss);
        sss:=copy(ss,1,b-1);
        if trim(ADOtemp2.FieldByName('组合项目号').AsString)=trim(sss) then
        begin
          clbNoCommUsed.Checked[i]:=true;
          break;
        end;
      end;
      
      ADOtemp2.Next;
    end;

    ADOtemp2.Free;
end;

procedure TSDIAppForm.GetCopyData(var Msg: TWmCopyData);
var
  strCurUnid:String ;
  pbuffer:PChar;
  curunid,BufferLength,i:integer ;

  sCombin_id:string;
begin
  //分解消息数据
  pbuffer:=msg.CopyDataStruct.lpData;
  BufferLength:=length(pbuffer);
  SETLENGTH(strCurUnid,BufferLength);
  for  i:=1  to BufferLength do strCurUnid[i]:=pbuffer[i-1];
  if not tryStrtoint(Trim(strCurUnid), curunid) then
  begin
    Msg.Result := 1;
    exit;
  end;

  //if not n41.Checked then
  //begin
  //  Msg.Result := 1;
  //  exit;
  //end;

  if not ADObasic.Active then
  begin
    Msg.Result := 1;
    exit;
  end;

  sCombin_id:=ScalarSQLCmd(LisConn,'SELECT combin_id FROM chk_con WHERE unid = '+strCurUnid);
  if sCombin_id<>cbxConnChar.Text then
  begin
    Msg.Result := 1;
    exit;
  end;

  //===在这里增加收到消息后的界面更新过程
  if n41.Checked then
  begin
    UpdateADObasic;

    DBGrid1.DataSource.DataSet.Locate('唯一编号',curunid,[loCaseInsensitive]);
    update_Ado_dtl;
  end else
  begin
    lsTransUnid.Add(Trim(strCurUnid));//已忽略重复项

    if lsTransUnid.Count<=9 then
      suiButton8.Glyph.LoadFromResourceName(HInstance,'Num'+inttostr(lsTransUnid.Count))
    else
      suiButton8.Glyph.LoadFromResourceName(HInstance,'Num9plus');
  end;
  //=====================================

  Msg.Result := 1;
end;

procedure TSDIAppForm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Diagnosetype:string;
begin
   //=====================常规与急诊用颜色区分=======================//
    if datacol=1 then //联机号列
    begin
      Diagnosetype:=tdbgrid(sender).DataSource.DataSet.fieldbyname('优先级别').AsString;
      IF Diagnosetype<>CGYXJB then
      begin
        tdbgrid(sender).Canvas.Font.Color:=clblue;
        tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
      end;
    end;
   //==========================================================================//   
end;

function TSDIAppForm.CheckMan: boolean;//20080130
var
  adotemp12:tadoquery;
  ifSuperUser:boolean;
begin
  result:=false;
  if trim(DBGrid1.DataSource.DataSet.FieldByName('审核者').AsString)='' then begin result:=true;exit; end;
  adotemp12:=tadoquery.Create(nil);
  adotemp12.Connection:=DM.ADOConnection1;
  adotemp12.Close;
  adotemp12.SQL.Clear;
  adotemp12.SQL.Text:='select * from worker where ifSuperUser=''1'' ';
  adotemp12.Open;
  ifSuperUser:=adotemp12.Locate('id',trim(operator_id),[loCaseInsensitive]);
  adotemp12.Free;
  if ifSuperUser then begin result:=true;exit; end;
  if SameText(trim(DBGrid1.DataSource.DataSet.FieldByName('审核者').AsString),trim(operator_name)) then result:=true;
end;

function TSDIAppForm.AddValetudinarianBasicInfo(const PLSH,pcheckid,Ppatientname,Psex,
  Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
  PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,pGermName,pTjDescription,
  pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone:string;
  Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
  var ValetudinarianInfoId:integer): boolean;
var
  adotemp2:tadoquery;
  stringTemp:string;
begin
  if pCombin_id='' then
  begin
    application.MessageBox('请为您要增加的病人指定组别!','系统提示', mb_iconinformation);
    result:=false;
    exit;
  end;



  stringTemp:='Insert into chk_con ('+
      ' checkid,lsh,patientname,sex,age,Caseno,bedno,deptname,check_date,check_doctor,report_date,report_doctor,operator,printtimes,Diagnosetype,flagetype,diagnose,typeflagcase,issure,Combin_id,'+
      ' WorkID,WorkCompany,WorkDepartment,WorkCategory,ifMarry,OldAddress,Address,Telephone) values ('+//,TjDescription//,GermName
      ':P_checkid,:P_lsh,:P_patientname,:P_sex,:P_age,:P_Caseno,:P_bedno,:P_deptname,:P_check_date,:P_check_doctor,:P_report_date,:P_report_doctor,:P_operator,:P_printtimes, '+
      ':P_Diagnosetype,:P_flagetype,:P_diagnose,:P_typeflagcase,:P_issure,:Combin_id,'+
      ':WorkID,:WorkCompany,:WorkDepartment,:WorkCategory,:ifMarry,:OldAddress,:Address,:Telephone) ';//,:TjDescription//,:GermName
  adotemp2:=tadoquery.Create(nil);
  adotemp2.Connection:=DM.ADOConnection1;
  adotemp2.Close;
  adotemp2.SQL.Clear;
  adotemp2.SQL.Add(stringTemp);
  adotemp2.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
  adotemp2.Parameters.ParamByName('P_checkid').Value:=pcheckid ;
  adotemp2.Parameters.ParamByName('P_lsh').Value:=Plsh ;
  adotemp2.Parameters.ParamByName('P_patientname').Value:=Ppatientname ;
  adotemp2.Parameters.ParamByName('P_sex').Value:=Psex ;
  adotemp2.Parameters.ParamByName('P_age').Value:=Page ;
  adotemp2.Parameters.ParamByName('P_Caseno').Value:=PCaseno ;
  adotemp2.Parameters.ParamByName('P_bedno').Value:=Pbedno ;
  adotemp2.Parameters.ParamByName('P_deptname').Value:=Pdeptname ;
  adotemp2.Parameters.ParamByName('P_check_date').Value:=strtodatetime(datetostr(Pcheck_date)+' '+timetostr(pJCSJ)) ;//检查时间
  adotemp2.Parameters.ParamByName('P_check_doctor').Value:=Pcheck_doctor ;
  adotemp2.Parameters.ParamByName('P_report_date').Value:=strtodatetime(datetostr(Preport_date)+' '+timetostr(pSJSJ)) ;//申请时间
  adotemp2.Parameters.ParamByName('P_report_doctor').Value:=Preport_doctor ;
  adotemp2.Parameters.ParamByName('P_operator').Value:=Poperator ;
  adotemp2.Parameters.ParamByName('P_printtimes').Value:=0 ;
  adotemp2.Parameters.ParamByName('P_Diagnosetype').Value:=PDiagnosetype ;
  adotemp2.Parameters.ParamByName('P_flagetype').Value:=Pflagetype ;
  adotemp2.Parameters.ParamByName('P_diagnose').Value:=Pdiagnose ;
  adotemp2.Parameters.ParamByName('P_typeflagcase').Value:=Ptypeflagcase ; //
  adotemp2.Parameters.ParamByName('P_issure').Value:=Pissure ;
  adotemp2.Parameters.ParamByName('Combin_id').Value:=pCombin_id ; //
  //adotemp2.Parameters.ParamByName('GermName').Value:=pGermName ; //
  //adotemp2.Parameters.ParamByName('TjDescription').Value:=pTjDescription ; //
  adotemp2.Parameters.ParamByName('WorkID').Value:=pWorkID ; //
  adotemp2.Parameters.ParamByName('WorkCompany').Value:=pWorkCompany ; //
  adotemp2.Parameters.ParamByName('WorkDepartment').Value:=pWorkDepartment ; //
  adotemp2.Parameters.ParamByName('WorkCategory').Value:=pWorkCategory ; //
  adotemp2.Parameters.ParamByName('ifMarry').Value:=pifMarry ; //
  adotemp2.Parameters.ParamByName('OldAddress').Value:=pOldAddress ; //
  adotemp2.Parameters.ParamByName('Address').Value:=pAddress ; //
  adotemp2.Parameters.ParamByName('Telephone').Value:=pTelephone ; //

  Try
    Try
      adotemp2.Open ;
      ValetudinarianInfoId:=adotemp2.fieldbyname('Insert_Identity').AsInteger;
      result:=true;
    except
      Application.MessageBox('增加新记录失败!','系统提示',MB_ICONWARNING);
      result:=false;
    End;
  finally
    adotemp2.Free;
  end;    
end;

function TSDIAppForm.UpdateValetudinarianBasicInfo(Punid:integer;const PLSH,pcheckid,Ppatientname,Psex,
  Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
  PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pGermName,pTjDescription,pHis_MzOrZy,
  pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone:string;
  Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
  var ValetudinarianInfoId:integer): boolean;
var
  adotemp2:tadoquery;
  stringTemp:string;
begin
  //if pHis_MzOrZy<>'' then//表示从HIS中取得的信息，不能修改
  //begin
  //  MESSAGEDLG('该病人信息从HIS中取得，不能修改!',MTINFORMATION,[MBOK],0);
  //  result:=false;
  //  exit;
  //end;
        
  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    result:=false;
    exit;
  end;

  stringTemp:=' Update chk_con set '+
        ' lsh=:P_lsh,checkid=:P_checkid,patientname=:P_patientname,sex=:P_sex,age=:P_age,Caseno=:P_Caseno,bedno=:P_bedno,deptname=:P_deptname,'+
        'check_date=:P_check_date,check_doctor=:P_check_doctor,report_date=:P_report_date,operator=:P_operator,'+  //report_doctor=:P_report_doctor,//审核者不需要在此更新
        'Diagnosetype=:P_Diagnosetype,flagetype=:P_flagetype,diagnose=:P_diagnose,typeflagcase=:P_typeflagcase,issure=:P_issure, ' +//age_real=:P_age_real,
        //' GermName=:GermName '+//,TjDescription=:TjDescription
        'WorkID=:WorkID,WorkCompany=:WorkCompany,WorkDepartment=:WorkDepartment,WorkCategory=:WorkCategory,ifMarry=:ifMarry,OldAddress=:OldAddress,Address=:Address,Telephone=:Telephone '+
        ' Where unid=:P_unid';
  adotemp2:=tadoquery.Create(nil);
  adotemp2.Connection:=DM.ADOConnection1;
  adotemp2.Close;
  adotemp2.SQL.Clear;
  adotemp2.SQL.text:=stringTemp ;
  adotemp2.Parameters.ParamByName('P_checkid').Value:=Pcheckid;
  adotemp2.Parameters.ParamByName('P_lsh').Value:=plsh ;
  adotemp2.Parameters.ParamByName('P_patientname').Value:=Copy(Ppatientname,1,40) ;
  adotemp2.Parameters.ParamByName('P_sex').Value:=Copy(Psex,1,8) ;
  adotemp2.Parameters.ParamByName('P_age').Value:=Copy(Page,1,14) ;
  adotemp2.Parameters.ParamByName('P_Caseno').Value:=Copy(PCaseno,1,20) ;
  adotemp2.Parameters.ParamByName('P_bedno').Value:=Copy(Pbedno,1,10) ;
  adotemp2.Parameters.ParamByName('P_deptname').Value:=Copy(Pdeptname,1,40) ;
  adotemp2.Parameters.ParamByName('P_check_date').Value:=strtodatetime(datetostr(Pcheck_date)+' '+timetostr(pJCSJ)) ;
  adotemp2.Parameters.ParamByName('P_check_doctor').Value:=Copy(Pcheck_doctor,1,14) ;
  adotemp2.Parameters.ParamByName('P_report_date').Value:=strtodatetime(datetostr(preport_date)+' '+timetostr(pSJSJ)) ;
  adotemp2.Parameters.ParamByName('P_operator').Value:=Copy(Poperator,1,14) ;
  adotemp2.Parameters.ParamByName('P_Diagnosetype').Value:=Copy(PDiagnosetype,1,4) ;
  adotemp2.Parameters.ParamByName('P_flagetype').Value:=Copy(Pflagetype,1,60) ;
  adotemp2.Parameters.ParamByName('P_diagnose').Value:=Copy(Pdiagnose,1,50) ;
  adotemp2.Parameters.ParamByName('P_typeflagcase').Value:=Copy(Ptypeflagcase,1,30) ;//
  adotemp2.Parameters.ParamByName('P_issure').Value:=Pissure ; //
  //adotemp2.Parameters.ParamByName('GermName').Value:=pGermName ; //
  //adotemp2.Parameters.ParamByName('TjDescription').Value:=pTjDescription ; //
  adotemp2.Parameters.ParamByName('WorkID').Value:=pWorkID ; //
  adotemp2.Parameters.ParamByName('WorkCompany').Value:=pWorkCompany ; //
  adotemp2.Parameters.ParamByName('WorkDepartment').Value:=pWorkDepartment ; //
  adotemp2.Parameters.ParamByName('WorkCategory').Value:=pWorkCategory ; //
  adotemp2.Parameters.ParamByName('ifMarry').Value:=pifMarry ; //
  adotemp2.Parameters.ParamByName('OldAddress').Value:=pOldAddress ; //
  adotemp2.Parameters.ParamByName('Address').Value:=pAddress ; //
  adotemp2.Parameters.ParamByName('Telephone').Value:=pTelephone ; //
  adotemp2.Parameters.ParamByName('P_unid').Value:=Punid ;
  Try
    adotemp2.EXECSql ;
  except
    on E:Exception do
    begin
      MESSAGEDLG('修改记录失败:'+E.Message,mtError,[mbOK],0);
      adotemp2.Free;
      result:=false;
      exit;
    end;
  end;

  adotemp2.Free;
  ValetudinarianInfoId:=PUNID;
  result:=true;
end;

procedure TSDIAppForm.suiButton6Click(Sender: TObject);
var
  valetudinarianInfoId:integer;
  adotemp11:tadoquery;

  Punid : integer;
  pcheckid : string; //联机号
  PLSH:STRING;
  Ppatientname : string;
  Psex : string;
  Page : string;
  PCaseno : string;
  Pbedno : string;
  Pdeptname : string;
  Pcheck_date : TDatetime;
  Pcheck_doctor : string;
  Preport_date : TDatetime;
  Preport_doctor : string;
  Poperator : string;
  PDiagnosetype : string;
  Pflagetype : string;
  Pdiagnose : string;
  Ptypeflagcase : string;
  pissure:string;
  pSJSJ,pJCSJ:TDATETIME;
  pCombin_id:string;//组别
  //pGermName:string;
  //pTjDescription:string;
  pHis_MzOrZy:string;

  pWorkID :string;
  pWorkCompany :string;
  pWorkDepartment :string;
  pWorkCategory :string;
  pifMarry :string;
  pOldAddress :string;
  pAddress :string;
  pTelephone :string;

  AddorUpdateResult:boolean;

  ini:tinifile;
  
  ifExistsCheckId:boolean;
  OldWorkGroup:string;//存在该联机号时的工作组
begin
  if not ifhaspower(sender,powerstr_js_main) then exit; //权限检查

  PDiagnosetype := trim(LabeledEdit12.text); //string 优先级别
  if PDiagnosetype='' then PDiagnosetype:=CGYXJB;
  if(PDiagnosetype<>CGYXJB)and(PDiagnosetype<>'急诊')and(PDiagnosetype<>'加急')then
  begin
    MessageBox(Handle, '请选择正确的优先级别！', '信息提示', MB_ICONHAND);
    LabeledEdit12.SetFocus;
    exit;
  end;
  Punid := DBGrid1.DataSource.DataSet.fieldbyname('唯一编号').AsInteger;//integer
  Pcheckid := uppercase(trim(LabeledEdit1.text));
  PLSH:=TRIM(LABELEDEDIT16.Text);
  Ppatientname := trim(LabeledEdit3.text); //string
  Psex := trim(LabeledEdit4.text); //string
  Page := trim(LabeledEdit5.text); //string
  PCaseno := trim(LabeledEdit2.text); //string
  Pbedno := trim(LabeledEdit7.text); //string
  Pdeptname := trim(LabeledEdit6.text); //string
  Pcheck_date := DateTimePicker2.Date; //TDatetime //检查日期
  Pcheck_doctor := trim(LabeledEdit10.Text); //string  //送检医生
  Preport_date := DateTimePicker1.Date; //TDatetime //申请日期
  Preport_doctor := '';//审核者; //string
  Poperator := operator_name; //string
  Pflagetype := trim(LabeledEdit8.text); //string
  Pdiagnose := trim(LabeledEdit14.text); //string
  Ptypeflagcase := trim(LabeledEdit9.text); //string
  pissure:=trim(labelededit15.Text);
  pSJSJ:=DateTimePicker3.Time;
  pJCSJ:=DateTimePicker4.Time;
  pCombin_id:=trim(cbxConnChar.Text); //工作组
  //pGermName:=trim(LabeledEdit18.Text);//细菌
  //pTjDescription:=Memo1.Text;//结论
  pHis_MzOrZy:=trim(ADObasic.fieldbyname('His门诊或住院').AsString);

  pWorkID := trim(lbedtWorkID.Text);
  pWorkCompany := trim(lbedtWorkCompany.Text);
  pWorkDepartment := trim(lbedtWorkDepartment.Text);
  pWorkCategory := trim(lbedtWorkCategory.Text);
  pifMarry := trim(lbedtifMarry.Text);
  pOldAddress := trim(lbedtOldAddress.Text);
  pAddress := trim(lbedtAddress.Text);
  pTelephone := trim(lbedtTelephone.Text);

  ifExistsCheckId:=false;

  //伪代码
  {if 有新联机号 and 该联机号存在 and 该联机号不在当前工作组 then 提示并退出

  if 当前工作组无记录 then 新增
  else begin
    if 该联机号存在 then 修改
    else begin
      if 新增状态 then 新增 else 修改
    end
  end//}
  
  if Pcheckid<>'' then
  begin
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:='select Unid,combin_id from chk_con where checkid is not null and checkid<>'''' and checkid='''+Pcheckid+''' and '+
                          ' CONVERT(CHAR(10),check_date,121)=:P_check_date and Diagnosetype=:Diagnosetype ';
    adotemp11.Parameters.ParamByName('P_check_date').Value:=FormatDateTime('YYYY-MM-DD',Pcheck_date);
    adotemp11.Parameters.ParamByName('Diagnosetype').Value:=PDiagnosetype;
    adotemp11.Open;
    if adotemp11.RecordCount>0 then
    begin
      ifExistsCheckId:=true;
      OldWorkGroup:=adotemp11.fieldbyname('combin_id').AsString;
      Punid:=adotemp11.fieldbyname('unid').AsInteger;
    end;
    adotemp11.Free;
  end;

  if ifExistsCheckId and (OldWorkGroup<>pCombin_id) then
  begin
    MessageDlg('工作组"'+OldWorkGroup+'"中已存在联机号为"'+Pcheckid+'"的病人记录', mtError, [mbYes], 0);
    exit;
  end;

  if ADObasic.RecordCount=0 then//当前无记录的情况,则肯定是新增
  begin
      AddorUpdateResult:=AddValetudinarianBasicInfo(PLSH,pcheckid,Ppatientname,Psex,
        Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
        PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,'','',
        pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone,
        Pcheck_date,Preport_date,pSJSJ,pJCSJ,
        ValetudinarianInfoId);
  end else//当前有记录的情况
  begin
    if ifExistsCheckId then//该联机号存在
    begin
        AddorUpdateResult:=UpdateValetudinarianBasicInfo(Punid,PLSH,pcheckid,Ppatientname,Psex,
          Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
          PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,'','',pHis_MzOrZy,
          pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone,
          Pcheck_date,Preport_date,pSJSJ,pJCSJ,
          ValetudinarianInfoId);
    end else
    begin
      if ifnewadd then//新增
      begin
        AddorUpdateResult:=AddValetudinarianBasicInfo(PLSH,pcheckid,Ppatientname,Psex,
          Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
          PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,'','',
          pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone,
          Pcheck_date,Preport_date,pSJSJ,pJCSJ,
          ValetudinarianInfoId);
      end else//修改
      begin
        AddorUpdateResult:=UpdateValetudinarianBasicInfo(Punid,PLSH,pcheckid,Ppatientname,Psex,
          Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
          PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,'','',pHis_MzOrZy,
          pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone,
          Pcheck_date,Preport_date,pSJSJ,pJCSJ,
          ValetudinarianInfoId);
      end;
    end;
  end;
  
  if AddorUpdateResult then
  begin
    UpdateADObasic;
    if not suiButton8.Glyph.Empty then suiButton8.Glyph:=nil;
    lsTransUnid.Clear;
    adobasic.Locate('唯一编号',ValetudinarianInfoId,[loCaseInsensitive]) ;
    update_Ado_dtl;

    LabeledEdit13.SetFocus;
  end;

  //保存当前联机号
  if trim(cbxConnChar.Text)<>'' then
  begin
    ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    ini.WriteString(cbxConnChar.Text,'检查日期',FormatDateTime('YYYY-MM-DD',DateTimePicker2.Date));
    ini.WriteString(cbxConnChar.Text,'联机号',LabeledEdit1.Text);
    ini.WriteString('Interface','当前保存的优先级别',LabeledEdit12.Text);
    ini.Free;
  end;
  //==============

  if CheckBox1.Checked then NewAddStatus();
end;

procedure TSDIAppForm.suiButton6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then suiButton6Click(nil);
end;

procedure TSDIAppForm.N28Click(Sender: TObject);
begin
if not ifhaspower(sender,powerstr_js_main) then exit;
  frmItemSetup.ShowModal;
end;

procedure TSDIAppForm.N15Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  frmBatchSpecNo(0).ShowModal; //批审核
end;

procedure TSDIAppForm.N46Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  frmBatchSpecNo(2).ShowModal;
end;

procedure TSDIAppForm.LabeledEdit13KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var b,i,checkunid:integer;
    ss,sss:string;
begin
  if key<>13 then EXIT;

  if (not dsbasic.DataSet.Active) or (dsbasic.DataSet.RecordCount <= 0) then
  begin
    Application.MessageBox('请先录入基本信息', '提示信息',MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
    exit;
  end;

  checkunid:=dsbasic.DataSet.fieldbyname('唯一编号').AsInteger;

  //===================输入'+',是最后条则新增，否则移到下一条============//
  if trim(LabeledEdit13.Text)='+' then
  begin
    ADObasic.Next;
    if LabeledEdit2.CanFocus then  LabeledEdit2.SetFocus else LabeledEdit3.SetFocus;
    exit;
  end;
  //==================================================//

  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    LabeledEdit13.Clear;
    LabeledEdit13.SetFocus;
    exit;
  end;

  for i:=0 to clbCommUsed.Count-1 do
  begin
    ss:=clbCommUsed.Items.Strings[i];
    b:=pos('   ',ss);
    sss:=copy(ss,1,b);
    if trim(sss)=trim(LabeledEdit13.Text) then
    begin
        clbCommUsed.Checked[i]:=not clbCommUsed.Checked[i];

        InsertOrDeleteVaue(sss,clbCommUsed.Checked[i],checkunid,-1);

        break;
    end;  //if
  end;

  for i:=0 to clbNoCommUsed.Count-1 do
  begin
    ss:=clbNoCommUsed.Items.Strings[i];
    b:=pos('   ',ss);
    sss:=copy(ss,1,b);
    if trim(sss)=trim(LabeledEdit13.Text) then
    begin
        clbNoCommUsed.Checked[i]:=not clbNoCommUsed.Checked[i];

        InsertOrDeleteVaue(sss,clbNoCommUsed.Checked[i],checkunid,-1);

        break;
    end;  //if
  end;
  
  if trim(LabeledEdit13.Text)<>'+' then
  begin
    tlabelededit(sender).Clear;
    tlabelededit(sender).SetFocus;
  end;
end;

procedure TSDIAppForm.LabeledEdit5Exit(Sender: TObject);
begin
  tlabelededit(sender).Text:=ageConvertChinese(trim(tlabelededit(sender).Text));
end;

procedure TSDIAppForm.suiButton1Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sReport_Doctor,sCombin_Id:string;

  sPatientname,sSex,sAge:string;

  i,j:integer;
  mvPictureTitle:TfrMemoView;  
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  sReport_Doctor:=trim(ADObasic.FieldByName('审核者').AsString);
  sCombin_Id:=adobasic.FieldByName('组别').AsString;

  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;
  
   if not ifAutoCheck then  //打印前要检查是否已被审核
   begin
     if sReport_Doctor='' then
     begin
      MessageBox(Handle, '请先审核！', '系统提示', MB_ICONASTERISK);
      exit;
     end;
   end;

  if (sCombin_Id=GP_WorkGroup_T1)
    and frReport1.LoadFromFile(GP_TempFile_T1) then//加载模板文件是不区分大小写的.空字符串将加载失败
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
    showmessage('加载默认分组打印模板report_Cur_group.frf失败，请设置:系统设置->选项->打印模板');
    exit;
  end;

  //动态创建图片标题begin
  //待处理问题:是否需要释放mvPictureTitle?何时释放?
  for j:=0 to frReport1.Pages.Count-1 do
  begin
    for i:=0 to frReport1.Pages[j].Objects.Count-1 do
    begin
      if TObject(frReport1.Pages[j].Objects.Items[i]) is TfrPictureView then
      begin
        if SameText(leftstr(TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name,7),'PICTURE') then
        begin
          mvPictureTitle:=TfrMemoView.Create;
          frReport1.Pages[j].Objects.Add(mvPictureTitle);
          mvPictureTitle.Name:='mv'+TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name;
          mvPictureTitle.Visible:=false;
        end;
      end;
    end;
  end;
  //动态创建图片标题end
  
    strsqlPrint:='select cv.combin_name as name,cv.name as 名称,cv.english_name as 英文名,cv.itemvalue as 检验结果,'+
    'cv.unit as 单位,cv.min_value as 最小值,cv.max_value as 最大值,'+
    ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as 前段参考范围,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as 后段参考范围,'+
    ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10, '+
    ' cv.itemid as 项目代码 '+//cci.Reserve3,
    ' from chk_valu cv WITH(NOLOCK) '+
    ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
    ' where cv.pkunid='+sUnid+
    ' and cv.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
    ' order by cv.pkcombin_id,cv.printorder ';//组合项目号,打印编号 '
  ADO_print.Close;
  ADO_print.SQL.Clear;
  ADO_print.SQL.Text:=strsqlPrint;
  ADO_print.Open;
  if (ADO_print.RecordCount=0) and (not ifNoResultPrint) then exit;

  if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm

  if n9.Checked then  //预览模式
  begin
    frReport1.ShowPrintDialog:=ifShowPrintDialog;
    frReport1.ShowReport;
  end;
  if n8.Checked then  //直接打印模式
  begin
    if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
  end;
end;

procedure TSDIAppForm.update_Ado_dtl;
var
  strsql11:string;
begin
  if not ADObasic.Active then exit;

  strsql11:='select '+
            IfThen(ifSearchHistValue,'(case dbo.uf_ifHasHistoricalValue(valueid) when 1 then ''√'' else '''' end)','''/''')+
            ' as 史,'+
            '(case when photo is null then null else ''图'' end) as 图,'+
            'name as 名称,english_name as 英文名,itemvalue as 检验结果,'+
            'min_value as 最小值,max_value as 最大值,'+
            'unit as 单位,'+
            'pkcombin_id as 组合项目号,itemid as 项目编号,valueid as 唯一编号,IsEdited as 修改标志 '+
            ' from chk_valu where pkunid=:pkunid and issure=1 '+
            ' order by pkcombin_id,printorder ';

  ADO_dtl.Close;
  ADO_dtl.SQL.Clear;
  ADO_dtl.SQL.Text:=strsql11;
  ADO_dtl.Parameters.ParamByName('pkunid').Value :=
      dsbasic.DataSet.FieldByName('唯一编号').AsInteger;
  try
    ADO_dtl.Open;
  except
  end;
end;

procedure TSDIAppForm.ADO_dtlAfterOpen(DataSet: TDataSet);
var
  adotemp11:tadoquery;
  strsql11:string;
begin
  //用不同的颜色进行分组标识(此过程放在要分组的数据集的AfterOpen过程中)
  strsql11:='select '+
            'DISTINCT pkcombin_id '+
            'from chk_valu where pkunid=:pkunid and issure=1 order by pkcombin_id ';

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:=strsql11;
  adotemp11.Parameters.ParamByName('pkunid').Value :=ADObasic.FieldByName('唯一编号').AsInteger;
  adotemp11.Open;
  lsGroupShow.Clear;
  while not adotemp11.Eof do
  begin
    lsGroupShow.Add(adotemp11.fieldbyname('pkcombin_id').AsString);

    adotemp11.Next;
  end;
  adotemp11.Free;
  //========================

  checkthelistbox;
  updateDBGrid2;
end;

procedure TSDIAppForm.InsertOrDeleteVaue(const ComboItemID:string;const ifAddorDel:boolean;const checkunid:integer;const AChk_Valu_His_ValueId:integer);
var
  adotemp3,adotemp33: tadoquery;
  s2,itemid,strsql:string;
  sAA:TStrings;
begin
  s2:=trim(ComboItemID);

  if ifAddorDel then
  //==========================增加插入=================================//
  begin
    ExecSQLCmd(LisConn,'update chk_valu set issure=1 where pkunid='+inttostr(checkunid)+' and pkcombin_id='+s2);

    //将病人检验项目表放入sAA中 start
    adotemp33:=tadoquery.Create(nil);
    adotemp33.Connection:=DM.ADOConnection1;
    adotemp33.Close;
    adotemp33.SQL.Clear;
    adotemp33.SQL.Text:='select * from chk_valu where pkunid='+inttostr(checkunid)+' and pkcombin_id='''+ComboItemID+''' ';
    adotemp33.Open;
    sAA:=TStringList.Create;
    while not adotemp33.Eof do
    begin
      sAA.Add(adotemp33.fieldbyname('itemid').AsString);
      adotemp33.Next;
    end;
    adotemp33.Free;
    //将病人检验项目表放入sAA中 end

    adotemp3:=tadoquery.Create(nil);
    adotemp3.Connection:=DM.ADOConnection1;
    adotemp3.Close;
    adotemp3.SQL.Clear;
    adotemp3.SQL.Text:='select cci.unid,cci.itemid from combinitem ci '+
                       'inner join CombSChkItem csci on csci.CombUnid=ci.Unid '+
                       'inner join clinicchkitem cci on cci.unid=csci.ItemUnid '+
                       'where ci.Id='''+s2+''' ';
    adotemp3.Open;
    while not adotemp3.Eof do//adotemp3是该组合项目的所有检验项目
    begin
      itemid:=trim(adotemp3.fieldbyname('itemid').AsString);

      //增加单个小项目start
      if sAA.IndexOf(itemid)<0 then
      begin
        strsql := 'insert into chk_valu(pkunid,issure,pkcombin_id,itemid) ' +
          ' values( ' +
          inttostr(checkunid)+',1,''' +s2+''','''+itemid+''')';
        ExecSQLCmd(LisConn,strsql);
        sAA.Add(itemid);
      end;
      //增加单个小项目stop

      adotemp3.Next;
    end;
    adotemp3.Free;
    sAA.Free;

    addOrEditCalcItem(pchar(LisConn),pchar(s2),checkunid);//增加计算项目

    addOrEditCalcValu(pchar(LisConn),checkunid,false,'');//更新计算项目
  end  //if ifAddorDel
    //===============================================================================//
  else
  begin
  //======================减少删除==================================================//
    ExecSQLCmd(LisConn,'update chk_valu set issure=0 where pkunid='+inttostr(checkunid)+' and pkcombin_id='''+s2+''' ');

    //检验结果全部删除后取消审核
    if '1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_valu where pkunid='+inttostr(checkunid)+' and issure=1') then
      ExecSQLCmd(LisConn,'update chk_con set report_doctor='''',Audit_Date=null where unid='+inttostr(checkunid));
  end;

  ADO_dtl.Close;
  ADO_dtl.Parameters.ParamByName('pkunid').Value := checkunid;
  ADO_dtl.Open;
end;

procedure TSDIAppForm.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(not ado_dtl.Active)or(ado_dtl.RecordCount=0) then exit;
  
  try
    if ado_dtl.Eof then (Sender as TDBGrid).Columns.Items[4].ReadOnly:=true;
  except
  end;
end;

procedure TSDIAppForm.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if(not ado_dtl.Active)or(ado_dtl.RecordCount=0) then exit;

      (Sender as TDBGrid).Columns.Items[4].ReadOnly:=false;
end;

procedure TSDIAppForm.Q1Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmCommQuery.ShowModal;
end;

procedure TSDIAppForm.ADObasicAfterScroll(DataSet: TDataSet);
begin
  FillBasic;
      
  if not ifBatchOperater then
  begin
    update_Ado_dtl;
    ShowPictureValue(DataSet.fieldbyname('唯一编号').AsInteger);
    ShowBarcode2D(DataSet.fieldbyname('唯一编号').AsInteger);
  end;

  ifnewadd:=false;
end;

procedure TSDIAppForm.N30Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  frmdocset.showmodal;
end;

procedure TSDIAppForm.N41Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

    tmenuitem(sender).Checked:= not tmenuitem(sender).Checked;
end;

procedure TSDIAppForm.cbxConnCharChange(Sender: TObject);
begin
  ClearAll(2);
  UpdateADObasic;
  update_Ado_dtl;
end;

procedure TSDIAppForm.ADO_dtlAfterPost(DataSet: TDataSet);
begin
  addOrEditCalcValu(pchar(LisConn),dsbasic.DataSet.FieldByName('唯一编号').AsInteger,false,''); //计算
  ADO_dtl.Refresh;//更新界面(计算值、翻译值、是否修改标识...)
end;

procedure TSDIAppForm.LabeledEdit16Exit(Sender: TObject);
begin
    if length(trim((sender as TLabeledEdit).Text))=0 then exit;

    (sender as TLabeledEdit).Text:=rightstr('0000'+trim((sender as TLabeledEdit).Text),4);
end;

procedure TSDIAppForm.DBGrid2Exit(Sender: TObject);
begin
  if not TDBGrid(sender).DataSource.DataSet.Active then exit;
  if TDBGrid(sender).DataSource.DataSet.RecordCount=0 then exit;
  if TDBGrid(sender).DataSource.DataSet.State=dsEdit then //add ly 20050521
    TDBGrid(sender).DataSource.DataSet.Post;
end;

procedure TSDIAppForm.O1Click(Sender: TObject);
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
  adotemp3.SQL.Text:='select name from CommCode where TypeName=''检验组别'' group by name';
  adotemp3.Open;
  while not adotemp3.Eof do
  begin
    sWorkGroup:=sWorkGroup+#13+trim(adotemp3.fieldbyname('name').AsString);
    adotemp3.Next;
  end;
  adotemp3.Free;
  sWorkGroup:=trim(sWorkGroup);

  ss:='直方图光滑次数'+#2+'Edit'+#2+#2+'0'+#2+'注:次数越多曲线越光滑,但曲线偏离越多'+#2+#3+
      '允许无检验结果打印'+#2+'CheckListBox'+#2+#2+'0'+#2+#2+#3+
      '打印对话框'+#2+'CheckListBox'+#2+#2+'0'+#2+'打印预览模式的高级选项(打印机、页码、份数等)'+#2+#3+
      '打印时自动审核检验单'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '根据"门诊/住院号"提取床号'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '根据"门诊/住院号"提取临床诊断'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '根据"门诊/住院号"提取备注'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '送检科室取码的匹配方式'+#2+'Combobox'+#2+'模糊匹配'+#13+'左匹配'+#13+'右匹配'+#13+'全匹配'+#2+'1'+#2+#2+#3+
      '送检医生取码的匹配方式'+#2+'Combobox'+#2+'模糊匹配'+#13+'左匹配'+#13+'右匹配'+#13+'全匹配'+#2+'1'+#2+#2+#3+
      '弹出登录窗口的时间'+#2+'Edit'+#2+#2+'1'+#2+'注:表示多长时间内无操作,则自动弹出登录窗口(单位:秒)'+#2+#3+
      '查找历史结果'+#2+'CheckListBox'+#2+#2+'1'+#2+'注:启用该选项将降低系统性能,慎用!'+#2+#3+
      '特殊模板1工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '特殊模板1文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '特殊模板2工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '特殊模板2文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '特殊模板3工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '特殊模板3文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '分组模板1工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '分组模板1文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '分组模板2工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '分组模板2文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '分组模板3工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '分组模板3文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '启用项目数控制纸张长度'+#2+'CheckListBox'+#2+#2+'2'+#2+'注:对普通打印、分组打印生效'+#2+#3+
      '每页项目数最大值'+#2+'Edit'+#2+#2+'2'+#2+'注:如项目数大于该值,则纸张长度为"报告长度"的值.默认值为0'+#2+#3+
      '报告长度'+#2+'Edit'+#2+#2+'2'+#2+'默认值为2794,单位:mm'+#2+#3;
  if ShowOptionForm('选项','报表'+#2+'选项'+#2+'打印模板',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
	  ReadIni;
end;

procedure TSDIAppForm.ADO_dtlAfterScroll(DataSet: TDataSet);
var
  adotemp11:tadoquery;
begin
  //常见结果下拉框
  if not DataSet.Active then exit;
  if DataSet.RecordCount=0 then exit;

  dbgrid2.Columns[4].PickList.Clear;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select sValue from CommValue,clinicchkitem where CommValue.ItemUnid=clinicchkitem.unid and clinicchkitem.itemid=:itemid';
  adotemp11.Parameters.ParamByName('itemid').Value:=
    DataSet.fieldbyname('项目编号').AsString;
  adotemp11.Open;
  while not adotemp11.Eof do
  begin
    dbgrid2.Columns[4].PickList.add(adotemp11.fieldbyname('sValue').AsString);
    adotemp11.Next;
  end;
  adotemp11.Free;

  //更新结果详情
  meValueDesc.Text:=DataSet.fieldbyname('检验结果').AsString;
  Label8.Caption:=DataSet.fieldbyname('组合项目号').AsString+'->'+DataSet.fieldbyname('名称').AsString;
end;

procedure TSDIAppForm.LabeledEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=dm.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcAll;
  tmpADOLYGetcode.IfShowDialogZeroRecord:=false;
  tmpADOLYGetcode.OpenStr:='select caseno as 病历号,patientname as 姓名,sex as 性别,age as 年龄,deptname as 送检科室,check_doctor as 送检医生,issure as 备注,bedno as 床号,diagnose as 临床诊断 from view_Chk_Con_All where isnull(caseno,'''')<>'''' order by unid desc';//最近输入的显示在最前(一般希望选择最近的病历) 
  tmpADOLYGetcode.InField:='caseno';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=tLabeledEdit(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=tLabeledEdit(SENDER).ClientToScreen(Point(0, tLabeledEdit(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit3.Text:=tmpADOLYGetcode.OutValue[1];
    LabeledEdit4.Text:=tmpADOLYGetcode.OutValue[2];
    LabeledEdit5.Text:=tmpADOLYGetcode.OutValue[3];
    LabeledEdit6.Text:=tmpADOLYGetcode.OutValue[4];
    LabeledEdit10.Text:=tmpADOLYGetcode.OutValue[5];
    if ifGetMemoFromCaseNo then LabeledEdit15.Text:=tmpADOLYGetcode.OutValue[6];
    if ifGetBedNoFromCaseNo then LabeledEdit7.Text:=tmpADOLYGetcode.OutValue[7];
    if ifGetDiagnoseFromCaseNo then LabeledEdit14.Text:=tmpADOLYGetcode.OutValue[8];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit12KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''优先级别'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=TComboBox(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=TComboBox(SENDER).ClientToScreen(Point(0, TComboBox(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  if deptname_match='全匹配' then tmpADOLYGetcode.GetCodePos:=gcAll
    else if deptname_match='左匹配' then tmpADOLYGetcode.GetCodePos:=gcLeft
      else if deptname_match='右匹配' then tmpADOLYGetcode.GetCodePos:=gcRight
        else tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''部门'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=TComboBox(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=TComboBox(SENDER).ClientToScreen(Point(0, TComboBox(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  if check_doctor_match='全匹配' then tmpADOLYGetcode.GetCodePos:=gcAll
    else if check_doctor_match='左匹配' then tmpADOLYGetcode.GetCodePos:=gcLeft
      else if check_doctor_match='右匹配' then tmpADOLYGetcode.GetCodePos:=gcRight
        else tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from worker';
  tmpADOLYGetcode.InField:='id,wbm,pinyin';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=TComboBox(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=TComboBox(SENDER).ClientToScreen(Point(0, TComboBox(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''样本类型'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=TComboBox(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=TComboBox(SENDER).ClientToScreen(Point(0, TComboBox(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''样本状态'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=TComboBox(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=TComboBox(SENDER).ClientToScreen(Point(0, TComboBox(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit14KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcLeft;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''临床诊断'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=tLabeledEdit(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=tLabeledEdit(SENDER).ClientToScreen(Point(0, tLabeledEdit(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit15KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''备注'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=tLabeledEdit(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=tLabeledEdit(SENDER).ClientToScreen(Point(0, tLabeledEdit(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('确实要退出系统吗?', mtInformation, [mbNo,mbYes], 0 ) = mrYes then
    action:=cafree
  else action:=caNone;
end;

procedure TSDIAppForm.UpdateStatusBar(const text: string);
//Text为该格式#$2+'0:abc'+#$2+'1:def'表示状态栏第0格显示abc,第1格显示def,依此类推
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

procedure TSDIAppForm.WMUpdateTextStatus(var message: twmupdatetextstatus);
begin
  UpdateStatusBar(pchar(message.Text));
  message.Result:=-1;
end;

procedure TSDIAppForm.cbxConnCharEnter(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then LabeledEdit1.SetFocus;//无权限则cbxConnChar失去焦点
end;

procedure TSDIAppForm.Excel1Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmExcelQuery.ShowModal;
end;

procedure TSDIAppForm.N33Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmHorizontalExport.ShowModal;
end;

procedure TSDIAppForm.N31Click(Sender: TObject);
begin
  LabeledEdit16.Enabled:=not LabeledEdit16.Enabled;
end;

procedure TSDIAppForm.N39Click(Sender: TObject);
begin
  LabeledEdit2.Enabled:=not LabeledEdit2.Enabled;
end;

procedure TSDIAppForm.N43Click(Sender: TObject);
begin
  LabeledEdit6.Enabled:=not LabeledEdit6.Enabled;
end;

procedure TSDIAppForm.N51Click(Sender: TObject);
begin
  LabeledEdit7.Enabled:=not LabeledEdit7.Enabled;
end;

procedure TSDIAppForm.N52Click(Sender: TObject);
begin
  LabeledEdit10.Enabled:=not LabeledEdit10.Enabled;
end;

procedure TSDIAppForm.N53Click(Sender: TObject);
begin
  LabeledEdit8.Enabled:=not LabeledEdit8.Enabled;
end;

procedure TSDIAppForm.N54Click(Sender: TObject);
begin
  LabeledEdit9.Enabled:=not LabeledEdit9.Enabled;
end;

procedure TSDIAppForm.N55Click(Sender: TObject);
begin
  LabeledEdit14.Enabled:=not LabeledEdit14.Enabled;
end;

procedure TSDIAppForm.N56Click(Sender: TObject);
begin
  DateTimePicker1.Enabled:=not DateTimePicker1.Enabled;
end;

procedure TSDIAppForm.N57Click(Sender: TObject);
begin
  DateTimePicker3.Enabled:=not DateTimePicker3.Enabled;
end;

procedure TSDIAppForm.N58Click(Sender: TObject);
begin
  DateTimePicker2.Enabled:=not DateTimePicker2.Enabled;
end;

procedure TSDIAppForm.N59Click(Sender: TObject);
begin
  DateTimePicker4.Enabled:=not DateTimePicker4.Enabled;
end;

procedure TSDIAppForm.N61Click(Sender: TObject);
begin
  LabeledEdit15.Enabled:=not LabeledEdit15.Enabled;
end;

procedure TSDIAppForm.N77Click(Sender: TObject);
begin
  lbedtWorkID.Enabled:=not lbedtWorkID.Enabled;
end;

procedure TSDIAppForm.N78Click(Sender: TObject);
begin
  lbedtWorkCompany.Enabled:=not lbedtWorkCompany.Enabled;
end;

procedure TSDIAppForm.N79Click(Sender: TObject);
begin
  lbedtWorkDepartment.Enabled:=not lbedtWorkDepartment.Enabled;
end;

procedure TSDIAppForm.N80Click(Sender: TObject);
begin
  lbedtWorkCategory.Enabled:=not lbedtWorkCategory.Enabled;
end;

procedure TSDIAppForm.N81Click(Sender: TObject);
begin
  lbedtifMarry.Enabled:=not lbedtifMarry.Enabled;
end;

procedure TSDIAppForm.N82Click(Sender: TObject);
begin
  lbedtOldAddress.Enabled:=not lbedtOldAddress.Enabled;
end;

procedure TSDIAppForm.N83Click(Sender: TObject);
begin
  lbedtAddress.Enabled:=not lbedtAddress.Enabled;
end;

procedure TSDIAppForm.N84Click(Sender: TObject);
begin
  lbedtTelephone.Enabled:=not lbedtTelephone.Enabled;
end;

procedure TSDIAppForm.pmChangeGroupItemClick(Sender: TObject);
var
  Insert_Identity:INTEGER;
begin
  if not adobasic.Active then exit;
  if adobasic.RecordCount=0 then exit;
  if trim(adobasic.FieldByName('组别').AsString)=trim(tmenuitem(sender).Caption) then exit;

  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    exit;
  end;
  if application.MessageBox(Pchar('您确实要将该病人更换为'+trim(tmenuitem(sender).Caption)+'吗?'),'系统提示', MB_OKCANCEL+MB_ICONINFORMATION)<>IDOK then exit;

  Insert_Identity:=adobasic.fieldbyname('唯一编号').AsInteger;

  ExecSQLCmd(LisConn,'update chk_con set combin_id='''+tmenuitem(sender).Caption+''' where unid='+inttostr(Insert_Identity));

  UpdateADObasic;//换组后刷新当前组的显示
end;

procedure TSDIAppForm.Y1Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmstaticcombitem.ShowModal;
end;

procedure TSDIAppForm.ADObasicAfterOpen(DataSet: TDataSet);
begin
  updatedbgrid1;
end;

function TSDIAppForm.CompletionJob: boolean;
var
  adotemp11:tadoquery;
  s1,s2,s3:string;
begin
  //为提高性能，采取分库分表(此处为水平拆分)
  result:=true;

  IF NOT ADObasic.Active THEN begin result:=false;EXIT;end;
  IF ADObasic.RecordCount=0 THEN begin result:=false;EXIT;end;

  s1:=' select   *  from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+cbxConnChar.Text+''' ';//所有已审核的单
  s2:=' select unid from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+cbxConnChar.Text+''' ';//与S1相同，除了选择范围不同外
  s3:='             from chk_con where isnull(chk_con.report_doctor,'''')<>'''' and combin_id='''+cbxConnChar.Text+''' ';//与S1相同，除了选择范围不同外
  //事务4特性ACID
  //Atomicity【原子性】:要么一起成功,要么一起失败
  //Consistency【一致性】:事务前后数据的完整性保持一致
  //Isolation【隔离性】:多个用户并发访问数据库时,数据库为每个用户开启事务,不会被其他事务的操作数据所干扰,多个并发事务之间相互隔离
              //4种事务隔离级别:
              //读未提交:一个事务未提交,它做的变更能被其他事务看到
              //读已提交:一个事务提交后,它做的变更才能被其他事务看到[SQL SERVER默认级别]
              //可重复读:同一个事务中用SELECT查询的结果总是相同的,哪怕是其他事务对该数据进行了操作并提交[MySQL InnoDB引擎默认级别]
              //串行化:读写相互都会阻塞,隔离级别最高,牺牲系统并发性
  //Durability【持久性】:事务一旦被提交,它对数据库中数据的改变就是永久性的,接下来即使数据库发生故障也不对其有任何影响
  DM.ADOConnection1.BeginTrans;
  try//经测试(设置断点并中止执行或断电)，BeginTrans与CommitTrans之间的语句中止执行，数据不会提交
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    ADOtemp11.Close;
    ADOtemp11.SQL.Clear;
    ADOtemp11.SQL.Add('insert into chk_con_bak '+s1);
    ADOtemp11.ExecSQL;

    ADOtemp11.Close;
    ADOtemp11.SQL.Clear;
    ADOtemp11.SQL.Add('insert into chk_valu_bak select * from chk_VALU where issure=1 and pkunid in ('+s2+')');
    ADOtemp11.ExecSQL;

    ADOtemp11.Close;
    ADOtemp11.SQL.Clear;
    ADOtemp11.SQL.Add('delete '+s3);
    ADOtemp11.ExecSQL;

    adotemp11.Free;

    DM.ADOConnection1.CommitTrans;
  except
    Application.MessageBox('结束工作发生异常!', '信息提示', MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
    DM.ADOConnection1.RollbackTrans;
    result:=false;
  end;
end;

procedure TSDIAppForm.Excel2Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmFromExcelLoad.ShowModal;
end;

procedure TSDIAppForm.N63Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  frmXDepictType.ShowModal;
end;

procedure TSDIAppForm.M1Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  frmXDepict(1).ShowModal;
end;

procedure TSDIAppForm.ReadIni;
var
  configini:tinifile;

  pInStr,pDeStr:Pchar;
  i:integer;
begin
  //读系统代码
  SCSYDW:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''系统代码'' and ReMark=''授权使用单位'' ');
  if SCSYDW='' then SCSYDW:='2F3A054F64394BBBE3D81033FDE12313';//'未授权单位'加密后的字符串
  //======解密SCSYDW
  pInStr:=pchar(SCSYDW);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(SCSYDW,length(pDeStr));
  for i :=1  to length(pDeStr) do SCSYDW[i]:=pDeStr[i-1];
  //==========

  MakeTjDescDays:=strtointdef(ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''系统代码'' and ReMark=''生成体检结论的偏差天数'' '),0);
  bAppendMakeTjDesc:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''系统代码'' and ReMark=''允许追加生成体检结论'' ');

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  SmoothNum:=configini.ReadInteger('报表','直方图光滑次数',0);
  ifNoResultPrint:=configini.ReadBool('报表','允许无检验结果打印',false);
  ifShowPrintDialog:=configini.ReadBool('报表','打印对话框',false);
  ifAutoCheck:=configini.ReadBool('选项','打印时自动审核检验单',false);
  deptname_match:=configini.ReadString('选项','送检科室取码的匹配方式','');
  check_doctor_match:=configini.ReadString('选项','送检医生取码的匹配方式','');
  ifGetBedNoFromCaseNo:=configini.ReadBool('选项','根据"门诊/住院号"提取床号',false);
  ifGetDiagnoseFromCaseNo:=configini.ReadBool('选项','根据"门诊/住院号"提取临床诊断',false);
  ifGetMemoFromCaseNo:=configini.ReadBool('选项','根据"门诊/住院号"提取备注',false);
  LoginTime:=configini.ReadInteger('选项','弹出登录窗口的时间',30);
  ifSearchHistValue:=configini.ReadBool('选项','查找历史结果',false);

  WorkGroup_T1:=configini.ReadString('打印模板','特殊模板1工作组','');
  TempFile_T1:=configini.ReadString('打印模板','特殊模板1文件','');
  WorkGroup_T2:=configini.ReadString('打印模板','特殊模板2工作组','');
  TempFile_T2:=configini.ReadString('打印模板','特殊模板2文件','');
  WorkGroup_T3:=configini.ReadString('打印模板','特殊模板3工作组','');
  TempFile_T3:=configini.ReadString('打印模板','特殊模板3文件','');  
  
  GP_WorkGroup_T1:=configini.ReadString('打印模板','分组模板1工作组','');
  GP_TempFile_T1:=configini.ReadString('打印模板','分组模板1文件','');
  GP_WorkGroup_T2:=configini.ReadString('打印模板','分组模板2工作组','');
  GP_TempFile_T2:=configini.ReadString('打印模板','分组模板2文件','');
  GP_WorkGroup_T3:=configini.ReadString('打印模板','分组模板3工作组','');
  GP_TempFile_T3:=configini.ReadString('打印模板','分组模板3文件','');  

  ifHeightForItemNum:=configini.ReadBool('打印模板','启用项目数控制纸张长度',false);
  ItemRecNum:=configini.ReadInteger('打印模板','每页项目数最大值',0);
  PageHeigth:=configini.ReadInteger('打印模板','报告长度',2794);  
      
  configini.Free;
end;

procedure TSDIAppForm.N37Click(Sender: TObject);
var
  ss:string;
begin
  ss:='RegisterNum'+#2+'Edit'+#2+#2+'0'+#2+'将该窗体标题栏上的字符串发给开发者,以获取注册码'+#2;
  if bRegister then exit;
  //函数返回的Pchar类型还真能直接赋值给string!!!
  if ShowOptionForm(Pchar('注册:'+GetHDSn('C:\')+'-'+GetHDSn('D:\')),'Register',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini')))then
    if ifRegister then bRegister:=true else bRegister:=false;
end;

procedure TSDIAppForm.N42Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmCommCode.ShowModal;
end;

procedure TSDIAppForm.ADO_dtlBeforeClose(DataSet: TDataSet);
var
  ConfigIni:tinifile;
  colValueWidth:integer;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  colValueWidth:=configini.ReadInteger('Interface','colValueWidth',70);{记录检验结果列的宽度}
  if (colValueWidth<>dbgrid2.Columns[4].Width)and(dbgrid2.Columns[4].Width>=70)and(dbgrid2.Columns[4].Width<=680) then
    configini.WriteInteger('Interface','colValueWidth',dbgrid2.Columns[4].Width);{记录检验结果列的宽度}

  configini.Free;
end;

{//体检结果录入菜单
procedure TSDIAppForm.N17Click(Sender: TObject);
TYPE
  TDLLProc=function(AHandle:THandle;ABasicDs:TAdoquery;AImeName:Pchar;AifCurTab:boolean;AOperator_ID:Pchar):boolean;stdcall;
VAR
  DLLProc:TDLLProc;
  HTJLIB:THandle;
  
  ConfigIni:tinifile;
  StrImeName:string;
  FExecute:boolean;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;
  
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    StrImeName:=ConfigIni.ReadString('输入法选择','默认中文输入法','中文 (简体) - 智能 ABC');
  finally
    ConfigIni.Free;
  end;

  HTJLIB:=LOADLIBRARY('TJ.dll');
  IF HTJLIB=0 THEN BEGIN SHOWMESSAGE('对不起,您使用的版本无此功能!');EXIT; END;//动态链接库TJ.DLL不存在
  DLLProc:=TDLLProc(GETPROCADDRESS(HTJLIB,'ShowTJForm'));
  IF @DLLProc=NIL THEN BEGIN SHOWMESSAGE('函数ShowTJForm不存在!');EXIT; END;
  FExecute:=DLLProc(Application.Handle,ADObasic,Pchar(StrImeName),true,Pchar(operator_id));
  FreeLIBRARY(HTJLIB);

  if FExecute then suiButton8Click(nil);
end;//}

procedure TSDIAppForm.pmChangeGroupPopup(Sender: TObject);
var
  adotemp3:tadoquery;
  delMenuItem,TempMenuItem:TMenuItem;
  tempstr:string;
  i,j:integer;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:='select name from CommCode where TypeName=''检验组别'' and Sysname='''+SYSNAME+''' group by name';
     adotemp3.Open;
     adotemp3.First;
     
     //加载前先清除pmChangeGroup项
     for j := pmChangeGroup.Items.Count-1 downto 0 do
     begin
          if (pmChangeGroup.Items.Items[j] is TMenuItem)then
          begin
            delMenuItem := pmChangeGroup.Items.Items[j];
            if(delMenuItem.Caption<>'更换组别')and(delMenuItem.Caption<>'-')and(delMenuItem.Caption<>'生成体检结论')and(delMenuItem.Caption<>'单个生成体检结论') then//and(delMenuItem.Caption<>'体检结果录入')
            //这就要求组别设置时，不能设置"更换组别"及"-"
              if (delMenuItem <> nil) then FreeandNIl(delMenuItem);
          end;
     end;

     i:=0;
     while not adotemp3.Eof do
     begin
      inc(i);
      tempstr:=trim(adotemp3.fieldbyname('name').AsString);

      //加载到pmChangeGroup
      TempMenuItem := TMenuItem.Create(self);
      TempMenuItem.Name := 'Temp' + inttostr(i);
      TempMenuItem.Caption := tempstr;
      TempMenuItem.OnClick:=pmChangeGroupItemClick;
      pmChangeGroup.Items.Add(TempMenuItem);

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure TSDIAppForm.N26Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmPlxg.ShowModal;
end;

procedure TSDIAppForm.N50Click(Sender: TObject);
begin
  TMenuItem(sender).Checked:=not TMenuItem(sender).Checked;
  VisibleColumn(dbgrid2,'英文名',TMenuItem(sender).Checked);
end;

procedure TSDIAppForm.N36Click(Sender: TObject);
begin
  TMenuItem(sender).Checked:=not TMenuItem(sender).Checked;
  VisibleColumn(dbgrid2,'最小值',TMenuItem(sender).Checked);
end;

procedure TSDIAppForm.N47Click(Sender: TObject);
begin
  TMenuItem(sender).Checked:=not TMenuItem(sender).Checked;
  VisibleColumn(dbgrid2,'最大值',TMenuItem(sender).Checked);
end;

procedure TSDIAppForm.N49Click(Sender: TObject);
begin
  TMenuItem(sender).Checked:=not TMenuItem(sender).Checked;
  VisibleColumn(dbgrid2,'单位',TMenuItem(sender).Checked);
end;

procedure TSDIAppForm.SpeedButton1Click(Sender: TObject);
var
  LYLocateRecord:TLYLocateRecord;
begin
  LYLocateRecord:=TLYLocateRecord.create(nil);
  LYLocateRecord.DataSource:=DSbasic;
  LYLocateRecord.Execute;
  LYLocateRecord.free;
end;

procedure TSDIAppForm.LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  adotemp11:tadoquery;
  unid:integer; 
begin
  if key<>13 then exit;

  if trim(TLabeledEdit(sender).Text)='' then exit;

  unid:=-1;
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select unid from chk_con where isnull(checkid,'''')<>'''' and ltrim(rtrim(checkid))='''+trim(TLabeledEdit(sender).Text)+''' and ltrim(rtrim(diagnosetype))='''+trim(LabeledEdit12.Text)+''' and CONVERT(CHAR(10),check_date,121)='''+FormatDateTime('YYYY-MM-DD',DateTimePicker2.Date)+''' ';
  adotemp11.Open;
  if adotemp11.RecordCount>0 then unid:=adotemp11.fieldbyname('unid').AsInteger;
  adotemp11.Free;
  ADObasic.Locate('唯一编号',unid,[]);
end;

procedure TSDIAppForm.frReport1BeforePrint(Memo: TStringList;
  View: TfrView);
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

  mvPictureTitle :TfrView;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('唯一编号').AsInteger;
  report_doctor:=trim(ADObasic.fieldbyname('审核者').AsString);

  //加载血流变曲线、直方图、散点图 start
  if(View is TfrChartView)and(pos('CURVE',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
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
      View.Visible:=true;

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
      TfrChartView(View).Assignchart(Chart_XLB);//指定统计图給FastReport

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
      View.Visible:=true;

      Chart_ZFT:=TChart.Create(nil);
      Chart_ZFT.Visible:=false;

      updatechart(Chart_ZFT,strHistogram,strEnglishName,strXTitle);
      TfrChartView(View).Assignchart(Chart_ZFT);//指定统计图給FastReport

      Chart_ZFT.Free;
    end;
  end;

  if(View is TfrPictureView)and(pos('PICTURE',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strEnglishName:=(View as TfrPictureView).Name;
    strEnglishName:=stringreplace(strEnglishName,'Picture','',[rfIgnoreCase]);
    strsqlPrint:='select top 1 Photo,english_name '+
       ' from chk_valu WITH(NOLOCK) '+
       ' where pkunid=:pkunid '+
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

      //显示图片标题begin
      mvPictureTitle:=frReport1.FindObject('mv'+(View as TfrPictureView).Name);
      if (mvPictureTitle<>nil) and (mvPictureTitle is TfrMemoView) then
      begin
        mvPictureTitle.Prop['AutoWidth']:=True;
        TfrMemoView(mvPictureTitle).Font.Name:='宋体';
        mvPictureTitle.SetBounds((View as TfrPictureView).Prop['left'], (View as TfrPictureView).Prop['top']-20, 50, 20);
        mvPictureTitle.Memo.Text:=adotemp11.fieldbyname('english_name').AsString;
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
    ExecSQLCmd(LisConn,'update chk_con set report_doctor='''+operator_name+''',Audit_Date=getdate() where unid='+inttostr(unid));
    adobasic.Refresh;//更新显示审核者
  end;
end;

procedure TSDIAppForm.frReport1PrintReport;
var
  unid,printtimes:integer;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('唯一编号').AsInteger;
  printtimes:=ADObasic.fieldbyname('打印次数').AsInteger;

  if printtimes=0 then//修改打印次数
  begin
    ExecSQLCmd(LisConn,'update chk_con set printtimes='+inttostr(printtimes+1)+' where unid='+inttostr(unid));
    adobasic.Refresh;//打印后要显示红色
  end;
  
  ExecSQLCmd(LisConn,'insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values ('+inttostr(unid)+','''+operator_name+''',''Class_Print'',''Lab'')');
end;

procedure TSDIAppForm.LabeledEdit3Change(Sender: TObject);
var
  ini:tinifile;
  XrfMc:string;//以前设置的输入法名称
  CurImeName:string;
begin
  //保存当前输入法
  CurImeName:=GetSysCurImeName;//函数返回的Pchar类型还真能直接赋值给string!!!
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  XrfMc:=ini.ReadString('输入法选择','默认中文输入法','');
  if (XrfMc<>CurImeName)and(CurImeName<>'') then
  begin
    ini.WriteString('输入法选择','默认中文输入法',CurImeName);
    ChangeYouFormAllControlIme(Self);//设置中文输入法
  end;
  ini.Free;
  //==============
end;

procedure TSDIAppForm.TimerIdleTrackerTimer(Sender: TObject);
begin
  //自动弹出登录窗口
  if (StopTime>LoginTime) and (FindWindow(PCHAR('TfrmLogin'),PCHAR('登录'))=0) then
    frmLogin.ShowModal;
end;

procedure TSDIAppForm.SpeedButton5Click(Sender: TObject);
begin
  NewAddStatus();
end;

procedure TSDIAppForm.N16Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmCopyInfo.ShowModal;
end;

procedure TSDIAppForm.N69Click(Sender: TObject);
begin
  copyName:=trim(LabeledEdit3.text);
  copySex:=trim(LabeledEdit4.text);
  copyage:=trim(LabeledEdit5.text);
  copyCaseno:=trim(LabeledEdit2.text);
  copyBedno:=trim(LabeledEdit7.text);
  copydeptname:=trim(LabeledEdit6.text);
  copycheck_doctor:=trim(LabeledEdit10.text);
end;

procedure TSDIAppForm.N70Click(Sender: TObject);
begin
  LabeledEdit3.text:=copyName;
  LabeledEdit4.text:=copySex;
  LabeledEdit5.text:=copyage;
  LabeledEdit2.text:=copyCaseno;
  LabeledEdit7.text:=copyBedno;
  LabeledEdit6.text:=copydeptname;
  LabeledEdit10.text:=copycheck_doctor;
end;

procedure TSDIAppForm.N71Click(Sender: TObject);
Var
  MS:TMemoryStream;
  J1:TJPEGImage;
  ti:TImage;
  adotemp22:tadoquery;
  FilePath:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if (MessageDlg('确实要为该样本新增图片项目?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  openpicturedialog1.Filter := '图片文件(*.bmp,*.jpg,*jpeg)|*.bmp;*.jpg;*.jpeg';
  if not openpicturedialog1.Execute then exit;
  FilePath:=openpicturedialog1.FileName;

  MS:=TMemoryStream.Create;
  J1:=TJPEGImage.Create;

  ti:=TImage.Create(nil);
  ti.Picture.LoadFromFile(FilePath);
  J1.Assign(ti.Picture.Graphic);
  ti.Free;

  J1.SaveToStream(MS);
  J1.Free;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=dm.ADOConnection1;
  adotemp22.Close;
  adotemp22.sql.clear;
  adotemp22.sql.Add('insert into chk_valu (Pkunid,ItemId,Photo,issure) values (:Pkunid,''Pure Photo'',:Photo,''1'') ');
  adotemp22.Parameters.ParamByName('Pkunid').Value:=ADObasic.fieldbyname('唯一编号').AsInteger;
  adotemp22.Parameters.ParamByName('Photo').LoadFromStream(MS,ftGraphic);
  adotemp22.ExecSQL;
  adotemp22.Free;
  MS.Free;

  update_Ado_dtl;
  ShowPictureValue(ADObasic.fieldbyname('唯一编号').AsInteger);
end;

procedure TSDIAppForm.N23Click(Sender: TObject);
Var
  MS:TMemoryStream;
  J1:TJPEGImage;
  ti:TImage;
  adotemp22:tadoquery;//修改图片用
  FilePath:string;
  iValueId:integer;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent.ClassName='TGroupBox' then iValueId:=TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent.Tag
  else iValueId:=ADO_dtl.fieldbyname('唯一编号').AsInteger;

  if '1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_valu where valueid='+inttostr(iValueId)+' and Photo is not null ') then
  begin
    if (MessageDlg('确实要覆盖已存在的图片?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;
  end;

  openpicturedialog1.Filter := '图片文件(*.bmp,*.jpg,*jpeg)|*.bmp;*.jpg;*.jpeg';
  if not openpicturedialog1.Execute then exit;
  FilePath:=openpicturedialog1.FileName;

  MS:=TMemoryStream.Create;
  J1:=TJPEGImage.Create;

  ti:=TImage.Create(nil);
  ti.Picture.LoadFromFile(FilePath);
  J1.Assign(ti.Picture.Graphic);
  ti.Free;

  J1.SaveToStream(MS);
  J1.Free;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=dm.ADOConnection1;
  adotemp22.Close;
  adotemp22.sql.clear;
  adotemp22.sql.Text:='update chk_valu set Photo=:Photo where valueid=:valueid';
  adotemp22.Parameters.ParamByName('valueid').Value:=iValueId;
  adotemp22.Parameters.ParamByName('Photo').LoadFromStream(MS,ftGraphic);
  adotemp22.ExecSQL;
  adotemp22.Free;
  MS.Free;

  update_Ado_dtl;
  Ado_dtl.Locate('唯一编号',iValueId,[loCaseInsensitive]);
  ShowPictureValue(ADObasic.fieldbyname('唯一编号').AsInteger);
end;

procedure TSDIAppForm.N48Click(Sender: TObject);
Var
  adotemp22,adotemp33:tadoquery;//修改图片用
  iHasPoto,iValueId:integer;
  sItemId:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent.ClassName='TGroupBox' then iValueId:=TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent.Tag
  else iValueId:=ADO_dtl.fieldbyname('唯一编号').AsInteger;

  adotemp33:=tadoquery.Create(nil);
  adotemp33.Connection:=dm.ADOConnection1;
  adotemp33.Close;
  adotemp33.sql.clear;
  adotemp33.sql.Text:='select * from chk_valu where valueid=:valueid and Photo is not null ';
  adotemp33.Parameters.ParamByName('valueid').Value:=iValueId;
  adotemp33.Open;
  iHasPoto:=adotemp33.RecordCount;
  sItemId:=adotemp33.fieldbyname('ItemId').AsString;
  adotemp33.Free;
  if iHasPoto<=0 then exit;

  if (MessageDlg('确实要删除已存在的图片?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  if sItemId='Pure Photo' then//纯图片项目
  begin
    ExecSQLCmd(LisConn,'delete from chk_valu where valueid='+inttostr(iValueId));
  end else
  begin
    adotemp22:=tadoquery.Create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.sql.clear;
    adotemp22.sql.Text:='update chk_valu set Photo=:Photo where valueid=:valueid';
    adotemp22.Parameters.ParamByName('valueid').Value:=iValueId;
    adotemp22.Parameters.ParamByName('Photo').Value:=Unassigned;
    adotemp22.ExecSQL;
    adotemp22.Free;
  end;

  update_Ado_dtl;
  Ado_dtl.Locate('唯一编号',iValueId,[loCaseInsensitive]);
  ShowPictureValue(ADObasic.fieldbyname('唯一编号').AsInteger);
end;

procedure TSDIAppForm.N74Click(Sender: TObject);
var
  iValueId:integer;
begin
  if not ADO_dtl.Active then exit;
  if ADO_dtl.RecordCount<=0 then exit;

  if TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent.ClassName='TGroupBox' then iValueId:=TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent.Tag
  else iValueId:=ADO_dtl.fieldbyname('唯一编号').AsInteger;
  frmPhoto(iValueId).ShowModal;
end;

procedure TSDIAppForm.ADO_dtlBeforePost(DataSet: TDataSet);
var
  s1:string;
begin
  //以前用DBGrid2KeyPress事件处理(如下)，但下拉常见结果更改就无效了
  //procedure TSDIAppForm.DBGrid2KeyPress(Sender: TObject; var Key: Char);
  //begin
  //      if not checkman then
  //      begin
  //          key:=#0;
  //          MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
  //      end;
  //end;
  //add by liuying 20111121
  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    SendKeyToControl(27,DBGrid2);//ESC键
    abort;
  end;

  //判断组合项目的所属部门
  s1:=ScalarSQLCmd(LisConn,'select Department from combinitem where ID='''+ADO_dtl.fieldbyname('组合项目号').AsString+''' ');
  if (operator_DeptName<>s1) and (s1<>'') and (operator_ShowAllTj<>'是') then
  begin
    MESSAGEDLG('您所在的部门无权修改该组合项目!',MTINFORMATION,[MBOK],0);
    SendKeyToControl(27,DBGrid2);//ESC键
    abort;
  end;
end;

procedure TSDIAppForm.LoadToolMenu(const ToolMenuItem: TMenuItem;
  const ASel: string);
var
  adotemp3:tadoquery;
  delMenuItem,TempMenuItem:TMenuItem;
  tempstr:string;
  i,j:integer;
begin
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:=ASel;
  adotemp3.Open;

  //加载前先清除工具菜单项
  for j := ToolMenuItem.Count-1 downto 0 do
  begin
      if (ToolMenuItem.Items[j] is TMenuItem)then
      begin
        delMenuItem := ToolMenuItem.Items[j];
        if (delMenuItem <> nil) then FreeandNIl(delMenuItem);
      end;
  end;

  i:=0;
  while not adotemp3.Eof do
  begin
    inc(i);
    tempstr:=trim(adotemp3.fieldbyname('name').AsString);

    //加载到工具菜单
    TempMenuItem := TMenuItem.Create(self);
    TempMenuItem.Name := 'TmpTool' + inttostr(i);
    TempMenuItem.Caption := tempstr;
    TempMenuItem.OnClick:=miToolItemClick;
    ToolMenuItem.Add(TempMenuItem);

    adotemp3.Next;
  end;
  adotemp3.Free;
end;

procedure TSDIAppForm.miToolItemClick(Sender: TObject);
var
  adotemp3:tadoquery;
  Reserve,Reserve2:string;
begin
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='select Reserve,Reserve2 from CommCode where TypeName=''工具菜单'' and name='''+(Sender as TMenuItem).Caption+''' ';
  adotemp3.Open;
  Reserve:=adotemp3.fieldbyname('Reserve').AsString;
  Reserve2:=adotemp3.fieldbyname('Reserve2').AsString;
  adotemp3.Free;

  if Reserve2='1' then if not ifhaspower(sender,powerstr_js_main) then exit;

  if ShellExecute(Handle, 'Open', Pchar(ExtractFilePath(application.ExeName)+Reserve), '', '', SW_ShowNormal)<=32 then
    MessageDlg((Sender as TMenuItem).Caption+'('+Reserve+')打开失败!',mtError,[mbOK],0);
end;

procedure TSDIAppForm.ShowPictureValue(const ACheckUnid: integer);
var
  adotemp3:tadoquery;
  i,n,m,k:integer;
  GroupBox:array of TGroupBox;
  Chart:array of TChart;
  MS:tmemorystream;

  //血流变变量start
  Reserve8_1,Reserve8_2:single;//切变率
  mPa_1,mPa_2:string;//粘度
  mPa_min_1,mPa_min_2:string;//粘度
  mPa_max_1,mPa_max_2:string;//粘度
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
      'select ''绘点''   as PictureType,chk_valu.* from chk_valu where pkunid='+inttostr(ACheckUnid)+' and isnull(histogram,'''')<>'''' and issure=''1'' '+
      'union all '+
      'select ''图片''   as PictureType,chk_valu.* from chk_valu where pkunid='+inttostr(ACheckUnid)+' and Photo is not null and issure=''1'' '+
      'union all '+
      'select ''血流变'' as PictureType,chk_valu.* from chk_valu where pkunid='+inttostr(ACheckUnid)+' and Reserve8 is not null and issure=''1'' '+
    ' ) TempTable order by pkcombin_id,printorder ';
  adotemp3.Open;
  setlength(GroupBox,adotemp3.RecordCount);
  setlength(Chart,adotemp3.RecordCount);
  n:=0;m:=0;k:=-1;Reserve8_1:=-1;Reserve8_2:=-1;
  while not adotemp3.Eof do
  begin
    GroupBox[n]:=TGroupBox.Create(self);
    GroupBox[n].Parent:=ScrollBoxPicture;
    GroupBox[n].Left:=maxint;//使各个Panel按创建顺序排列
    GroupBox[n].Align:=alLeft;
    GroupBox[n].Width:=ScrollBoxPicture.Height;
    GroupBox[n].Caption:=adotemp3.FieldByName('name').AsString;
    GroupBox[n].Tag:=adotemp3.FieldByName('valueid').AsInteger;
    GroupBox[n].PopupMenu:=PopupMenu2;

    if adotemp3.FieldByName('PictureType').AsString='绘点' then
    begin
      Chart[n]:=TChart.Create(GroupBox[n]);//GroupBox负责释放Chart
      Chart[n].Parent:=GroupBox[n];
      Chart[n].Align:=alClient;
      updatechart(Chart[n],trim(adotemp3.FieldByName('histogram').AsString),adotemp3.FieldByName('english_name').AsString,adotemp3.FieldByName('Dosage1').AsString);
    end;

    if adotemp3.FieldByName('PictureType').AsString='图片' then
    begin
      if tblobfield(adotemp3.FieldByName('photo')).BlobSize <=0 then begin inc(n);adotemp3.Next;continue;end;
      
      MS:=TMemoryStream.Create;
      TBlobField(adotemp3.fieldbyname('photo')).SaveToStream(MS);
      MS.Position:=0;
      with TImage.Create(GroupBox[n]) do//GroupBox负责释放Image
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

    if adotemp3.FieldByName('PictureType').AsString='血流变' then
    begin
      inc(m);
      
      if m=1 then
      begin
        Reserve8_1:=adotemp3.fieldbyname('Reserve8').AsFloat;//切变率
        mPa_1:=adotemp3.fieldbyname('itemValue').AsString;//粘度
        mPa_min_1:=adotemp3.fieldbyname('Min_Value').AsString;//粘度
        mPa_max_1:=adotemp3.fieldbyname('Max_Value').AsString;//粘度
      end;
      
      if m=2 then
      begin
        Reserve8_2:=adotemp3.fieldbyname('Reserve8').AsFloat;//切变率
        mPa_2:=adotemp3.fieldbyname('itemValue').AsString;//粘度
        mPa_min_2:=adotemp3.fieldbyname('Min_Value').AsString;//粘度
        mPa_max_2:=adotemp3.fieldbyname('Max_Value').AsString;//粘度
        k:=n;
      end;
    end;

    inc(n);
    adotemp3.Next
  end;
  adotemp3.Free;

  if m=2 then//血流变
  begin
    Chart[k]:=TChart.Create(GroupBox[k]);//GroupBox负责释放Chart
    Chart[k].Parent:=GroupBox[k];
    Chart[k].Align:=alClient;
    Draw_MVIS2035_Curve(Chart[k],Reserve8_1,strtofloatdef(mPa_1,-1),Reserve8_2,strtofloatdef(mPa_2,-1),
                        Reserve8_1,strtofloatdef(mPa_min_1,-1),Reserve8_2,strtofloatdef(mPa_min_2,-1),
                        Reserve8_1,strtofloatdef(mPa_max_1,-1),Reserve8_2,strtofloatdef(mPa_max_2,-1));
  end;
end;

procedure TSDIAppForm.ShowBarcode2D(const ACheckUnid: integer);
var
  ss:string;
  adotemp3:tadoquery;
begin
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='select * from chk_con cc,chk_valu cv where cc.unid=cv.pkunid and cv.issure=1 and isnull(cv.itemvalue,'''')<>'''' and cc.unid='+inttostr(ACheckUnid);
  adotemp3.Open;
  ss:=ss+'姓名:'+adotemp3.fieldbyname('patientname').AsString+';';
  ss:=ss+'性别:'+adotemp3.fieldbyname('sex').AsString+';';
  ss:=ss+'年龄:'+adotemp3.fieldbyname('age').AsString+';';
  ss:=ss+'门诊/住院号:'+adotemp3.fieldbyname('Caseno').AsString+';';
  ss:=ss+'床号:'+adotemp3.fieldbyname('bedno').AsString+';';
  ss:=ss+'送检科室:'+adotemp3.fieldbyname('deptname').AsString+';';
  ss:=ss+'检查日期:'+adotemp3.fieldbyname('check_date').AsString+';';
  ss:=ss+'送检医生:'+adotemp3.fieldbyname('check_doctor').AsString+';';
  ss:=ss+'样本类型:'+adotemp3.fieldbyname('flagetype').AsString+';';
  ss:=ss+'临床诊断:'+adotemp3.fieldbyname('diagnose').AsString;
  ss:=ss+#13;
  while not adotemp3.Eof do
  begin
    ss:=ss+adotemp3.fieldbyname('name').AsString+':';
    ss:=ss+adotemp3.fieldbyname('itemvalue').AsString+' ';
    ss:=ss+adotemp3.fieldbyname('Unit').AsString;
    ss:=ss+#13;
    adotemp3.Next;
  end;
  adotemp3.Free;

  //BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  ImageBarcode2D.Canvas.FillRect(rect(0,0,ImageBarcode2D.Width,ImageBarcode2D.Height));
  //Create 2D Barcode
  CreateQRCode(ss, 0, 0, 3,ImageBarcode2D.Canvas.Handle);
end;

procedure TSDIAppForm.BitBtn1Click(Sender: TObject);
var
  s1:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit; //权限检查

  if not ADO_dtl.Active then exit;
  if ADO_dtl.RecordCount<=0 then exit;

  //判断组合项目的所属部门
  s1:=ScalarSQLCmd(LisConn,'select Department from combinitem where ID='''+ADO_dtl.fieldbyname('组合项目号').AsString+''' ');
  if (operator_DeptName<>s1) and (s1<>'') and (operator_ShowAllTj<>'是') then
  begin
    MESSAGEDLG('您所在的部门无权修改该组合项目!',MTINFORMATION,[MBOK],0);
    exit;
  end;  

  ExecSQLCmd(LisConn,'update chk_valu set itemvalue='''+meValueDesc.Text+''' where valueid='+ADO_dtl.fieldbyname('唯一编号').AsString);

  ADO_dtl.Refresh;//更新显示DBGRID中的结果
end;

procedure TSDIAppForm.BitBtn2Click(Sender: TObject);
begin
  frmXDepict(2).Show;
end;

procedure TSDIAppForm.N29Click(Sender: TObject);
var
  adotemp11:Tadoquery;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  if not ifhaspower(sender,powerstr_js_main) then exit; //权限检查

  if (MessageDlg('确定要为当前界面的所有体检者生成体检结论？', mtWarning, [mbYes, mbNo], 0) <> mrYes) then exit;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.clone(ADObasic);
  while not adotemp11.Eof do
  begin

    ExecSQLCmd(LisConn,'update chk_con set Weight=''待生成'' where unid='+adotemp11.fieldbyname('唯一编号').AsString+' and isnull(Weight,'''')<>''待生成'' ');

    adotemp11.Next;
  end;
  adotemp11.Free;
end;

procedure TSDIAppForm.N76Click(Sender: TObject);
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  if not ifhaspower(sender,powerstr_js_main) then exit; //权限检查

  if (MessageDlg('确定要为当前体检者生成体检结论？', mtWarning, [mbYes, mbNo], 0) <> mrYes) then exit;

  ExecSQLCmd(LisConn,'update chk_con set Weight=''待生成'' where unid='+ADObasic.fieldbyname('唯一编号').AsString+' and isnull(Weight,'''')<>''待生成'' ');
end;

procedure TSDIAppForm.lbedtifMarryExit(Sender: TObject);
begin
    if trim(TLabeledEdit(Sender).Text)='0' then TLabeledEdit(Sender).Text:='未婚' else
    if trim(TLabeledEdit(Sender).Text)='2' then TLabeledEdit(Sender).Text:='不确定' else
    if (trim(TLabeledEdit(Sender).Text)<>'未婚') and (trim(TLabeledEdit(Sender).Text)<>'不确定')
      and (trim(TLabeledEdit(Sender).Text)<>'') then TLabeledEdit(Sender).Text:='已婚';
end;

procedure TSDIAppForm.lbedtWorkCompanyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.OpenStr:='select name as 名称,ID AS 代码 from CommCode where TypeName=''所属公司'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=tLabeledEdit(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=tLabeledEdit(SENDER).ClientToScreen(Point(0, tLabeledEdit(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
end;

procedure TSDIAppForm.lbedtWorkDepartmentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.OpenStr:='select name as 名称,ID AS 代码 from CommCode where TypeName=''所属部门'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=tLabeledEdit(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=tLabeledEdit(SENDER).ClientToScreen(Point(0, tLabeledEdit(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
end;

procedure TSDIAppForm.lbedtWorkCategoryKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.OpenStr:='select name as 名称,ID AS 代码 from CommCode where TypeName=''工种'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=tLabeledEdit(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=tLabeledEdit(SENDER).ClientToScreen(Point(0, tLabeledEdit(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
end;

procedure TSDIAppForm.LabeledEdit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select name as 名称,id as 代码 from CommCode where TypeName=''性别'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=tLabeledEdit(SENDER).ClientToScreen(Point(0, 0)).X;//left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=tLabeledEdit(SENDER).ClientToScreen(Point(0, tLabeledEdit(SENDER).Height)).Y;//top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
  {//国家标准性别代码
  if trim(TLabeledEdit(Sender).Text)='0' then TLabeledEdit(Sender).Text:='未知的性别' else
  if trim(TLabeledEdit(Sender).Text)='1' then TLabeledEdit(Sender).Text:='男' else
  if trim(TLabeledEdit(Sender).Text)='2' then TLabeledEdit(Sender).Text:='女' else
  if trim(TLabeledEdit(Sender).Text)='5' then TLabeledEdit(Sender).Text:='女变男' else
  if trim(TLabeledEdit(Sender).Text)='6' then TLabeledEdit(Sender).Text:='男变女' else
  if trim(TLabeledEdit(Sender).Text)='9' then TLabeledEdit(Sender).Text:='未说明的性别';
  }
end;

procedure TSDIAppForm.MakeCombinChecklistbox;
var
  adotemp3:tadoquery;
  ini:tinifile;
  bNoCommUsed:boolean;

  SS:STRING;
begin
     clbCommUsed.Items.Clear;
     clbNoCommUsed.Items.Clear;

     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:='select id,name from combinitem where sysname='''+SYSNAME+''' order by id';
     adotemp3.Open;
     while not adotemp3.Eof do
     begin
      SS:=trim(adotemp3.fieldbyname('id').AsString);
      
      if SS='' THEN bNoCommUsed:=FALSE
      else begin
        ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
        bNoCommUsed:=ini.ReadBool('备用组合项目',SS,false);//如果SS='',则ReadBool会报错ntdll.dll
        ini.Free;
      end;

      if bNoCommUsed then
        clbNoCommUsed.Items.Add(trim(adotemp3.fieldbyname('id').AsString)+'   '+adotemp3.fieldbyname('name').AsString)
      else clbCommUsed.Items.Add(trim(adotemp3.fieldbyname('id').AsString)+'   '+adotemp3.fieldbyname('name').AsString);
      
      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure TSDIAppForm.N17Click(Sender: TObject);
VAR
  ini:tinifile;
  i:integer;
  s2:string;
  b:integer;
  CheckListBox:TCheckListBox;
begin
  if not (((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent is TCheckListBox) then
  begin
    MESSAGEDLG('"移除"功能异常,请联系软件开发商!',mtError,[MBOK],0);
    exit;
  end;
  
  CheckListBox:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TCheckListBox;

  if CheckListBox.Items.Count<=0 then exit;
  
  i:=CheckListBox.ItemIndex;
  if i<0 then
  begin
    MESSAGEDLG('请选择要移除的组合项目!',mtWarning,[MBOK],0);
    exit;
  end;

  s2:=CheckListBox.Items.Strings[i];
  b:=pos('   ',s2);
  s2:=copy(s2,1,b-1);

  if s2='' then//如果s2='',则WriteBool、DeleteKey会报错ntdll.dll
  begin
    MESSAGEDLG('组合项目代码为空,不能移除!',mtError,[MBOK],0);
    exit;
  end;

  if SameText(CheckListBox.Name,'clbCommUsed') then
  begin
      ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
      INI.WriteBool('备用组合项目',s2,TRUE);
      ini.Free;
  end else
  begin
      ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
      INI.DeleteKey('备用组合项目',s2);
      ini.Free;
  end;

        //=============更新主界面的组合项目CheckListBox=======================//
        MakeCombinChecklistbox;
        CheckTheListBox;
        //====================================================================//
end;

procedure TSDIAppForm.N75Click(Sender: TObject);
var
  Nname,Ssex,Qitemid,QitemName,Cbirthday:string;
  adotemp11,adotemp66:tadoquery;
  sHistorySeries,sCurSeries,Cage,Creport_date,sMin_value,sMax_value:string;
  //sHistorySeries格式:项目名称#$1当前结果日期#$2当前结果#$3历史结果1日期#$2历史结果1#$3...历史结果n日期#$2历史结果n#$3
  ifHasHistoricalValue:boolean;
  Save_Cursor:TCursor;
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  if not ADO_dtl.Active then exit;
  if ADO_dtl.RecordCount=0 then exit;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select dbo.uf_ifHasHistoricalValue('+ADO_dtl.fieldbyname('唯一编号').AsString+') as ifHasHistoricalValue ';
  adotemp11.Open;
  ifHasHistoricalValue:=adotemp11.fieldbyname('ifHasHistoricalValue').AsBoolean;
  adotemp11.Free;

  if not ifHasHistoricalValue then//用该自定义函数判断是否有历史结果
  begin
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
    exit;
  end;

  //=====================当前病人的基本信息===================================//
  Qitemid:=trim(ADO_dtl.fieldbyname('项目编号').AsString);
  QitemName:=trim(ADO_dtl.fieldbyname('名称').AsString);
  Nname:=trim(ADObasic.fieldbyname('姓名').AsString);
  Ssex:=trim(ADObasic.fieldbyname('性别').AsString);
  Creport_date:=ADObasic.fieldbyname('申请日期').AsString;
  Cage:=trim(ADObasic.fieldbyname('年龄').AsString);
  //==========================================================================//

  //=================当前病人的生日===========================================//
  Cbirthday:=ScalarSQLCmd(LisConn,'select dbo.uf_GetBirthday('''+Cage+''','''+Creport_date+''') as Cbirthday ');
  //==========================================================================//

  //=====================当前病人的参考范围===================================//
  sMin_value:=trim(ADO_dtl.fieldbyname('最小值').AsString);
  sMax_value:=trim(ADO_dtl.fieldbyname('最大值').AsString);
  //==========================================================================//

  sCurSeries:=QitemName+#$1+trim(ADObasic.fieldbyname('检查日期').AsString)+#$2+trim(ADO_dtl.fieldbyname('检验结果').AsString)+#$3;
  sHistorySeries:=sCurSeries;

  adotemp66:=tadoquery.Create(nil);
  adotemp66.Connection:=DM.ADOConnection1;
  adotemp66.SQL.Clear;
  //该SQL语句与dbo.uf_ifHasHistoricalValue中的相应语句相同
  adotemp66.SQL.Text:='select z.check_date,f.itemvalue from chk_con_bak Z,chk_valu_bak F '+
   'where z.unid=f.pkunid and '+
   'z.patientname='''+Nname+''' and '+
   'z.sex='''+Ssex+''' and '+
   'datepart(yyyy,dbo.uf_GetBirthday(z.age,z.report_date))=datepart(yyyy,'''+Cbirthday+''') and '+
   'f.itemid='''+Qitemid+''' and '+
   'z.check_date is not null and '+
   'z.check_date<>'''' and '+
   'z.check_date<>0 and '+
   'f.itemvalue is not null and '+
   'f.itemvalue<>'''' '+
   ' order by z.check_date desc ';//隐藏了LEGEND，故需此句来按顺序手动显示文字说明
  adotemp66.Open;
  while not adotemp66.Eof do
  begin
    sHistorySeries:=sHistorySeries+trim(adotemp66.fieldbyname('check_date').AsString)+#$2+trim(adotemp66.fieldbyname('itemvalue').AsString)+#$3;
    adotemp66.Next;
  end;
  adotemp66.Free;

  Screen.Cursor := Save_Cursor;  { Always restore to normal }

  if sHistorySeries<>sCurSeries then//有历史结果则显示出来,但不一定有曲线（非数字结果无曲线）
    frmHistoryResult(sHistorySeries,sMin_value,sMax_value).ShowModal;
end;

procedure TSDIAppForm.TimerMakeTjDescriptionTimer(Sender: TObject);
begin
  LYLed2.Value:='1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_con WITH(NOLOCK) where Weight=''待生成'' ',False);
end;

procedure TSDIAppForm.N85Click(Sender: TObject);
begin
  frmModifyPwd.ShowModal;
end;

procedure TSDIAppForm.FormActivate(Sender: TObject);
VAR
  adotemp11:tadoquery;
  i:integer;
  d1:TDate;
begin
  if not bFirstOverWorkTips then exit;//让下面的提示只出现一次
  bFirstOverWorkTips:=false;

  //【结束当批检验工作】功能提示begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.clone(ADObasic);
  i:=adotemp11.RecordCount;
  d1:=adotemp11.FieldByName('检查日期').AsDateTime;
  adotemp11.Free;
  if (i>1000)and(now()-d1>40)then
    MESSAGEDLG('当前界面的验单这么多,不影响您的正常工作吗!!!'+#$D+'尝试使用【信息录入->结束当批检验工作】,可以将已审核的验单转入历史库',MTINFORMATION,[MBOK],0);
  //【结束当批检验工作】功能提示end
end;

procedure TSDIAppForm.N19Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmEquipManage.ShowModal;
end;

procedure TSDIAppForm.N32Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmSJ_JBXX.ShowModal;
end;

procedure TSDIAppForm.TimerCriticalValueTimer(Sender: TObject);
begin
  if LYLed1.Value then exit;
  
  LYLed1.Value:='1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from Chk_Con cc WITH(NOLOCK),chk_valu cv WITH(NOLOCK) where cc.unid=cv.pkunid and cc.check_date>getdate()-7 and isnull(cc.TjXinDianTu,'''')='''' and dbo.uf_CriticalValueAlarm(cv.itemid,cc.sex,cc.age,cv.itemvalue)=1',False);
end;

procedure TSDIAppForm.LYLed1DblClick(Sender: TObject);
begin
  frmCriticalValueDetail.ShowModal;
end;

procedure TSDIAppForm.SpeedButton2Click(Sender: TObject);
var
  strsqlPrint:string;
  sUnid,sReport_Doctor,sCombin_Id:string;
  
  //对姓别性别年龄的合并项做打印标记 变量
  sPatientname,sSex,sAge:string;
  //===============================

  frxMasterData:TfrxMasterData;  
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  sReport_Doctor:=trim(ADObasic.FieldByName('审核者').AsString);
  sCombin_Id:=adobasic.FieldByName('组别').AsString;

  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;
  
  if not ifAutoCheck then  //打印前要检查是否已被审核
  begin
    if sReport_Doctor='' then
    begin
      MessageBox(Handle, '请先审核！', '系统提示', MB_ICONASTERISK);
      exit;
    end;
  end;
  
  DM.frxReport1.Clear;//清除报表模板
  DM.frxDBDataSet1.UserName:='ADObasic';//加载模板文件前设置别名.因为一般设计模板文件时已经包含了别名信息
  DM.frxDBDataSet2.UserName:='ADO_print';//加载模板文件前设置别名.因为一般设计模板文件时已经包含了别名信息

  if (sCombin_Id=WorkGroup_T1)
    and DM.frxReport1.LoadFromFile(TempFile_T1) then//加载模板文件是不区分大小写的.空字符串将加载失败
  begin
  end else
  if (sCombin_Id=WorkGroup_T2)
    and DM.frxReport1.LoadFromFile(TempFile_T2) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T3)
    and DM.frxReport1.LoadFromFile(TempFile_T3) then
  begin
  end else
  if not DM.frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_cur.fr3') then
  begin
    showmessage('加载默认通用打印模板report_cur.fr3失败，请设置:系统设置->选项->打印模板');
    exit;
  end;

    strsqlPrint:='select itemid as 项目代码,name as 名称,english_name as 英文名,'+
          ' itemvalue as 检验结果,'+
          ' min_value as 最小值,max_value as 最大值,'+
          ' dbo.uf_Reference_Value_B1(chk_valu.min_value,chk_valu.max_value) as 前段参考范围,dbo.uf_Reference_Value_B2(chk_valu.min_value,chk_valu.max_value) as 后段参考范围,'+
          ' unit as 单位,min(printorder) as 打印编号,'+
          ' min(pkcombin_id) as 组合项目号, '+
          ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
          ' from chk_valu WITH(NOLOCK) where pkunid='+sUnid+
          ' and chk_valu.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
          ' group by itemid,name,english_name,itemvalue,min_value,max_value,unit, '+
          ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
          ' order by 组合项目号,打印编号 ';
  ado_print.Close;
  ado_print.SQL.Clear;
  ado_print.SQL.Text:=strsqlPrint;
  ado_print.Open;
  if (ADO_print.RecordCount=0) and (not ifNoResultPrint) then exit;

  {if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    frxReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm}

  DM.frxDBDataSet1.DataSet:=ADObasic;//关联Fastreport的组件与TDataset数据集
  DM.frxDBDataSet2.DataSet:=ADO_print;//关联Fastreport的组件与TDataset数据集
  DM.frxReport1.DataSets.Clear;//清除原来的数据集
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet1);//加载关联好的TfrxDBDataSet到报表中
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet2);//加载关联好的TfrxDBDataSet到报表中
  
  frxMasterData:=DM.frxReport1.FindObject('MasterData1') as TfrxMasterData;
  if (frxMasterData<>nil) and (frxMasterData is TfrxMasterData) then frxMasterData.DataSet:=DM.frxDBDataSet2;//动态配置MasterData.DataSet
      
  if n9.Checked then  //预览模式
  begin
    DM.frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;
    DM.frxReport1.ShowReport;
  end;
  if n8.Checked then  //直接打印模式
  begin
    if DM.frxReport1.PrepareReport then begin DM.frxReport1.PrintOptions.ShowDialog:=false;DM.frxReport1.Print;end;
  end;
end;

procedure TSDIAppForm.SpeedButton8Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sReport_Doctor,sCombin_Id:string;

  sPatientname,sSex,sAge:string;

  frxMasterData:TfrxMasterData;  
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  sReport_Doctor:=trim(ADObasic.FieldByName('审核者').AsString);
  sCombin_Id:=adobasic.FieldByName('组别').AsString;

  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;

  if not ifAutoCheck then  //打印前要检查是否已被审核
  begin
    if sReport_Doctor='' then
    begin
      MessageBox(Handle, '请先审核！', '系统提示', MB_ICONASTERISK);
      exit;
    end;
  end;

  DM.frxReport1.Clear;//清除报表模板
  DM.frxDBDataSet1.UserName:='ADObasic';//加载模板文件前设置别名.因为一般设计模板文件时已经包含了别名信息
  DM.frxDBDataSet2.UserName:='ADO_print';//加载模板文件前设置别名.因为一般设计模板文件时已经包含了别名信息

  if (sCombin_Id=GP_WorkGroup_T1)
    and DM.frxReport1.LoadFromFile(GP_TempFile_T1) then//加载模板文件是不区分大小写的.空字符串将加载失败
  begin
  end else
  if (sCombin_Id=GP_WorkGroup_T2)
    and DM.frxReport1.LoadFromFile(GP_TempFile_T2) then
  begin
  end else
  if (sCombin_Id=GP_WorkGroup_T3)
    and DM.frxReport1.LoadFromFile(GP_TempFile_T3) then
  begin
  end else
  if not DM.frxReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_Cur_group.fr3') then
  begin
    showmessage('加载默认分组打印模板report_Cur_group.fr3失败，请设置:系统设置->选项->打印模板');
    exit;
  end;

    strsqlPrint:='select cv.combin_name as name,cv.name as 名称,cv.english_name as 英文名,cv.itemvalue as 检验结果,'+
    'cv.unit as 单位,cv.min_value as 最小值,cv.max_value as 最大值,'+
    ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as 前段参考范围,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as 后段参考范围,'+
    ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10, '+
    ' cv.itemid as 项目代码 '+//cci.Reserve3,
    ' from chk_valu cv WITH(NOLOCK) '+
    ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
    ' where cv.pkunid='+sUnid+
    ' and cv.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
    ' order by cv.pkcombin_id,cv.printorder ';//组合项目号,打印编号 '
  ADO_print.Close;
  ADO_print.SQL.Clear;
  ADO_print.SQL.Text:=strsqlPrint;
  ADO_print.Open;
  if (ADO_print.RecordCount=0) and (not ifNoResultPrint) then exit;

  {if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm}

  DM.frxDBDataSet1.DataSet:=ADObasic;//关联Fastreport的组件与TDataset数据集
  DM.frxDBDataSet2.DataSet:=ADO_print;//关联Fastreport的组件与TDataset数据集
  DM.frxReport1.DataSets.Clear;//清除原来的数据集
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet1);//加载关联好的TfrxDBDataSet到报表中
  DM.frxReport1.DataSets.Add(DM.frxDBDataSet2);//加载关联好的TfrxDBDataSet到报表中
  
  frxMasterData:=DM.frxReport1.FindObject('MasterData1') as TfrxMasterData;
  if (frxMasterData<>nil) and (frxMasterData is TfrxMasterData) then frxMasterData.DataSet:=DM.frxDBDataSet2;//动态配置MasterData.DataSet
      
  if n9.Checked then  //预览模式
  begin
    DM.frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;
    DM.frxReport1.ShowReport;
  end;
  if n8.Checked then  //直接打印模式
  begin
    if DM.frxReport1.PrepareReport then begin DM.frxReport1.PrintOptions.ShowDialog:=false;DM.frxReport1.Print;end;
  end;
end;

procedure TSDIAppForm.N6Click(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := true;
end;

procedure TSDIAppForm.N24Click(Sender: TObject);
begin
  (Sender as TMenuItem).Checked := true;
end;

procedure TSDIAppForm.LabeledEdit12DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''优先级别'' ');
end;

procedure TSDIAppForm.LabeledEdit4DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''性别'' ');
end;

procedure TSDIAppForm.LabeledEdit6DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''部门'' ');
end;

procedure TSDIAppForm.LabeledEdit10DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from worker WITH(NOLOCK)');
end;

procedure TSDIAppForm.LabeledEdit8DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''样本类型'' ');
end;

procedure TSDIAppForm.LabeledEdit9DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''样本状态'' ');
end;

procedure TSDIAppForm.cbxConnCharDropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select name from CommCode WITH(NOLOCK) where TypeName=''检验组别'' AND SysName='''+SYSNAME+''' group by name');
end;

procedure TSDIAppForm.SpeedButton3Click(Sender: TObject);
begin
  MessageDlg('年龄默认单位是岁'+#$D+'单位快速录入方式：Y-岁,M-月,D-天,H-小时',mtInformation,[MBOK],0);
end;

end.
