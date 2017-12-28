select 
TempA1.WorkID as 身份证号,
TempA1.patientname as 姓名,
TempA1.sex as 性别,
TempA1.age as 年龄,

max(case when TempA1.combin_name in ('血球组','DM血常规') and TempA1.name='白细胞' then TempA1.itemvalue end) as '血常规/白细胞',
max(case when TempA1.combin_name in ('血球组','DM血常规') and TempA1.name='血红蛋白' then TempA1.itemvalue end) as '血常规/血红蛋白',
max(case when TempA1.combin_name in ('血球组','DM血常规') and TempA1.name='血小板' then TempA1.itemvalue end) as '血常规/血小板',

max(case when TempA1.combin_name in ('尿十一项组','全自动尿沉渣组') and TempA1.name='葡萄糖' then TempA1.itemvalue end) as '尿常规/葡萄糖',
max(case when TempA1.combin_name in ('尿十一项组','全自动尿沉渣组') and TempA1.name='蛋白质' then TempA1.itemvalue end) as '尿常规/蛋白质',
max(case when TempA1.combin_name in ('尿十一项组','全自动尿沉渣组') and TempA1.name='酮体' then TempA1.itemvalue end) as '尿常规/酮体',
max(case when TempA1.combin_name in ('尿十一项组','全自动尿沉渣组') and TempA1.name in ('红细胞','潜血') then TempA1.itemvalue end) as '尿常规/红细胞',

max(case when TempA1.combin_name='大便常规组' and TempA1.name='潜血' then TempA1.itemvalue end) as '大便常规/潜血',

max(case when TempA1.combin_name='电解质组' and TempA1.name='钾' then TempA1.itemvalue end) as '电解质/钾',
max(case when TempA1.combin_name='电解质组' and TempA1.name='钠' then TempA1.itemvalue end) as '电解质/钠',

max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='谷丙转氨酶' then TempA1.itemvalue end) as '生化/谷丙转氨酶',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='谷草转氨酶' then TempA1.itemvalue end) as '生化/谷草转氨酶',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='白蛋白' then TempA1.itemvalue end) as '生化/白蛋白',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='总胆红素' then TempA1.itemvalue end) as '生化/总胆红素',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='直接胆红素' then TempA1.itemvalue end) as '生化/直接胆红素',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='肌酐' then TempA1.itemvalue end) as '生化/肌酐',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='尿素' then TempA1.itemvalue end) as '生化/尿素',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='总胆固醇' then TempA1.itemvalue end) as '生化/总胆固醇',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='甘油三酯' then TempA1.itemvalue end) as '生化/甘油三酯',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='高密度脂蛋白胆固醇' then TempA1.itemvalue end) as '生化/高密度脂蛋白胆固醇',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='低密度脂蛋白胆固醇' then TempA1.itemvalue end) as '生化/低密度脂蛋白胆固醇',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='葡萄糖' then TempA1.itemvalue end) as '生化/葡萄糖',
max(case when TempA1.combin_name='生化组（sl）' and TempA1.name='乙肝表面抗原' then TempA1.itemvalue end) as '生化/乙肝表面抗原',

max(case when TempA1.combin_name='糖化血红蛋白工作组' and TempA1.name='糖化血红蛋白' then TempA1.itemvalue end) as '糖化/糖化血红蛋白'

 from 
(

select cc2.WorkID,cc2.patientname,cc2.sex,cc2.age,cv2.combin_name ,cv2.Name,cv2.english_name,cv2.itemvalue,cv2.Unit,cv2.Min_value,cv2.Max_value 
from view_chk_con_all cc2,view_chk_valu_all cv2 where cc2.unid=cv2.pkunid
and isnull(cv2.itemvalue,'')<>'' and cv2.issure=1
and cc2.check_date>getdate()-400--控制时间范围内的检验结果
and isnull(cc2.WorkID,'')<>''
) TempA1 

group by 
TempA1.WorkID,
TempA1.patientname,
TempA1.sex,
TempA1.age
