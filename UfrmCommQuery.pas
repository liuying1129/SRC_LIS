unit UfrmCommQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,ADODB,StrUtils,
  FR_DSet, FR_DBSet, FR_Class, TeEngine, Series, TeeProcs, Chart,fr_chart,
  UADOLYQuery,ComObj,Jpeg, Menus,inifiles,Printers, ULYDataToExcel;

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
    BitBtn1: TBitBtn;
    frReport1: TfrReport;
    ADObasic: TADOQuery;
    frDBDataSet2: TfrDBDataSet;
    ADO_print: TADOQuery;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    LYQuery1: TADOLYQuery;
    MasterDataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Label3: TLabel;
    BitBtn5: TBitBtn;
    RadioGroup1: TRadioGroup;
    LYDataToExcel1: TLYDataToExcel;
    N4: TMenuItem;
    Excel1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure BitBtnCommQryCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure frReport1BeforePrint(Memo: TStringList; View: TfrView);
    procedure BitBtn5Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure frReport1PrintReport;
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
    'check_doctor as 送检医生,operator as 操作者,report_doctor as 审核者,Audit_Date as 审核时间,'+
    'report_date as 申请日期,'+
    'diagnosetype as 优先级别,combin_id as 组别,'+
    'flagetype as 样本类型,typeflagcase as 样本情况,diagnose as 临床诊断,'+
    'issure as 备注,germname as 细菌,'+
    ' WorkCompany as 所属公司,WorkDepartment as 所属部门,WorkCategory as 工种,WorkID as 工号,ifMarry as 婚否,OldAddress as 籍贯,Address as 住址,Telephone as 电话, '+
    ' PushPress as 舒张压,PullPress as 收缩压,LeftEyesight as 左眼视力,RightEyesight as 右眼视力,Stature as 身高,Weight as 体重, '+
    ' TjJiWangShi as 既往史,TjJiaZuShi as 家族史,TjNeiKe as 内科,TjWaiKe as 外科,TjWuGuanKe as 五官科,TjFuKe as 妇科,TjLengQiangGuang as 冷强光,TjXGuang as X光,TjBChao as B超,TjXinDianTu as 心电图,TjJianYan as 检验,TjDescription as 结论,TJAdvice as 建议, '+
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

