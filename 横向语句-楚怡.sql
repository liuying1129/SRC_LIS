select 
TempA1.unid,
TempA1.caseno as 病历号,
TempA1.patientname as 姓名,
TempA1.sex as 性别,
TempA1.age as 年龄,

max(case when TempA1.combin_name='体检结论' and TempA1.name='体检结论' then TempA1.itemvalue end) as '体检结论/体检结论',
max(case when TempA1.combin_name='体检建议' and TempA1.name='医生建议' then TempA1.itemvalue end) as '体检建议/医生建议',

max(case when TempA1.combin_name='一般项目检查' and TempA1.name='身高' then TempA1.itemvalue end) as '一般项目检查/身高',
max(case when TempA1.combin_name='一般项目检查' and TempA1.name='体重' then TempA1.itemvalue end) as '一般项目检查/体重',
max(case when TempA1.combin_name='一般项目检查' and TempA1.name='体质指数' then TempA1.itemvalue end) as '一般项目检查/体质指数',
max(case when TempA1.combin_name='一般项目检查' and TempA1.name='收缩压' then TempA1.itemvalue end) as '一般项目检查/收缩压',
max(case when TempA1.combin_name='一般项目检查' and TempA1.name='舒张压' then TempA1.itemvalue end) as '一般项目检查/舒张压',
max(case when TempA1.combin_name='一般项目检查' and TempA1.name='检查者' then TempA1.itemvalue end) as '一般项目检查/检查者',

max(case when TempA1.combin_name='内科' and TempA1.name='病史' then TempA1.itemvalue end) as '内科/病史',
max(case when TempA1.combin_name='内科' and TempA1.name='家族史' then TempA1.itemvalue end) as '内科/家族史',
max(case when TempA1.combin_name='内科' and TempA1.name='心律' then TempA1.itemvalue end) as '内科/心律',
max(case when TempA1.combin_name='内科' and TempA1.name='心音' then TempA1.itemvalue end) as '内科/心音',
max(case when TempA1.combin_name='内科' and TempA1.name='肺部听诊' then TempA1.itemvalue end) as '内科/肺部听诊',
max(case when TempA1.combin_name='内科' and TempA1.name='肝脏触诊' then TempA1.itemvalue end) as '内科/肝脏触诊',
max(case when TempA1.combin_name='内科' and TempA1.name='脾脏触诊' then TempA1.itemvalue end) as '内科/脾脏触诊',
max(case when TempA1.combin_name='内科' and TempA1.name='肾脏叩诊' then TempA1.itemvalue end) as '内科/肾脏叩诊',
max(case when TempA1.combin_name='内科' and TempA1.name='内科其它' then TempA1.itemvalue end) as '内科/内科其它',
max(case when TempA1.combin_name='内科' and TempA1.name='检查者' then TempA1.itemvalue end) as '内科/检查者',

max(case when TempA1.combin_name='外科' and TempA1.name='皮肤' then TempA1.itemvalue end) as '外科/皮肤',
max(case when TempA1.combin_name='外科' and TempA1.name='浅表淋巴结' then TempA1.itemvalue end) as '外科/浅表淋巴结',
max(case when TempA1.combin_name='外科' and TempA1.name='甲状腺（外科）' then TempA1.itemvalue end) as '外科/甲状腺（外科）',
max(case when TempA1.combin_name='外科' and TempA1.name='乳房' then TempA1.itemvalue end) as '外科/乳房',
max(case when TempA1.combin_name='外科' and TempA1.name='脊柱' then TempA1.itemvalue end) as '外科/脊柱',
max(case when TempA1.combin_name='外科' and TempA1.name='四肢关节' then TempA1.itemvalue end) as '外科/四肢关节',
max(case when TempA1.combin_name='外科' and TempA1.name='外科其它' then TempA1.itemvalue end) as '外科/外科其它',
max(case when TempA1.combin_name='外科' and TempA1.name='检查者' then TempA1.itemvalue end) as '外科/检查者',

