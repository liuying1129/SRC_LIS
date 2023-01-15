unit UfrmHorizontalExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, Grids, DBGrids, Buttons, DB, ADODB,
  ExtCtrls, ULYDataToExcel;

type
  TfrmHorizontalExport = class(TForm)
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    CheckListBox2: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LYDataToExcel1: TLYDataToExcel;
    Label4: TLabel;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    procedure updateADOQuery1(const ASQL:String);
  public
    { Public declarations }
  end;

//var
//  frmHorizontalExport: TfrmHorizontalExport;

function frmHorizontalExport: TfrmHorizontalExport;{��̬�������庯��}

implementation

uses UDM;

var
  ffrmHorizontalExport: TfrmHorizontalExport;{���صĴ������,���رմ����ͷ��ڴ�ʱ����}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmHorizontalExport: TfrmHorizontalExport;{��̬�������庯��}
begin
  if ffrmHorizontalExport=nil then ffrmHorizontalExport:=TfrmHorizontalExport.Create(application.mainform);
  result:=ffrmHorizontalExport;
end;

procedure TfrmHorizontalExport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmHorizontalExport=self then ffrmHorizontalExport:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmHorizontalExport.FormShow(Sender: TObject);
var
  adotemp3:tadoquery;
begin
  //�����Ŀ����CheckListBox begin
  CheckListBox2.Items.Clear;

  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='select id,name from combinitem where sysname='''+SYSNAME+''' order by id';
  adotemp3.Open;
  while not adotemp3.Eof do
  begin
    CheckListBox2.Items.Add(trim(adotemp3.fieldbyname('id').AsString)+'   '+adotemp3.fieldbyname('name').AsString);

    adotemp3.Next;
  end;
  adotemp3.Free;
  //�����Ŀ����CheckListBox end
end;

procedure TfrmHorizontalExport.BitBtn2Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:=ADOQuery1;                     
  //LYDataToExcel1.ExcelTitel:=BBBT;                      
  LYDataToExcel1.Execute;
end;

{
--�÷�������ѡ������ƴ�����µ�SQL
select 
 TempA1.unid as ���鵥ID
,TempA1.caseno as ������
,CONVERT(varchar(10),TempA1.check_date,23) as �������
,TempA1.patientname as ����
,TempA1.sex as �Ա�
,TempA1.age as ����
,TempA1.combin_id as ������
,TempA1.deptname as �ͼ����

,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��ϸ��' then TempA1.itemvalue end) as '�򳣹�/��ϸ��'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��������' then TempA1.itemvalue end) as '�򳣹�/��������'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��ԭ' then TempA1.itemvalue end) as '�򳣹�/��ԭ'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='�У�ֵ' then TempA1.itemvalue end) as '�򳣹�/�У�ֵ'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='Ǳ  Ѫ' then TempA1.itemvalue end) as '�򳣹�/Ǳ  Ѫ'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��  ��' then TempA1.itemvalue end) as '�򳣹�/��  ��'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='VC' then TempA1.itemvalue end) as '�򳣹�/VC'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='ͪ  ��' then TempA1.itemvalue end) as '�򳣹�/ͪ  ��'
,max(case when TempA1.combin_name='�򳣹�' and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������'

,max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ��' then TempA1.itemvalue end) as 'Ѫ����/��ϸ��'
,max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ��' then TempA1.itemvalue end) as 'Ѫ����/��ϸ��'
,max(case when TempA1.combin_name='Ѫ����' and TempA1.name='Ѫ�쵰��' then TempA1.itemvalue end) as 'Ѫ����/Ѫ�쵰��'

 from 
(
select cc2.unid,cc2.Caseno,cc2.check_date,cc2.patientname,cc2.sex,cc2.age,cc2.combin_id,cc2.deptname,cv2.combin_name,cv2.Name,cv2.english_name,cv2.itemvalue,cv2.Unit,cv2.Min_value,cv2.Max_value 
from view_chk_con_all cc2,view_chk_valu_all cv2 where cc2.unid=cv2.pkunid
and isnull(cv2.itemvalue,'')<>'' and cv2.issure=1
and isnull(cc2.patientname,'')<>''
and isnull(cc2.report_doctor,'')<>''
and cc2.check_date between getdate()-30 and getdate()--����ʱ�䷶Χ�ڵļ�����
and (cv2.pkcombin_id='54' or cv2.pkcombin_id='62')--������ѡ�����Ŀ
) TempA1

group by 
 TempA1.unid
,TempA1.caseno
,TempA1.check_date
,TempA1.patientname
,TempA1.sex
,TempA1.age
,TempA1.combin_id
,TempA1.deptname
}
procedure TfrmHorizontalExport.BitBtn1Click(Sender: TObject);
const
  ss1=
'select'+
' TempA1.unid as ���鵥ID'+
',TempA1.caseno as ������'+
',CONVERT(varchar(10),TempA1.check_date,23) as �������'+
',TempA1.patientname as ����'+
',TempA1.sex as �Ա�'+
',TempA1.age as ����'+
',TempA1.combin_id as ������'+
',TempA1.deptname as �ͼ����';

  ss2=
' from '+
'('+
'select cc2.unid,cc2.Caseno,cc2.check_date,cc2.patientname,cc2.sex,cc2.age,cc2.combin_id,cc2.deptname,cv2.combin_name,cv2.Name,cv2.english_name,cv2.itemvalue,cv2.Unit,cv2.Min_value,cv2.Max_value '+
'from view_chk_con_all cc2,view_chk_valu_all cv2 where cc2.unid=cv2.pkunid '+
'and isnull(cv2.itemvalue,'''')<>'''' and cv2.issure=1 '+
'and isnull(cc2.patientname,'''')<>'''' '+
'and isnull(cc2.report_doctor,'''')<>'''' '+
'and cc2.check_date between :P_DateTimePicker1 and :P_DateTimePicker2 ';

  ss5=
') TempA1'+
' group by'+
' TempA1.unid'+
',TempA1.caseno'+
',TempA1.check_date'+
',TempA1.patientname'+
',TempA1.sex'+
',TempA1.age'+
',TempA1.combin_id'+
',TempA1.deptname';
var
  ss3,ss4:string;
  i,b:integer;
  s1,s2,s3:string;
  adotemp1:tadoquery;
begin
  //ƴ�����ֶ�ss4
  //where����SQL:�����Ŀss3
  for i:=0 to CheckListBox2.Items.Count-1 do
  begin
    if not CheckListBox2.Checked[i] then continue;
    
    s1:=CheckListBox2.Items.Strings[i];
    b:=pos('   ',s1);
    s2:=copy(s1,1,b-1);
    s3:=copy(s1,b+3,MaxInt);

    if ss3='' then ss3:=' cv2.pkcombin_id='''+s2+'''' else ss3:=ss3+' or cv2.pkcombin_id='''+s2+'''';
      
    adotemp1:=tadoquery.Create(nil);
    adotemp1.Connection:=DM.ADOConnection1;
    adotemp1.Close;
    adotemp1.SQL.Clear;
    adotemp1.SQL.Text:='select cci.name from combinitem ci '+
                     'inner join CombSChkItem csci on csci.CombUnid=ci.Unid '+
                     'inner join clinicchkitem cci on cci.unid=csci.ItemUnid '+
                     'where ci.Id='''+s2+''' order by cci.printorder';
    adotemp1.Open;
    while not adotemp1.Eof do
    begin
      ss4:=ss4+',max(case when TempA1.combin_name='''+s3+''' and TempA1.name='''+adotemp1.fieldbyname('name').AsString+''' then TempA1.itemvalue end) as '''+s3+'/'+adotemp1.fieldbyname('name').AsString+'''';

      adotemp1.Next;
    end;
    adotemp1.Free;
  end;
  if ss3<>'' then ss3:=' and ('+ss3+')';

  if ss4='' then
  begin
    MessageDlg('����ѡ��1����Ч�������Ŀ!',mtWarning,[MBOK],0);
    exit;
  end;

  updateADOQuery1(ss1+ss4+ss2+ss3+ss5);
end;

procedure TfrmHorizontalExport.FormCreate(Sender: TObject);
begin
  DateTimePicker2.Date := date;
  DateTimePicker1.Date := date-30;

  ADOQuery1.Connection := DM.ADOConnection1;
end;

procedure TfrmHorizontalExport.updateADOQuery1(const ASQL: String);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=ASQL;
  ADOQuery1.Parameters.ParamByName('P_DateTimePicker1').Value :=DateTimePicker1.DateTime;//�����Time����Ϊ00:00:00.����,����ѡ������ʱ����ı�Timeֵ
  ADOQuery1.Parameters.ParamByName('P_DateTimePicker2').Value :=DateTimePicker2.DateTime;//�����Time����Ϊ23:59:59.����,����ѡ������ʱ����ı�Timeֵ
  try
    ADOQuery1.Open;
  except
    on E:Exception do
    begin
      WriteLog(PChar(E.Message+'�������SQL:'+ASQL));
      MESSAGEDLG(E.Message+'�������SQL:'+ASQL,mtError,[mbOK],0);
    end;
  end;
end;

procedure TfrmHorizontalExport.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
  if not DataSet.Active then exit;

  for i := 0 to DataSet.Fields.Count-1 do
  begin
    if i=0 then dbgrid1.Columns[i].Width:=56;//chk_con.unid
    if i=1 then dbgrid1.Columns[i].Width:=65;//������
    if i=2 then dbgrid1.Columns[i].Width:=72;//�������
    if i=3 then dbgrid1.Columns[i].Width:=42;//����
    if i=4 then dbgrid1.Columns[i].Width:=30;//�Ա�
    if i=5 then dbgrid1.Columns[i].Width:=30;//����
    if i=6 then dbgrid1.Columns[i].Width:=67;//������//5������
    if i=7 then dbgrid1.Columns[i].Width:=60;//�ͼ����

    if i>=8 then dbgrid1.Columns[i].Width:=100;
  end;
end;

initialization
  ffrmHorizontalExport:=nil;

end.
