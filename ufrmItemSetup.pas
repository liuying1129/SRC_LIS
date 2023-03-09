unit UfrmItemSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB,
  DosMove, UfrmLocateRecord, ULYDataToExcel;

type
  TfrmItemSetup = class(TForm)
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ADOQuery2: TADOQuery;
    ADOQuery4: TADOQuery;
    DataSource4: TDataSource;
    DosMove1: TDosMove;
    LYDataToExcel1: TLYDataToExcel;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    LabeledEdit1chkitem: TLabeledEdit;
    LabeledEdit2chkitem: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4chkitem: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit13chkitem: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    LabeledEdit9: TLabeledEdit;
    BitBtn8: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    Label4: TLabel;
    DBGrid1: TDBGrid;
    LabeledEdit1combin: TLabeledEdit;
    LabeledEdit2combin: TLabeledEdit;
    LabeledEdit9combin: TLabeledEdit;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn4: TBitBtn;
    DBGrid2: TDBGrid;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    DBGrid4: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    GroupBox1: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Panel2: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Label19: TLabel;
    Memo1: TMemo;
    LabeledEdit8combin: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit14: TComboBox;
    LabeledEdit8: TComboBox;
    Label18: TLabel;
    Label20: TLabel;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    ComboBox1: TComboBox;
    Label21: TLabel;
    BitBtn16: TBitBtn;
    Label25: TLabel;
    Panel9: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure ADOQuery2AfterScroll(DataSet: TDataSet);
    procedure BitBtn8Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn12Click(Sender: TObject);
    procedure ADOQuery4AfterOpen(DataSet: TDataSet);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure ADOQuery2AfterOpen(DataSet: TDataSet);
    procedure DBGrid4DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ADOQuery4AfterScroll(DataSet: TDataSet);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
  private
    { Private declarations }
    procedure updateedit;
    procedure updateedit2;
    procedure updateadoquery1;
    procedure update_CombinItemSChkItem;   //���������Ŀ�ļ�����Ŀ
    procedure ClearItemEdit;
    procedure ClearCombEdit;
  public
    { Public declarations }
  end;

//var
function  frmItemSetup: TfrmItemSetup;

implementation

uses ufrm_referencevalue, UDM, SDIMAIN, UfrmCommValue, UfrmHisCombItem,UfrmExtItemSetup,
  UfrmExceptionValue;


const
  SmallItemSql='select itemid as ��Ŀ����,name as ����,english_name as Ӣ����,'+
          ' printorder as ˳��,dlttype as ������ʶ��,commword as ������ĸ,'+
          ' price as �۸�,defaultvalue as Ĭ��ֵ,unit as ��λ,'+
          ' caculexpress as ���㹫ʽ,'+
          ' pym as ƴ������,wbm as ��ʼ���, '+
          ' SysName as ϵͳ����,unid '+
          ' from clinicchkitem '+
          ' order by itemid ';
var
  ffrmItemSetup: TfrmItemSetup;
  ifNewAddItem,ifNewAddComb:boolean;
{$R *.dfm}


////////////////////////////////////////////////////////////////////////////////
function frmItemSetup: TfrmItemSetup;
begin
  if ffrmItemSetup=nil then ffrmItemSetup:=TfrmItemSetup.Create(application.mainform);
  result:=ffrmItemSetup;
end;

procedure TfrmItemSetup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmItemSetup=self then ffrmItemSetup:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmItemSetup.FormCreate(Sender: TObject);
var
  sqlstr:string;
