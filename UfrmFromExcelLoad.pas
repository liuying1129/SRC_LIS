unit UfrmFromExcelLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,ComObj,ADODB;

type
  TfrmFromExcelLoad = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function frmFromExcelLoad: TfrmFromExcelLoad;

implementation

uses UDM, SDIMAIN;
var
  ffrmFromExcelLoad: TfrmFromExcelLoad;
  
{$R *.dfm}
function frmFromExcelLoad: TfrmFromExcelLoad;
begin
  if ffrmFromExcelLoad=nil then ffrmFromExcelLoad:=TfrmFromExcelLoad.Create(application.mainform);
  result:=ffrmFromExcelLoad;
end;

procedure TfrmFromExcelLoad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmFromExcelLoad=self then ffrmFromExcelLoad:=nil;
end;

procedure TfrmFromExcelLoad.SpeedButton1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then exit;
  LabeledEdit1.Text:=OpenDialog1.FileName;
end;

procedure TfrmFromExcelLoad.BitBtn1Click(Sender: TObject);
var
  excelv,sheetv:variant;
  //(1)ռλ��,(2)��ˮ��,(3)������,(4)������,(5)�������,(6)����,
  LSH,LJH,BLH,JCRQ,XM:string;
  //(7)�Ա�,(8)����,(9)����,(10)�ͼ����,(11)�ͼ�ҽ��, (12)����Ա,
  XB,LL,CH,SJKS,SJYS,CZY:STRING;
  //(13)�����,(14)��������,(15)���ȼ���,(16)�������,(17)��������,
  SHZ,SQRQ,YXJB,ZB,YBLX:STRING;
  //(18)�������,(19)�ٴ����,(20)��ע,(21)ϸ��,(22)������˾,
  YBQK,LCZD,BZ,{XJ,}SSGS:STRING;
  //(23)��������,(24)���֣�(25)����,(26)���,(27)����,(28)סַ,
  SSBM,GZ,GH,HF,JG,ZZ:STRING;
  //(29)�绰��(30)����ѹ,(31)����ѹ,(32)��������,
  DH{,SZY,SSY,ZYSL}:STRING;
  //(33)��������,(34)���,(35)����,(36)����ʷ,(37)����ʷ,
  {YYSL,SG,TZ,JWS,JZS:STRING;
  //(38)�ڿƣ�(39)��ƣ�(40)��ٿƣ�(41)���ƣ�(42)��ǿ�⣬
  NK,WK,WGK,FK,LQG:STRING;
  //(43)X�⣬(44)B����(45)�ĵ�ͼ��(46)���飬(47)���ۣ�(48)����
  XG,BC,XDT,JY,JL,YSJY:STRING;}
  //(49)��Ŀ����,(50)��ĿӢ����,(51)������,(52)��λ
  XMMC,XMYWM,JYJG,DW:STRING;
  //(53)��Сֵ,(54)���ֵ,(55)�����Ŀ��,(56)��ӡ���,(57)��Ŀ����
  ZXZ,ZDZ,ZHXMH,DYBH,XMDM:STRING;

  i,RecNum,ValetudinarianInfoId:integer;
  adotemp11,adotemp22,adotemp33:tadoquery;
  Save_Cursor:TCursor;
