unit UDM;

interface

uses
  WINDOWS,SysUtils, Classes, DB, ADODB,INIFILES,Dialogs{ShowMessage����},Controls,
  ComCtrls, Buttons,StdCtrls, ExtCtrls,MENUS,DBGrids,StrUtils, 
  Forms{Application����},DBCtrls{DBEdit},Mask{TMaskEdit},Imm{ImmGetIMEFileName},
  CheckLst{TCheckListBox};

type
  PDescriptType=^TDescriptType;
  TDescriptType=record
    ID:string;//�������ID
    UpID:String;//�ϼ�����ID
  end;
  
type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  SYSNAME='CentralPrint';
  sDBALIAS='ALIAS_SHHJ';
  CGYXJB='����';//�������ȼ����ַ���
  CryptStr='lc';

  //0 as ѡ��,Ĭ����δѡ���.1--ѡ��,��1--δѡ
  SHOW_CHK_CON='select top 1000 patientname as ����,'+
        ' sex as �Ա�,'+
        ' age as ����,(case when printtimes>0 then ''��'' end) as ��ӡ,caseno as ������,bedno as ����,deptname as �ͼ����,'+
        ' check_doctor as �ͼ�ҽ��,check_date as �������,'+
        ' report_date as ��������,report_doctor as �����,'+//dbo.uf_GetPatientCombName(ifCompleted,unid) as �����Ŀ,'+
        ' combin_id as ������,operator as ������,diagnosetype as ���ȼ���,'+
        ' flagetype as ��������,diagnose as �ٴ����,typeflagcase as �������,'+
        ' issure as ��ע,unid as Ψһ���, '+
        ' His_Unid as HisΨһ���,His_MzOrZy as His�����סԺ, '+
        ' WorkCompany as ������˾,WorkDepartment as ��������,WorkCategory as ����,WorkID as ����,ifMarry as ���,OldAddress as ����,Address as סַ,Telephone as �绰, '+
        ' Audit_Date as ���ʱ��,ifCompleted,checkid as ������,lsh as ��ˮ��, '+
        ' PushPress as �����ͽ���,PullPress as ����������,LeftEyesight as ��������,RightEyesight as ��������,Stature as ��������ʱ��,Weight as ����״̬, '+
        ' TjJiWangShi as ����ʷ,TjJiaZuShi as ����ʷ,TjNeiKe as �ڿ�,TjWaiKe as ���,TjWuGuanKe as ��ٿ�,TjFuKe as ����,TjLengQiangGuang as ��ǿ��,TjXGuang as X��,TjBChao as Σ��ֵ����ʱ��,TjXinDianTu as Σ��ֵ������,TjJianYan as �����,'+
        ' TjDescription as ����,TJAdvice as ����,printtimes as ��ӡ���� '+
        ' from view_Chk_Con_All ';

var
  DM: TDM;

  powerstr_js_main:string;
  operator_name:string;
  operator_id:string;
  operator_DeptName:string;//����Ա��������
  
  ifEnterGetCode:boolean;//��¼�Ƿ� ��д���˻�����Ϣʱ,ֱ�ӻس�����ȡ���
  deptname_match:string;//��¼�ͼ���ҵ�ȡ��ƥ�䷽ʽ
  check_doctor_match:string;////��¼�ͼ�ҽ����ȡ��ƥ�䷽ʽ
  SCSYDW:STRING;//��Ȩʹ�õ�λ
  SmoothNum:integer;//ֱ��ͼ�⻬����
  LisConn:string;//Lis�����ַ���,MakeDBConn�����б���ֵ,Ȼ����QC.DLL��CalcItemPro.dll
  gServerName:string;//������,������ʾ��״̬��
  gDbName:string;//���ݿ���,������ʾ��״̬��
  BASE_URL:STRING;//http://211.97.0.5:8080/YkAPI/service
  ifShowPrintDialog:boolean;//��ӡ�Ի���

  WorkGroup_T1:string;
  TempFile_T1:string;
  WorkGroup_T2:string;
  TempFile_T2:string;
  WorkGroup_T3:string;
  TempFile_T3:string;
  WorkGroup_T4:string;
  TempFile_T4:string;
  WorkGroup_T5:string;
  TempFile_T5:string;
  WorkGroup_T6:string;
  TempFile_T6:string;
  WorkGroup_T7:string;
  TempFile_T7:string;
  WorkGroup_T8:string;
  TempFile_T8:string;
  WorkGroup_T9:string;
  TempFile_T9:string;
  WorkGroup_T10:string;
  TempFile_T10:string;
  WorkGroup_T11:string;
  TempFile_T11:string;
  WorkGroup_T12:string;
  TempFile_T12:string;
  WorkGroup_T13:string;
  TempFile_T13:string;
  WorkGroup_T14:string;
  TempFile_T14:string;
  WorkGroup_T15:string;
  TempFile_T15:string;
  GP_WorkGroup_T1:string;//����ģ��1������
  GP_TempFile_T1:string;//����ģ��1�ļ�
  GP_WorkGroup_T2:string;//����ģ��2������
  GP_TempFile_T2:string;//����ģ��2�ļ�
  GP_WorkGroup_T3:string;//����ģ��3������
  GP_TempFile_T3:string;//����ģ��3�ļ�
  Merge_TempFile:string;//�ϲ���ӡģ���ļ�

//**********************Dll�ӿں�������***************************************//
//��ǿ�͵�Pos����,ȡ��psubStr��pAllstr�е�Times�γ��ֵ�λ��
function PosExt(const psubStr,pAllstr:Pchar;const Times:Byte):integer;stdcall;external 'LYFunction.dll';
function GetHDSn(const RootPath:pchar):pchar;stdcall;external 'LYFunction.dll';
function CassonEquation(const X1,Y1,X2,Y2:Real;var A,B:Real):boolean;stdcall;external 'LYFunction.dll';//���ɷ���ʽ
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//����
function EnCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunction.dll';//����
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';
procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunction.dll';
//****************************************************************************//

//����ָ���е���ʾ���
procedure VisibleColumn(dbgrid:tdbgrid;const DisplayName:string;const ifVisible:boolean);
function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//��Ҫ�������뷨�Ĵ�������
function SmoothLine(const strHistogram:string;const SmoothNum:byte;var Strings:TStrings;var AMin:single;var AMax:single):integer;
function MakeDBConn:boolean;
procedure LoadGroupName(const comboBox:TcomboBox;const ASel:string);
function ExecSQLCmd(AConnectionString:string;ASQL:string):integer;
function ScalarSQLCmd(AConnectionString:string;ASQL:string):string;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
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

function ExecSQLCmd(AConnectionString:string;ASQL:string):integer;
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
      MESSAGEDLG('����ExecSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0);
      Result:=-1;
    end;
  end;
  Qry.Free;
  Conn.Free;
end;

function ScalarSQLCmd(AConnectionString:string;ASQL:string):string;
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
      MESSAGEDLG('����ScalarSQLCmdʧ��:'+E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0);
      Qry.Free;
      Conn.Free;
      exit;
    end;
  end;
  Result:=Qry.Fields[0].AsString;
  Qry.Free;
  Conn.Free;
end;

end.