max(case when TempA1.combin_name='妇科' and TempA1.name='外阴' then TempA1.itemvalue end) as '妇科/外阴',
max(case when TempA1.combin_name='妇科' and TempA1.name='阴道' then TempA1.itemvalue end) as '妇科/阴道',
max(case when TempA1.combin_name='妇科' and TempA1.name='宫颈' then TempA1.itemvalue end) as '妇科/宫颈',
max(case when TempA1.combin_name='妇科' and TempA1.name='子宫' then TempA1.itemvalue end) as '妇科/子宫',
max(case when TempA1.combin_name='妇科' and TempA1.name='附件' then TempA1.itemvalue end) as '妇科/附件',
max(case when TempA1.combin_name='妇科' and TempA1.name='妇科其它' then TempA1.itemvalue end) as '妇科/妇科其它',
max(case when TempA1.combin_name='妇科' and TempA1.name='TCT检测' then TempA1.itemvalue end) as '妇科/TCT检测',
max(case when TempA1.combin_name='妇科' and TempA1.name='检查者' then TempA1.itemvalue end) as '妇科/检查者',

max(case when TempA1.combin_name='放射检查' and TempA1.name='胸片' then TempA1.itemvalue end) as '放射检查/胸片',
max(case when TempA1.combin_name='放射检查' and TempA1.name='颈椎片' then TempA1.itemvalue end) as '放射检查/颈椎片',
max(case when TempA1.combin_name='放射检查' and TempA1.name='腰椎片' then TempA1.itemvalue end) as '放射检查/腰椎片',
max(case when TempA1.combin_name='放射检查' and TempA1.name='膝关节片' then TempA1.itemvalue end) as '放射检查/膝关节片',
max(case when TempA1.combin_name='放射检查' and TempA1.name='其它X光片' then TempA1.itemvalue end) as '放射检查/其它X光片',
max(case when TempA1.combin_name='放射检查' and TempA1.name='检查者' then TempA1.itemvalue end) as '放射检查/检查者',

max(case when TempA1.combin_name='心电图' and TempA1.name='心电图' then TempA1.itemvalue end) as '心电图/心电图',
max(case when TempA1.combin_name='心电图' and TempA1.name='检查者' then TempA1.itemvalue end) as '心电图/检查者',

max(case when TempA1.combin_name='B超' and TempA1.name='肝' then TempA1.itemvalue end) as 'B超/肝',
max(case when TempA1.combin_name='B超' and TempA1.name='胆' then TempA1.itemvalue end) as 'B超/胆',
max(case when TempA1.combin_name='B超' and TempA1.name='脾' then TempA1.itemvalue end) as 'B超/脾',
max(case when TempA1.combin_name='B超' and TempA1.name='双肾' then TempA1.itemvalue end) as 'B超/双肾',
max(case when TempA1.combin_name='B超' and TempA1.name='膀胱' then TempA1.itemvalue end) as 'B超/膀胱',
max(case when TempA1.combin_name='B超' and TempA1.name='前列腺' then TempA1.itemvalue end) as 'B超/前列腺',
max(case when TempA1.combin_name='B超' and TempA1.name='子宫附件' then TempA1.itemvalue end) as 'B超/子宫附件',
max(case when TempA1.combin_name='B超' and TempA1.name='检查者' then TempA1.itemvalue end) as 'B超/检查者',

