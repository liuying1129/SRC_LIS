unit UfrmCopyInfo;
//20080423 creat

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB,StrUtils{rightstr},
  Grids, DBGrids, CheckLst;

type
  TfrmCopyInfo = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit2: TLabeledEdit;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Label5: TLabel;
    DataSource1: TDataSource;
    Label3: TLabel;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckListBox1: TCheckListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure ComboBox2DropDown(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  frmCopyInfo: TfrmCopyInfo;

implementation

uses UDM, SDIMAIN;
var
  ffrmCopyInfo: TfrmCopyInfo;
  GAdotemp11:tadoquery;

{$R *.dfm}

function  frmCopyInfo: TfrmCopyInfo;
begin
  if ffrmCopyInfo=nil then ffrmCopyInfo:=TfrmCopyInfo.Create(application.mainform);
  result:=ffrmCopyInfo;
end;

procedure TfrmCopyInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  Gadotemp11.Free;
  if ffrmCopyInfo=self then ffrmCopyInfo:=nil;
end;

procedure TfrmCopyInfo.FormShow(Sender: TObject);
begin
  combinchecklistbox(CheckListBox1);
end;

procedure TfrmCopyInfo.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmCopyInfo.BitBtn1Click(Sender: TObject);
var
  valetudinarianInfoId:integer;
  adotemp22:tadoquery;
  
  tmpPatientname : string;
  tmpLSH:STRING;

  sMinCheckID:STRING;//开始联机号

  Punid : integer;
  pcheckid : string; //联机号
  icheckid : integer;
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
  PDiagnosetype : string;//优先级别
  Pflagetype : string;
  Pdiagnose : string;
  Ptypeflagcase : string;
  pissure:string;
  pSJSJ,pJCSJ:TDATETIME;
  pCombin_id:string;//组别
  //pGermName:string;
  
  pWorkID :string;
  pWorkCompany :string;
  pWorkDepartment :string;
  pWorkCategory :string;
  pifMarry :string;
  pOldAddress :string;
  pAddress :string;
  pTelephone :string;

  AddorUpdateResult:boolean;
  
  Save_Cursor:TCursor;
  i,j,b:integer;
  s2:string;
begin
  pCombin_id:=trim(combobox1.Items[combobox1.ItemIndex]);

  if pCombin_id='' then//如果combobox1.ItemIndex<0，pCombin_id肯定为空
  begin
    MessageBox(Handle, '请选择目标工作组！', '提示', MB_ICONERROR);
    exit;
  end;

  sMinCheckID:=trim(LabeledEdit2.Text);
  IF sMinCheckID<>'' then//表示允许不填联机号
    if NOT TRYSTRTOINT(sMinCheckID,icheckid) THEN
    BEGIN
      MessageBox(Handle, PCHAR('无效的开始联机号'+sMinCheckID), '提示', MB_ICONERROR);
      EXIT;
    END;

  if GAdotemp11.RecordCount<=0 then exit;

  AddorUpdateResult:=false;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  for i :=0  to dbgrid1.SelectedRows.Count-1 do
  begin
    GAdotemp11.GotoBookmark(pointer(DBGrid1.SelectedRows.Items[i]));

    PLSH:=GAdotemp11.fieldbyname('流水号').AsString;
    PDiagnosetype := GAdotemp11.fieldbyname('优先级别').AsString; //优先级别
    Ppatientname := GAdotemp11.fieldbyname('姓名').AsString;
    Psex := GAdotemp11.fieldbyname('性别').AsString;
    Page := GAdotemp11.fieldbyname('年龄').AsString;
    PCaseno := GAdotemp11.fieldbyname('病历号').AsString;
    Pbedno := GAdotemp11.fieldbyname('床号').AsString;
    Pdeptname := GAdotemp11.fieldbyname('送检科室').AsString;
    Pcheck_date := GAdotemp11.fieldbyname('检查日期').AsDateTime; //TDatetime //检查日期
    Pcheck_doctor := GAdotemp11.fieldbyname('送检医生').AsString; //送检医生
    Preport_date := GAdotemp11.fieldbyname('申请日期').AsDateTime; //TDatetime //申请日期
    Preport_doctor := '';//审核者; //string
    Poperator := operator_name; //string
    Pflagetype := trim(combobox2.text); //样本类型
    Pdiagnose := GAdotemp11.fieldbyname('临床诊断').AsString;
    Ptypeflagcase := GAdotemp11.fieldbyname('样本情况').AsString;
    pissure:=GAdotemp11.fieldbyname('备注').AsString;//备注
    pSJSJ:=GAdotemp11.fieldbyname('申请日期').AsDateTime;
    pJCSJ:=GAdotemp11.fieldbyname('检查日期').AsDateTime;
    //pGermName:=GAdotemp11.fieldbyname('细菌').AsString;//细菌

    pWorkID := GAdotemp11.fieldbyname('工号').AsString;
    pWorkCompany := GAdotemp11.fieldbyname('所属公司').AsString;
    pWorkDepartment := GAdotemp11.fieldbyname('所属部门').AsString;
    pWorkCategory := GAdotemp11.fieldbyname('工种').AsString;
    pifMarry := GAdotemp11.fieldbyname('婚否').AsString;
    pOldAddress := GAdotemp11.fieldbyname('籍贯').AsString;
    pAddress := GAdotemp11.fieldbyname('住址').AsString;
    pTelephone := GAdotemp11.fieldbyname('电话').AsString;

    Pcheckid := uppercase(LabeledEdit1.Text)+rightstr('0000'+inttostr(icheckid),4);
    if sMinCheckID='' then Pcheckid:='';
    //判断是否已存在该联机号
    adotemp22:=tadoquery.Create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:='select unid,lsh,patientname from chk_con where isnull(checkid,'''')<>'''' and checkid='''+Pcheckid+''' and '+
                            ' CONVERT(CHAR(10),check_date,121)=:P_check_date and Diagnosetype=:Diagnosetype ';
    adotemp22.Parameters.ParamByName('P_check_date').Value:=FormatDateTime('YYYY-MM-DD',Pcheck_date);
    adotemp22.Parameters.ParamByName('Diagnosetype').Value:=PDiagnosetype;
    adotemp22.Open;
    Punid:=adotemp22.fieldbyname('unid').AsInteger;
    tmpLSH:=adotemp22.fieldbyname('lsh').AsString;//修改时流水号就不用修改了
    tmpPatientname := adotemp22.fieldbyname('patientname').AsString;
    if adotemp22.RecordCount>0 then//已存在该联机号
    begin
      if tmpPatientname='' then
      begin
        AddorUpdateResult:=SDIAppForm.UpdateValetudinarianBasicInfo(Punid,tmpLSH,pcheckid,Ppatientname,Psex,
          Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
          PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,'','','',
          pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone,
          Pcheck_date,Preport_date,pSJSJ,pJCSJ,
          ValetudinarianInfoId);
      end else//如果该病人已填写了基本资料(填写了姓名就代表已填写了基本资料)则不做处理了
      begin
        inc(icheckid);
        adotemp22.Free;
        continue;
      end;
    end else
    begin
      AddorUpdateResult:=SDIAppForm.AddValetudinarianBasicInfo(PLSH,pcheckid,Ppatientname,Psex,
        Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
        PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,'','',
        pWorkID,pWorkCompany,pWorkDepartment,pWorkCategory,pifMarry,pOldAddress,pAddress,pTelephone,
        Pcheck_date,Preport_date,pSJSJ,pJCSJ,
        ValetudinarianInfoId);
    end;
    adotemp22.Free;
    //======================
    inc(icheckid);

    if not AddorUpdateResult then
    begin
      //MessageBox(Handle, PCHAR('无效的开始联机号'+trim(LabeledEdit2.Text)), '提示', MB_ICONERROR);//AddValetudinarianBasicInfo方法本身会报错
      break;
    end;

    for j:=0 to checklistbox1.Items.Count-1 do
    begin
     if checklistbox1.Checked[j] then
     begin
       s2:=checklistbox1.Items.Strings[j];
       b:=pos('   ',s2);
       s2:=copy(s2,1,b-1);

       sdiappform.InsertOrDeleteVaue(s2,true,ValetudinarianInfoId,-1);
     end;
    end;
  end;

  if pCombin_id=trim(sdiappform.cbxConnChar.Text) then sdiappform.suiButton8Click(nil);//如果复制到当前组，则需马上更新显示
  
  Screen.Cursor := Save_Cursor;  { Always restore to normal }
  close;
end;

procedure TfrmCopyInfo.FormCreate(Sender: TObject);
begin
  SetWindowLong(LabeledEdit2.Handle, GWL_STYLE, GetWindowLong(LabeledEdit2.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字

  Gadotemp11:=tadoquery.Create(nil);
  Gadotemp11.clone(SDIAppForm.ADObasic);//clone的dataset,指针指在第1条记录,故无需Gadotemp11.First(呵呵,程序中也无需指到第一条,当做一个知识点吧)
  DataSource1.DataSet:=Gadotemp11;

  if dbgrid1.DataSource.DataSet.Active then
  begin
    dbgrid1.Columns[0].Width:=40;
    dbgrid1.Columns[1].Width:=40;
    dbgrid1.Columns[2].Width:=42;//姓名
    dbgrid1.Columns[3].Width:=42;//审核者
    dbgrid1.Columns[4].Width:=65;
    dbgrid1.Columns[5].Width:=30;
    dbgrid1.Columns[6].Width:=30;
    dbgrid1.Columns[7].Width:=30;
    dbgrid1.Columns[8].Width:=60;//送检科室
    dbgrid1.Columns[9].Width:=72;//检查日期
    dbgrid1.Columns[10].Width:=55;//送检医生
    dbgrid1.Columns[11].Width:=72;//申请日期
  end;
end;

procedure TfrmCopyInfo.LabeledEdit1Change(Sender: TObject);
begin
  if trim((sender as TLabeledEdit).Text)='' then begin LabeledEdit2.Clear;LabeledEdit2.Enabled:=false;end
    else begin LabeledEdit2.Enabled:=true;end;
end;

procedure TfrmCopyInfo.CheckBox1Click(Sender: TObject);
begin
  Gadotemp11.First;
  while not Gadotemp11.Eof do
  begin
    DBGrid1.SelectedRows.CurrentRowSelected:=(sender as TCheckBox).Checked;
    Gadotemp11.Next;  
  end;
end;

procedure TfrmCopyInfo.ComboBox1DropDown(Sender: TObject);
begin
  LoadGroupName(ComboBox1,'select name from CommCode where TypeName=''检验组别'' AND SysName='''+SYSNAME+''' group by name order by MIN(ID)');
end;

procedure TfrmCopyInfo.ComboBox2DropDown(Sender: TObject);
begin
  LoadGroupName(ComboBox2,'select name from CommCode where TypeName=''样本类型'' group by name');//加载样本类型
end;

initialization
  ffrmCopyInfo:=nil;

end.
