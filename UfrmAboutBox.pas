unit UfrmAboutBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, IniFiles, ShellAPI;

type
  TfrmAboutBox = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    WebPage: TLabel;
    Author: TLabel;
    ImageWeChatCS: TImage;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure WebPageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  frmAboutBox: TfrmAboutBox;

implementation

uses SDIMAIN, UDM;

var
  ffrmAboutBox:TfrmAboutBox;           {本地的窗体变量,供关闭窗体释放内存时调用}
  
{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmAboutBox:TfrmAboutBox;    {动态创建窗体函数}
begin
  if ffrmAboutBox=nil then ffrmAboutBox:=TfrmAboutBox.Create(application.mainform);
  result:=ffrmAboutBox;
end;

procedure TfrmAboutBox.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmAboutBox=self then ffrmAboutBox:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmAboutBox.FormShow(Sender: TObject);
var
  ini:tinifile;
begin
  ProgramIcon.Picture.Icon:=application.icon;
  ProductName.Caption:=SDIAppForm.Caption;
  Version.Caption:=GetVersionLY(pchar(APPLICATION.ExeName));//函数返回的Pchar类型还真能直接赋值给string!!!
  Copyright.Caption:='版权所有,严禁反编译，反汇编';
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  Comments.Caption:=ini.ReadString('Interface','companyname','广东誉凯软件工作室');
  Author.Caption:=ini.ReadString('Interface','companytel','13710248644、QQ:46524223');
  WebPage.Caption:=ini.ReadString('Interface','companywww','');
  ini.Free;
  //sWeChat:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''系统代码'' and ReMark=''微信公众号'' ');
  //WeChat:=ifThen(sWeChat='','http://weixin.qq.com/r/GDvN1Y7EmtPlrcq2924K',sWeChat);
end;

procedure ExploerWeb(handle:HWND ; page:PChar);
Var
  Returnvalue : integer;
begin 
  ReturnValue := ShellExecute(handle, 'open', page,nil, nil, SW_SHOWNORMAL);
  if ReturnValue <= 32 then
  case Returnvalue of
    0 : MessageBox(handle,'Error: Out of Memory','Error ExploreWeb',0);
                            //内存不足
    ERROR_FILE_NOT_FOUND: MessageBox(handle,'Error:File not Found','Error ExploreWeb',0);
                            //没有找到该文件
    ERROR_PATH_NOT_FOUND: MessageBox(handle,'Error:Directory not','Error ExploreWeb',0);
                            //路径不对
    ERROR_BAD_FORMAT : MessageBox(handle,'Fehler:Wrong format in EXE','Error ExploreWeb',0);
                            //文件格式不对
    Else MessageBox(handle,PChar('Error nr:'+IntToStr(Returnvalue)+' in ShellExecute'),'Error ExploreWeb',0) // 其 他 错 误
                            //还有其他错误处理，请参考帮助ShellExcute 的ReturnValues说明。
  end //case
end;

procedure TfrmAboutBox.WebPageClick(Sender: TObject);
begin
  ExploerWeb(handle,PChar(WebPage.caption));
end;

initialization
  ffrmAboutBox:=nil;
  
end.