begin
  adoquery4.Connection:=DM.ADOConnection1;
  adoquery1.Connection:=DM.ADOConnection1;

  updateadoquery1;

  adoquery2.Connection:=DM.ADOConnection1;
  sqlstr:='select id as ��Ŀ����,name as ����,specimentype_DfValue as Ĭ����������,dept_DfValue as Ĭ�Ϲ�����,itemtype as �����ָ���,remark as ˵��,Department as ��������,SysName as ϵͳ����,Unid'+
          ' from combinitem order by id ';
  adoquery2.Close;
  adoquery2.SQL.Clear;
  adoquery2.SQL.Text:=sqlstr;
  adoquery2.Open;

  update_CombinItemSChkItem;
  
  updateedit;

  LoadGroupName(LabeledEdit14,'select name from CommCode where TypeName=''�������'' AND SysName='''+SYSNAME+''' group by name');
  
  LoadGroupName(LabeledEdit8,'select name from CommCode where TypeName=''��������'' group by name');//������������

  LoadGroupName(ComboBox1,'select name from CommCode where TypeName=''����'' ');//������������

  updateedit2;

  ChangeYouFormAllControlIme(Self);//�����������뷨

  SetWindowLong(LabeledEdit1chkitem.Handle, GWL_STYLE, GetWindowLong(LabeledEdit1chkitem.Handle, GWL_STYLE) or ES_NUMBER);//ֻ����������
  SetWindowLong(LabeledEdit1combin.Handle, GWL_STYLE, GetWindowLong(LabeledEdit1combin.Handle, GWL_STYLE) or ES_NUMBER);//ֻ����������
  SetWindowLong(LabeledEdit1.Handle, GWL_STYLE, GetWindowLong(LabeledEdit1.Handle, GWL_STYLE) or ES_NUMBER);//ֻ����������
end;

procedure TfrmItemSetup.BitBtn1Click(Sender: TObject);
begin
  ClearItemEdit;
  if LabeledEdit1chkitem.CanFocus then LabeledEdit1chkitem.SetFocus;

  ifNewAddItem:=true;
end;

procedure TfrmItemSetup.updateedit;
begin
          if adoquery1.RecordCount>0 then
          begin
            LabeledEdit1chkitem.Text:=trim(adoquery1.fieldbyname('��Ŀ����').AsString);
            LabeledEdit2chkitem.Text:=trim(adoquery1.fieldbyname('����').AsString);
            LabeledEdit3.Text:=trim(adoquery1.fieldbyname('Ӣ����').AsString);
            LabeledEdit6.Text:=trim(adoquery1.fieldbyname('�۸�').AsString);
            LabeledEdit13chkitem.Text:=trim(adoquery1.fieldbyname('���㹫ʽ').AsString);
            LabeledEdit4chkitem.Text:=trim(adoquery1.fieldbyname('��λ').AsString);
            LabeledEdit2.Text:=trim(adoquery1.fieldbyname('������ʶ��').AsString);
            LabeledEdit9.Text:=trim(adoquery1.fieldbyname('������ĸ').AsString);
            LabeledEdit1.Text:=trim(adoquery1.fieldbyname('˳��').AsString);
          end else
          begin
            ClearItemEdit;
          end;
end;

procedure TfrmItemSetup.BitBtn2Click(Sender: TObject);
var
    adotemp11:tadoquery;
    sqlstr:string;
    Insert_Identity:integer;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAddItem then //����
  begin
    ifNewAddItem:=false;
    sqlstr:='insert into clinicchkitem (itemid,name,english_name,'+
      ' printorder,unit,price,caculexpress,'+
      ' dlttype,commword,SysName)values( '+
      ' :itemid,:name,:english_name,'+
      ' :printorder,:unit,:price,:caculexpress,'+
      ' :dlttype,:commword,:SysName) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('itemid').Value:=trim(LabeledEdit1chkitem.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2chkitem.Text);
    adotemp11.Parameters.ParamByName('english_name').Value:=trim(LabeledEdit3.Text);
    adotemp11.Parameters.ParamByName('price').Value:=strtofloatdef(LabeledEdit6.Text,0);
    adotemp11.Parameters.ParamByName('caculexpress').Value:=trim(LabeledEdit13chkitem.Text);
    adotemp11.Parameters.ParamByName('dlttype').Value:=trim(LabeledEdit2.text);
    adotemp11.Parameters.ParamByName('unit').Value:=trim(LabeledEdit4chkitem.text);
    adotemp11.Parameters.ParamByName('commword').Value:=uppercase(trim(LabeledEdit9.text));
    adotemp11.Parameters.ParamByName('printorder').Value:=strtointdef(LabeledEdit1.text,0);
    adotemp11.Parameters.ParamByName('SysName').Value:=SYSNAME;
    adotemp11.Open;
    ADOQuery1.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else
  begin
    IF AdoQuery1.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('û�м�¼�����޸ģ���Ҫ���������ȵ��"������ť"��');
      EXIT;
    END;
    
    if ADOQuery1.FieldByName('ϵͳ����').AsString<>SYSNAME then
    begin
      adotemp11.Free;
      MESSAGEDLG('����Ȩ�޸�����ϵͳ��ϸ��Ŀ!',mtError,[MBOK],0);
      exit;
    end;
    
    Insert_Identity:=ADOQuery1.fieldbyname('Unid').AsInteger;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update clinicchkitem  '+
      ' set itemid=:itemid,name=:name,english_name=:english_name,'+
      ' printorder=:printorder,unit=:unit,'+
      ' price=:price,caculexpress=:caculexpress,'+
      ' dlttype=:dlttype,commword=:commword,'+//Dosage1=:Dosage1,
      ' SysName=:SysName  '+
      ' Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('itemid').Value:=trim(LabeledEdit1chkitem.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2chkitem.Text);
    adotemp11.Parameters.ParamByName('english_name').Value:=trim(LabeledEdit3.Text);
    adotemp11.Parameters.ParamByName('price').Value:=strtofloatdef(LabeledEdit6.Text,0);
    adotemp11.Parameters.ParamByName('caculexpress').Value:=trim(LabeledEdit13chkitem.Text);
    adotemp11.Parameters.ParamByName('dlttype').Value:=trim(LabeledEdit2.text);
    adotemp11.Parameters.ParamByName('unit').Value:=trim(LabeledEdit4chkitem.text);
    adotemp11.Parameters.ParamByName('commword').Value:=uppercase(trim(LabeledEdit9.text));
    adotemp11.Parameters.ParamByName('printorder').Value:=strtointdef(LabeledEdit1.text,0);
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    adotemp11.Parameters.ParamByName('SysName').Value:=SYSNAME;
    adotemp11.ExecSQL;
    AdoQuery1.Refresh;
  end;
  adotemp11.Free;
  AdoQuery1.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
  updateEdit;
end;

procedure TfrmItemSetup.BitBtn3Click(Sender: TObject);
var
  iitemid:string;
begin
  if not adoquery1.Active then exit;
  if adoquery1.RecordCount=0 then exit;
  iitemid:=adoquery1.fieldbyname('��Ŀ����').AsString;
  if messagedlg('ȷʵҪɾ������Ŀ��',mtWarning,mbOKCancel,0)<>mrok then exit;

  if adoquery1.FieldByName('ϵͳ����').AsString<>SYSNAME then
  begin
    MESSAGEDLG('����Ȩɾ������ϵͳ��ϸ��Ŀ!',mtError,[MBOK],0);
    exit;
  end;
  
  DBGrid1.DataSource.DataSet.Delete;

  adoquery1.Refresh;
  updateEdit;
end;

procedure TfrmItemSetup.BitBtn5Click(Sender: TObject);
begin
  ClearCombEdit;
  if LabeledEdit1combin.CanFocus then LabeledEdit1combin.SetFocus;
  
  ifNewAddComb:=true;
end;

procedure TfrmItemSetup.updateedit2;
begin
  if not adoquery2.Active then exit;
  if adoquery2.RecordCount>0 then
  begin
    LabeledEdit1combin.Text:=trim(adoquery2.fieldbyname('��Ŀ����').AsString);
    LabeledEdit2combin.Text:=trim(adoquery2.fieldbyname('����').AsString);
    LabeledEdit9combin.Text:=trim(adoquery2.fieldbyname('˵��').AsString);
    //�����Ŀ�۸�
    LabeledEdit8combin.Text:=ScalarSQLCmd(LisConn,'select sum(price) as CombItemPrice from CombSChkItem,clinicchkitem where CombSChkItem.ItemUnid=clinicchkitem.unid and CombUnid='+adoquery2.fieldbyname('Unid').AsString);
    //============

    LabeledEdit8.Text:=trim(adoquery2.fieldbyname('Ĭ����������').AsString);
    LabeledEdit14.Text:=trim(adoquery2.fieldbyname('Ĭ�Ϲ�����').AsString);
    LabeledEdit15.Text:=trim(adoquery2.fieldbyname('�����ָ���').AsString);

    ComboBox1.Text:=trim(adoquery2.fieldbyname('��������').AsString);
  end else
  begin
    ClearCombEdit;
  end;
end;

procedure TfrmItemSetup.BitBtn7Click(Sender: TObject);
begin
  if not adoquery2.Active then exit;
  if adoquery2.RecordCount=0 then exit;

  if adoquery2.FieldByName('ϵͳ����').AsString<>SYSNAME then
  begin
    MESSAGEDLG('����Ȩɾ������ϵͳ�������Ŀ!',mtError,[MBOK],0);
    exit;
  end;
  
  if messagedlg('ȷʵҪɾ������Ŀ��',mtWarning,mbOKCancel,0)<>mrok then exit;

  adoquery2.Delete;
  adoquery2.Refresh;
  updateedit2;

  //=============����������������ĿCheckListBox=======================//
  sdiappform.MakeCombinChecklistbox;
  sdiappform.update_Ado_dtl;
  //====================================================================//
end;

procedure TfrmItemSetup.BitBtn6Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAddComb then //����
  begin
    ifNewAddComb:=false;

    sqlstr:='Insert into combinitem ('+
                        ' ID,name,Remark,specimentype_DfValue,dept_DfValue,itemtype,Department,SysName) values ('+
                        ' :ID,:name,:Remark,:specimentype_DfValue,:dept_DfValue,:itemtype,:Department,:SysName) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Parameters.ParamByName('ID').Value:=trim(LabeledEdit1combin.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2combin.Text);
    adotemp11.Parameters.ParamByName('Remark').Value:=trim(LabeledEdit9combin.Text);

    adotemp11.Parameters.ParamByName('specimentype_DfValue').Value:=LabeledEdit8.Text;
    adotemp11.Parameters.ParamByName('dept_DfValue').Value:=LabeledEdit14.Text;
    adotemp11.Parameters.ParamByName('itemtype').Value:=LabeledEdit15.Text;

    adotemp11.Parameters.ParamByName('Department').Value:=ComboBox1.Text;
    adotemp11.Parameters.ParamByName('SysName').Value:=SYSNAME;

    adotemp11.Open;
    ADOQuery2.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //�޸�
  begin
    IF AdoQuery2.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('û�м�¼�����޸ģ���Ҫ���������ȵ��"������ť"��');
      EXIT;
    END;
    
    if ADOQuery2.FieldByName('ϵͳ����').AsString<>SYSNAME then
    begin
      adotemp11.Free;
      MESSAGEDLG('����Ȩ�޸�����ϵͳ�������Ŀ!',mtError,[MBOK],0);
      exit;
    end;
    
    Insert_Identity:=ADOQuery2.fieldbyname('Unid').AsInteger;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update combinitem  '+
    '  set ID=:ID,name=:name,Remark=:Remark,specimentype_DfValue=:specimentype_DfValue,dept_DfValue=:dept_DfValue,itemtype=:itemtype,Department=:Department,SysName=:SysName '+
    '  Where    Unid=:Unid      ';
    adotemp11.Parameters.ParamByName('ID').Value:=trim(LabeledEdit1combin.Text);
    adotemp11.Parameters.ParamByName('name').Value:=trim(LabeledEdit2combin.Text);
    adotemp11.Parameters.ParamByName('Remark').Value:=trim(LabeledEdit9combin.Text);
    adotemp11.Parameters.ParamByName('Unid').Value:=Insert_Identity;
    
    adotemp11.Parameters.ParamByName('specimentype_DfValue').Value:=LabeledEdit8.Text;
    adotemp11.Parameters.ParamByName('dept_DfValue').Value:=LabeledEdit14.Text;
    adotemp11.Parameters.ParamByName('itemtype').Value:=LabeledEdit15.Text;

    adotemp11.Parameters.ParamByName('Department').Value:=ComboBox1.Text;
    adotemp11.Parameters.ParamByName('SysName').Value:=SYSNAME;
    
    adotemp11.ExecSQL;
    AdoQuery2.Refresh;
  end;

  adotemp11.Free;
  AdoQuery2.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
  updateEdit2;
  
        //=============����������������ĿCheckListBox=======================//
        sdiappform.MakeCombinChecklistbox;
        sdiappform.update_Ado_dtl;
        //====================================================================//
end;

procedure TfrmItemSetup.BitBtn9Click(Sender: TObject);
var
  ADOQuery_temp:tadoquery;
  CombUnid,ItemUnid:integer;
begin
  if adoquery1.RecordCount=0 then exit;
  if adoquery2.RecordCount=0 then exit;

  if adoquery2.FieldByName('ϵͳ����').AsString<>SYSNAME then
  begin
    MESSAGEDLG('����Ȩ�༭����ϵͳ�������Ŀ!',mtError,[MBOK],0);
    exit;
  end;
  
      ItemUnid:=adoquery1.FieldByName('unid').AsInteger;
      CombUnid:=adoquery2.FieldByName('unid').AsInteger;

        ADOQuery_temp:=tadoquery.Create(nil);
        ADOQuery_temp.Connection:=DM.ADOConnection1;

        ADOQuery_temp.Close;
        ADOQuery_temp.SQL.Clear;
        ADOQuery_temp.SQL.Text:=' insert into CombSChkItem (CombUnid,ItemUnid'+
                          ') values (:CombUnid,:ItemUnid'+
                          ') ';
        ADOQuery_temp.Parameters.ParamByName('CombUnid').Value:=CombUnid;
        ADOQuery_temp.Parameters.ParamByName('ItemUnid').Value:=ItemUnid;
        ADOQuery_temp.ExecSQL;

        ADOQuery_temp.Free;

  update_CombinItemSChkItem;
end;

procedure TfrmItemSetup.BitBtn10Click(Sender: TObject);
begin
  if adoquery4.RecordCount=0 then exit;

  if adoquery2.FieldByName('ϵͳ����').AsString<>SYSNAME then
  begin
    MESSAGEDLG('����Ȩ�༭����ϵͳ�������Ŀ!',mtError,[MBOK],0);
    exit;
  end;
  
  ExecSQLCmd(LisConn,'delete from CombSChkItem where unid='+adoquery4.fieldbyname('unid').AsString);

  update_CombinItemSChkItem;
end;

procedure TfrmItemSetup.update_CombinItemSChkItem;
var
  sqlstr:string;
  CombUnid:integer;
begin
  CombUnid:=adoquery2.fieldbyname('Unid').AsInteger;
  sqlstr:='select (select top 1 printorder from clinicchkitem A where A.Unid=ItemUnid) as ˳��,'+
          ' (select top 1 name from clinicchkitem B where B.Unid=ItemUnid) as ����,'+
          ' (select top 1 english_name from clinicchkitem C where C.Unid=ItemUnid) as Ӣ����,'+
          ' (select top 1 itemid from clinicchkitem D where D.Unid=ItemUnid) as ��Ŀ����, '+
          ' (select top 1 caculexpress from clinicchkitem E where E.Unid=ItemUnid) as caculexpress,'+
          ' (select top 1 COMMWORD from clinicchkitem F where F.Unid=ItemUnid) as COMMWORD, '+
          ' ItemUnid,unid from CombSChkItem '+
          ' where CombUnid= '+inttostr(CombUnid)+
          ' order by ˳�� ';
  adoquery4.Close;
  adoquery4.SQL.Clear;
  adoquery4.SQL.Add(sqlstr);
  adoquery4.Open;
end;

procedure TfrmItemSetup.updateadoquery1;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:=SmallItemSql;
  adoquery1.Open;
end;

procedure TfrmItemSetup.BitBtn4Click(Sender: TObject);
var
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='dbo.pro_PrintCombinItem';
  adotemp11.Open;

  LYDataToExcel1.DataSet:=adotemp11;
  LYDataToExcel1.ExcelTitel:='�����Ŀ';
  LYDataToExcel1.Execute;
  
  adotemp11.Free;
end;

procedure TfrmItemSetup.ADOQuery1AfterScroll(DataSet: TDataSet);
var
  ItemUnid:string;
  adotemp22:tadoquery;
begin
  ifNewAddItem:=false;
  updateedit;

  //����Ŀ������Щ���
  Memo1.Clear;
  Memo1.Lines.Add('�������:');
  ItemUnid:=ADOQuery1.fieldbyname('Unid').AsString;
  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select B.name from CombSChkItem A,combinitem B where B.Unid=A.CombUnid and A.ItemUnid='+ItemUnid;
  adotemp22.Open;
  while not adotemp22.Eof do
  begin
    Memo1.Lines.Add(adotemp22.fieldbyname('name').AsString);
    adotemp22.Next;
  end;
  adotemp22.Free;
  //==================
end;

procedure TfrmItemSetup.ADOQuery2AfterScroll(DataSet: TDataSet);
begin
  ifNewAddComb:=false;
  updateedit2;
  update_CombinItemSChkItem;
end;

procedure TfrmItemSetup.BitBtn8Click(Sender: TObject);
begin
  if adoquery1.RecordCount=0 then exit;
  frm_referencevalue.ShowModal;
end;

procedure TfrmItemSetup.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn8Click(nil);
end;

procedure TfrmItemSetup.BitBtn11Click(Sender: TObject);
var
  LYLocateRecord:TLYLocateRecord;
begin
  LYLocateRecord:=TLYLocateRecord.create(nil);
  LYLocateRecord.DataSource:=DataSource1;
  LYLocateRecord.Execute;
  LYLocateRecord.free;
end;

procedure TfrmItemSetup.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  caculexpress:string;
  COMMWORD:string;
  ItemUnid:string;
begin
  //================�ò�ͬ����ɫ�����ֹ���������������Ŀ======================//
  if datacol=1 then //������
  begin
    caculexpress:=trim(tdbgrid(sender).DataSource.DataSet.fieldbyname('���㹫ʽ').AsString);
    COMMWORD:=trim(tdbgrid(sender).DataSource.DataSet.fieldbyname('������ĸ').AsString);
    IF caculexpress<>'' then
      tdbgrid(sender).Canvas.Brush.Color:=$00aad5d5;
    IF COMMWORD<>'' then
      tdbgrid(sender).Canvas.Brush.Color:=clLime;
    IF (COMMWORD<>'')and(caculexpress<>'') then
      tdbgrid(sender).Canvas.Brush.Color:=clred;
    tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
  end;
  //==========================================================================//

  //====================��ɫ�����ʾ�������κ������Ŀ========================//
  if datacol=0 then //��Ŀ������
  begin
    ItemUnid:=tdbgrid(sender).DataSource.DataSet.fieldbyname('Unid').AsString;
    if '1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from CombSChkItem where ItemUnid='+ItemUnid) then
    begin
      tdbgrid(sender).Canvas.Font.Color:=clBlue;
      tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
    end;
  end;
  //==========================================================================//
end;

procedure TfrmItemSetup.DBGrid4DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  caculexpress:string;
  COMMWORD:string;
begin
  //================�ò�ͬ����ɫ�����ֹ���������������Ŀ======================//
  if datacol=1 then //������
  begin
    caculexpress:=trim(TDBGrid(Sender).DataSource.DataSet.fieldbyname('caculexpress').AsString);
    COMMWORD:=trim(TDBGrid(Sender).DataSource.DataSet.fieldbyname('COMMWORD').AsString);
    IF caculexpress<>'' then
      tdbgrid(sender).Canvas.Brush.Color:=$00aad5d5;
    IF COMMWORD<>'' then
      tdbgrid(sender).Canvas.Brush.Color:=clLime;
    IF (COMMWORD<>'')and(caculexpress<>'') then
      tdbgrid(sender).Canvas.Brush.Color:=clred;
    tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
  end;
  //==========================================================================//
end;

procedure TfrmItemSetup.BitBtn12Click(Sender: TObject);
var
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select '+
           ' (select top 1 itemid from clinicchkitem where itemid=r.id) as ��Ŀ����,'+
           ' (select top 1 name from clinicchkitem where itemid=r.id) as ��Ŀ����,'+
           ' r.sex as �Ա�,r.minvalue ��Сֵ,'+
           ' r.maxvalue ���ֵ,'+
           ' (select top 1 unit from clinicchkitem where itemid=r.id) as ��λ,'+
           ' r.age_low_display ��������, '+
           ' r.age_high_display �������� '+
           ' from referencevalue R '+
           ' order by ��Ŀ����,�Ա� ';
  adotemp11.Open;

  LYDataToExcel1.DataSet:=adotemp11;
  LYDataToExcel1.ExcelTitel:='������Ŀ�ο�ֵ';
  LYDataToExcel1.Execute;
  
  adotemp11.Free;
end;

procedure TfrmItemSetup.ADOQuery4AfterOpen(DataSet: TDataSet);
begin
  dbgrid4.Columns[0].width:=55;
  dbgrid4.Columns[1].width:=90;
end;

procedure TfrmItemSetup.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  dbgrid1.Columns[0].width:=55;
  dbgrid1.Columns[1].width:=110;
  dbgrid1.Columns[2].width:=40;
  dbgrid1.Columns[3].width:=35;
  dbgrid1.Columns[4].width:=45;
end;

procedure TfrmItemSetup.ADOQuery2AfterOpen(DataSet: TDataSet);
begin
  dbgrid2.Columns[0].width:=60;
  dbgrid2.Columns[1].width:=100;
  dbgrid2.Columns[2].width:=85;
  dbgrid2.Columns[3].width:=80;
  dbgrid2.Columns[4].width:=80;
  dbgrid2.Columns[5].width:=100;
  dbgrid2.Columns[6].width:=70;
end;

procedure TfrmItemSetup.ClearItemEdit;
begin
            LabeledEdit1chkitem.Clear;
            LabeledEdit2chkitem.Clear;
            LabeledEdit3.Clear;
            LabeledEdit6.Clear;
            LabeledEdit13chkitem.Clear;
            LabeledEdit4chkitem.Clear;
            LabeledEdit2.Clear;
            LabeledEdit9.Clear;
            LabeledEdit1.Clear;
            //LabeledEdit5.Clear;
            //LabeledEdit7.Clear;
            //LabeledEdit10.Clear;
            //LabeledEdit11.Clear;
            //LabeledEdit12.Clear;
            //LabeledEdit13.Clear;
end;

procedure TfrmItemSetup.ClearCombEdit;
begin
            LabeledEdit1combin.Clear;
            LabeledEdit2combin.Clear;
            LabeledEdit9combin.Clear;
            LabeledEdit8combin.Clear;
            LabeledEdit8.Text:='';
            LabeledEdit14.Text:='';
            LabeledEdit15.Clear;
            ComboBox1.Text:='';
end;

procedure TfrmItemSetup.ADOQuery4AfterScroll(DataSet: TDataSet);
begin
  if not ADOQuery1.Active then exit;
  ADOQuery1.Locate('Unid',ADOQuery4.fieldbyname('ItemUnid').AsString,[]);
end;

procedure TfrmItemSetup.BitBtn13Click(Sender: TObject);
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount<=0 then exit;
  
  frmCommValue(ADOQuery1.fieldbyname('unid').AsInteger).ShowModal;
end;

procedure TfrmItemSetup.BitBtn14Click(Sender: TObject);
begin
  if not ADOQuery2.Active then exit;
  if ADOQuery2.RecordCount<=0 then exit;
  
  frmHisCombItem(ADOQuery2.fieldbyname('unid').AsInteger).ShowModal;
end;

procedure TfrmItemSetup.BitBtn15Click(Sender: TObject);
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount<=0 then exit;
  
  frmExtItemSetup(adoquery1.fieldbyname('unid').asinteger).ShowModal;
end;

procedure TfrmItemSetup.BitBtn16Click(Sender: TObject);
begin
  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount<=0 then exit;

  frmExceptionValue(adoquery1.fieldbyname('unid').asinteger).ShowModal;
end;

initialization
  ffrmItemSetup:=nil;

end.
