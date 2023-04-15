unit UfrmCriticalValueDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, Menus, StrUtils, ComCtrls, ExtCtrls,
  StdCtrls, Buttons;

type
  TfrmCriticalValueDetail = class(TForm)
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    ADOQuery2: TADOQuery;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure ADOQuery2AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    procedure UpdateADOQuery1;
  public
    { Public declarations }
  end;

//var
function  frmCriticalValueDetail: TfrmCriticalValueDetail;

implementation

uses UDM;

var
  ffrmCriticalValueDetail: TfrmCriticalValueDetail;
  
{$R *.dfm}

function  frmCriticalValueDetail: TfrmCriticalValueDetail;
begin
  if ffrmCriticalValueDetail=nil then ffrmCriticalValueDetail:=TfrmCriticalValueDetail.Create(application.mainform);
  result:=ffrmCriticalValueDetail;
end;

procedure TfrmCriticalValueDetail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCriticalValueDetail=self then ffrmCriticalValueDetail:=nil;
end;

procedure TfrmCriticalValueDetail.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=DM.ADOConnection1;
  ADOQuery2.Connection:=DM.ADOConnection1;
  
  DateTimePicker2.Date := date;
  DateTimePicker1.Date := date-30;
end;

procedure TfrmCriticalValueDetail.N1Click(Sender: TObject);
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount<=0 then exit;

  ExecSQLCmd(LisConn,'update '+ifThen(ADOQuery1.FieldByName('ifCompleted').AsInteger=1,'chk_con_bak','chk_con')+' set TjXinDianTu='''+operator_name+''',TjBChao=getdate() where unid='+ADOQuery1.fieldbyname('unid').AsString);

  UpdateADOQuery1;
end;

procedure TfrmCriticalValueDetail.UpdateADOQuery1;
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select cc.patientname as 姓名,cc.sex as 性别,cc.age as 年龄,cv.itemid as 项目代码,cv.name as 项目名称,cv.itemvalue as 项目结果,cv.unit as 项目单位,cc.deptname as 送检科室,cc.check_doctor as 送检医生,cc.unid,cc.ifCompleted '+
                      'from view_Chk_Con_All cc WITH(NOLOCK),view_chk_valu_All cv WITH(NOLOCK) '+
                      'where cc.unid=cv.pkunid and check_date>getdate()-7 and isnull(cc.TjXinDianTu,'''')='''' and dbo.uf_CriticalValueAlarm(cv.itemid,cc.sex,cc.age,cv.itemvalue)=1';
  ADOQuery1.Open;
end;

procedure TfrmCriticalValueDetail.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;

  UpdateADOQuery1;
end;

procedure TfrmCriticalValueDetail.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;

  dbgrid1.Columns.Items[0].Width:=42;//姓名
  dbgrid1.Columns.Items[1].Width:=30;//性别
  dbgrid1.Columns.Items[2].Width:=30;//年龄
  dbgrid1.Columns.Items[3].Width:=60;//项目代码
  dbgrid1.Columns.Items[4].Width:=100;//项目名称
  dbgrid1.Columns.Items[5].Width:=100;//项目结果
  dbgrid1.Columns.Items[6].Width:=100;//项目单位
  dbgrid1.Columns.Items[7].Width:=60;//送检科室
  dbgrid1.Columns.Items[8].Width:=55;//送检医生
end;

procedure TfrmCriticalValueDetail.BitBtn1Click(Sender: TObject);
begin
  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Text:='select cc.patientname as 姓名,cc.sex as 性别,cc.age as 年龄,cv.itemid as 项目代码,cv.name as 项目名称,cv.itemvalue as 项目结果,cv.unit as 项目单位,'+
                      'cc.deptname as 送检科室,cc.check_doctor as 送检医生,cc.TjXinDianTu as 危急值报告人,cc.TjBChao as 危急值报告时间 '+
                      'from view_Chk_Con_All cc WITH(NOLOCK),view_chk_valu_All cv WITH(NOLOCK) '+
                      'where cc.unid=cv.pkunid and isnull(cc.TjXinDianTu,'''')<>'''' '+
                      'and dbo.uf_CriticalValueAlarm(cv.itemid,cc.sex,cc.age,cv.itemvalue)=1 '+
                      'and cc.check_date between :P_DateTimePicker1 and :P_DateTimePicker2';
  ADOQuery2.Parameters.ParamByName('P_DateTimePicker1').Value :=DateTimePicker1.DateTime;//设计期Time设置为00:00:00.放心,下拉选择日期时不会改变Time值
  ADOQuery2.Parameters.ParamByName('P_DateTimePicker2').Value :=DateTimePicker2.DateTime;//设计期Time设置为23:59:59.放心,下拉选择日期时不会改变Time值
  ADOQuery2.Open;
end;

procedure TfrmCriticalValueDetail.ADOQuery2AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;

  dbgrid2.Columns.Items[0].Width:=42;//姓名
  dbgrid2.Columns.Items[1].Width:=30;//性别
  dbgrid2.Columns.Items[2].Width:=30;//年龄
  dbgrid2.Columns.Items[3].Width:=56;//项目代码
  dbgrid2.Columns.Items[4].Width:=70;//项目名称
  dbgrid2.Columns.Items[5].Width:=60;//项目结果
  dbgrid2.Columns.Items[6].Width:=60;//项目单位
  dbgrid2.Columns.Items[7].Width:=60;//送检科室
  dbgrid2.Columns.Items[8].Width:=55;//送检医生
  dbgrid2.Columns.Items[9].Width:=82;//危急值报告人
  dbgrid2.Columns.Items[10].Width:=128;//危急值报告时间
end;

initialization
  ffrmCriticalValueDetail:=nil;

end.
