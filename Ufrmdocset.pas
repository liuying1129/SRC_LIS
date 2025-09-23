unit Ufrmdocset;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB,
  DosMove, Buttons, ULYDataToExcel, StrUtils, ExtCtrls;

type
  Tfrmdocset = class(TForm)
    ADOdoclist: TADOQuery;
    DataSourcedoclist: TDataSource;
    DosMove1: TDosMove;
    LYDataToExcel1: TLYDataToExcel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Panel1: TPanel;
    suiButton1: TSpeedButton;
    suiButton2: TSpeedButton;
    suiButton3: TSpeedButton;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Panel3: TPanel;
    Label1: TLabel;
    ComboBox2: TComboBox;
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOdoclistAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox2DropDown(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    function GetDepUnid:string;
    procedure UpdateADOdoclist;
    procedure docrefresh;
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function frmdocset: Tfrmdocset;

implementation
uses  UDM, SDIMAIN;

var
  ifdocnewadd:boolean;
  ffrmdocset: Tfrmdocset;

{$R *.dfm}

function frmdocset: Tfrmdocset;
begin
  if ffrmdocset=nil then ffrmdocset:=Tfrmdocset.Create(application.mainform);
  result:=ffrmdocset;
end;

procedure Tfrmdocset.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmdocset=self then ffrmdocset:=nil;
end;

procedure Tfrmdocset.suiButton1Click(Sender: TObject);
begin
  if not ADOdoclist.Active then exit;
  
  if trim(GetDepUnid)='' then//�û��������
  begin
    MessageDlg('����ǰ����ѡ���ţ�',mtError,[MBOK],0);
    exit;
  end;

  LabeledEdit1.Clear;
  LabeledEdit2.Clear;
  LabeledEdit1.SetFocus;
  
  ifdocnewadd:=true;
end;

procedure Tfrmdocset.suiButton2Click(Sender: TObject);
Var
   adotemp11,adotemp12: tadoquery;
   iid:string;
   dep_unid:string;
Begin
   if ifdocnewadd then
   begin
        ifdocnewadd:=false;

        dep_unid:=GetDepUnid;

        if trim(dep_unid)='' then
        begin
          MessageDlg('��ѡ���ţ�',mtError,[MBOK],0);
          exit;
        end;
        
        if trim(LabeledEdit1.Text)='' then
        begin
          MessageDlg('�û����벻��Ϊ�գ�',mtError,[MBOK],0);
          exit;
        end;

        adotemp12:=tadoquery.Create(nil);
        adotemp12.Connection:=DM.ADOConnection1;
        adotemp12.Close;
        adotemp12.SQL.Clear;
        adotemp12.SQL.Text:='select * from worker ';
        adotemp12.Open;
        if adotemp12.Locate('id',trim(LabeledEdit1.text),[loCaseInsensitive]) then
        begin
          MessageDlg('�Ѵ��ڸ��û����룬�������',mtError,[MBOK],0);
          adotemp12.Free;
          exit;
        end;
        
        adotemp12.Close;
        adotemp12.SQL.Clear;
        adotemp12.SQL.Text:='Insert into WORKER ('+
                            ' Name,PassWd,account_limit,pkdeptid,ID,ShowAllTj) values ('+
                            ':P_Name,:P_PassWd,:P_account_limit,:P_pkdeptid,:P_ID,:ShowAllTj) ';
        adotemp12.Parameters.ParamByName('P_ID').Value:=trim(uppercase(LabeledEdit1.Text)) ;
        adotemp12.Parameters.ParamByName('P_Name').Value:=trim(uppercase(LabeledEdit2.Text)) ;
        adotemp12.Parameters.ParamByName('P_PassWd').Value:='' ;
        adotemp12.Parameters.ParamByName('P_account_limit').Value:='' ;
        adotemp12.Parameters.ParamByName('P_pkdeptid').Value:=dep_unid;
        adotemp12.Parameters.ParamByName('ShowAllTj').Value:=ComboBox1.Text ;
        adotemp12.ExecSQL;
        adotemp12.Free;

        UpdateADOdoclist;
        
        iid:=trim(LabeledEdit1.Text);
        ADOdoclist.Locate('�û�����',iid,[loCaseInsensitive]);
   end else
   begin
        adotemp11:=tadoquery.Create(nil);
        adotemp11.Connection:=DM.ADOConnection1;
        adotemp11.Close;
        adotemp11.SQL.Clear;
        adotemp11.SQL.Text:='update worker set id=:id,name=:name,ShowAllTj=:ShowAllTj where unid=:unid';
        try
          adotemp11.Parameters.ParamByName('id').Value:=trim(uppercase(LabeledEdit1.Text));
          adotemp11.Parameters.ParamByName('name').Value:=trim(uppercase(LabeledEdit2.Text));
          adotemp11.Parameters.ParamByName('ShowAllTj').Value:=ComboBox1.Text ;
          adotemp11.Parameters.ParamByName('unid').Value:=ADOdoclist.FieldByName('Ψһ���').AsInteger;
          adotemp11.ExecSQL;
        except
          MessageDlg('�Ѵ��ڸ��û����룬�������',mtError,[MBOK],0);
          adotemp11.Free;
          exit;
        end;
        adotemp11.Free;
        ADOdoclist.Refresh;
   end;
end;

procedure Tfrmdocset.docrefresh;
begin
  ifdocnewadd:=false;
  
  if (ADOdoclist.Active) and (ADOdoclist.RecordCount>0) then
  begin
      LabeledEdit1.Text:=trim(ADOdoclist.FieldByName('�û�����').AsString);
      LabeledEdit2.Text:=trim(ADOdoclist.FieldByName('�û�����').AsString);
      ComboBox1.Text:=ADOdoclist.FieldByName('���п�����Ŀ').AsString;
  end else
  begin
      LabeledEdit1.Clear;
      LabeledEdit2.Clear;
      ComboBox1.Text:='';
  end;
end;

procedure Tfrmdocset.suiButton3Click(Sender: TObject);
begin
  if not ADOdoclist.Active then exit;
  if ADOdoclist.RecordCount<=0 then exit;
  
  if application.MessageBox('�㽫ɾ��ѡ���ļ�¼,������?','ϵͳ��ʾ', MB_OKCANCEL+MB_ICONWARNING)=1 then
  begin
    ADOdoclist.Delete;
    ADOdoclist.Refresh;
  end;
end;

procedure Tfrmdocset.FormCreate(Sender: TObject);
begin
  ifdocnewadd:=false;

  ADOdoclist.Connection:=DM.ADOConnection1;

  ChangeYouFormAllControlIme(Self);//�����������뷨
end;

procedure Tfrmdocset.ADOdoclistAfterScroll(DataSet: TDataSet);
begin
  docrefresh;
end;

procedure Tfrmdocset.FormShow(Sender: TObject);
begin
  UpdateADOdoclist;
  docrefresh;
end;

procedure Tfrmdocset.BitBtn1Click(Sender: TObject);
var
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='dbo.pro_PrintDepartWorker';
  adotemp11.Open;

  LYDataToExcel1.DataSet:=adotemp11;
  LYDataToExcel1.ExcelTitel:='������Ա';
  LYDataToExcel1.Execute;
  
  adotemp11.Free;
end;

procedure Tfrmdocset.ComboBox2DropDown(Sender: TObject);
begin
  LoadGroupName(TComboBox(Sender),'select CONCAT(''['',unid,'']'',Name) from CommCode WITH(NOLOCK) where TypeName=''����'' order by id');
end;

procedure Tfrmdocset.UpdateADOdoclist;
begin
  ADOdoclist.Close;
  ADOdoclist.SQL.Clear;
  if trim(GetDepUnid)='' then
  begin
    ADOdoclist.SQL.Text:='SELECT id AS �û�����,name AS �û�����,ShowAllTj as ���п�����Ŀ,unid AS Ψһ��� FROM worker order by id';
  end else
  begin
    ADOdoclist.SQL.Text:='SELECT id AS �û�����,name AS �û�����,ShowAllTj as ���п�����Ŀ,unid AS Ψһ��� FROM worker where pkdeptid='+trim(GetDepUnid)+' order by id';
  end;
  ADOdoclist.Open;
end;

procedure Tfrmdocset.ComboBox2Change(Sender: TObject);
begin
  UpdateADOdoclist;
end;

function Tfrmdocset.GetDepUnid: string;
var
  s2:string;
begin
  s2:=leftstr(ComboBox2.Text,pos(']',ComboBox2.Text));
  Result:=StringReplace(s2,'[','',[rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result,']','',[rfReplaceAll, rfIgnoreCase]);
end;

initialization
  ffrmdocset:=nil;

end.
