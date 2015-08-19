unit UfrmSmallItemPick;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst,ADODB, ExtCtrls, Buttons,inifiles;

type
  TfrmSmallItemPick = class(TForm)
    CheckListBox1: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SmallItemChecklistbox(CheckListBox:TCheckListBox);
    procedure ReadConfig;
    procedure WriteProfile;
  public
    { Public declarations }
  end;

//var
function  frmSmallItemPick: TfrmSmallItemPick;

implementation
uses  UDM, SDIMAIN;
var
  ffrmSmallItemPick: TfrmSmallItemPick;
{$R *.dfm}

function  frmSmallItemPick: TfrmSmallItemPick;
begin
  if ffrmSmallItemPick=nil then ffrmSmallItemPick:=TfrmSmallItemPick.Create(application.mainform);
  result:=ffrmSmallItemPick;
end;

procedure TfrmSmallItemPick.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmSmallItemPick=self then ffrmSmallItemPick:=nil;
end;

procedure TfrmSmallItemPick.FormShow(Sender: TObject);
begin
  SmallItemChecklistbox(CheckListBox1);

  ReadConfig;
end;

procedure TfrmSmallItemPick.SmallItemChecklistbox(
  CheckListBox: TCheckListBox);
const sqll=' select itemid as 项目代码,name as 名称 '+
          ' from clinicchkitem where unid not in (select itemunid from CombSChkItem) order by itemid';

    var adotemp3:tadoquery;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=sqll;
     adotemp3.Open;
     adotemp3.First;
     CheckListBox.Items.Clear;

     while not adotemp3.Eof do
     begin
      CheckListBox.Items.Add(trim(adotemp3.fieldbyname('项目代码').AsString)+'   '+adotemp3.fieldbyname('名称').AsString);
      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure TfrmSmallItemPick.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmSmallItemPick.BitBtn1Click(Sender: TObject);
var
  adotemp11{,adotemp22}:tadoquery;
  SmallItemCode:string;
  b,i:integer;
begin
  if(not sdiappform.ADObasic.Active)or(sdiappform.ADObasic.RecordCount=0)then exit;
  
       //adotemp22:=tadoquery.Create(nil);
       //adotemp22.Connection:=DM.ADOConnection1;
       adotemp11:=tadoquery.Create(nil);
       adotemp11.Connection:=DM.ADOConnection1;
        for i:=0 to checklistbox1.Items.Count-1 do
        begin
          if checklistbox1.Checked[i] then
          begin
            b:=pos('   ',checklistbox1.Items.Strings[i]);
            SmallItemCode:=copy(checklistbox1.Items.Strings[i],1,b-1);
             //adotemp22.Close;
             //adotemp22.SQL.Clear;
             //adotemp22.SQL.Text:= 'select itemid,' +
             //       ' name,english_name,unit,printorder,price ' +
             //       ' from clinicchkitem '+
             //       ' where itemid=:P_itemid ';
             //adotemp22.Parameters.ParamByName('P_itemid').Value:=trim(SmallItemCode);
             //adotemp22.open;
             //if adotemp22.RecordCount=0 then continue;//找不到该项目的基本信息（该情况理论上不可能发生）

             adotemp11.Close;
             adotemp11.SQL.Clear;
             adotemp11.SQL.Text:= 'insert into chk_valu(pkunid,issure,pkcombin_id,itemid) ' +
                    //' name,english_name,unit,printorder,getmoney) ' +
                    ' values (:P_pkunid,1,:P_pkcombin_id,:P_itemid) ';
                    //' :P_name,:P_english_name,:P_unit,:P_printorder,:P_getmoney) ';
             adotemp11.Parameters.ParamByName('P_pkunid').Value:=sdiappform.ADObasic.fieldbyname('唯一编号').AsInteger;
             adotemp11.Parameters.ParamByName('P_pkcombin_id').Value:=trim(LabeledEdit1.Text);
             adotemp11.Parameters.ParamByName('P_itemid').Value:=trim(SmallItemCode);
             //adotemp11.Parameters.ParamByName('P_name').Value:=adotemp22.fieldbyname('name').AsString;
             //adotemp11.Parameters.ParamByName('P_english_name').Value:=adotemp22.fieldbyname('english_name').AsString;
             //adotemp11.Parameters.ParamByName('P_unit').Value:=adotemp22.fieldbyname('unit').AsString;
             //adotemp11.Parameters.ParamByName('P_printorder').Value:=99;
             //adotemp11.Parameters.ParamByName('P_getmoney').Value:=adotemp22.fieldbyname('price').AsFloat;
             adotemp11.ExecSQL;
          end;
        end;
        adotemp11.Free;
        //adotemp22.Free;

        //=============插入参考值
        //SDIAppForm.CheckReference(sdiappform.ADObasic.fieldbyname('唯一编号').AsInteger,trim(LabeledEdit1.Text));
        //======================
        
        SDIAppForm.update_Ado_dtl;

        close;
end;

procedure TfrmSmallItemPick.ReadConfig;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  LabeledEdit1.Text:=trim(CONFIGINI.ReadString('Interface','EscpecialItemComID','99'));
  configini.Free;
end;

procedure TfrmSmallItemPick.WriteProfile;
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  ConfigIni.WriteString('Interface','EscpecialItemComID',trim(LabeledEdit1.Text)); {记录特殊项目大组合项目代码}

  configini.Free;
end;

procedure TfrmSmallItemPick.FormDestroy(Sender: TObject);
begin
  WriteProfile;
end;

initialization
  ffrmSmallItemPick:=nil;

end.
