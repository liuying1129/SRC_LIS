select 
TempA1.unid,
TempA1.caseno as ������,
TempA1.patientname as ����,
TempA1.sex as �Ա�,
TempA1.age as ����,

max(case when TempA1.combin_name='������' and TempA1.name='������' then TempA1.itemvalue end) as '������/������',
max(case when TempA1.combin_name='��콨��' and TempA1.name='ҽ������' then TempA1.itemvalue end) as '��콨��/ҽ������',

max(case when TempA1.combin_name='һ����Ŀ���' and TempA1.name='���' then TempA1.itemvalue end) as 'һ����Ŀ���/���',
max(case when TempA1.combin_name='һ����Ŀ���' and TempA1.name='����' then TempA1.itemvalue end) as 'һ����Ŀ���/����',
max(case when TempA1.combin_name='һ����Ŀ���' and TempA1.name='����ָ��' then TempA1.itemvalue end) as 'һ����Ŀ���/����ָ��',
max(case when TempA1.combin_name='һ����Ŀ���' and TempA1.name='����ѹ' then TempA1.itemvalue end) as 'һ����Ŀ���/����ѹ',
max(case when TempA1.combin_name='һ����Ŀ���' and TempA1.name='����ѹ' then TempA1.itemvalue end) as 'һ����Ŀ���/����ѹ',
max(case when TempA1.combin_name='һ����Ŀ���' and TempA1.name='�����' then TempA1.itemvalue end) as 'һ����Ŀ���/�����',

max(case when TempA1.combin_name='�ڿ�' and TempA1.name='��ʷ' then TempA1.itemvalue end) as '�ڿ�/��ʷ',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='����ʷ' then TempA1.itemvalue end) as '�ڿ�/����ʷ',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='����' then TempA1.itemvalue end) as '�ڿ�/����',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='����' then TempA1.itemvalue end) as '�ڿ�/����',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='�β�����' then TempA1.itemvalue end) as '�ڿ�/�β�����',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='���ഥ��' then TempA1.itemvalue end) as '�ڿ�/���ഥ��',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='Ƣ�ഥ��' then TempA1.itemvalue end) as '�ڿ�/Ƣ�ഥ��',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='����ߵ��' then TempA1.itemvalue end) as '�ڿ�/����ߵ��',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='�ڿ�����' then TempA1.itemvalue end) as '�ڿ�/�ڿ�����',
max(case when TempA1.combin_name='�ڿ�' and TempA1.name='�����' then TempA1.itemvalue end) as '�ڿ�/�����',

max(case when TempA1.combin_name='���' and TempA1.name='Ƥ��' then TempA1.itemvalue end) as '���/Ƥ��',
max(case when TempA1.combin_name='���' and TempA1.name='ǳ���ܰͽ�' then TempA1.itemvalue end) as '���/ǳ���ܰͽ�',
max(case when TempA1.combin_name='���' and TempA1.name='��״�٣���ƣ�' then TempA1.itemvalue end) as '���/��״�٣���ƣ�',
max(case when TempA1.combin_name='���' and TempA1.name='�鷿' then TempA1.itemvalue end) as '���/�鷿',
max(case when TempA1.combin_name='���' and TempA1.name='����' then TempA1.itemvalue end) as '���/����',
max(case when TempA1.combin_name='���' and TempA1.name='��֫�ؽ�' then TempA1.itemvalue end) as '���/��֫�ؽ�',
max(case when TempA1.combin_name='���' and TempA1.name='�������' then TempA1.itemvalue end) as '���/�������',
max(case when TempA1.combin_name='���' and TempA1.name='�����' then TempA1.itemvalue end) as '���/�����',

max(case when TempA1.combin_name='����' and TempA1.name='����' then TempA1.itemvalue end) as '����/����',
max(case when TempA1.combin_name='����' and TempA1.name='����' then TempA1.itemvalue end) as '����/����',
max(case when TempA1.combin_name='����' and TempA1.name='����' then TempA1.itemvalue end) as '����/����',
max(case when TempA1.combin_name='����' and TempA1.name='�ӹ�' then TempA1.itemvalue end) as '����/�ӹ�',
max(case when TempA1.combin_name='����' and TempA1.name='����' then TempA1.itemvalue end) as '����/����',
max(case when TempA1.combin_name='����' and TempA1.name='��������' then TempA1.itemvalue end) as '����/��������',
max(case when TempA1.combin_name='����' and TempA1.name='TCT���' then TempA1.itemvalue end) as '����/TCT���',
max(case when TempA1.combin_name='����' and TempA1.name='�����' then TempA1.itemvalue end) as '����/�����',

