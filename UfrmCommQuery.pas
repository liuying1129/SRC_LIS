unit UfrmCommQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,ADODB,StrUtils,
  Series, Chart,
  UADOLYQuery,ComObj,Jpeg, Menus,inifiles,Printers, ULYDataToExcel,
  frxClass;

type
  TfieldList=array of string;
  
type
  TfrmCommQuery = class(TForm)
    pnlCommQryTop: TPanel;
    DBGridResult: TDBGrid;
    pnlCommQryBotton: TPanel;
    BitBtnCommQry: TBitBtn;
    BitBtnCommQryClose: TBitBtn;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADObasic: TADOQuery;
    ADO_print: TADOQuery;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    LYQuery1: TADOLYQuery;
    MasterDataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Label3: TLabel;
    N4: TMenuItem;
    Excel1: TMenuItem;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    LYDataToExcel1: TLYDataToExcel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure BitBtnCommQryCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Excel1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmCommQuery: TfrmCommQuery;

function frmCommQuery:TfrmCommQuery;    {动态创建窗体函数}

implementation
uses  UDM,SDIMAIN;

const
  //明细sql语句，查询、导出到EXCEL中均要用到，故定义为单元的全局变量
  MXSqlstr1='select name 名称,english_name as 英文名,itemvalue as 检验结果,unit as 单位,'+
          ' min_value as 最小值,max_value as 最大值,printorder as 打印编号,'+
          ' issure as 是否确认,itemid as 项目编号,pkcombin_id as 组合项目号,'+
          ' valueid as 唯一编号,pkunid as 基本信息唯一编号,IsEdited as 修改标志 from chk_valu_bak ';
  MXSqlstr2=' order by 基本信息唯一编号,组合项目号,打印编号 ';


var
  ffrmCommQuery:TfrmCommQuery;           {本地的窗体变量,供关闭窗体释放内存时调用}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmCommQuery:TfrmCommQuery;    {动态创建窗体函数}
begin
  if ffrmCommQuery=nil then ffrmCommQuery:=TfrmCommQuery.Create(application.mainform);
  result:=ffrmCommQuery;
end;

procedure TfrmCommQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCommQuery=self then ffrmCommQuery:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmCommQuery.BitBtnCommQryClick(Sender: TObject);
var
  sqlstr1:string;
  Save_Cursor:TCursor;
begin
  sqlstr1:='select lsh as 流水号,checkid as 联机号,caseno as 病历号,check_date as 检查日期,patientname as 姓名,'+
    'sex as 性别,'+
    'age as 年龄,bedno as 床号,deptname as 送检科室,'+
    'check_doctor as 送检医生,report_date as 申请日期,operator as 操作者,report_doctor as 审核者,Audit_Date as 审核时间,'+
    '(case when printtimes>0 then ''√'' end) as 打印,'+
    'diagnosetype as 优先级别,combin_id as 组别,'+
    'flagetype as 样本类型,typeflagcase as 样本情况,diagnose as 临床诊断,'+
    'issure as 备注,germname as 细菌,'+
    ' WorkCompany as 所属公司,WorkDepartment as 所属部门,WorkCategory as 工种,WorkID as 工号,ifMarry as 婚否,OldAddress as 籍贯,Address as 住址,Telephone as 电话, '+
    ' PushPress as 样本送交人,PullPress as 样本接收人,LeftEyesight as 左眼视力,RightEyesight as 右眼视力,Stature as 样本接收时间,Weight as 单据状态, '+
    ' TjJiWangShi as 既往史,TjJiaZuShi as 家族史,TjNeiKe as 内科,TjWaiKe as 外科,TjWuGuanKe as 五官科,TjFuKe as 妇科,TjLengQiangGuang as 冷强光,TjXGuang as X光,TjBChao as 危急值报告时间,TjXinDianTu as 危急值报告人,TjJianYan as 条码号,'+
    ' TjDescription as 结论,TJAdvice as 建议, '+
    ' printtimes as 打印次数,unid as 唯一编号 '+
    ' from chk_con_bak order by unid';
  
  lyquery1.Connection:=DM.ADOConnection1;
  lyquery1.SelectString:=sqlstr1;
  if lyquery1.Execute then
  begin
    ADObasic.SQL.Text:=lyquery1.ResultSelect;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    { Show hourglass cursor }
    try
      ADObasic.Open;
    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;
  end;
