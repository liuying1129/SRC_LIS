unit UfrmXDepictType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, StdCtrls, ExtCtrls, Buttons,ADODB,StrUtils,
  DosMove, ActnList, DBCtrls, DB;

type
  TfrmXDepictType = class(TForm)
    GroupBox1: TGroupBox;
    tvWareHouse: TTreeView;
    Panel1: TPanel;
    labWhId: TLabel;
    labWhName: TLabel;
    edtWhId: TEdit;
    edtWhName: TEdit;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Splitter1: TSplitter;
    DosMove1: TDosMove;
    ActionList1: TActionList;
    ActAdd1: TAction;
    ActAdd2: TAction;
    ActSave: TAction;
    ActDel: TAction;
    ActRefresh: TAction;
    ActExit: TAction;
    procedure FormShow(Sender: TObject);
    procedure tvWareHouseChange(Sender: TObject; Node: TTreeNode);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtWhNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvWareHouseDeletion(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    procedure UpdatetvWareHouse;
    procedure ClearEdit;
    procedure UpdateEdit(Node:TTreeNode);
  public
    { Public declarations }
  end;

//var
function  frmXDepictType: TfrmXDepictType;

implementation

uses UDM;

var
  ffrmXDepictType: TfrmXDepictType;
  InsertPwhid:string;
  ifInsert:boolean;

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function  frmXDepictType: TfrmXDepictType;  {动态创建窗体函数}
begin
  if ffrmXDepictType=nil then ffrmXDepictType:=tfrmXDepictType.Create(application.mainform);
  result:=ffrmXDepictType;
end;

procedure TfrmXDepictType.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmXDepictType=self then ffrmXDepictType:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmXDepictType.UpdatetvWareHouse;
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
    new(DescriptType);//为指针分配内存
    DescriptType^.ID:=adotemp11.fieldbyname('ID').AsString;
    DescriptType^.UpID:=adotemp11.fieldbyname('UpID').AsString;
    Node:=tvWareHouse.Items.AddChildObject(nil,adotemp11.fieldbyname('name').AsString,DescriptType);//.Add(nil,'['+adotemp11.fieldbyname('Id').AsString+']'+adotemp11.fieldbyname('name').AsString);

    if HasSubInDbf(node) then Node.HasChildren := True;//判断是否有子节点，用来控制是否显示前面的'+'

    adotemp11.Next;
  end;
  adotemp11.free;

  ClearEdit;      //因为重新加载TREEVIEW后就没了焦点
end;


procedure TfrmXDepictType.ClearEdit;
begin
  edtWhId.Clear;
  edtWhName.Clear;
end;

procedure TfrmXDepictType.BitBtn1Click(Sender: TObject);
var
  SelectID:string;
begin
  if '1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from RisDescriptType where sysname='''+sysname+''' ') then//否则,没有记录SelectID为默认值空('')
  begin
    if tvWareHouse.Selected=nil then
    begin
      MessageBox(Handle, '请选择一个类别!', '系统提示', MB_OK + MB_ICONINFORMATION);
      exit;
    end;
    SelectID:=PDescriptType(tvWareHouse.Selected.Data)^.ID;
  end;

  ClearEdit;
  edtWhId.Enabled:=true;
  edtWhId.SetFocus;
  ifInsert:=true;

  InsertPwhid:=ScalarSQLCmd(LisConn,'select UpID from RisDescriptType where id='''+SelectID+''' ');
end;

procedure TfrmXDepictType.BitBtn2Click(Sender: TObject);
begin
  if tvWareHouse.Selected=nil then
  begin
    MessageBox(Handle, '请选择一个类别!', '系统提示', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  ClearEdit;
  edtWhId.Enabled:=true;
  edtWhId.SetFocus;
  InsertPwhid:=PDescriptType(tvWareHouse.Selected.Data)^.ID;
  ifInsert:=true;
end;

procedure TfrmXDepictType.BitBtn3Click(Sender: TObject);
var
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;

  if ifInsert then
  begin
    adotemp11.SQL.add('Insert into RisDescriptType');
    adotemp11.SQL.add('(Id,Name,UpID,sysname)');
    adotemp11.SQL.add(' Values(');
    adotemp11.SQL.add(QuotedStr(trim(edtWhId.Text))+',');
    adotemp11.SQL.add(QuotedStr(edtWhName.Text)+',');
    adotemp11.SQL.add(QuotedStr(InsertPwhid)+',');
    adotemp11.SQL.add(QuotedStr(sysname));
    adotemp11.SQL.add(')');
  end else
  begin
    adotemp11.SQL.add('UPDATE RisDescriptType');
    adotemp11.SQL.add(' SET ');
    adotemp11.SQL.add('Name='+QuotedStr(edtWhName.Text));
    adotemp11.SQL.add(' Where Id='+QuotedStr(PDescriptType(tvWareHouse.Selected.Data)^.ID));
  end;
  try
    adotemp11.ExecSQL;
  finally
    adotemp11.Free;
    ifInsert:=false;
    edtWhId.Enabled:=false;
    UpdatetvWareHouse;
  end;
end;

procedure TfrmXDepictType.UpdateEdit(Node:TTreeNode);
begin
  edtWhId.Text:=PDescriptType(tvWareHouse.Selected.Data)^.ID;
  edtWhName.Text:=Node.Text;
end;

procedure TfrmXDepictType.BitBtn4Click(Sender: TObject);
begin
  if tvWareHouse.Selected=nil then
  begin
    MessageBox(Handle, '请选择一个类别!', '系统提示', MB_OK + MB_ICONINFORMATION);
    exit;
  end;
  
  if '1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from RisDescriptType where UpID='''+PDescriptType(tvWareHouse.Selected.Data)^.ID+''' ') then
  begin
    MessageBox(Handle, '该节点有子节点,不能删除!', '系统提示', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  if '1'=ScalarSQLCmd(LisConn,'select TOP 1 1 from RisDescription where PkID='''+PDescriptType(tvWareHouse.Selected.Data)^.ID+''' ') then
  begin
    showmessage('该节点下有描述,不能删除!');
    exit;
  end;

  if MessageBox(Handle, '真的要删除吗？', '系统提示', MB_YESNO + MB_ICONQUESTION) <> mrYes then exit;

  ExecSQLCmd(LisConn,'delete from RisDescriptType where id='''+PDescriptType(tvWareHouse.Selected.Data)^.ID+''' ');

  UpdatetvWareHouse;
end;

procedure TfrmXDepictType.FormShow(Sender: TObject);
begin
  ifInsert:=false;
  ClearEdit;
  UpdatetvWareHouse;
end;

procedure TfrmXDepictType.tvWareHouseChange(Sender: TObject;
  Node: TTreeNode);
var
  adotemp11:tadoquery;
  ChildNode:ttreenode;
  DescriptType:PDescriptType;
begin
  node.DeleteChildren;//清除节点下的所有子节点

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;

  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select * from RisDescriptType where UpID=:UpID';
  adotemp11.Parameters.ParamByName('UpID').Value:=PDescriptType(Node.Data)^.ID;
  adotemp11.Open;
  while not adotemp11.Eof do
  begin
    new(DescriptType);//为指针分配内存
    DescriptType^.ID:=adotemp11.fieldbyname('ID').AsString;
    DescriptType^.UpID:=adotemp11.fieldbyname('UpID').AsString;

    ChildNode:=tvWareHouse.Items.AddChildObject(node,adotemp11.fieldbyname('Name').AsString,DescriptType);

    if HasSubInDbf(ChildNode) then ChildNode.HasChildren := True;//判断是否有子节点，用来控制是否显示前面的'+'

    adotemp11.Next;
  end;

  UpdateEdit(Node);
end;

procedure TfrmXDepictType.BitBtn6Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmXDepictType.BitBtn5Click(Sender: TObject);
begin
  UpdatetvWareHouse;
end;

procedure TfrmXDepictType.FormCreate(Sender: TObject);
begin
  ChangeYouFormAllControlIme(Self);//设置中文输入法

  SetWindowLong(edtWhId.Handle,GWL_STYLE,GetWindowLong(edtWhId.Handle,GWL_STYLE) or ES_NUMBER);//只能输入数字
end;

procedure TfrmXDepictType.edtWhNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
    if bitbtn3.CanFocus then bitbtn3.SetFocus;
end;

procedure TfrmXDepictType.tvWareHouseDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  Dispose(Node.Data);{释放节点数据内存}
end;

initialization
  ffrmXDepictType:=nil;

end.