max(case when TempA1.combin_name='彩超' and TempA1.name='肝' then TempA1.itemvalue end) as '彩超/肝',
max(case when TempA1.combin_name='彩超' and TempA1.name='胆' then TempA1.itemvalue end) as '彩超/胆',
max(case when TempA1.combin_name='彩超' and TempA1.name='脾' then TempA1.itemvalue end) as '彩超/脾',
max(case when TempA1.combin_name='彩超' and TempA1.name='胰腺' then TempA1.itemvalue end) as '彩超/胰腺',
max(case when TempA1.combin_name='彩超' and TempA1.name='双肾' then TempA1.itemvalue end) as '彩超/双肾',
max(case when TempA1.combin_name='彩超' and TempA1.name='膀胱' then TempA1.itemvalue end) as '彩超/膀胱',
max(case when TempA1.combin_name='彩超' and TempA1.name='前列腺' then TempA1.itemvalue end) as '彩超/前列腺',
max(case when TempA1.combin_name='彩超' and TempA1.name='子宫及附件' then TempA1.itemvalue end) as '彩超/子宫及附件',
max(case when TempA1.combin_name='彩超' and TempA1.name='乳腺' then TempA1.itemvalue end) as '彩超/乳腺',
max(case when TempA1.combin_name='彩超' and TempA1.name='甲状腺' then TempA1.itemvalue end) as '彩超/甲状腺',
max(case when TempA1.combin_name='彩超' and TempA1.name='心脏' then TempA1.itemvalue end) as '彩超/心脏',
max(case when TempA1.combin_name='彩超' and TempA1.name='血管' then TempA1.itemvalue end) as '彩超/血管',
max(case when TempA1.combin_name='彩超' and TempA1.name='腔内' then TempA1.itemvalue end) as '彩超/腔内',
max(case when TempA1.combin_name='彩超' and TempA1.name='检查者' then TempA1.itemvalue end) as '彩超/检查者'--,
/*
max(case when TempA1.combin_name='血常规' and TempA1.name='白细胞' then TempA1.itemvalue end) as '血常规/白细胞',
max(case when TempA1.combin_name='血常规' and TempA1.name='红细胞' then TempA1.itemvalue end) as '血常规/红细胞',
max(case when TempA1.combin_name='血常规' and TempA1.name='血红蛋白' then TempA1.itemvalue end) as '血常规/血红蛋白',
max(case when TempA1.combin_name='血常规' and TempA1.name='红细胞比积' then TempA1.itemvalue end) as '血常规/红细胞比积',
max(case when TempA1.combin_name='血常规' and TempA1.name='平均红细胞体积' then TempA1.itemvalue end) as '血常规/平均红细胞体积',
max(case when TempA1.combin_name='血常规' and TempA1.name='平均血红蛋白含量' then TempA1.itemvalue end) as '血常规/平均血红蛋白含量',
max(case when TempA1.combin_name='血常规' and TempA1.name='平均血红蛋白浓度' then TempA1.itemvalue end) as '血常规/平均血红蛋白浓度',
max(case when TempA1.combin_name='血常规' and TempA1.name='血小板' then TempA1.itemvalue end) as '血常规/血小板',
max(case when TempA1.combin_name='血常规' and TempA1.name='淋巴细胞百分比' then TempA1.itemvalue end) as '血常规/淋巴细胞百分比',
max(case when TempA1.combin_name='血常规' and TempA1.name='单核细胞百分比' then TempA1.itemvalue end) as '血常规/单核细胞百分比',
max(case when TempA1.combin_name='血常规' and TempA1.name='粒细胞百分比' then TempA1.itemvalue end) as '血常规/粒细胞百分比',
max(case when TempA1.combin_name='血常规' and TempA1.name='淋巴细胞记数' then TempA1.itemvalue end) as '血常规/淋巴细胞记数',
max(case when TempA1.combin_name='血常规' and TempA1.name='单核细胞记数' then TempA1.itemvalue end) as '血常规/单核细胞记数',
max(case when TempA1.combin_name='血常规' and TempA1.name='粒细胞记数' then TempA1.itemvalue end) as '血常规/粒细胞记数',
max(case when TempA1.combin_name='血常规' and TempA1.name='红细胞分布宽度标准差' then TempA1.itemvalue end) as '血常规/红细胞分布宽度标准差',
max(case when TempA1.combin_name='血常规' and TempA1.name='血小板体积分布宽度' then TempA1.itemvalue end) as '血常规/血小板体积分布宽度',
max(case when TempA1.combin_name='血常规' and TempA1.name='平均血小板体积' then TempA1.itemvalue end) as '血常规/平均血小板体积',
max(case when TempA1.combin_name='血常规' and TempA1.name='血小板压积' then TempA1.itemvalue end) as '血常规/血小板压积',
max(case when TempA1.combin_name='血常规' and TempA1.name='红细胞分布宽度变异系数' then TempA1.itemvalue end) as '血常规/红细胞分布宽度变异系数',

max(case when TempA1.combin_name='乙肝两对半' and TempA1.name='乙肝表面抗原' then TempA1.itemvalue end) as '乙肝两对半/乙肝表面抗原',
max(case when TempA1.combin_name='乙肝两对半' and TempA1.name='乙肝表面抗体' then TempA1.itemvalue end) as '乙肝两对半/乙肝表面抗体',
max(case when TempA1.combin_name='乙肝两对半' and TempA1.name='乙肝e抗原' then TempA1.itemvalue end) as '乙肝两对半/乙肝e抗原',
max(case when TempA1.combin_name='乙肝两对半' and TempA1.name='乙肝e抗体' then TempA1.itemvalue end) as '乙肝两对半/乙肝e抗体',
max(case when TempA1.combin_name='乙肝两对半' and TempA1.name='乙肝核心抗体' then TempA1.itemvalue end) as '乙肝两对半/乙肝核心抗体',

max(case when TempA1.combin_name='尿常规' and TempA1.name='潜  血' then TempA1.itemvalue end) as '尿常规/潜  血',
max(case when TempA1.combin_name='尿常规' and TempA1.name='尿胆原' then TempA1.itemvalue end) as '尿常规/尿胆原',
max(case when TempA1.combin_name='尿常规' and TempA1.name='亚硝酸盐' then TempA1.itemvalue end) as '尿常规/亚硝酸盐',
max(case when TempA1.combin_name='尿常规' and TempA1.name='蛋白质' then TempA1.itemvalue end) as '尿常规/蛋白质',
max(case when TempA1.combin_name='尿常规' and TempA1.name='酮  体' then TempA1.itemvalue end) as '尿常规/酮  体',
max(case when TempA1.combin_name='尿常规' and TempA1.name='比  重' then TempA1.itemvalue end) as '尿常规/比  重',
max(case when TempA1.combin_name='尿常规' and TempA1.name='ＰＨ值' then TempA1.itemvalue end) as '尿常规/ＰＨ值',
max(case when TempA1.combin_name='尿常规' and TempA1.name='胆红素' then TempA1.itemvalue end) as '尿常规/胆红素',
max(case when TempA1.combin_name='尿常规' and TempA1.name='葡萄糖' then TempA1.itemvalue end) as '尿常规/葡萄糖',
max(case when TempA1.combin_name='尿常规' and TempA1.name='白细胞' then TempA1.itemvalue end) as '尿常规/白细胞'
*/
 from 
(
select cc.unid,cc.caseno, cc.patientname,cc.sex,cc.age,
TempA2.combin_name,TempA2.name,TempA2.itemvalue 
from dbo.view_chk_con_all cc
left join 
(
select cc2.patientname,cc2.sex,cc2.age,cv2.combin_name ,cv2.Name,cv2.english_name,cv2.itemvalue,cv2.Unit,cv2.Min_value,cv2.Max_value 
from view_chk_con_all cc2,view_chk_valu_all cv2 where cc2.unid=cv2.pkunid
and isnull(cv2.itemvalue,'')<>'' and cv2.issure=1
and cc2.check_date>getdate()-60--控制时间范围内的检验结果
) TempA2 on TempA2.patientname=cc.patientname and isnull(TempA2.sex,'')=isnull(cc.sex,'') and replace(isnull(TempA2.age,''),'岁','')=replace(isnull(cc.age,''),'岁','')
where cc.combin_id like '%体检2组%'--控制工作组别的人员基本信息
and cc.check_date>getdate()-60--控制时间范围内的人员基本信息
and isnull(cc.patientname,'')<>''
) TempA1

group by 
TempA1.unid,
TempA1.caseno,
TempA1.patientname,
TempA1.sex,
TempA1.age