procedure TfrmCommQuery.BitBtn1Click(Sender: TObject);
var
  strsqlPrint:string;

  sUnid,sCombin_Id:string;

  //对姓别性别年龄的合并项做打印标记 变量
  sPatientname,sSex,sAge,sCheck_Date:string;
  //===============================  

  i,j:integer;
  mvPictureTitle:TfrMemoView;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  sCombin_Id:=adobasic.FieldByName('组别').AsString;  

  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('检查日期').AsDateTime);
  
  if (sCombin_Id=WorkGroup_T1)
    and (frReport1.LoadFromFile(TempFile_T1)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T2)
    and (frReport1.LoadFromFile(TempFile_T2)) then
  begin
  end else
  if (sCombin_Id=WorkGroup_T3)
    and (frReport1.LoadFromFile(TempFile_T3)) then
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
        if uppercase(leftstr(TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name,7))='PICTURE' then
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
  
  if (SDIAppForm.N64.Checked)and(sPatientname<>'') then//按姓别性别年龄合并打印//只有存在姓名时才合并
    strsqlPrint:='select cv.itemid as 项目代码,cv.name as 名称,cv.english_name as 英文名,'+
          ' cv.itemvalue as 检验结果,'+
          ' cv.min_value as 最小值,cv.max_value as 最大值,'+
          ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as 前段参考范围,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as 后段参考范围,'+
          ' cv.unit as 单位,min(cv.printorder) as 打印编号,'+
          ' min(cv.pkcombin_id) as 组合项目号, '+
          ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10 '+
          ' from chk_valu_bak cv '+
          ' inner join chk_con_bak cc on cv.pkunid=cc.unid '+
          ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
          ' where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+
          ''') and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
          ' and CONVERT(CHAR(10),cc.check_date,121)>=DATEADD(day,'+inttostr(-1*MergePrintDays)+','''+sCheck_Date+''') '+
          ' and CONVERT(CHAR(10),cc.check_date,121)<=DATEADD(day,'+inttostr(MergePrintDays)+','''+sCheck_Date+''') '+
          ' and cci.sysname='''+SYSNAME+''' '+
          ' group by cv.itemid,cv.name,cv.english_name,cv.itemvalue,cv.min_value,cv.max_value,cv.unit, '+
          ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10 '+
          ' order by 组合项目号,打印编号 '
  else
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

  if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm

  if sdiappform.n9.Checked then  //预览模式
  begin
    frReport1.ShowPrintDialog:=ifShowPrintDialog;
    frReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //直接打印模式
  begin
    if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
  end;
end;

procedure TfrmCommQuery.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
var
  ItemChnName:string;
  cur_value:string;
  min_value:string;
  max_value:string;
  i:integer;
  adotemp22:tadoquery;
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
        ParValue := TRIM(COPY(CXZF,3,2))
      else if i=2 then
        ParValue := TRIM(COPY(CXZF,1,2))
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
    
    if parname='检验设备' then ParValue:=ScalarSQLCmd(LisConn,'select dbo.uf_GetEquipFromChkUnid(1,'+ADObasic.fieldbyname('唯一编号').AsString+')');
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

procedure TfrmCommQuery.BitBtn3Click(Sender: TObject);
var
  strsqlPrint:string;
  frGH: TfrBandView;//分组头

  sUnid:string;

  //对姓别性别年龄的合并项做打印标记 变量
  sPatientname,sSex,sAge,sCheck_Date,sMergePrintWorkGroupRange,sCombin_Id:string;
  //===============================  

  i,j:integer;
  mvPictureTitle:TfrMemoView;  
begin
  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;

  sUnid:=adobasic.fieldbyname('唯一编号').AsString;//防止点击打印后，马上将光标移到另一条病人信息上。故写在最前面
  
  sPatientname:=trim(adobasic.fieldbyname('姓名').AsString);
  sSex:=adobasic.fieldbyname('性别').AsString;
  sAge:=adobasic.fieldbyname('年龄').AsString;
  sCheck_Date:=FormatDateTime('yyyy-mm-dd',adobasic.fieldbyname('检查日期').AsDateTime);
  sCombin_Id:=adobasic.FieldByName('组别').AsString;
  
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

  frGH := TfrBandView(frReport1.FindObject('GroupHeader1'));
  if(frGH=nil)then
  begin
    showmessage('报表模板中没有发现GroupHeader1');
    exit;
  end;

  if SDIAppForm.N25.Checked then//按组分页
    frGH.Prop['formnewpage'] := True
  else
    frGH.Prop['formnewpage'] := false;

  //动态创建图片标题begin
  //待处理问题:是否需要释放mvPictureTitle?何时释放?
  for j:=0 to frReport1.Pages.Count-1 do
  begin
    for i:=0 to frReport1.Pages[j].Objects.Count-1 do
    begin
      if TObject(frReport1.Pages[j].Objects.Items[i]) is TfrPictureView then
      begin
        if uppercase(leftstr(TfrPictureView(frReport1.Pages[j].Objects.Items[i]).Name,7))='PICTURE' then
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
  
  if MergePrintWorkGroupRange<>'' then
    sMergePrintWorkGroupRange:=' and cc.combin_id in ('+MergePrintWorkGroupRange+') ';
  if (SDIAppForm.N64.Checked)and(sPatientname<>'') then//按姓别性别年龄合并打印//只有存在姓名时才合并
    strsqlPrint:='select cv.combin_name as name,cv.name as 名称,cv.english_name as 英文名,cv.itemvalue as 检验结果,'+//combinitem.name
    'cv.unit as 单位,cv.min_value as 最小值,cv.max_value as 最大值,'+
    ' dbo.uf_Reference_Value_B1(cv.min_value,cv.max_value) as 前段参考范围,dbo.uf_Reference_Value_B2(cv.min_value,cv.max_value) as 后段参考范围,'+
    ' cv.Reserve1,cv.Reserve2,cv.Dosage1,cv.Dosage2,cv.Reserve5,cv.Reserve6,cv.Reserve7,cv.Reserve8,cv.Reserve9,cv.Reserve10, '+
    ' cv.itemid as 项目代码 '+//cci.Reserve3,
    ' from chk_valu_bak cv '+//combinitem,从组合项目表取组合项目名称，有可能代码变了，取不到名称了
    ' inner join chk_con_bak cc on cv.pkunid=cc.unid '+
    ' left join clinicchkitem cci on cci.itemid=cv.itemid '+
    ' where Patientname='''+sPatientname+''' and isnull(sex,'''')='''+sSex+''' and dbo.uf_GetAgeReal(age)=dbo.uf_GetAgeReal('''+sAge+
    ''') and cv.issure=1 and ltrim(rtrim(isnull(itemvalue,'''')))<>'''' '+
    ' and CONVERT(CHAR(10),cc.check_date,121)>=DATEADD(day,'+inttostr(-1*MergePrintDays)+','''+sCheck_Date+''') '+
    ' and CONVERT(CHAR(10),cc.check_date,121)<=DATEADD(day,'+inttostr(MergePrintDays)+','''+sCheck_Date+''') '+
    ' and cci.sysname='''+SYSNAME+''' '+
    sMergePrintWorkGroupRange+
    ' order by cv.pkcombin_id,cv.printorder '//组合项目号,打印编号 '
  else
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

  if ifHeightForItemNum and (ADO_print.RecordCount>ItemRecNum) then
    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    frReport1.Pages[0].ChangePaper($100,2100,PageHeigth,-1,poPortrait);  //1 inch=2.54 cm

  if sdiappform.n9.Checked then  //预览模式
  begin
    frReport1.ShowPrintDialog:=ifShowPrintDialog;
    frReport1.ShowReport;
  end;
  if sdiappform.n8.Checked then  //直接打印模式
  begin
    if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
  end;
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
       if (i=3)or(i=12)or(i=2)or(i=13) then dbgridresult.Columns[i].Width:=70;//检查日期，申请日期,病历号，审核时间
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

procedure TfrmCommQuery.frReport1BeforePrint(Memo: TStringList;
  View: TfrView);
var
  adotemp11:tadoquery;
  unid:integer;

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

  //加载血流变曲线、直方图、散点图 start
  if(View is TfrChartView)and(pos('CURVE',uppercase(View.Name))>0)then
  begin
    View.Visible:=false;
    strsqlPrint:='select Reserve8,itemValue,Min_Value,Max_Value '+
       ' from chk_valu_bak '+
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
      sdiappform.Draw_MVIS2035_Curve(Chart_XLB,Reserve8_1,strtofloatdef(mPa_1,-1),Reserve8_2,strtofloatdef(mPa_2,-1),
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
       ' from chk_valu_bak '+
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

      sdiappform.updatechart(Chart_ZFT,strHistogram,strEnglishName,strXTitle);
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
       ' from chk_valu_bak '+
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
end;

procedure TfrmCommQuery.frReport1PrintReport;
var
  unid,printtimes:integer;
begin
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('唯一编号').AsInteger;
  printtimes:=ADObasic.fieldbyname('打印次数').AsInteger;
  
  if printtimes=0 then//修改打印次数
    ExecSQLCmd(LisConn,'update chk_con_bak set printtimes='+inttostr(printtimes+1)+' where unid='+inttostr(unid));
  
  ExecSQLCmd(LisConn,'insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values ('+inttostr(unid)+','''+operator_name+''',''Class_Print'',''Lab'')');
end;

procedure TfrmCommQuery.BitBtn5Click(Sender: TObject);
begin
  ADObasic.First;
  while not ADObasic.Eof do
  begin
    if RadioGroup1.ItemIndex=0 then BitBtn1Click(nil);
    if RadioGroup1.ItemIndex=1 then BitBtn3Click(nil);

    ADObasic.Next;
  end;
end;

procedure TfrmCommQuery.Excel1Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= ADObasic;
  //LYDataToExcel1.ExcelTitel:=BBBT;
  LYDataToExcel1.Execute;
end;

initialization
  ffrmCommQuery:=nil;
end.
