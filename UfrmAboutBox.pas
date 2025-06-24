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
  ffrmAboutBox:TfrmAboutBox;           {���صĴ������,���رմ����ͷ��ڴ�ʱ����}
  
{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmAboutBox:TfrmAboutBox;    {��̬�������庯��}
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
  Version.Caption:=GetVersionLY(pchar(APPLICATION.ExeName));//�������ص�Pchar���ͻ�����ֱ�Ӹ�ֵ��string!!!
  Copyright.Caption:='��Ȩ����,�Ͻ������룬�����';
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  Comments.Caption:=ini.ReadString('Interface','companyname','�㶫�������������');
  Author.Caption:=ini.ReadString('Interface','companytel','13710248644��QQ:46524223');
  WebPage.Caption:=ini.ReadString('Interface','companywww','');
  ini.Free;
  //sWeChat:=ScalarSQLCmd(LisConn,'select Name from CommCode where TypeName=''ϵͳ����'' and ReMark=''΢�Ź��ں�'' ');
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
                            //�ڴ治��
    ERROR_FILE_NOT_FOUND: MessageBox(handle,'Error:File not Found','Error ExploreWeb',0);
                            //û���ҵ����ļ�
    ERROR_PATH_NOT_FOUND: MessageBox(handle,'Error:Directory not','Error ExploreWeb',0);
                            //·������
    ERROR_BAD_FORMAT : MessageBox(handle,'Fehler:Wrong format in EXE','Error ExploreWeb',0);
                            //�ļ���ʽ����
    Else MessageBox(handle,PChar('Error nr:'+IntToStr(Returnvalue)+' in ShellExecute'),'Error ExploreWeb',0) // �� �� �� ��
                            //����������������ο�����ShellExcute ��ReturnValues˵����
  end //case
end;

procedure TfrmAboutBox.WebPageClick(Sender: TObject);
begin
  ExploerWeb(handle,PChar(WebPage.caption));
end;

initialization
  ffrmAboutBox:=nil;
  
end.
