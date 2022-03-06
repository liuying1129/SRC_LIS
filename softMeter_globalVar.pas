//////////////////////////////////////////////////////////////
///
///     unit softMeter_globalVar.pas
///     Example unit to offer a global object of softMeter
///
///     Version of file: 2.6
///     URL of repo:
///     https://github.com/starmessage/libSoftMeter
///     Copyright, StarMessage software
///     https://www.starmessagesoftware.com/libSoftMeter
///
//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
///
///     该埋点功能底层使用Google Analytics,即GA
///     官网：analytics.google.com
///     帐号：liuying1129@163.com
///     密码：liu771129
///
///     Account Name:liuying
///     Property name:liuyingGA44
///
//////////////////////////////////////////////////////////////


unit softMeter_globalVar;

interface

uses
  dll_loaderAppTelemetry;

var
  dllSoftMeter: TDllAppTelemetry;

implementation

uses
  dialogs, ShellApi{ShellExecute}, SysUtils{ChangeFileExt}, Forms{Application}, Windows{DWORD};

const
  // put here your Google Analytics property ID as given to you 
  // from your Google Analytics account.
  // Or put the Matomo/Piwik tracking ID if you you are using Matomo
  GooglePropertyID =  'UA-207373569-1';

  //GA的Source值:应用名称+AppVersion+AppEdition                    
  AppEdition = 'Enterprise Edition';
  AppLicense = 'Free';//GA的Medium值
  // if you have a SoftMeter PRO subscription
  //PROsubscription = 'subscriptionID=your-subscription-id' + CHR(10) + 'subscriptionType=2';

  //libSoftMeter64.dll只能被64位windows的64位应用程序调用
  //Delphi7编译的程序为32位应用,故理论上只会调用到libSoftMeter.dll
  {$IFDEF WIN32}
      DLLfilename =  'libSoftMeter.dll';
  {$ENDIF}
  {$IFDEF WIN64}
      DLLfilename =  'libSoftMeter64.dll';
  {$ENDIF}

var
  userGaveConsent:boolean;
  startResult: boolean;
  logFilename: string;

function GetBuildInfo(const AFileName:string):string;//获取文件版本号函数
var
  VerInfoSize,VerValueSize,Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
  V1,V2,V3,V4: Word;
begin
  Result:='';
  if not FileExists(AFileName) then exit;
  VerInfoSize:=GetFileVersionInfoSize(PChar(AFileName),Dummy);
  if VerInfoSize=0 then exit;
  GetMem(VerInfo,VerInfoSize);
  if not GetFileVersionInfo(PChar(AFileName),0,VerInfoSize,VerInfo) then exit;
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    V1:=dwFileVersionMS shr 16;
    V2:=dwFileVersionMS and $FFFF;
    V3:=dwFileVersionLS shr 16;
    V4:=dwFileVersionLS and $FFFF;
    Result:=inttostr(v1)+'.'+inttostr(v2)+'.'+inttostr(v3)+'.'+inttostr(v4);
  end;
  FreeMem(VerInfo,VerInfoSize);
end;

initialization

  try
    dllSoftMeter := TDllAppTelemetry.Create(DLLfilename);
  Except
    MessageDlg('Error loading '+ DLLfilename,mtError,[mbOK],0);
  end;

  dllSoftMeter.enableLogfile('Delphi demo');
  logFilename := dllSoftMeter.getLogFilename;

  if Length(GooglePropertyID)<10 then
  begin
    MessageDlg('You are running this demo with the propertyID: ' + GooglePropertyID + CHR(10)+CHR(13) +
                'Are you sure this is YOUR Google propertyID?' + CHR(10)+CHR(13) +
                'Go to softMeter_globalVar.pas to review it.' + CHR(10)+CHR(13) +
                'Will not enable telemetry now.',mtWarning,[mbOK],0);
    exit;
  end;

  // set your SoftMeter PRO subscription here, before calling start()
  // dllSoftMeter.setOptions(PChar(PROsubscription));
    
  // make sure you load this variable from the user settings
  userGaveConsent:= true;
  // ToDo: make this a lazy call so that the INI file with the user settings containing the 
  // consent of the user is already loaded somewhere in the program.

  startResult:=false;  
  try
    startResult := dllSoftMeter.start(PChar(ChangeFileExt(ExtractFileName(Application.ExeName),'')), PChar(GetBuildInfo(Application.ExeName)), AppLicense, AppEdition, GooglePropertyID, userGaveConsent );
  Except
    MessageDlg('Exception while calling dllSoftMeter.start',mtError,[mbOK],0);
  end;
  if not startResult then MessageDlg('dllSoftMeter.start returned false',mtError,[mbOK],0);

  if dllSoftMeter.errorsExist then MessageDlg('Errors in dllSoftMeter:' + dllSoftMeter.getErrorText,mtError,[mbOK],0);

finalization

  try
    dllSoftMeter.stop;
  Except
    MessageDlg('Error calling dllSoftMeter.stop',mtError,[mbOK],0);
  end;

  // during the development (not for release) open the logFile
  //注释.避免应用退出时打开softMeter日志文件
  //ShellExecute( 0 , nil, PChar('notepad'), PChar(logFilename) , nil, 1{SW_SHOWNORMAL} ) ;

end.
