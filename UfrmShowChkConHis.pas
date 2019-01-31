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
    procedure WriteProfile;
    procedure Query_Chk_Valu_His(Aadoquery:TAdoquery;const Achk_con_his_unid:integer);
    function Add_Chk_Con_Valu_His(const AChk_Con_His_Unid:integer;const ACheckId:string):integer;
  public
    { Public declarations }
  end;

//var
//  frmShowChkConHis: TfrmShowChkConHis;
function frmShowChkConHis(const PQuery:string):TfrmShowChkConHis;    {��̬�������庯��}

implementation

uses UDM, SDIMAIN;

var
  ArCheckBoxValue:TArCheckBoxValue;
  ffrmShowChkConHis:TfrmShowChkConHis;           {���صĴ������,���رմ����ͷ��ڴ�ʱ����}
{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmShowChkConHis(const PQuery:string):TfrmShowChkConHis;    {��̬�������庯��}
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
        //�ö�ά������һ��Ҫ�и��ֶα�ʶΨһ�Ե�
        if j=0 then ArCheckBoxValue[I,j]:=adotemp22.FieldByName('ѡ��').AsInteger
        else ArCheckBoxValue[I,j]:=adotemp22.FieldByName('Ψһ���').AsInteger;
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

  CheckBox1.Checked:=configini.ReadBool('���뵥','ǿ�Ƹ��ǵ�ǰָ������',false);
  CheckBox2.Checked:=configini.ReadBool('���뵥','����ʾ��ǰ������������Ŀ',false);
  CheckBox3.Checked:=configini.ReadBool('���뵥','ȷ����رմ���',false);

  configini.Free;

  //��ȡ������
  ServerDate:=GetServerDate(DM.ADOConnection1);
  labelededit1.Text:=GetMaxCheckId(SDIAppForm.cbxConnChar.Text,ServerDate);
  //==========
end;

procedure TfrmShowChkConHis.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=DM.ADOConnection1;
  ADOQuery2.Connection:=DM.ADOConnection1;
end;

procedure TfrmShowChkConHis.Query_Chk_Valu_His(Aadoquery:TAdoquery;const Achk_con_his_unid:integer);
begin
  Aadoquery.Close;
  Aadoquery.SQL.Clear;
                      //1 as ѡ��,Ĭ����ѡ���.1--ѡ��,��1--δѡ
  Aadoquery.SQL.Text:='select cvh.pkcombin_id as �����Ŀ����,cvh.combin_name as �����Ŀ����,IfSel as ѡ��,combinitem.dept_DfValue as Ĭ�Ϲ�����,combinitem.specimentype_DfValue as Ĭ����������,combinitem.itemtype as �����ָ���,cvh.TakeSampleTime as ����ʱ��,'+
                      ' cvh.* '+
                      ' from chk_valu_his cvh '+
                      ' left join combinitem on combinitem.id=cvh.pkcombin_id '+
                      ' where '+
                      'pkunid='+inttostr(Achk_con_his_unid)+
                      ' and isnull(cvh.itemvalue,'''')<>''1'' ';
  Aadoquery.Open;
end;

procedure TfrmShowChkConHis.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  Query_Chk_Valu_His(ADOQuery2,DataSet.fieldbyname('Ψһ���').AsInteger);
end;

function TfrmShowChkConHis.Add_Chk_Con_Valu_His(const AChk_Con_His_Unid:integer;const ACheckId:string):integer;
VAR
  sWorkGroup:string;

  stringTemp1,stringTemp2,stringTemp3,stringTemp4:string;

  adotemp2,adotemp22,adotemp33:tadoquery;
  His_Unid_Unid,Chk_Valu_His_ValueId:integer;
  sCheckId:string;
begin
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
    exit;
  end;
  adotemp33.Free;
  
  if CheckBox1.Checked then
  begin
    His_Unid_Unid:=SDIAppForm.adobasic.fieldbyname('Ψһ���').AsInteger;
    stringTemp1:=' Update chk_con set '+
        '   his_unid='+inttostr(AChk_Con_His_Unid)+
        ',PushPress='''+LabeledEdit3.Text+
        ''',PullPress='''+operator_name+
        ''',Stature=getdate() '+
        ' Where unid='+inttostr(His_Unid_Unid);
    ExecSQLCmd(LisConn,stringTemp1);
  end;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  Query_Chk_Valu_His(adotemp22,AChk_Con_His_Unid);

  while not adotemp22.Eof do
  begin
    if not CheckBox1.Checked then His_Unid_Unid:=0;
    
    Chk_Valu_His_ValueId:=adotemp22.fieldbyname('ValueId').AsInteger;

    if not adotemp22.FieldByName('ѡ��').AsBoolean then//���δѡ��������
    begin
      adotemp22.Next;
      continue;
    end;

    sWorkGroup:=adotemp22.fieldbyname('Ĭ�Ϲ�����').AsString;
    if CheckBox2.Checked then//��ѡ��ѡ���ֻ��Ĭ�Ϲ�������ڵ�ǰ������ʱ�Żᵼ��
    begin
      if sWorkGroup<>SDIAppForm.cbxConnChar.Text then
      begin
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
    end;
        
    if His_Unid_Unid=0 then
    begin
      stringTemp4:='select Unid as His_Unid_Unid from chk_con where combin_id='''+sWorkGroup+''' and his_unid='+inttostr(AChk_Con_His_Unid);
      
      His_Unid_Unid:=strtointdef(ScalarSQLCmd(LisConn,stringTemp4),0);
    end;

    if His_Unid_Unid=0 then
    begin
      sCheckId:='checkid';
      if ACheckId<>'' then//ɨ��ʱֻ��һ����¼������������˽����ϵ�������
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
    end;

    sdiappform.InsertOrDeleteVaue(adotemp22.fieldbyname('�����Ŀ����').AsString,true,His_Unid_Unid,Chk_Valu_His_ValueId);//���������Ŀ

    adotemp22.Next;
  end;
  adotemp22.Free;
  
  result:=His_Unid_Unid;
end;

procedure TfrmShowChkConHis.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
  if not DataSet.Active then exit;

  for i:=0 to (dbgrid1.columns.count-1) do
   dbgrid1.columns[i].readonly:=TRUE;
  dbgrid1.columns[0].readonly:=FALSE;
  
  dbgrid1.Columns[0].Width:=42;//������
  dbgrid1.Columns[1].Width:=100;//�����
  dbgrid1.Columns[2].Width:=30;//ѡ��
  dbgrid1.Columns[3].Width:=40;//������
  dbgrid1.Columns[4].Width:=42;//����
  dbgrid1.Columns[5].Width:=75;
  dbgrid1.Columns[6].Width:=30;
  dbgrid1.Columns[7].Width:=30;
  dbgrid1.Columns[8].Width:=150;//�����Ŀ��
  dbgrid1.Columns[9].Width:=60;//�ͼ����
  dbgrid1.Columns[10].Width:=72;//�������
  dbgrid1.Columns[11].Width:=55;//�ͼ�ҽ��
  dbgrid1.Columns[12].Width:=72;//��������
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

  configini.WriteBool('���뵥','ǿ�Ƹ��ǵ�ǰָ������',CheckBox1.Checked);
  configini.WriteBool('���뵥','����ʾ��ǰ������������Ŀ',CheckBox2.Checked);
  configini.WriteBool('���뵥','ȷ����رմ���',CheckBox3.Checked);

  configini.Free;
end;

procedure TfrmShowChkConHis.FormDestroy(Sender: TObject);
begin
  WriteProfile;
end;

procedure TfrmShowChkConHis.BitBtn2Click(Sender: TObject);
VAR
  ValetudinarianInfoId:integer;
  i:integer;
  ifSelect:boolean;
  adotemp22:tadoquery;
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount<=0 then exit;

  (Sender as TBitBtn).Enabled:=false;//��ֹ�ظ�"ȷ��"

  ValetudinarianInfoId:=0;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.clone(ADOQuery1);
  while not adotemp22.Eof do
  begin
    ifSelect:=false;
    for i :=LOW(ArCheckBoxValue)  to HIGH(ArCheckBoxValue) do//ѭ��ArCheckBoxValue
    begin
      if (ArCheckBoxValue[i,1]=adotemp22.fieldbyname('Ψһ���').AsInteger)and(ArCheckBoxValue[i,0]=1) then
      begin
        ifSelect:=true;
        break;
      end;
    end;
    if not ifSelect then begin adotemp22.Next;continue;end;//���δѡ��������

    ValetudinarianInfoId:=Add_Chk_Con_Valu_His(adotemp22.fieldbyname('Ψһ���').AsInteger,'');

    adotemp22.next;
  end;
  adotemp22.free;

  if CheckBox3.Checked then close;

  SDIAppForm.UpdateADObasic;
  SDIAppForm.adobasic.Locate('Ψһ���',ValetudinarianInfoId,[loCaseInsensitive]);

  (Sender as TBitBtn).Enabled:=true;
end;

procedure TfrmShowChkConHis.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
  CtrlState: array[Boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  checkBox_check:boolean;
begin
  if Column.Field.FieldName='ѡ��' then
  begin
    (sender as TDBGrid).Canvas.FillRect(Rect);
    checkBox_check:=(Sender AS TDBGRID).DataSource.DataSet.FieldByName('ѡ��').AsBoolean;
    DrawFrameControl((sender as TDBGrid).Canvas.Handle,Rect, DFC_BUTTON, CtrlState[checkBox_check]);
  end else (sender as TDBGrid).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmShowChkConHis.DBGrid2CellClick(Column: TColumn);
begin
  if Column.Field.FieldName <>'ѡ��' then exit;

  ADOQuery2.Edit;
  ADOQuery2.FieldByName('ѡ��').AsBoolean:=not ADOQuery2.FieldByName('ѡ��').AsBoolean;
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

  (Sender as TLabeledEdit).Enabled:=false;//Ϊ�˷�ֹû��������ɨ����һ������

  sCheckId:=LabeledEdit1.Text;
  ServerDate:=GetServerDate(DM.ADOConnection1);

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=SHOW_CHK_CON_HIS+' where dbo.uf_GetExtBarcode(cch.unid) like ''%,'+sExtBarcode+',%'' ';
  ADOQuery1.Open;
  RecNum:=ADOQuery1.RecordCount;
  Chk_Con_His_Unid:=0;//û�á�Ϊ�˲��ñ���ʱ��Warning:Variable 'Chk_Con_His_Unid' might not have been initialized
  if RecNum=1 then Chk_Con_His_Unid:=ADOQuery1.fieldbyname('Ψһ���').AsInteger;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.clone(ADOQuery1);
  ArCheckBoxValue:=nil;
  setlength(ArCheckBoxValue,adotemp22.RecordCount);
  i:=0;
  while not adotemp22.Eof do
  begin
    for j :=0  to 1 do
    begin
      //�ö�ά������һ��Ҫ�и��ֶα�ʶΨһ�Ե�
      if j=0 then ArCheckBoxValue[I,j]:=adotemp22.FieldByName('ѡ��').AsInteger
      else ArCheckBoxValue[I,j]:=adotemp22.FieldByName('Ψһ���').AsInteger;
    end;
    adotemp22.Next;
    inc(i);
  end;
  adotemp22.Free;

  if RecNum=1 then
  begin
    ValetudinarianInfoId:=Add_Chk_Con_Valu_His(Chk_Con_His_Unid,sCheckId);

    SDIAppForm.UpdateADObasic;
    SDIAppForm.adobasic.Locate('Ψһ���',ValetudinarianInfoId,[loCaseInsensitive]);

    //���浱ǰ������
    if trim(SDIAppForm.cbxConnChar.Text)<>'' then
    begin
      ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
      ini.WriteDate(SDIAppForm.cbxConnChar.Text,'�������',ServerDate);
      ini.WriteString(SDIAppForm.cbxConnChar.Text,'������',sCheckId);
      ini.Free;
    end;
    //==============

    //��ȡ������
    labelededit1.Text:=GetMaxCheckId(SDIAppForm.cbxConnChar.Text,ServerDate);
    //==========
  end;

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
  if Column.Field.FieldName='ѡ��' then
  begin
    (sender as TDBGrid).Canvas.FillRect(Rect);
    checkBox_check:=false;
    iUNID:=(Sender AS TDBGRID).DataSource.DataSet.FieldByName('Ψһ���').AsInteger;
    for i :=0  to (Sender AS TDBGRID).DataSource.DataSet.RecordCount-1 do
    begin
      if ArCheckBoxValue[i,1]=iUNID then
      begin
        checkBox_check:=ArCheckBoxValue[i,0]=1;
        break;
      end;
    end;
    DrawFrameControl((sender as TDBGrid).Canvas.Handle,Rect, DFC_BUTTON, CtrlState[checkBox_check]);
  end else (sender as TDBGrid).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmShowChkConHis.DBGrid1CellClick(Column: TColumn);
var
  iUNID,i:INTEGER;
begin
  if not Column.Grid.DataSource.DataSet.Active then exit;  
  if Column.Field.FieldName <>'ѡ��' then exit;

  iUNID:=Column.Grid.DataSource.DataSet.FieldByName('Ψһ���').AsInteger;
  for i :=low(ArCheckBoxValue)  to high(ArCheckBoxValue) do//ѭ��ArCheckBoxValue
  begin
    if ArCheckBoxValue[i,1]=iUNID then
    begin
      ArCheckBoxValue[i,0]:=ifThen(ArCheckBoxValue[i,0]=1,0,1);
      Column.Grid.Refresh;//����DBGrid1DrawColumnCell�¼�
      break;
    end;
  end;
end;

procedure TfrmShowChkConHis.ADOQuery2AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid2.Columns[0].Width:=85;//
  dbgrid2.Columns[1].Width:=150;//
  dbgrid2.Columns[2].Width:=30;//ѡ��
  dbgrid2.Columns[3].Width:=70;//
  dbgrid2.Columns[4].Width:=85;
  dbgrid2.Columns[5].Width:=70;
  dbgrid2.Columns[6].Width:=137;//����ʱ��
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