end;

procedure TfrmCommQuery.BitBtnCommQryCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCommQuery.FormCreate(Sender: TObject);
begin
  ADObasic.Connection:=DM.ADOConnection1;
  ADOQuery1.Connection:=DM.ADOConnection1;
  ADO_PRINT.Connection:=DM.ADOConnection1;
end;

procedure TfrmCommQuery.BitBtn2Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  dbgridresult.ReadOnly:=false;
end;

procedure TfrmCommQuery.BitBtn4Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  dbgrid1.ReadOnly:=false;

end;

procedure TfrmCommQuery.ADObasicAfterScroll(DataSet: TDataSet);
const
  sqlstr1=' where pkunid=:pkunid and issure=1 ';
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=MXSqlstr1+sqlstr1+MXSqlstr2;
  ADOQuery1.Parameters.ParamByName('pkunid').Value:=
    masterDataSource.DataSet.fieldbyname('唯一编号').AsInteger;
  ADOQuery1.Open;
end;

procedure TfrmCommQuery.ADObasicAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
    VisibleColumn(dbgridresult,'唯一编号',false);
    for i :=0  to dbgridresult.Columns.Count-1 do
    begin
       dbgridresult.Columns[i].Width:=55;
       if (i=2)or(i=3)or(i=10)or(i=13) then dbgridresult.Columns[i].Width:=70;//病历号,检查日期,申请日期,审核时间
    end;

    label2.Caption:=inttostr(DataSet.RecordCount);//显示人次
end;

procedure TfrmCommQuery.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
    VisibleColumn(dbgrid1,'打印编号',false);
    VisibleColumn(dbgrid1,'是否确认',false);
    VisibleColumn(dbgrid1,'项目编号',false);
    VisibleColumn(dbgrid1,'组合项目号',false);
    VisibleColumn(dbgrid1,'项目编号',false);
    VisibleColumn(dbgrid1,'基本信息唯一编号',false);
    for i :=0  to dbgrid1.Columns.Count-1 do
    begin
       dbgrid1.Columns[i].Width:=65;
    end;
end;

procedure TfrmCommQuery.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  ItemChnName,IsEdited:string;
  cur_value:string;
  min_value:string; 
  max_value:string; 
  i:integer;
  adotemp22:Tadoquery;
begin
  //======================检验结果超出参考范围时变化颜色======================//
  if (datacol=2) then
  begin
    ItemChnName:=trim(ADOQuery1.fieldbyname('项目编号').AsString);
    cur_value:=trim(ADOQuery1.fieldbyname('检验结果').AsString);
    min_value:=trim(ADOQuery1.fieldbyname('最小值').AsString);
    max_value:=trim(ADOQuery1.fieldbyname('最大值').AsString);

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

  //======================修改过的检验结果变化颜色============================//
  if (datacol=2) then
  begin
    IsEdited:=ADOQuery1.fieldbyname('修改标志').AsString;
    if IsEdited='1' then
    begin
      (Sender as TDBGrid).Canvas.Pen.Color := clRed; //定义画笔颜色(绿色)
      (Sender as TDBGrid).Canvas.MoveTo(Rect.Right, Rect.Top); //画笔定位
      (Sender as TDBGrid).Canvas.LineTo(Rect.Right, Rect.Bottom); //画绿色的竖线
    end; 
  end;
  //==========================================================================//
end;

