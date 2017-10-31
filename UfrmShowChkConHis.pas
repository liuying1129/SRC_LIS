unit UfrmShowChkConHis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, Grids, DBGrids, ADODB,
  UADOLYQuery,Inifiles,Math, DosMove;

type TArCheckBoxValue = array of array [0..1] of integer; 
  
type
  TfrmShowChkConHis = class(TForm)
    Panel1: TPanel;
    BitBtnCommQry: TBitBtn;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    ADOQuery2: TADOQuery;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    LabeledEdit2: TLabeledEdit;
    CheckBox3: TCheckBox;
    LabeledEdit3: TLabeledEdit;
    DosMove1: TDosMove;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure LabeledEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure ADOQuery2AfterOpen(DataSet: TDataSet);
    procedure DBGrid1Exit(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    //pPQuery:string;
    procedure WriteProfile;
    procedure Query_Chk_Valu_His(Aadoquery:TAdoquery;const Achk_con_his_unid:integer);
    function Add_Chk_Con_Valu_His(const AChk_Con_His_Unid:integer;const ACheckId:string):integer;
  public
    { Public declarations }
  end;

//var
//  frmShowChkConHis: TfrmShowChkConHis;
function frmShowChkConHis(const PQuery:string):TfrmShowChkConHis;    {动态创建窗体函数}

implementation

uses UDM, SDIMAIN;

var
  {ArCheckBoxValueCon,}ArCheckBoxValue:TArCheckBoxValue;
  ffrmShowChkConHis:TfrmShowChkConHis;           {本地的窗体变量,供关闭窗体释放内存时调用}
{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmShowChkConHis(const PQuery:string):TfrmShowChkConHis;    {动态创建窗体函数}
begin
  if ffrmShowChkConHis=nil then ffrmShowChkConHis:=TfrmShowChkConHis.Create(application.mainform);
  result:=ffrmShowChkConHis;
end;

procedure TfrmShowChkConHis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmShowChkConHis=self then ffrmShowChkConHis:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmShowChkConHis.BitBtnCommQryClick(Sender: TObject);
var
  ADOLYQuery1:TADOLYQuery;
  adotemp22:TADOQuery;
  i,j:integer;
begin
  adolyquery1:=TADOLYQuery.create(nil);
  adolyquery1.DataBaseType:=dbtMSSQL;
  adolyquery1.Connection:=DM.ADOConnection1;
  adolyquery1.SelectString:=SHOW_CHK_CON_HIS;
  if adolyquery1.Execute then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:=adolyquery1.ResultSelect;
    ADOQuery1.Open;

    adotemp22:=tadoquery.Create(nil);
    adotemp22.clone(ADOQuery1);
    ArCheckBoxValue:=nil;
    setlength(ArCheckBoxValue,adotemp22.RecordCount);
    i:=0;
    while not adotemp22.Eof do
    begin
      for j :=0  to 1 do
      begin
        //该二维数组中一定要有个字段标识唯一性的
        if j=0 then ArCheckBoxValue[I,j]:=adotemp22.FieldByName('选择').AsInteger
        else ArCheckBoxValue[I,j]:=adotemp22.FieldByName('唯一编号').AsInteger;
      end;
      adotemp22.Next;
      inc(i);
    end;
    adotemp22.Free;
  end;
  adolyquery1.Free;
end;

procedure TfrmShowChkConHis.FormShow(Sender: TObject);
var
  configini:tinifile;
  ServerDate:tdate;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  CheckBox1.Checked:=configini.ReadBool('申请单','强制覆盖当前指定病人',false);
  CheckBox2.Checked:=configini.ReadBool('申请单','仅显示当前工作组的组合项目',false);
  CheckBox3.Checked:=configini.ReadBool('申请单','确定后关闭窗口',false);

  configini.Free;

  //获取联机号
  ServerDate:=GetServerDate(DM.ADOConnection1);
  labelededit1.Text:=GetMaxCheckId(SDIAppForm.cbxConnChar.Text,ServerDate);
  //==========

  {if pPQuery<>'' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:=pPQuery;
    ADOQuery1.Open;
  end;//}
end;

procedure TfrmShowChkConHis.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=DM.ADOConnection1;
  ADOQuery2.Connection:=DM.ADOConnection1;
end;

procedure TfrmShowChkConHis.Query_Chk_Valu_His(Aadoquery:TAdoquery;const Achk_con_his_unid:integer);
//var
  //sqlstr1:string;
  //adotemp22:tadoquery;
  //i,j:integer;
begin
  //if not ADOQuery1.Active then exit;
  //if ADOQuery1.RecordCount=0 then exit;
  
  //sqlstr1:='';
  //if CheckBox2.Checked then
  //  sqlstr1:='inner join combinitem on combinitem.id=cvh.pkcombin_id and combinitem.dept_DfValue='''+SDIAppForm.cbxConnChar.Text+''' ';

  Aadoquery.Close;
  Aadoquery.SQL.Clear;
                      //1 as 选择,默认是选择的.1--选择,非1--未选
  Aadoquery.SQL.Text:='select cvh.pkcombin_id as 组合项目代码,cvh.combin_name as 组合项目名称,IfSel as 选择,combinitem.dept_DfValue as 默认工作组,combinitem.specimentype_DfValue as 默认样本类型,combinitem.itemtype as 样本分隔符,cvh.TakeSampleTime as 采样时间,'+
                      ' cvh.* '+
                      ' from chk_valu_his cvh '+
                      //sqlstr1+
                      ' left join combinitem on combinitem.id=cvh.pkcombin_id '+
                      ' where '+
                      'pkunid='+inttostr(Achk_con_his_unid)+//ADOQuery1.fieldbyname('唯一编号').AsString+
                      //' and not exists '+
                      //'( '+
                      //'select 1 from view_Chk_Con_All vcca '+
                      //'inner join view_chk_valu_All vcva on vcca.unid=vcva.pkunid '+
                      //'and cvh.pkunid=vcca.his_unid and cvh.pkcombin_id=vcva.pkcombin_id and vcva.issure=''1'' '+
                      //') ';
                      ' and isnull(cvh.itemvalue,'''')<>''1'' ';
  Aadoquery.Open;

  {adotemp22:=tadoquery.Create(nil);
  adotemp22.clone(ADOQuery2);
  ArCheckBoxValue:=nil;
  setlength(ArCheckBoxValue,adotemp22.RecordCount);
  i:=0;
  while not adotemp22.Eof do
  begin
    for j :=0  to 1 do
    begin
      //该二维数组中一定要有个字段标识唯一性的
      if j=0 then
      begin
        if (CheckBox2.Checked)and(adotemp22.fieldbyname('dept_DfValue').AsString<>SDIAppForm.cbxConnChar.Text) then ArCheckBoxValue[I,j]:=0
          else ArCheckBoxValue[I,j]:=adotemp22.FieldByName('选择').AsInteger;
      end else ArCheckBoxValue[I,j]:=adotemp22.FieldByName('VALUEID').AsInteger;
    end;
    adotemp22.Next;
    inc(i);
  end;
  adotemp22.Free;//}
end;

procedure TfrmShowChkConHis.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  Query_Chk_Valu_His(ADOQuery2,DataSet.fieldbyname('唯一编号').AsInteger);
end;

function TfrmShowChkConHis.Add_Chk_Con_Valu_His(const AChk_Con_His_Unid:integer;const ACheckId:string):integer;
VAR
  sWorkGroup:string;

  stringTemp1,stringTemp2,stringTemp3,stringTemp4:string;

  adotemp2,adotemp22,adotemp33:tadoquery;
  His_Unid_Unid,Chk_Valu_His_ValueId:integer;
  sCheckId:string;
begin
  WriteLog(pchar('操作者:'+operator_name+',开始增加申请单,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+ACheckId));

  His_Unid_Unid:=0;

  adotemp33:=tadoquery.Create(nil);
  adotemp33.Connection:=DM.ADOConnection1;
  adotemp33.Close;
  adotemp33.SQL.Clear;
  adotemp33.SQL.Text:='select * from chk_con_his cch where cch.unid='+inttostr(AChk_Con_His_Unid);
  adotemp33.Open ;
  if adotemp33.RecordCount<=0 then
  begin
    adotemp33.Free;
    result:=0;
    WriteLog(pchar('操作者:'+operator_name+',增加申请单结束,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+ACheckId+',预约登记中无该唯一编号'));
    exit;
  end;
  adotemp33.Free;
  
  if CheckBox1.Checked then
  begin
    His_Unid_Unid:=SDIAppForm.adobasic.fieldbyname('唯一编号').AsInteger;
    stringTemp1:=' Update chk_con set '+
        '   his_unid='+inttostr(AChk_Con_His_Unid)+
        ',PushPress='''+LabeledEdit3.Text+
        ''',PullPress='''+operator_name+
        ''',Stature=getdate() '+
        ' Where unid='+inttostr(His_Unid_Unid);
    ExecSQLCmd(LisConn,stringTemp1);
  
    WriteLog(pchar('操作者:'+operator_name+',增加申请单,强制覆盖当前指定病人LIS unid:'+inttostr(His_Unid_Unid)+',申请单唯一编号:'+inttostr(AChk_Con_His_Unid)));
  end;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  Query_Chk_Valu_His(adotemp22,AChk_Con_His_Unid);

  WriteLog(pchar('操作者:'+operator_name+',增加申请单,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',待处理组合项目数量:'+inttostr(adotemp22.RecordCount)));

  while not adotemp22.Eof do
  begin
    if not CheckBox1.Checked then His_Unid_Unid:=0;
    
    Chk_Valu_His_ValueId:=adotemp22.fieldbyname('ValueId').AsInteger;

    if not adotemp22.FieldByName('选择').AsBoolean then//如果未选择，则跳过
    begin
      WriteLog(pchar('操作者:'+operator_name+',增加申请单,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+ACheckId+',预约登记ValueId:'+inttostr(Chk_Valu_His_ValueId)+',未选择,跳过'));
      adotemp22.Next;
      continue;
    end;

    sWorkGroup:=adotemp22.fieldbyname('默认工作组').AsString;
    if CheckBox2.Checked then//勾选该选项，则只有默认工作组等于当前工作组时才会导入
    begin
      if sWorkGroup<>SDIAppForm.cbxConnChar.Text then
      begin
        WriteLog(pchar('操作者:'+operator_name+',增加申请单,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+ACheckId+',预约登记ValueId:'+inttostr(Chk_Valu_His_ValueId)+',非当前工作组的组合项目,跳过'));
        adotemp22.Next;
        continue;
      end;
    end;
    if sWorkGroup='' then sWorkGroup:=SDIAppForm.cbxConnChar.Text;

    if His_Unid_Unid=0 then
    begin
      stringTemp3:='select vcca.unid as His_Unid_Unid from Chk_Con vcca '+
                          'inner join chk_valu vcva on vcca.unid=vcva.pkunid '+
                          'inner join chk_valu_his cvh on cvh.pkunid=vcca.his_unid and cvh.pkcombin_id=vcva.pkcombin_id '+
                          ' and cvh.ValueID='+inttostr(Chk_Valu_His_ValueId);//adotemp22.fieldbyname('ValueID').AsString;

      His_Unid_Unid:=strtointdef(ScalarSQLCmd(LisConn,stringTemp3),0); 
      
      WriteLog(pchar('操作者:'+operator_name+',增加申请单,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+ACheckId+',预约登记ValueId:'+inttostr(Chk_Valu_His_ValueId)+',LIS唯一编号1:'+inttostr(His_Unid_Unid)));
    end;
        
    if His_Unid_Unid=0 then
    begin
      stringTemp4:='select Unid as His_Unid_Unid from chk_con where combin_id='''+sWorkGroup+''' and his_unid='+inttostr(AChk_Con_His_Unid);
      
      His_Unid_Unid:=strtointdef(ScalarSQLCmd(LisConn,stringTemp4),0);
      
      WriteLog(pchar('操作者:'+operator_name+',增加申请单,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+ACheckId+',LIS唯一编号2:'+inttostr(His_Unid_Unid)));
    end;

    if His_Unid_Unid=0 then
    begin
      sCheckId:='checkid';
      if ACheckId<>'' then//扫描时只有一条记录的情况，传入了界面上的联机号
      begin
        sCheckId:=''''+ACheckId+'''';
      end;
      
      stringTemp2:='Insert into chk_con ('+
          ' lsh,Combin_id         ,his_unid,'+
          'checkid,PushPress,PullPress,Stature) select '+
          'dbo.uf_GetNextSerialNum('''+sWorkGroup+''',CONVERT(CHAR(10),getdate(),121),Diagnosetype),'''+sWorkGroup+''',unid    ,'+
          sCheckId+','''+LabeledEdit3.Text+''','''+operator_name+''',getdate() from chk_con_his '+
          ' where unid=:punid';
      adotemp2:=tadoquery.Create(nil);
      adotemp2.Connection:=DM.ADOConnection1;
      adotemp2.Close;
      adotemp2.SQL.Clear;
      adotemp2.SQL.Add(stringTemp2);
      adotemp2.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
      adotemp2.Parameters.ParamByName('punid').Value:=AChk_Con_His_Unid ;
      adotemp2.Open ;
      His_Unid_Unid:=adotemp2.fieldbyname('Insert_Identity').AsInteger;
      adotemp2.Free;

      WriteLog(pchar('操作者:'+operator_name+',增加申请单,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+sCheckId+',LIS唯一编号3:'+inttostr(His_Unid_Unid)));
    end;

    sdiappform.InsertOrDeleteVaue(adotemp22.fieldbyname('组合项目代码').AsString,true,His_Unid_Unid,Chk_Valu_His_ValueId);//插入检验项目

    adotemp22.Next;
  end;
  adotemp22.Free;
  
  result:=His_Unid_Unid;
  
  WriteLog(pchar('操作者:'+operator_name+',增加申请单结束,申请单唯一编号:'+inttostr(AChk_Con_His_Unid)+',联机号:'+ACheckId+',LIS唯一编号:'+inttostr(His_Unid_Unid)));
end;

procedure TfrmShowChkConHis.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
  if not DataSet.Active then exit;

  for i:=0 to (dbgrid1.columns.count-1) do
   dbgrid1.columns[i].readonly:=TRUE;
  dbgrid1.columns[0].readonly:=FALSE;
  
  dbgrid1.Columns[0].Width:=42;//联机号
  dbgrid1.Columns[1].Width:=100;//条码号
  dbgrid1.Columns[2].Width:=30;//选择
  dbgrid1.Columns[3].Width:=40;//样本号
  dbgrid1.Columns[4].Width:=42;//姓名
  dbgrid1.Columns[5].Width:=75;
  dbgrid1.Columns[6].Width:=30;
  dbgrid1.Columns[7].Width:=30;
  dbgrid1.Columns[8].Width:=150;//组合项目串
  dbgrid1.Columns[9].Width:=60;//送检科室
  dbgrid1.Columns[10].Width:=72;//检查日期
  dbgrid1.Columns[11].Width:=55;//送检医生
  dbgrid1.Columns[12].Width:=72;//申请日期
  dbgrid1.Columns[13].Width:=55;
  dbgrid1.Columns[14].Width:=55;
  dbgrid1.Columns[15].Width:=55;
  dbgrid1.Columns[16].Width:=55;
end;

procedure TfrmShowChkConHis.WriteProfile;
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteBool('申请单','强制覆盖当前指定病人',CheckBox1.Checked);
  configini.WriteBool('申请单','仅显示当前工作组的组合项目',CheckBox2.Checked);
  configini.WriteBool('申请单','确定后关闭窗口',CheckBox3.Checked);

  configini.Free;
end;

procedure TfrmShowChkConHis.FormDestroy(Sender: TObject);
begin
  WriteProfile;
end;

procedure TfrmShowChkConHis.BitBtn2Click(Sender: TObject);
VAR
  ValetudinarianInfoId:integer;
  //sCheckId:string;
  i{,j}:integer;
  //ServerDate:tdate;
  ifSelect:boolean;
  adotemp22:tadoquery;
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount<=0 then exit;

  (Sender as TBitBtn).Enabled:=false;//防止重复"确定"

  ValetudinarianInfoId:=0;
  //j:=0;
  //ServerDate:=GetServerDate(DM.ADOConnection1);

  adotemp22:=tadoquery.Create(nil);
  adotemp22.clone(ADOQuery1);
  while not adotemp22.Eof do
  begin
    ifSelect:=false;
    //for i :=0  to ADOQuery1.RecordCount-1 do//循环ArCheckBoxValue
    for i :=LOW(ArCheckBoxValue)  to HIGH(ArCheckBoxValue) do//循环ArCheckBoxValue
    begin
      if (ArCheckBoxValue[i,1]=adotemp22.fieldbyname('唯一编号').AsInteger)and(ArCheckBoxValue[i,0]=1) then
      begin
        ifSelect:=true;
        break;
      end;
    end;//}
    if not ifSelect then begin adotemp22.Next;continue;end;//如果未选择，则跳过
    //if not adotemp22.FieldByName('选择').AsBoolean then begin adotemp22.Next;continue;end;//如果未选择，则跳过

    //if j=0 then sCheckId:=LabeledEdit1.Text else sCheckId:=GetMaxCheckId(SDIAppForm.cbxConnChar.Text,ServerDate);
    ValetudinarianInfoId:=Add_Chk_Con_Valu_His(adotemp22.fieldbyname('唯一编号').AsInteger,'');
    //showmessage(ADOQuery1.fieldbyname('唯一编号').AsString);
    //inc(j);

    adotemp22.next;
  end;
  adotemp22.free;

  //ADOQuery1.First;
  //while not ADOQuery1.Eof do
  //begin
  //  if i=0 then sCheckId:=LabeledEdit1.Text else sCheckId:=GetMaxCheckId(SDIAppForm.cbxConnChar.Text,ServerDate);
  //  ValetudinarianInfoId:=Add_Chk_Con_Valu_His(sCheckId);
  //  inc(i);
  //  ADOQuery1.Next;
  //end;


  if CheckBox3.Checked then close;

  SDIAppForm.UpdateADObasic;
  SDIAppForm.adobasic.Locate('唯一编号',ValetudinarianInfoId,[loCaseInsensitive]);

  (Sender as TBitBtn).Enabled:=true;
end;

procedure TfrmShowChkConHis.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
  CtrlState: array[Boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  checkBox_check:boolean;
  //iUNID,i:INTEGER;
begin
  if Column.Field.FieldName='选择' then
  begin
    (sender as TDBGrid).Canvas.FillRect(Rect);
    //checkBox_check:=false;
    checkBox_check:=(Sender AS TDBGRID).DataSource.DataSet.FieldByName('选择').AsBoolean;
    {iUNID:=(Sender AS TDBGRID).DataSource.DataSet.FieldByName('VALUEID').AsInteger;
    for i :=0  to (Sender AS TDBGRID).DataSource.DataSet.RecordCount-1 do
    begin
      if ArCheckBoxValue[i,1]=iUNID then
      begin
        checkBox_check:=ArCheckBoxValue[i,0]=1;
        break;
      end;
    end;//}
    DrawFrameControl((sender as TDBGrid).Canvas.Handle,Rect, DFC_BUTTON, CtrlState[checkBox_check]);
  end else (sender as TDBGrid).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmShowChkConHis.DBGrid2CellClick(Column: TColumn);
//var
  //iUNID,i:INTEGER;
begin
  if Column.Field.FieldName <>'选择' then exit;

  {iUNID:=DBGrid2.DataSource.DataSet.FieldByName('VALUEID').AsInteger;
  for i :=0  to DBGrid2.DataSource.DataSet.RecordCount-1 do
  begin
    if ArCheckBoxValue[i,1]=iUNID then
    begin
      ArCheckBoxValue[i,0]:=ifThen(ArCheckBoxValue[i,0]=1,0,1);
      DBGrid2.Refresh;//调用DBGrid1DrawColumnCell事件
      break;
    end;
  end;//}

  ADOQuery2.Edit;
  ADOQuery2.FieldByName('选择').AsBoolean:=not ADOQuery2.FieldByName('选择').AsBoolean;
  ADOQuery2.Post;
end;

procedure TfrmShowChkConHis.LabeledEdit2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
VAR
  ValetudinarianInfoId,i,j,RecNum:integer;
  ServerDate:tdate;
  adotemp22:TAdoquery;
  ini:tinifile;

  Chk_Con_His_Unid:integer;
  sCheckId,sExtBarcode:string;
begin
  if key<>13 then exit;

  sExtBarcode:=(Sender as TLabeledEdit).Text;

  if sExtBarcode='' then exit;

  (Sender as TLabeledEdit).Enabled:=false;//为了防止没处理完又扫描下一个条码

  sCheckId:=LabeledEdit1.Text;
  ServerDate:=GetServerDate(DM.ADOConnection1);

  WriteLog(pchar('操作者:'+operator_name+',选取申请单,开始,联机号:'+sCheckId+',条码:'+sExtBarcode));

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=SHOW_CHK_CON_HIS+' where dbo.uf_GetExtBarcode(cch.unid) like ''%,'+sExtBarcode+',%'' ';
  ADOQuery1.Open;
  RecNum:=ADOQuery1.RecordCount;
  Chk_Con_His_Unid:=0;//没用。为了不让编译时报Warning:Variable 'Chk_Con_His_Unid' might not have been initialized
  if RecNum=1 then Chk_Con_His_Unid:=ADOQuery1.fieldbyname('唯一编号').AsInteger;

  WriteLog(pchar('操作者:'+operator_name+',选取申请单,查询样本条码,数量:'+inttostr(RecNum)));
  
  adotemp22:=tadoquery.Create(nil);
  adotemp22.clone(ADOQuery1);
  ArCheckBoxValue:=nil;
  setlength(ArCheckBoxValue,adotemp22.RecordCount);
  i:=0;
  while not adotemp22.Eof do
  begin
    for j :=0  to 1 do
    begin
      //该二维数组中一定要有个字段标识唯一性的
      if j=0 then ArCheckBoxValue[I,j]:=adotemp22.FieldByName('选择').AsInteger
      else ArCheckBoxValue[I,j]:=adotemp22.FieldByName('唯一编号').AsInteger;
    end;
    adotemp22.Next;
    inc(i);
  end;
  adotemp22.Free;

  if RecNum=1 then
  begin
    ValetudinarianInfoId:=Add_Chk_Con_Valu_His(Chk_Con_His_Unid,sCheckId);

    SDIAppForm.UpdateADObasic;
    SDIAppForm.adobasic.Locate('唯一编号',ValetudinarianInfoId,[loCaseInsensitive]);

    //保存当前联机号
    if trim(SDIAppForm.cbxConnChar.Text)<>'' then
    begin
      ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
      ini.WriteDate(SDIAppForm.cbxConnChar.Text,'检查日期',ServerDate);
      ini.WriteString(SDIAppForm.cbxConnChar.Text,'联机号',sCheckId);
      ini.Free;
    end;
    //==============

    //获取联机号
    labelededit1.Text:=GetMaxCheckId(SDIAppForm.cbxConnChar.Text,ServerDate);
    //==========
    
    WriteLog(pchar('操作者:'+operator_name+',选取申请单,获取下一个联机号:'+labelededit1.Text));
  end;

  WriteLog(pchar('操作者:'+operator_name+',选取申请单,结束,条码:'+sExtBarcode));

  (Sender as TLabeledEdit).Enabled:=true;
  if (Sender as TLabeledEdit).CanFocus then begin (Sender as TLabeledEdit).SetFocus;(Sender as TLabeledEdit).SelectAll; end;
end;

procedure TfrmShowChkConHis.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
  CtrlState: array[Boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  checkBox_check:boolean;
  iUNID,i:INTEGER;
begin
  if Column.Field.FieldName='选择' then
  begin
    (sender as TDBGrid).Canvas.FillRect(Rect);
    checkBox_check:=false;
    //checkBox_check:=ADOQuery1.fieldbyname('选择').AsBoolean;
    iUNID:=(Sender AS TDBGRID).DataSource.DataSet.FieldByName('唯一编号').AsInteger;
    for i :=0  to (Sender AS TDBGRID).DataSource.DataSet.RecordCount-1 do
    begin
      if ArCheckBoxValue[i,1]=iUNID then
      begin
        checkBox_check:=ArCheckBoxValue[i,0]=1;
        break;
      end;
    end;//}
    DrawFrameControl((sender as TDBGrid).Canvas.Handle,Rect, DFC_BUTTON, CtrlState[checkBox_check]);
  end else (sender as TDBGrid).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmShowChkConHis.DBGrid1CellClick(Column: TColumn);
var
  iUNID,i:INTEGER;
begin
  if not Column.Grid.DataSource.DataSet.Active then exit;  
  if Column.Field.FieldName <>'选择' then exit;

  iUNID:=Column.Grid.DataSource.DataSet.FieldByName('唯一编号').AsInteger;
  for i :=low(ArCheckBoxValue)  to high(ArCheckBoxValue) do//循环ArCheckBoxValue
  begin
    if ArCheckBoxValue[i,1]=iUNID then
    begin
      ArCheckBoxValue[i,0]:=ifThen(ArCheckBoxValue[i,0]=1,0,1);
      Column.Grid.Refresh;//调用DBGrid1DrawColumnCell事件
      break;
    end;
  end;
end;

procedure TfrmShowChkConHis.ADOQuery2AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid2.Columns[0].Width:=85;//
  dbgrid2.Columns[1].Width:=150;//
  dbgrid2.Columns[2].Width:=30;//选择
  dbgrid2.Columns[3].Width:=70;//
  dbgrid2.Columns[4].Width:=85;
  dbgrid2.Columns[5].Width:=70;
  dbgrid2.Columns[6].Width:=137;//采样时间
end;

procedure TfrmShowChkConHis.DBGrid1Exit(Sender: TObject);
begin
  if not TDBGrid(sender).DataSource.DataSet.Active then exit;
  if TDBGrid(sender).DataSource.DataSet.RecordCount=0 then exit;
  if TDBGrid(sender).DataSource.DataSet.State=dsEdit then //add ly 20050521
    TDBGrid(sender).DataSource.DataSet.Post;
end;

procedure TfrmShowChkConHis.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(not ADOQuery1.Active)or(ADOQuery1.RecordCount=0) then exit;
  
  try
    if ADOQuery1.Eof then (Sender as TDBGrid).Columns.Items[0].ReadOnly:=true;
  except
  end;
end;

procedure TfrmShowChkConHis.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if(not ADOQuery1.Active)or(ADOQuery1.RecordCount=0) then exit;

      (Sender as TDBGrid).Columns.Items[0].ReadOnly:=false;
end;

initialization
  ffrmShowChkConHis:=nil;
end.
