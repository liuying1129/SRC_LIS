//////////////////////////////////////////////////////////////
///
///     誉凯检验信息管理系统
///     Version: 7.0
///
///     Copyright: 刘瑛
///
//////////////////////////////////////////////////////////////
program ProYkLis;

uses
  Forms,
  SDIMAIN in 'SDIMAIN.PAS' {SDIAppForm},
  Unitstatic in 'Unitstatic.pas' {Formstatic},
  UfrmCommQuery in 'UfrmCommQuery.pas' {frmCommQuery},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  UfrmBatchSpecNo in 'UfrmBatchSpecNo.pas' {frmBatchSpecNo},
  ufrm_referencevalue in 'ufrm_referencevalue.pas' {frm_referencevalue},
  UfrmItemSetup in 'ufrmItemSetup.pas' {frmItemSetup},
  Ufrmdocset in 'Ufrmdocset.pas' {frmdocset},
  UfrmHistoryResult in 'UfrmHistoryResult.pas' {frmHistoryResult},
  UfrmExcelQuery in 'UfrmExcelQuery.pas' {frmExcelQuery},
  UfrmStaticCombItem in 'UfrmStaticCombItem.pas' {frmStaticCombItem},
  UDM in 'UDM.pas' {DM: TDataModule},
  UfrmFromExcelLoad in 'UfrmFromExcelLoad.pas' {frmFromExcelLoad},
  UfrmXDepictType in 'UfrmXDepictType.pas' {frmXDepictType},
  UfrmXDepict in 'UfrmXDepict.pas' {frmXDepict},
  UfrmCommCode in 'UfrmCommCode.pas' {frmCommCode},
  UfrmPlxg in 'UfrmPlxg.pas' {frmPlxg},
  UfrmCopyInfo in 'UfrmCopyInfo.pas' {frmCopyInfo},
  UfrmPhoto in 'UfrmPhoto.pas' {frmPhoto},
  UfrmCommValue in 'UfrmCommValue.pas' {frmCommValue},
  UfrmHisCombItem in 'UfrmHisCombItem.pas' {frmHisCombItem},
  UfrmExtItemSetup in 'UfrmExtItemSetup.pas' {frmExtItemSetup},
  UfrmExceptionValue in 'UfrmExceptionValue.pas' {frmExceptionValue},
  UfrmModifyPwd in 'UfrmModifyPwd.pas' {frmModifyPwd},
  UfrmEquipManage in 'UfrmEquipManage.pas' {frmEquipManage},
  UfrmSJ_JBXX in 'UfrmSJ_JBXX.pas' {frmSJ_JBXX},
  softMeter_globalVar in 'softMeter_globalVar.pas',
  UfrmHorizontalExport in 'UfrmHorizontalExport.pas' {frmHorizontalExport},
  superobject in 'superobject.pas',
  UfrmCriticalManage in 'UfrmCriticalManage.pas' {frmCriticalManage},
  UfrmCriticalValueDetail in 'UfrmCriticalValueDetail.pas' {frmCriticalValueDetail},
  UfrmAboutBox in 'UfrmAboutBox.pas' {frmAboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TSDIAppForm, SDIAppForm);
  Application.Run;
end.