{//体检结果录入菜单
procedure TfrmCommQuery.N1Click(Sender: TObject);
TYPE
  TDLLProc=function(AHandle:THandle;ABasicDs:TAdoquery;AImeName:Pchar;AifCurTab:boolean;AOperator_ID:Pchar):boolean;stdcall;
VAR
  DLLProc:TDLLProc;
  HTJLIB:THandle;
  
  ConfigIni:tinifile;
  StrImeName:string;
  FExecute:boolean;
  ff:integer;
begin
  if not ifhaspower(BitBtn2,powerstr_js_main) then exit;//权限与"修改基本信息"按钮的权限一样

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
  FExecute:=DLLProc(Application.Handle,ADObasic,Pchar(StrImeName),false,Pchar(operator_id));
  FreeLIBRARY(HTJLIB);

  if FExecute then
  begin
    ff:=adobasic.fieldbyname('唯一编号').AsInteger;
    ADObasic.Requery();//刷新
    adobasic.Locate('唯一编号',ff,[loCaseInsensitive]);
  end;
end;//}

procedure TfrmCommQuery.Excel1Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= ADObasic;
  //LYDataToExcel1.ExcelTitel:=BBBT;
  LYDataToExcel1.Execute;
end;

procedure TfrmCommQuery.BitBtn6Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sCombin_Id:string;

  //对姓别性别年龄的合并项做打印标记 变量
  sPatientname,sSex,sAge,sCheck_Date:string;
  //===============================  

  frxMasterData:TfrxMasterData;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  sCombin_Id:=adobasic.FieldByName('组别').AsString;  

  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('检查日期').AsDateTime);
  
  DM.frxReport1.Clear;//清除报表模板
  DM.frxDBDataSet1.UserName:='ADObasic';//加载模板文件前设置别名.因为一般设计模板文件时已经包含了别名信息
  DM.frxDBDataSet2.UserName:='ADO_print';//加载模板文件前设置别名.因为一般设计模板文件时已经包含了别名信息

  if (sCombin_Id=WorkGroup_T1)
    and (DM.frxReport1.LoadFromFile(TempFile_T1)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T2)
    and (DM.frxReport1.LoadFromFile(TempFile_T2)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T3)
    and (DM.frxReport1.LoadFromFile(TempFile_T3)) then
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
            ' dbo.uf_Reference_Value_B1(min_value,max_value) as 前段参考范围,dbo.uf_Reference_Value_B2(min_value,max_value) as 后段参考范围,'+
            ' unit as 单位,min(printorder) as 打印编号,'+
            ' min(pkcombin_id) as 组合项目号, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' from chk_valu_bak '+
            ' where pkunid='+sUnid+
            ' and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
            ' group by itemid,name,english_name,itemvalue,min_value,max_value,unit, '+
            ' Reserve1,Reserve2,Dosage1,Dosage2,Reserve5,Reserve6,Reserve7,Reserve8,Reserve9,Reserve10 '+
            ' order by 组合项目号,打印编号 ';
    ado_print.Close;
    ado_print.SQL.Clear;
    ado_print.SQL.Text:=strsqlPrint;
    ado_print.Open;
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
      
  if sdiappform.n9.Checked then  //预览模式
  begin
    DM.frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;
    DM.frxReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //直接打印模式
  begin
    if DM.frxReport1.PrepareReport then begin DM.frxReport1.PrintOptions.ShowDialog:=false;DM.frxReport1.Print;end;
  end;
end;

procedure TfrmCommQuery.BitBtn7Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid:string;

  sPatientname,sSex,sAge,sCheck_Date,sCombin_Id:string;

  frxMasterData:TfrxMasterData;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  
  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('检查日期').AsDateTime);
  sCombin_Id:=adobasic.FieldByName('组别').AsString;
  
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
    ' from chk_valu_bak cv '+
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
      
  if sdiappform.n9.Checked then  //预览模式
  begin
    DM.frxReport1.PrintOptions.ShowDialog:=ifShowPrintDialog;
    DM.frxReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //直接打印模式
  begin
    if DM.frxReport1.PrepareReport then begin DM.frxReport1.PrintOptions.ShowDialog:=false;DM.frxReport1.Print;end;
  end;
end;

initialization
  ffrmCommQuery:=nil;
end.