max(case when TempA1.combin_name='������' and TempA1.name='��Ƭ' then TempA1.itemvalue end) as '������/��Ƭ',
max(case when TempA1.combin_name='������' and TempA1.name='��׵Ƭ' then TempA1.itemvalue end) as '������/��׵Ƭ',
max(case when TempA1.combin_name='������' and TempA1.name='��׵Ƭ' then TempA1.itemvalue end) as '������/��׵Ƭ',
max(case when TempA1.combin_name='������' and TempA1.name='ϥ�ؽ�Ƭ' then TempA1.itemvalue end) as '������/ϥ�ؽ�Ƭ',
max(case when TempA1.combin_name='������' and TempA1.name='����X��Ƭ' then TempA1.itemvalue end) as '������/����X��Ƭ',
max(case when TempA1.combin_name='������' and TempA1.name='�����' then TempA1.itemvalue end) as '������/�����',

max(case when TempA1.combin_name='�ĵ�ͼ' and TempA1.name='�ĵ�ͼ' then TempA1.itemvalue end) as '�ĵ�ͼ/�ĵ�ͼ',
max(case when TempA1.combin_name='�ĵ�ͼ' and TempA1.name='�����' then TempA1.itemvalue end) as '�ĵ�ͼ/�����',

max(case when TempA1.combin_name='B��' and TempA1.name='��' then TempA1.itemvalue end) as 'B��/��',
max(case when TempA1.combin_name='B��' and TempA1.name='��' then TempA1.itemvalue end) as 'B��/��',
max(case when TempA1.combin_name='B��' and TempA1.name='Ƣ' then TempA1.itemvalue end) as 'B��/Ƣ',
max(case when TempA1.combin_name='B��' and TempA1.name='˫��' then TempA1.itemvalue end) as 'B��/˫��',
max(case when TempA1.combin_name='B��' and TempA1.name='����' then TempA1.itemvalue end) as 'B��/����',
max(case when TempA1.combin_name='B��' and TempA1.name='ǰ����' then TempA1.itemvalue end) as 'B��/ǰ����',
max(case when TempA1.combin_name='B��' and TempA1.name='�ӹ�����' then TempA1.itemvalue end) as 'B��/�ӹ�����',
max(case when TempA1.combin_name='B��' and TempA1.name='�����' then TempA1.itemvalue end) as 'B��/�����',