begin
  if trim(sdiappform.cbxConnChar.Text)='' then
  begin
    showmessage('�����Ϊ��!');
    exit;
  end;

  {IF TRIM(ZB)='' THEN //}ZB:=sdiappform.cbxConnChar.Text;//�������,���뵱ǰ���

  try
    excelv:=CreateOleObject('excel.application');
  except
    on E:Exception do
    begin
      MessageDlg('Execl�쳣:'+E.Message,mtError,[MBOK],0);
      exit;
    end;
  end;
  try
    excelv.workbooks.open(LabeledEdit1.Text);
  except
    showmessage('���ļ�������!');
    exit;
  end;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try  
    sheetv:=excelv.workbooks[1].worksheets[1];

    i:=2;
    //������Ϣ
    {TJH:=sheetv.cells[i,1];}LSH:=sheetv.cells[i,2];LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];JCRQ:=sheetv.cells[i,5];XM:=sheetv.cells[i,6];
    XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];CZY:=sheetv.cells[i,12];
    SHZ:=sheetv.cells[i,13];SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
    YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];{XJ:=sheetv.cells[i,21];}SSGS:=sheetv.cells[i,22];
    SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
    DH:=sheetv.cells[i,29];{SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
    YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
    NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
    XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];}
    //������
    XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
    ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];ZHXMH:=sheetv.cells[i,55];DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];

    while (XM<>'') do //AND (TJH<>'')
    begin
      adotemp22:=tadoquery.create(nil);
      adotemp22.Connection:=dm.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select unid from chk_con where patientname='''+XM+''' AND sex='''+XB+''' AND age='''+LL+''' AND combin_id='''+ZB+'''';// dnh='+TJH;
      adotemp22.Open;
      RecNum:=adotemp22.RecordCount;
      IF RecNum>=1 then ValetudinarianInfoId:=adotemp22.FIELDBYNAME('UNID').AsInteger else ValetudinarianInfoId:=-1;
      adotemp22.Free;
      IF RecNum>=1 then//�ò����Ѵ���
      begin
        if (trim(JYJG)<>'')and(trim(XMDM)<>'') then//���������
        begin
          IF '1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_valu where PkUnid='+inttostr(ValetudinarianInfoId)+' and name='''+XMMC+''' and itemvalue='''+JYJG+''' ') THEN//�ò���û�иü�����Ŀ�Ľ��(ͨ��ÿ�����˵���Ŀ��������������ж�)
          BEGIN
            adotemp33:=tadoquery.create(nil);
            adotemp33.Connection:=dm.ADOConnection1;
            adotemp33.Close;
            adotemp33.SQL.Clear;
            adotemp33.SQL.Add('insert into chk_valu ([pkunid],[pkcombin_id],[itemid],[name],[english_name],[itemvalue],[Unit],'+
           '[Min_value],[Max_value],[printorder],[issure]) values ('+
                inttostr(ValetudinarianInfoId)+','''+ZHXMH+''','''+XMDM+''','''+XMMC+''','''+XMYWM+''','''+JYJG+''','''+DW+''','''+
                ZXZ+''','''+ZDZ+''','+inttostr(strtointdef(DYBH,0))+',''1'')');
            adotemp33.ExecSQL;
            adotemp33.Free;
          END;
        end;

        inc(i);
        //������Ϣ
        {TJH:=sheetv.cells[i,1];}LSH:=sheetv.cells[i,2];LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];JCRQ:=sheetv.cells[i,5];XM:=sheetv.cells[i,6];
        XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];CZY:=sheetv.cells[i,12];
        SHZ:=sheetv.cells[i,13];SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
        YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];{XJ:=sheetv.cells[i,21];}SSGS:=sheetv.cells[i,22];
        SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
        DH:=sheetv.cells[i,29];{SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
        YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
        NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
        XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];}
        //������
        XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
        ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];ZHXMH:=sheetv.cells[i,55];DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];
        continue;
      end;

      IF TRIM(YXJB)='' THEN YXJB:=CGYXJB;//�������ȼ���,����'����'
      adotemp11:=tadoquery.create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Add('insert into chk_con ([checkid],[patientname],[sex],[age],[Caseno],[bedno],[deptname],[check_date],[check_doctor],'+
     '[report_date],[report_doctor],[operator],[Diagnosetype],[flagetype],[diagnose],[typeflagcase],'+
     '[issure],[combin_id],[LSH],[WorkDepartment],[WorkCategory],[WorkID],[ifMarry],'+//[GermName],
     '[OldAddress],[Address],[Telephone],[WorkCompany]'+//[TjDescription],[PushPress],[PullPress],
     //'[LeftEyesight],[RightEyesight],[Stature],[Weight],[TjJiWangShi],[TjJiaZuShi],[TjNeiKe],'+
     //'[TjWaiKe],[TjWuGuanKe],[TjFuKe],[TjLengQiangGuang],[TjXGuang],[TjBChao],'+
     ') values ('''+//,[DNH] [TjXinDianTu],[TJAdvice],[TjJianYan]
          LJH+''','''+XM+''','''+XB+''','''+LL+''','''+BLH+''','''+CH+''','''+SJKS+''','''+JCRQ+''','''+SJYS+''','''+
          SQRQ+''','''+SHZ+''','''+CZY+''','''+YXJB+''','''+YBLX+''','''+LCZD+''','''+YBQK+''','''+
          BZ+''','''+ZB+''','''+LSH+''','''+SSBM+''','''+GZ+''','''+GH+''','''+HF+''','''+//+''','''+XJ
          JG+''','''+ZZ+''','''+DH+''','''+SSGS+//''','''+//SZY+''','''+SSY+''','''+//+''','''+JL
          //ZYSL+''','''+YYSL+''','''+SG+''','''+TZ+''','''+JWS+''','''+JZS+''','''+NK+''','''+
          //WK+''','''+WGK+''','''+FK+''','''+LQG+''','''+XG+''','''+BC+''','''+
          ''')');//''','''+TJH+ XDT+''','''+YSJY+''','''+JY+
      adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
      adotemp11.Open;
      ValetudinarianInfoId:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
      adotemp11.Free;
      if (trim(JYJG)<>'')and(trim(XMDM)<>'') then//���������
      begin
        IF '1'<>ScalarSQLCmd(LisConn,'select TOP 1 1 from chk_valu where PkUnid='+inttostr(ValetudinarianInfoId)+' and name='''+XMMC+''' and itemvalue='''+JYJG+''' ') THEN//�ò���û�иü�����Ŀ�Ľ��(ͨ��ÿ�����˵���Ŀ��������������ж�)
        BEGIN
          adotemp33:=tadoquery.create(nil);
          adotemp33.Connection:=dm.ADOConnection1;
          adotemp33.Close;
          adotemp33.SQL.Clear;
          adotemp33.SQL.Add('insert into chk_valu ([pkunid],[pkcombin_id],[itemid],[name],[english_name],[itemvalue],[Unit],'+
         '[Min_value],[Max_value],[printorder],[issure]) values ('+
              inttostr(ValetudinarianInfoId)+','''+ZHXMH+''','''+XMDM+''','''+XMMC+''','''+XMYWM+''','''+JYJG+''','''+DW+''','''+
              ZXZ+''','''+ZDZ+''','+inttostr(strtointdef(DYBH,0))+',''1'')');
          adotemp33.ExecSQL;
          adotemp33.Free;
        END;
      end;

      inc(i);
      //������Ϣ
      {TJH:=sheetv.cells[i,1];}LSH:=sheetv.cells[i,2];LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];JCRQ:=sheetv.cells[i,5];XM:=sheetv.cells[i,6];
      XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];CZY:=sheetv.cells[i,12];
      SHZ:=sheetv.cells[i,13];SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
      YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];{XJ:=sheetv.cells[i,21];}SSGS:=sheetv.cells[i,22];
      SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
      DH:=sheetv.cells[i,29];{SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
      YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
      NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
      XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];}
      //������
      XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
      ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];ZHXMH:=sheetv.cells[i,55];DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];
    end;

    //======����ڴ�
    if not VarIsEmpty(sheetv) then VarClear(sheetv);
    if not VarIsEmpty(excelv) then
    begin
      excelv.DisplayAlerts := False;
      excelv.Quit;
      VarClear(excelv);
    end;
    //=============

  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

  sdiappform.UpdateADObasic;//ˢ��������
  MESSAGEDLG('����ɹ�!',MTINFORMATION,[MBOK],0);
  close;
end;

procedure TfrmFromExcelLoad.BitBtn2Click(Sender: TObject);
begin
  CLOSE;
end;

initialization
  ffrmFromExcelLoad:=nil;

end.
