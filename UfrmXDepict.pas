unit UfrmXDepict;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DBGrids, StdCtrls, DB, ADODB, Buttons,
  ActnList, UfrmLocateRecord,inifiles;

type
  TfrmXDepict = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    DBGrid1: TDBGrid;
    tvWareHouse: TTreeView;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    ActionList1: TActionList;
    ActAdd: TAction;
    ActSave: TAction;
    ActDel: TAction;
    ActEsc: TAction;
    ActSearch: TAction;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Splitter2: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tvWareHouseChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure BitBtn2Click(Sender: TObject);
    procedure tvWareHouseDeletion(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    fType:integer;
    procedure UpdateAdoquery1(const CurrentID:string);
    procedure UpdatetvWareHouse;
    procedure UpdateEdit;
    procedure ClearEdit;
  public
    { Public declarations }
  end;

//var
function  frmXDepict(const AType:integer): TfrmXDepict;//AType 1:��ʾ����������� 2:��ʾ���ģ�����

implementation

uses UDM, SDIMAIN;
var
  ffrmXDepict: TfrmXDepict;
  ifNewAdd:boolean;

{$R *.dfm}
////////////////////////////////////////////////////////////////////////////////
function  frmXDepict(const AType:integer): TfrmXDepict;  {��̬�������庯��}
begin
  if ffrmXDepict=nil then ffrmXDepict:=tfrmXDepict.Create(application.mainform);
  result:=ffrmXDepict;
  frmXDepict.fType:=AType;
end;

procedure TfrmXDepict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmXDepict=self then ffrmXDepict:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmXDepict.UpdatetvWareHouse;
var
  adotemp11:tadoquery;
  Node: TTreeNode;
  DescriptType:PDescriptType;
begin
  tvWareHouse.Items.Clear;
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;

  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select * from RisDescriptType where (sysname='''+sysname+''') and ((UpID is null) or (UpID='''')) ';
  adotemp11.Open;
  while not adotemp11.Eof do
  begin
    new(DescriptType);//Ϊָ������ڴ�
    DescriptType^.ID:=adotemp11.fieldbyname('ID').AsString;
    DescriptType^.UpID:=adotemp11.fieldbyname('UpID').AsString;
    Node:=tvWareHouse.Items.AddChildObject(nil,adotemp11.fieldbyname('name').AsString,DescriptType);//.Add(nil,'['+adotemp11.fieldbyname('Id').AsString+']'+adotemp11.fieldbyname('name').AsString);

    if HasSubInDbf(node) then Node.HasChildren := True;//�ж��Ƿ����ӽڵ㣬���������Ƿ���ʾǰ���'+'

    adotemp11.Next;
  end;
  adotemp11.free;
end;

procedure TfrmXDepict.FormShow(Sender: TObject);
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  GroupBox1.Height:=configini.ReadInteger('Interface','GroupBox1Height',164);
  configini.Free;

  ifNewAdd:=false;

  if fType=2 then
  begin
    BitBtn3.Enabled:=false;
    BitBtn4.Enabled:=false;
    //Caption:='�����������';
  end;

  UpdatetvWareHouse;

  if tvWareHouse.Selected = nil then
  begin
    exit;
  end;

  UpdateAdoquery1(PDescriptType(tvWareHouse.Selected.data)^.ID);

  updateEdit;
end;

procedure TfrmXDepict.tvWareHouseChange(Sender: TObject; Node: TTreeNode);
var
  adotemp11:tadoquery;
  ChildNode:ttreenode;
  DescriptType:PDescriptType;
begin
  node.DeleteChildren;//����ڵ��µ������ӽڵ�

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;

  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select * from RisDescriptType where UpID=:UpID';
  adotemp11.Parameters.ParamByName('UpID').Value:=PDescriptType(Node.Data)^.ID;
  adotemp11.Open;
  while not adotemp11.Eof do
  begin
    new(DescriptType);//Ϊָ������ڴ�
    DescriptType^.ID:=adotemp11.fieldbyname('ID').AsString;
    DescriptType^.UpID:=adotemp11.fieldbyname('UpID').AsString;

    ChildNode:=tvWareHouse.Items.AddChildObject(node,adotemp11.fieldbyname('Name').AsString,DescriptType);

    if HasSubInDbf(ChildNode) then ChildNode.HasChildren := True;//�ж��Ƿ����ӽڵ㣬���������Ƿ���ʾǰ���'+'

    adotemp11.Next;
  end;

  UpdateAdoquery1(PDescriptType(Node.Data)^.ID);
end;

procedure TfrmXDepict.UpdateAdoquery1(const CurrentID:string);
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='select Name as ����,ID as ���,pym as ƴ����,wbm as �����,Content as ����,XxIdea as ���,Unid as Ψһ��� from RisDescription where PKID='''+CurrentID+''' ';
  adoquery1.Open;
end;

procedure TfrmXDepict.FormCreate(Sender: TObject);
begin
  ChangeYouFormAllControlIme(Self);//�����������뷨

  adoquery1.Connection:=dm.ADOConnection1;
end;

procedure TfrmXDepict.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  dbgrid1.Columns[0].Width:=175;
  dbgrid1.Columns[1].Width:=50;
  //dbgrid1.Columns[2].Width:=50;
end;

procedure TfrmXDepict.BitBtn6Click(Sender: TObject);
begin
  close;
end;

procedure TfrmXDepict.UpdateEdit;
begin
  if adoquery1.RecordCount<>0 then
  begin
    LabeledEdit1.Text:=trim(adoquery1.fieldbyname('���').AsString);
    LabeledEdit2.Text:=trim(adoquery1.fieldbyname('����').AsString);
    Memo1.Lines.Text:=(adoquery1.fieldbyname('����').AsString);
  end else
  begin
    ClearEdit;
  end;
end;

procedure TfrmXDepict.ClearEdit;
begin
  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  Memo1.Lines.Clear;
end;

procedure TfrmXDepict.BitBtn1Click(Sender: TObject);
begin
  ClearEdit;
  LabeledEdit1.SetFocus;
  ifNewAdd:=true;
end;

procedure TfrmXDepict.BitBtn3Click(Sender: TObject);
var
  adotemp11:tadoquery;
  unid,Insert_Identity:integer;
  sqlstr:string;
begin
  if tvWareHouse.Selected=nil then
  begin
    MessageBox(Handle, '��ѡ��һ�����!', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION);
    exit;
  end;//}

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  if ifNewAdd then //����
  begin
    ifNewAdd:=false;
    sqlstr:='Insert into RisDescription ('+
                        ' id,name,Content,pkid,XxIdea) values ('+
                        ' :id,:name,:Content,:pkid,:XxIdea) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('id').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('Content').Value:=memo1.Lines.Text;
    adotemp11.Parameters.ParamByName('pkid').Value:=PDescriptType(tvWareHouse.Selected.Data)^.ID;
    adotemp11.Parameters.ParamByName('XxIdea').Value:='';
    adotemp11.Open;
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
    AdoQuery1.Close;
    ADOQUERY1.Open;
    AdoQuery1.Locate('Ψһ���',Insert_Identity,[loCaseInsensitive]) ;
  end else //�޸�
  begin
    IF AdoQuery1.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('û�м�¼�����޸ģ���Ҫ���������ȵ��"������ť"��');
      EXIT;
    END;
    unid:=adoquery1.fieldbyname('Ψһ���').AsInteger;

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update RisDescription  '+
    '  set id=:id,name=:name,Content=:Content,XxIdea=:XxIdea  '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('id').Value:=trim(LabeledEdit1.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2.Text);
    adotemp11.Parameters.ParamByName('Content').Value:=memo1.Lines.Text;
    adotemp11.Parameters.ParamByName('unid').Value:=unid;
    adotemp11.Parameters.ParamByName('XxIdea').Value:='';
    adotemp11.ExecSQL;
    AdoQuery1.Refresh;
    AdoQuery1.Locate('Ψһ���',unid,[loCaseInsensitive]) ;
  end;

  updateEdit;
  adotemp11.Free;
end;

procedure TfrmXDepict.BitBtn4Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  
    DBGrid1.DataSource.DataSet.Delete;

    adoquery1.Refresh;
    updateEdit;
end;

procedure TfrmXDepict.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
{  ifNewAdd:=false;
  updateEdit;//}//��ADOQuery1����û�м�¼,���ᴥ�����¼�,�༭�򲻻����.����DataSource1DataChange�¼�����
end;

procedure TfrmXDepict.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  ifNewAdd:=false;
  updateEdit;
end;

procedure TfrmXDepict.BitBtn2Click(Sender: TObject);
var
  LYLocateRecord:TLYLocateRecord;
begin
  LYLocateRecord:=TLYLocateRecord.create(nil);
  LYLocateRecord.DataSource:=DataSource1;
  LYLocateRecord.Execute;
  LYLocateRecord.free;
end;

procedure TfrmXDepict.tvWareHouseDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  Dispose(Node.Data);//�ͷŽڵ������ڴ�
end;

procedure TfrmXDepict.FormDestroy(Sender: TObject);
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteInteger('Interface','GroupBox1Height',GroupBox1.Height);

  configini.Free;
end;

procedure TfrmXDepict.DBGrid1DblClick(Sender: TObject);
begin
  if fType<>2 then exit;

  if not adoquery1.Active then exit;
  if adoquery1.RecordCount=0 then exit;

  sdiappform.meValueDesc.Lines.Add(ADOQuery1.fieldbyname('����').AsString);
end;

initialization
  ffrmXDepict:=nil;

end.