max(case when TempA1.combin_name='�ʳ�' and TempA1.name='��' then TempA1.itemvalue end) as '�ʳ�/��',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='��' then TempA1.itemvalue end) as '�ʳ�/��',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='Ƣ' then TempA1.itemvalue end) as '�ʳ�/Ƣ',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='����' then TempA1.itemvalue end) as '�ʳ�/����',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='˫��' then TempA1.itemvalue end) as '�ʳ�/˫��',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='����' then TempA1.itemvalue end) as '�ʳ�/����',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='ǰ����' then TempA1.itemvalue end) as '�ʳ�/ǰ����',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='�ӹ�������' then TempA1.itemvalue end) as '�ʳ�/�ӹ�������',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='����' then TempA1.itemvalue end) as '�ʳ�/����',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='��״��' then TempA1.itemvalue end) as '�ʳ�/��״��',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='����' then TempA1.itemvalue end) as '�ʳ�/����',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='Ѫ��' then TempA1.itemvalue end) as '�ʳ�/Ѫ��',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='ǻ��' then TempA1.itemvalue end) as '�ʳ�/ǻ��',
max(case when TempA1.combin_name='�ʳ�' and TempA1.name='�����' then TempA1.itemvalue end) as '�ʳ�/�����'--,
/*
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ��' then TempA1.itemvalue end) as 'Ѫ����/��ϸ��',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ��' then TempA1.itemvalue end) as 'Ѫ����/��ϸ��',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='Ѫ�쵰��' then TempA1.itemvalue end) as 'Ѫ����/Ѫ�쵰��',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ���Ȼ�' then TempA1.itemvalue end) as 'Ѫ����/��ϸ���Ȼ�',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='ƽ����ϸ�����' then TempA1.itemvalue end) as 'Ѫ����/ƽ����ϸ�����',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='ƽ��Ѫ�쵰�׺���' then TempA1.itemvalue end) as 'Ѫ����/ƽ��Ѫ�쵰�׺���',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='ƽ��Ѫ�쵰��Ũ��' then TempA1.itemvalue end) as 'Ѫ����/ƽ��Ѫ�쵰��Ũ��',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='ѪС��' then TempA1.itemvalue end) as 'Ѫ����/ѪС��',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='�ܰ�ϸ���ٷֱ�' then TempA1.itemvalue end) as 'Ѫ����/�ܰ�ϸ���ٷֱ�',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='����ϸ���ٷֱ�' then TempA1.itemvalue end) as 'Ѫ����/����ϸ���ٷֱ�',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ���ٷֱ�' then TempA1.itemvalue end) as 'Ѫ����/��ϸ���ٷֱ�',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='�ܰ�ϸ������' then TempA1.itemvalue end) as 'Ѫ����/�ܰ�ϸ������',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='����ϸ������' then TempA1.itemvalue end) as 'Ѫ����/����ϸ������',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ������' then TempA1.itemvalue end) as 'Ѫ����/��ϸ������',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ���ֲ���ȱ�׼��' then TempA1.itemvalue end) as 'Ѫ����/��ϸ���ֲ���ȱ�׼��',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='ѪС������ֲ����' then TempA1.itemvalue end) as 'Ѫ����/ѪС������ֲ����',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='ƽ��ѪС�����' then TempA1.itemvalue end) as 'Ѫ����/ƽ��ѪС�����',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='ѪС��ѹ��' then TempA1.itemvalue end) as 'Ѫ����/ѪС��ѹ��',
max(case when TempA1.combin_name='Ѫ����' and TempA1.name='��ϸ���ֲ���ȱ���ϵ��' then TempA1.itemvalue end) as 'Ѫ����/��ϸ���ֲ���ȱ���ϵ��',

max(case when TempA1.combin_name='�Ҹ����԰�' and TempA1.name='�Ҹα��濹ԭ' then TempA1.itemvalue end) as '�Ҹ����԰�/�Ҹα��濹ԭ',
max(case when TempA1.combin_name='�Ҹ����԰�' and TempA1.name='�Ҹα��濹��' then TempA1.itemvalue end) as '�Ҹ����԰�/�Ҹα��濹��',
max(case when TempA1.combin_name='�Ҹ����԰�' and TempA1.name='�Ҹ�e��ԭ' then TempA1.itemvalue end) as '�Ҹ����԰�/�Ҹ�e��ԭ',
max(case when TempA1.combin_name='�Ҹ����԰�' and TempA1.name='�Ҹ�e����' then TempA1.itemvalue end) as '�Ҹ����԰�/�Ҹ�e����',
max(case when TempA1.combin_name='�Ҹ����԰�' and TempA1.name='�Ҹκ��Ŀ���' then TempA1.itemvalue end) as '�Ҹ����԰�/�Ҹκ��Ŀ���',

max(case when TempA1.combin_name='�򳣹�' and TempA1.name='Ǳ  Ѫ' then TempA1.itemvalue end) as '�򳣹�/Ǳ  Ѫ',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��ԭ' then TempA1.itemvalue end) as '�򳣹�/��ԭ',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��������' then TempA1.itemvalue end) as '�򳣹�/��������',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='ͪ  ��' then TempA1.itemvalue end) as '�򳣹�/ͪ  ��',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��  ��' then TempA1.itemvalue end) as '�򳣹�/��  ��',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='�У�ֵ' then TempA1.itemvalue end) as '�򳣹�/�У�ֵ',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='������' then TempA1.itemvalue end) as '�򳣹�/������',
max(case when TempA1.combin_name='�򳣹�' and TempA1.name='��ϸ��' then TempA1.itemvalue end) as '�򳣹�/��ϸ��'
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
and cc2.check_date>getdate()-60--����ʱ�䷶Χ�ڵļ�����
) TempA2 on TempA2.patientname=cc.patientname and isnull(TempA2.sex,'')=isnull(cc.sex,'') and replace(isnull(TempA2.age,''),'��','')=replace(isnull(cc.age,''),'��','')
where cc.combin_id like '%���2��%'--���ƹ���������Ա������Ϣ
and cc.check_date>getdate()-60--����ʱ�䷶Χ�ڵ���Ա������Ϣ
and isnull(cc.patientname,'')<>''
) TempA1

group by 
TempA1.unid,
TempA1.caseno,
TempA1.patientname,
TempA1.sex,
TempA1.age