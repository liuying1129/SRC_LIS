unit UfrmSJ_JBXX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB, DosMove,
  UfrmLocateRecord;

type
  TfrmSJ_JBXX = class(TForm)
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    LabeledEdit7: TLabeledEdit;
    DosMove1: TDosMove;
    Panel2: TPanel;
    DBGrid2: TDBGrid;
    Panel3: TPanel;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn7: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure ADOQuery2AfterScroll(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
    procedure updateAdoQuery1;
    procedure updateAdoQuery2;
    procedure ClearEdit;
    procedure ClearPackEdit;
    procedure updateEdit;
    procedure updatePackEdit;
  public
    { Public declarations }
  end;

//var
function  frmSJ_JBXX: TfrmSJ_JBXX;

implementation

uses UDM;

var
  ffrmSJ_JBXX: TfrmSJ_JBXX;
  ifNewAdd,ifPackNewAdd:boolean;

{$R *.dfm}

function  frmSJ_JBXX: TfrmSJ_JBXX;
begin
  if ffrmSJ_JBXX=nil then ffrmSJ_JBXX:=TfrmSJ_JBXX.Create(application.mainform);
  result:=ffrmSJ_JBXX;
end;

procedure TfrmSJ_JBXX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmSJ_JBXX=self then ffrmSJ_JBXX:=nil;
end;

procedure TfrmSJ_JBXX.FormCreate(Sender: TObject);
begin
  adoquery1.Connection:=DM.ADOConnection1;
  adoquery2.Connection:=DM.ADOConnection1;
  
  SetWindowLong(LabeledEdit10.Handle, GWL_STYLE, GetWindowLong(LabeledEdit10.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
end;

procedure TfrmSJ_JBXX.FormShow(Sender: TObject);
begin
  ifNewAdd:=false;
  ifPackNewAdd:=false;

  updateAdoQuery1;
end;

procedure TfrmSJ_JBXX.updateAdoQuery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select SJId as 代码,name as 名称,Model as 型号,GG as 规格,'+
  'SCCJ as 生产厂家,ApprovalNo as 批准文号,Memo as 备注,'+
  'Create_Date_Time as 创建时间,Unid from SJ_JBXX order by SJId ';
  adoquery1.Open;
end;

procedure TfrmSJ_JBXX.updateAdoQuery2;
begin
  if not adoquery1.Active then exit;

  adoquery2.Close;
  adoquery2.SQL.Clear;
  adoquery2.SQL.Text:='select PackName as 包装单位,ParentSL as 比率,SonPackName as 下级包装单位,'+
  'Create_Date_Time as 创建时间,Unid from SJ_Pack where SJUnid='+adoquery1.FieldByName('Unid').AsString;
  adoquery2.Open;
end;

procedure TfrmSJ_JBXX.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  updateAdoQuery2;
  
  ifNewAdd:=false;
  updateEdit;
end;

procedure TfrmSJ_JBXX.BitBtn1Click(Sender: TObject);
begin
  ClearEdit;
  LabeledEdit1.SetFocus;
  ifNewAdd:=true;
end;

procedure TfrmSJ_JBXX.ClearEdit;
begin
  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  LabeledEdit3.Clear;
  LabeledEdit4.Clear;
  LabeledEdit5.Clear;
  LabeledEdit6.Clear;
  LabeledEdit7.Clear;
end;

procedure TfrmSJ_JBXX.BitBtn2Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
begin
  if trim(LabeledEdit1.Text)='' then
  begin
    MESSAGEDLG('代码不能为空!',mtError,[MBOK],0);
    LabeledEdit1.SetFocus;
    exit;
  end;

  if trim(LabeledEdit2.Text)='' then
  begin
    MESSAGEDLG('名称不能为空!',mtError,[MBOK],0);
    LabeledEdit2.SetFocus;
    exit;
  end;
  
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;

  if ifNewAdd then //新增
  begin
    ifNewAdd:=false;

    sqlstr:='Insert into SJ_JBXX ('+
                        '  SJId,  name,Model, GG, SCCJ, ApprovalNo, Memo) values ('+
                        ' :SJId,:name,:Model,:GG,:SCCJ,:ApprovalNo,:Memo) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('SJId').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('Model').Value:=trim(LabeledEdit3.Text);
    adotemp11.Parameters.ParamByName('GG').Value:=trim(LabeledEdit4.Text);
    adotemp11.Parameters.ParamByName('SCCJ').Value:=trim(LabeledEdit5.Text);
    adotemp11.Parameters.ParamByName('ApprovalNo').Value:=trim(LabeledEdit6.Text);
    adotemp11.Parameters.ParamByName('Memo').Value:=trim(LabeledEdit7.Text);
    adotemp11.Open;
    ADOQuery1.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //修改
  begin
    IF AdoQuery1.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('没有记录供你修改，若要新增，请先点击"新增按钮"！');
      EXIT;
    END;

    Insert_Identity:=ADOQuery1.fieldbyname('Unid').AsInteger;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update SJ_JBXX  '+
    '  set SJId=:SJId,name=:name,Model=:Model,GG=:GG,SCCJ=:SCCJ,ApprovalNo=:ApprovalNo,Memo=:Memo '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('SJId').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('Model').Value:=trim(LabeledEdit3.Text);
    adotemp11.Parameters.ParamByName('GG').Value:=trim(LabeledEdit4.Text);
    adotemp11.Parameters.ParamByName('SCCJ').Value:=trim(LabeledEdit5.Text);
    adotemp11.Parameters.ParamByName('ApprovalNo').Value:=trim(LabeledEdit6.Text);
    adotemp11.Parameters.ParamByName('Memo').Value:=trim(LabeledEdit7.Text);
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    adotemp11.ExecSQL;
    AdoQuery1.Refresh;
  end;

  adotemp11.Free;
  AdoQuery1.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
  updateEdit;
end;

procedure TfrmSJ_JBXX.updateEdit;
begin
  if adoquery1.RecordCount<>0 then
  begin
    LabeledEdit1.Text:=trim(adoquery1.fieldbyname('代码').AsString);
    LabeledEdit2.Text:=trim(adoquery1.fieldbyname('名称').AsString);
    LabeledEdit3.Text:=trim(adoquery1.fieldbyname('型号').AsString);
    LabeledEdit4.Text:=trim(adoquery1.fieldbyname('规格').AsString);
    LabeledEdit5.Text:=trim(adoquery1.fieldbyname('生产厂家').AsString);
    LabeledEdit6.Text:=trim(adoquery1.fieldbyname('批准文号').AsString);
    LabeledEdit7.Text:=trim(adoquery1.fieldbyname('备注').AsString);
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmSJ_JBXX.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  dbgrid1.Columns.Items[0].Width:=60;
  dbgrid1.Columns.Items[1].Width:=150;
  dbgrid1.Columns.Items[2].Width:=150;
  dbgrid1.Columns.Items[3].Width:=100;
  dbgrid1.Columns.Items[4].Width:=100;
  dbgrid1.Columns.Items[5].Width:=100;
  dbgrid1.Columns.Items[6].Width:=100;
end;

procedure TfrmSJ_JBXX.BitBtn3Click(Sender: TObject);
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount=0 then exit;
  
  if (MessageDlg('是否真要删除当前记录？', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  ADOQuery1.Delete;
end;

procedure TfrmSJ_JBXX.ADOQuery2AfterScroll(DataSet: TDataSet);
begin
  ifPackNewAdd:=false;
  updatePackEdit;
end;

procedure TfrmSJ_JBXX.updatePackEdit;
begin
  if adoquery2.RecordCount<>0 then
  begin
    LabeledEdit8.Text:=trim(adoquery2.fieldbyname('包装单位').AsString);
    LabeledEdit9.Text:=trim(adoquery2.fieldbyname('下级包装单位').AsString);
    LabeledEdit10.Text:=adoquery2.fieldbyname('比率').AsString;
  end else
  begin
    ClearPackEdit;
  end;
end;

procedure TfrmSJ_JBXX.ClearPackEdit;
begin
  LabeledEdit8.Clear;
  LabeledEdit9.Clear;
  LabeledEdit10.Clear;
end;

procedure TfrmSJ_JBXX.BitBtn4Click(Sender: TObject);
begin
  ClearPackEdit;
  LabeledEdit8.SetFocus;
  ifPackNewAdd:=true;
end;

procedure TfrmSJ_JBXX.BitBtn5Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
  iParentSL,iParentSL2:integer;
begin
  if trim(LabeledEdit8.Text)='' then
  begin
    MESSAGEDLG('包装单位不能为空!',mtError,[MBOK],0);
    LabeledEdit8.SetFocus;
    exit;
  end;

  if (trim(LabeledEdit10.Text)<>'')and(not trystrtoint(LabeledEdit10.Text,iParentSL2)) then
  begin
    MESSAGEDLG('非法比率!',mtError,[MBOK],0);
    LabeledEdit10.SetFocus;
    exit;
  end;

  if (trim(LabeledEdit10.Text)<>'')and(iParentSL2<=0) then
  begin
    MESSAGEDLG('比率必须是大于0的整理!',mtError,[MBOK],0);
    LabeledEdit10.SetFocus;
    exit;
  end;

  if ((trim(LabeledEdit10.Text)<>'')and(trim(LabeledEdit9.Text)=''))
  or ((trim(LabeledEdit10.Text)='')and(trim(LabeledEdit9.Text)<>'')) then
  begin
    MESSAGEDLG('【比率】与【下级包装单位】必须同时为空或同时填写!',mtError,[MBOK],0);
    LabeledEdit10.SetFocus;
    exit;
  end;

  //if (trim(LabeledEdit9.Text)<>'')
  //and (strtoint(ScalarSQLCmd(LisConn,'select count(*) from SJ_Pack where SJUnid='+ADOQuery1.fieldbyname('Unid').AsString+' and SonPackName='''+trim(LabeledEdit9.Text)+''' '))>0) then
  //begin
  //  MESSAGEDLG('已存在相同的【下级包装单位】!',mtError,[MBOK],0);
  //  LabeledEdit9.SetFocus;
  //  exit;
  //end;

  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount=0 then exit;
  
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;

  if ifPackNewAdd then //新增
  begin
    ifPackNewAdd:=false;

    sqlstr:='Insert into SJ_Pack ('+
                        '  SJUnid, PackName, ParentSL, SonPackName) values ('+
                        ' :SJUnid,:PackName,:ParentSL,:SonPackName) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('SJUnid').Value:=ADOQuery1.fieldbyname('Unid').AsInteger;
    adotemp11.Parameters.ParamByName('PackName').Value:=trim(LabeledEdit8.Text);
    adotemp11.Parameters.ParamByName('SonPackName').Value:=trim(LabeledEdit9.Text);
    if trystrtoint(LabeledEdit10.Text,iParentSL) then
      adotemp11.Parameters.ParamByName('ParentSL').Value:=iParentSL
    else adotemp11.Parameters.ParamByName('ParentSL').Value:=null;
    adotemp11.Open;
    ADOQuery2.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //修改
  begin
    IF AdoQuery2.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('没有记录供你修改，若要新增，请先点击"新增按钮"！');
      EXIT;
    END;

    Insert_Identity:=ADOQuery2.fieldbyname('Unid').AsInteger;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update SJ_Pack  '+
    '  set PackName=:PackName,ParentSL=:ParentSL,SonPackName=:SonPackName '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('PackName').Value:=trim(LabeledEdit8.Text);
    adotemp11.Parameters.ParamByName('SonPackName').Value:=trim(LabeledEdit9.Text);
    if trystrtoint(LabeledEdit10.Text,iParentSL) then
      adotemp11.Parameters.ParamByName('ParentSL').Value:=iParentSL
    else adotemp11.Parameters.ParamByName('ParentSL').Value:=null;
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    adotemp11.ExecSQL;
    AdoQuery2.Refresh;
  end;

  adotemp11.Free;
  AdoQuery2.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
  updatePackEdit;
end;

procedure TfrmSJ_JBXX.BitBtn6Click(Sender: TObject);
begin
  if not ADOQuery2.Active then exit;
  if ADOQuery2.RecordCount=0 then exit;
  
  if (MessageDlg('是否真要删除当前记录？', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  ADOQuery2.Delete;
end;

procedure TfrmSJ_JBXX.BitBtn7Click(Sender: TObject);
var
  LYLocateRecord:TLYLocateRecord;
begin
  LYLocateRecord:=TLYLocateRecord.create(nil);
  LYLocateRecord.DataSource:=DataSource1;
  LYLocateRecord.Execute;
  LYLocateRecord.free;
end;

initialization
  ffrmSJ_JBXX:=nil;

end.
