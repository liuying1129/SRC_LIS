# SRC_LIS
uQRCode.pas:外部unit，用于生成二维码。该单元又引入了PtQREncode.dll、PtImageRW.dll  

softMeter_globalVar.pas:外部unit，用于发送埋点数据到GA。该单元又引入了dll_loader.pas、dll_loaderAppTelemetry.pas、libSoftMeter.dll、libSoftMeter64.dll

# 项目AutoCompleteJob 
凌晨2点自动结束当批检验工作

# 项目Result2His 
向HIS等外部系统提供检验结果 

SpringBoot，前后端分离。JDK17 

后端： 

提供HTTP接口，返回JSON数据。http://IP:8090/queryResult?his_unid=1&his_unid=2&barcode=3&reqItemNo='5','6' 

前端： 

提供前端页面。http://IP:8091?his_unid=1&his_unid=2&barcode=3&reqItemNo='5','6' 

运行JDBC操作时报错:
javax.net.ssl.SSLHandshakeException: No appropriate protocol (protocol is disabled or cipher suites are inappropriate)
处理方式:
jdk-17\conf\security\java.security,找到【TLSv1, TLSv1.1,】,删除并保存
