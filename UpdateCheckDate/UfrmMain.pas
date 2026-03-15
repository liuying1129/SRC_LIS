unit UfrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.DApt, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    FDConnection1: TFDConnection;
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function MakeDBConn:boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function EnCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunctionV250.dll';//加密
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'LYFunctionV250.dll';
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetFormV250.dll';
function GetHDSn(const RootPath:Pchar):Pchar;stdcall;external 'LYFunctionV250.dll';
procedure WriteLog(const ALogStr: Pchar);stdcall;external 'LYFunctionV250.dll';

const
  CryptStr='lc';

var
  gConnectionString:String;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  adotemp11:TFDQuery;
begin
  adotemp11:=TFDQuery.Create(nil);
  adotemp11.Connection:=FDConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='update chk_con set check_date=CONVERT(datetime, WorkCompany) '+
                      'where isnull(WorkCompany,'''')<>'''' '+
                      'and ISDATE(WorkCompany) = 1';
  adotemp11.ExecSQL;
  adotemp11.Free;
  MessageDlg('更新完成,请刷新并查看!',mtInformation,[MBOK],0);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MakeDBConn;
end;

function TfrmMain.MakeDBConn: boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  userid, password, datasource, initialcatalog: string;
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('连接数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接数据库','集成登录模式',false);
  userid := Ini.ReadString('连接数据库', '用户', '');
  password := Ini.ReadString('连接数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,Pchar(CryptStr));
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  newconnstr :='';
  newconnstr := newconnstr + 'User_Name=' + UserID + ';';
  newconnstr := newconnstr + 'Password=' + Password + ';';
  newconnstr := newconnstr + 'Server=' + datasource + ';';
  newconnstr := newconnstr + 'Database=' + initialcatalog + ';';
  newconnstr := newconnstr + 'DriverID=' + 'MSSQL' + ';';
  if ifIntegrated then
    newconnstr := newconnstr + 'OSAuthent=Yes;';
  try
    FDConnection1.Connected := false;
    FDConnection1.ConnectionString := newconnstr;
    FDConnection1.Connected := true;
    result:=true;
    gConnectionString:=newconnstr;
  except
  end;
  if not result then
  begin
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+'启用该模式,则用户及口令无需填写'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接数据库','连接数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

end.
