select 
TempA1.WorkID as ���֤��,
TempA1.patientname as ����,
TempA1.sex as �Ա�,
TempA1.age as ����,

max(case when TempA1.combin_name in ('Ѫ����','DMѪ����') and TempA1.name='��ϸ��' then TempA1.itemvalue end) as 'Ѫ����/��ϸ��',
max(case when TempA1.combin_name in ('Ѫ����','DMѪ����') and TempA1.name='Ѫ�쵰��' then TempA1.itemvalue end) as 'Ѫ����/Ѫ�쵰��',
max(case when TempA1.combin_name in ('Ѫ����','DMѪ����') and TempA1.name='ѪС��' then TempA1.itemvalue end) as 'Ѫ����/ѪС��',

max(case when TempA1.combin_name in ('��ʮһ����','ȫ�Զ��������') and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������',
max(case when TempA1.combin_name in ('��ʮһ����','ȫ�Զ��������') and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������',
max(case when TempA1.combin_name in ('��ʮһ����','ȫ�Զ��������') and TempA1.name='ͪ��' then TempA1.itemvalue end) as '�򳣹�/ͪ��',
max(case when TempA1.combin_name in ('��ʮһ����','ȫ�Զ��������') and TempA1.name in ('��ϸ��','ǱѪ') then TempA1.itemvalue end) as '�򳣹�/��ϸ��',

max(case when TempA1.combin_name='��㳣����' and TempA1.name='ǱѪ' then TempA1.itemvalue end) as '��㳣��/ǱѪ',

max(case when TempA1.combin_name='�������' and TempA1.name='��' then TempA1.itemvalue end) as '�����/��',
max(case when TempA1.combin_name='�������' and TempA1.name='��' then TempA1.itemvalue end) as '�����/��',

max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='�ȱ�ת��ø' then TempA1.itemvalue end) as '����/�ȱ�ת��ø',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='�Ȳ�ת��ø' then TempA1.itemvalue end) as '����/�Ȳ�ת��ø',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='�׵���' then TempA1.itemvalue end) as '����/�׵���',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='�ܵ�����' then TempA1.itemvalue end) as '����/�ܵ�����',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='ֱ�ӵ�����' then TempA1.itemvalue end) as '����/ֱ�ӵ�����',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='����' then TempA1.itemvalue end) as '����/����',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='����' then TempA1.itemvalue end) as '����/����',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='�ܵ��̴�' then TempA1.itemvalue end) as '����/�ܵ��̴�',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='��������' then TempA1.itemvalue end) as '����/��������',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='���ܶ�֬���׵��̴�' then TempA1.itemvalue end) as '����/���ܶ�֬���׵��̴�',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='���ܶ�֬���׵��̴�' then TempA1.itemvalue end) as '����/���ܶ�֬���׵��̴�',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='������' then TempA1.itemvalue end) as '����/������',
max(case when TempA1.combin_name='�����飨sl��' and TempA1.name='�Ҹα��濹ԭ' then TempA1.itemvalue end) as '����/�Ҹα��濹ԭ',

max(case when TempA1.combin_name='�ǻ�Ѫ�쵰�׹�����' and TempA1.name='�ǻ�Ѫ�쵰��' then TempA1.itemvalue end) as '�ǻ�/�ǻ�Ѫ�쵰��'

 from 
(

select cc2.WorkID,cc2.patientname,cc2.sex,cc2.age,cv2.combin_name ,cv2.Name,cv2.english_name,cv2.itemvalue,cv2.Unit,cv2.Min_value,cv2.Max_value 
from view_chk_con_all cc2,view_chk_valu_all cv2 where cc2.unid=cv2.pkunid
and isnull(cv2.itemvalue,'')<>'' and cv2.issure=1
and cc2.check_date>getdate()-400--����ʱ�䷶Χ�ڵļ�����
and isnull(cc2.WorkID,'')<>''
) TempA1 

group by 
TempA1.WorkID,
TempA1.patientname,
TempA1.sex,
TempA1.age
