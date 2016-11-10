use YKLis
go

--删除关系FK_worker_department
if exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_worker_department' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.worker
	DROP CONSTRAINT FK_worker_department

--删除关系FK_clinicchkitem_combinitem
if exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_clinicchkitem_combinitem' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.clinicchkitem
	DROP CONSTRAINT FK_clinicchkitem_combinitem

--CombSChkItem
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CombSChkItem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
create table CombSChkItem
 (Unid int identity primary key,
  CombUnid int not null,
  ItemUnid int not null
)

--CommCode
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CommCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
create table CommCode
 (Unid int identity primary key,
  TypeName varchar(30) not null,
  ID varchar(30) not null,
  Name varchar(80) null,
  PYM varchar(30) null,
  WBM varchar(30) null,
  Remark varchar(100) null,
  Reserve varchar(100) null
)

--20120511,临床诊断,char(50)->varchar(200)
alter table CommCode alter column ID varchar(200) Not Null
GO

--20100315 start--授权使用单位挺长的
alter table CommCode alter column Name varchar(200) null
GO
alter table CommCode alter column PYM varchar(200) null
GO
alter table CommCode alter column WBM varchar(200) null
GO
--20100315 stop

if not exists(select * from sysindexes where name='IX_CommCode')
begin
CREATE UNIQUE NONCLUSTERED INDEX IX_CommCode ON dbo.CommCode
	(
	TypeName,
	ID
	) ON [PRIMARY]
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '优先级别',ID,Name,PINYIN,WBM from ChkStatus
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '临床诊断',ID,Name,PINYIN,WBM from clinicdiagnose
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '结果快捷码',ID,Name,PINYIN,WBM from codeexpress
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '部门',ID,Name,PINYIN,WBM from department
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '细菌',ID,Name,PINYIN,WBM from Germs
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '检验组别',ID,Name,PINYIN,WBM from InfoGroup
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '备注',ID,Name,PINYIN,WBM from memo
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '样本类型',ID,Name,PINYIN,WBM from specimentype
  insert into CommCode(TypeName,ID,Name,PYM,WBM) select '样本状态',ID,Name,PINYIN,WBM from specimencase
end

--combinitem
IF not EXISTS (select 1 from syscolumns where name='itemtype' and id=object_id('combinitem'))
  Alter table combinitem add itemtype varchar(50) null

IF EXISTS (select 1 from syscolumns where name='price' and id=object_id('combinitem'))
  Alter table combinitem drop column price

IF not EXISTS (select 1 from syscolumns where name='dept_DfValue' and id=object_id('combinitem'))
  Alter table combinitem add dept_DfValue varchar(30) null

IF EXISTS (select 1 from syscolumns where name='sex_DfValue' and id=object_id('combinitem'))
  Alter table combinitem drop column sex_DfValue

IF not EXISTS (select 1 from syscolumns where name='specimentype_DfValue' and id=object_id('combinitem'))
  Alter table combinitem add specimentype_DfValue varchar(60) null

IF EXISTS (select 1 from syscolumns where name='specimentcase_DfValue' and id=object_id('combinitem'))
  Alter table combinitem drop column specimentcase_DfValue

IF EXISTS (select 1 from syscolumns where name='diagnose_DfValue' and id=object_id('combinitem'))
  Alter table combinitem drop column diagnose_DfValue

IF NOT EXISTS (select 1 from syscolumns where name='PYM' and id=object_id('combinitem'))
  Alter table combinitem add PYM varchar(50) null

IF NOT EXISTS (select 1 from syscolumns where name='WBM' and id=object_id('combinitem'))
  Alter table combinitem add WBM varchar(50) null

IF NOT EXISTS (select 1 from syscolumns where name='Unid' and id=object_id('combinitem'))
begin
  ALTER TABLE dbo.combinitem DROP CONSTRAINT PK_combinitem
  Alter table combinitem add Unid int IDENTITY PRIMARY key
end

if not exists(select * from sysindexes where name='IX_combinitem')
  CREATE UNIQUE NONCLUSTERED INDEX [IX_combinitem] ON [dbo].[combinitem] 
  (
	[id] ASC
  )

go


--将数据插入到CombSChkItem表中 start
--combinitem中增加unid字段之后
--删除clinicchkitem重复记录之前
  DECLARE Cur_CombSChkItem Cursor For 
    select combinitem,itemid from clinicchkitem where (combinitem is not null) and (combinitem<>'')
  Open Cur_CombSChkItem

  Declare @combinitem varchar(50),@itemid varchar(50)
  FETCH NEXT FROM Cur_CombSChkItem INTO @combinitem,@itemid
  WHILE @@FETCH_STATUS=0
  BEGIN
    declare @itemunid int,@combunid varchar(50)
    select @itemunid=unid from clinicchkitem where (itemid=@itemid) and ((combinitem is null) or (combinitem=''))
    select @combunid=unid from combinitem where id=@combinitem
    if (@itemunid is not null) and (@combunid is not null)
      insert into CombSChkItem (itemunid,combunid) values (@itemunid,@combunid)


    FETCH NEXT FROM Cur_CombSChkItem INTO @combinitem,@itemid
  END
  CLOSE Cur_CombSChkItem
  DEALLOCATE Cur_CombSChkItem
go
--将数据插入到CombSChkItem表中 stop

--clinicchkitem
IF EXISTS (select 1 from syscolumns where name='combinitem' and id=object_id('clinicchkitem'))
  delete from clinicchkitem where (combinitem is not null) and (combinitem<>'')
GO

IF EXISTS (select 1 from syscolumns where name='combinitem' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column combinitem
GO

IF EXISTS (select 1 from syscolumns where name='reference' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column reference

IF EXISTS (select 1 from syscolumns where name='clinicmeaning' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column clinicmeaning

IF EXISTS (select 1 from syscolumns where name='channelno' and id=object_id('clinicchkitem'))
begin
  --由项目编号生成计算公式
  Alter table clinicchkitem drop column channelno
end

IF EXISTS (select 1 from syscolumns where name='itemtype' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column itemtype

IF EXISTS (select 1 from syscolumns where name='Qc_def' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column Qc_def

IF EXISTS (select 1 from syscolumns where name='QC_def_sd' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column QC_def_sd

IF EXISTS (select 1 from syscolumns where name='QC_def_hv_dest' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column QC_def_hv_dest

IF EXISTS (select 1 from syscolumns where name='QC_def_hv_sd' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column QC_def_hv_sd

IF EXISTS (select 1 from syscolumns where name='QC_def_lv_dest' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column QC_def_lv_dest

IF EXISTS (select 1 from syscolumns where name='QC_def_lv_sd' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column QC_def_lv_sd

--2010-05-03从varchar(15)改为varchar(100),使之能容纳直方图X轴的Title
IF EXISTS (select 1 from syscolumns where name='Dosage1' and id=object_id('clinicchkitem'))
  alter table clinicchkitem alter column Dosage1 varchar(100) null

--2015-05-30从varchar(15)改为varchar(100),使之能容纳酶标仪ELX800的计算公式
IF EXISTS (select 1 from syscolumns where name='Dosage2' and id=object_id('clinicchkitem'))
  alter table clinicchkitem alter column Dosage2 varchar(100) null

if not exists(select * from sysindexes where name='IX_clinicchkitem')
CREATE UNIQUE NONCLUSTERED INDEX [IX_clinicchkitem] ON [dbo].[clinicchkitem] 
(
	[itemid] ASC
) 

--创建clinicchkitem与CombSChkItem之间的关系
if not exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_CombSChkItem_clinicchkitem' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.CombSChkItem ADD CONSTRAINT
	FK_CombSChkItem_clinicchkitem FOREIGN KEY
	(
	ItemUnid
	) REFERENCES dbo.clinicchkitem
	(
	unid
	) ON UPDATE CASCADE
	 ON DELETE CASCADE

--创建combinitem与CombSChkItem之间的关系
if not exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_CombSChkItem_combinitem' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.CombSChkItem ADD CONSTRAINT
	FK_CombSChkItem_combinitem FOREIGN KEY
	(
	CombUnid
	) REFERENCES dbo.combinitem
	(
	unid
	) ON UPDATE CASCADE
	 ON DELETE CASCADE

go

--创建clinicchkitem与referencevalue之间的关系
if not exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_referencevalue_clinicchkitem' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.referencevalue ADD CONSTRAINT
	FK_referencevalue_clinicchkitem FOREIGN KEY
	(
	id
	) REFERENCES dbo.clinicchkitem
	(
	itemid
	) ON UPDATE CASCADE
	 ON DELETE CASCADE

--删除表ChkStatus
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ChkStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[ChkStatus]

--删除表clinicdiagnose
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[clinicdiagnose]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[clinicdiagnose]

--删除表codeexpress
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[codeexpress]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[codeexpress]

--删除表department
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[department]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
--删除科室表之前将人员转移 start
  DECLARE Cur_worker Cursor For 
    select Unid,pkdeptid FROM worker

  Open Cur_worker

  Declare @Unid int,@pkdeptid int
  FETCH NEXT FROM Cur_worker INTO @Unid,@pkdeptid
  WHILE @@FETCH_STATUS=0
  BEGIN
    Declare @Name varchar(30)
    select @Name=Name from department where Unid=@pkdeptid
    if @Name is not null --该人员不属于任何科室
    begin
      Declare @Unid2 int
      select @Unid2=Unid from CommCode where TypeName='部门' and Name=@Name
      if @Unid2 is not null --该人员不属于任何科室
        update worker set pkdeptid=@Unid2 where Unid=@Unid
    end

    FETCH NEXT FROM Cur_worker INTO @Unid,@pkdeptid
  END
  CLOSE Cur_worker
  DEALLOCATE Cur_worker
--删除科室表之前将人员转移 end
  drop table [dbo].[department]
end

--删除表Germs
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Germs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[Germs]

--删除表InfoGroup
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InfoGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[InfoGroup]

--删除表MEMO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MEMO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[MEMO]

--删除表specimencase
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[specimencase]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[specimencase]

--删除表specimentype
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[specimentype]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  drop table [dbo].[specimentype]


--20150616根据LIS组合项目得到对应的HIS项目串
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetHisCombItem]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetHisCombItem]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION uf_GetHisCombItem
(
  @LisCombUnid int --LIS组合项目UNID
)  
RETURNS varchar(500) AS  
BEGIN 
  declare @ret varchar(500)
  set @ret=''
  select @ret=@ret+','+HisItem from HisCombItem WHERE CombUnid=@LisCombUnid
  set @ret=stuff(@ret,1,1,'')

  return @ret
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--20150616根据项目得到项目的常见结果串
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetCommValue]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetCommValue]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION uf_GetCommValue
(
  @ItemUnid int --项目UNID
)  
RETURNS varchar(500) AS  
BEGIN 
  declare @ret varchar(500)
  set @ret=''
  select @ret=@ret+','+sValue+(case dfValue when 1 then '(默认值)' else '' end) from CommValue WHERE ItemUnid=@ItemUnid
  set @ret=stuff(@ret,1,1,'')

  return @ret
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--存储过程pro_PrintCombinItem创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pro_PrintCombinItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pro_PrintCombinItem]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--打印/导出组合项目
CREATE PROCEDURE [dbo].[pro_PrintCombinItem] 
AS

CREATE TABLE #temp01
(
   Unid int IDENTITY PRIMARY KEY,
   ItemName varchar(70) null,
   ItemEName varchar(50) null,
   itemUnit varchar(50) null,
   ItemPrice Money null,
   ItemDefault varchar(100) null
)

DECLARE Cur_combinitem Cursor For 
	select Unid,Name from combinitem order by ID

Open Cur_combinitem

Declare @Unid int,@Name varchar(60)
FETCH NEXT FROM Cur_combinitem INTO @Unid,@Name
WHILE @@FETCH_STATUS=0
BEGIN
  --插入组合项目名
  insert into #temp01 (ItemName,ItemDefault) values (@Name+'(组合项目)',dbo.uf_GetHisCombItem(@Unid))
  --插入项目信息
  insert into #temp01 (ItemName,ItemEName,itemUnit,ItemPrice,ItemDefault)
    select (select top 1 name from clinicchkitem A where A.unid=ItemUnid),
           (select top 1 english_name from clinicchkitem B where B.unid=ItemUnid),
	   (select top 1 unit from clinicchkitem C where C.unid=ItemUnid),
	   (select top 1 price from clinicchkitem D where D.unid=ItemUnid),
	   dbo.uf_GetCommValue(ItemUnid) 
    from CombSChkItem where CombUnid=@unid

  FETCH NEXT FROM Cur_combinitem INTO @Unid,@Name
END
CLOSE Cur_combinitem
DEALLOCATE Cur_combinitem

select 
   --Unid int IDENTITY PRIMARY KEY,
   ItemName 名称,
   ItemEName 英文名,
   itemUnit 单位,
   ItemPrice 价格,
   ItemDefault 常见结果
from #temp01

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--删除触发器TRIGGER_chk_con_SCJG_Update
if exists (select name from sysobjects where name='TRIGGER_chk_con_SCJG_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_con_SCJG_Update
go

--删除触发器TRIGGER_chk_valu_SCJG_insert
if exists (select name from sysobjects where name='TRIGGER_chk_valu_SCJG_insert' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_SCJG_insert
go

IF EXISTS (select 1 from syscolumns where name='itemvalue_hist' and id=object_id('chk_valu'))
Alter table chk_valu drop column itemvalue_hist
go

IF EXISTS (select 1 from syscolumns where name='check_date_hist' and id=object_id('chk_valu'))
Alter table chk_valu drop column check_date_hist
go

IF EXISTS (select 1 from syscolumns where name='itemvalue_hist' and id=object_id('chk_valu_bak'))
Alter table chk_valu_bak drop column itemvalue_hist
go

IF EXISTS (select 1 from syscolumns where name='check_date_hist' and id=object_id('chk_valu_bak'))
Alter table chk_valu_bak drop column check_date_hist
go

--从EXCEL导入信息时要用到，故要保留
--IF EXISTS (select 1 from syscolumns where name='DNH' and id=object_id('chk_con'))
--Alter table chk_con drop column DNH
--go

--IF EXISTS (select 1 from syscolumns where name='DNH' and id=object_id('chk_con_bak'))
--Alter table chk_con_bak drop column DNH
--go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetPy]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetPy]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE  function uf_GetPy
(
@str nvarchar(4000)
)
returns nvarchar(4000)
as
begin
declare @strlen int,@re nvarchar(4000)
declare @t table(chr nchar(1) collate Chinese_PRC_CI_AS,letter nchar(1))
insert into @t(chr,letter)
  select '吖','A' union all select '八','B' union all
  select '嚓','C' union all select '咑','D' union all
  select '妸','E' union all select '发','F' union all
  select '旮','G' union all select '铪','H' union all
  select '丌','J' union all select '咔','K' union all
  select '垃','L' union all select '嘸','M' union all
  select '拏','N' union all select '噢','O' union all
  select '妑','P' union all select '七','Q' union all
  select '呥','R' union all select '仨','S' union all
  select '他','T' union all select '屲','W' union all
  select '夕','X' union all select '丫','Y' union all
  select '帀','Z'
  select @strlen=len(@str),@re=''
  while @strlen>0
  begin
  select top 1 @re=letter+@re,@strlen=@strlen-1
  from @t a where chr<=substring(@str,@strlen,1)
  order by chr desc
  if @@rowcount=0
  select @re=substring(@str,@strlen,1)+@re,@strlen=@strlen-1
  end
  return(@re)
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_ifHasHistoricalValue]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_ifHasHistoricalValue]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--是否存在历史结果
--有则返回1,否则返回0
CREATE   FUNCTION uf_ifHasHistoricalValue
(
  @ValueUnid int
)  
RETURNS bit AS  
BEGIN 
  if @ValueUnid is null return 0
  declare @pkunid int,@itemid varchar(50)
  SELECT @pkunid=pkunid,@itemid=itemid FROM chk_valu where valueid=@ValueUnid 
  if (@pkunid is null)  return 0--表示没找到刚刚插入记录相对应的主记录

  declare @patientname varchar(50),@age varchar(50),@sex varchar(50),@report_date datetime
  select @patientname=patientname,@age=age,@sex=sex,@report_date=report_date from chk_con where unid=@pkunid
  if (@patientname='')or(@patientname is null) return 0
  if (@age='')or(@age is null) return 0
  if (@sex='')or(@sex is null) return 0
  declare @Birthday datetime
  set @Birthday=dbo.uf_GetBirthday(@age,@report_date)
  if (@Birthday='')or(@Birthday is null)or(@Birthday=0) return 0

  if exists(select 1 from chk_con_bak Z,chk_valu_bak F 
   where z.unid=f.pkunid and 
   z.patientname=@patientname and 
   z.sex=@sex and 
   datepart(yyyy,dbo.uf_GetBirthday(z.age,z.report_date))=datepart(yyyy,@Birthday) and 
   f.itemid=@itemid and
   z.check_date is not null and 
   z.check_date<>'' and 
   z.check_date<>0 and 
   f.itemvalue is not null and 
   f.itemvalue<>'') return 1
  return 0
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


---------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetAgeReal]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetAgeReal]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--返回年龄的实数值(分钟值)
--2006-01-05年龄传入'成'则默认为18岁
CREATE         FUNCTION uf_GetAgeReal
(
  @ageStr varchar(50)--ageStr='1岁2月3天4小时5分钟'
)  
RETURNS float AS  
BEGIN 
  declare @re_age float --返回值
  set @re_age=0

  if(@agestr='')or(@agestr is null) return 0
  if(ltrim(rtrim(@agestr))='成') return 18*365*24*60

  if isnumeric(@agestr)=1 --//只有数字时按岁来计算
  begin
    set @re_age=convert(float,@agestr)*365*24*60
    return @re_age
  end

  declare @yPos int,@mPos int,@dpos int,@hpos int,@minpos int
  declare @temp varchar(50),@temp_ageStr varchar(50)

  set @temp_ageStr=@ageStr
  set @yPos=charindex('岁',@temp_ageStr)
  if @yPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@yPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@yPos)
    if isnumeric(@temp)=1 
    begin
      set @re_age=@re_age+convert(float,@temp)*365*24*60
    end
  end
  
  set @mPos=charindex('月',@temp_ageStr)
  if @mPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@mPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@mPos)
    if isnumeric(@temp)=1 
    begin
      set @re_age=@re_age+convert(float,@temp)*30*24*60
    end
  end

  set @dpos=charindex('天',@temp_ageStr)
  if @dPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@dPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@dPos)
    if isnumeric(@temp)=1 
    begin
      set @re_age=@re_age+convert(float,@temp)*24*60
    end
  end

  set @hpos=charindex('小时',@temp_ageStr)
  if @hPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@hPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@hPos-1)
    if isnumeric(@temp)=1 
    begin
      set @re_age=@re_age+convert(float,@temp)*60
    end
  end

  set @minpos=charindex('分钟',@temp_ageStr)
  if @minPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@minPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@minPos-1)
    if isnumeric(@temp)=1 
    begin
      set @re_age=@re_age+convert(float,@temp)*1
    end
  end

  return @re_age
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetBirthday]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetBirthday]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--返回生日
--2006-01-05年龄传入'成'则默认为18岁
CREATE      FUNCTION uf_GetBirthday
(
  @ageStr varchar(50),--ageStr='1岁2月3日4小时5分钟'
  @op_date datetime --送检日期
)  
RETURNS datetime AS  
BEGIN 
  if(@agestr='')or(@agestr is null) return null
  if isdate(@op_date)=0 return null --不是合法的日期
  if(@op_date='')or(@op_date is null) return null 
  declare @re_age datetime --返回值
  set @re_age=null

  if(ltrim(rtrim(@agestr))='成') set @agestr='18'
  if isnumeric(@agestr)=1 --//只有数字时按岁来计算
  begin
    set @re_age=@op_date-convert(float,@agestr)*365
    return @re_age
  end

  declare @yPos int,@mPos int,@dpos int,@hpos int,@minpos int
  declare @temp varchar(50),@temp_ageStr varchar(50)

  set @temp_ageStr=@ageStr
  set @yPos=charindex('岁',@temp_ageStr)
  if @yPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@yPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@yPos)
    if isnumeric(@temp)=1 
    begin
      set @re_age=isnull(@re_age,@op_date)-convert(float,@temp)*365
    end
  end
  
  set @mPos=charindex('月',@temp_ageStr)
  if @mPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@mPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@mPos)
    if isnumeric(@temp)=1 
    begin
      set @re_age=isnull(@re_age,@op_date)-convert(float,@temp)*30
    end
  end

  set @dpos=charindex('天',@temp_ageStr)
  if @dPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@dPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@dPos)
    if isnumeric(@temp)=1 
    begin
      set @re_age=isnull(@re_age,@op_date)-convert(float,@temp)
    end
  end

  set @hpos=charindex('小时',@temp_ageStr)
  if @hPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@hPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@hPos-1)
    if isnumeric(@temp)=1 
    begin
      set @re_age=isnull(@re_age,@op_date)-convert(float,@temp)/24
    end
  end

  set @minpos=charindex('分钟',@temp_ageStr)
  if @minPos<>0
  begin
    set @temp=substring(@temp_ageStr,1,@minPos-1)
    set @temp_ageStr=right(@temp_ageStr,len(@temp_ageStr)-@minPos-1)
    if isnumeric(@temp)=1 
    begin
      set @re_age=isnull(@re_age,@op_date)-convert(float,@temp)/24/60
    end
  end

  return @re_age
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetNextXxNo]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetNextXxNo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pro_StaticCombItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pro_StaticCombItem]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--按组合项目统计数量、金额 
--编写时间：2005-12-09 
--编写人：刘鹰
--BUG：启用“根据组合项目编号插入组合项目名称”触发器之前，字段Combin_Name可能为空，
--故在使用此存储过程中，需调整开始日期，直到无空的组合项目名称出现。
--此开始日期之前的结果不能用此方法统计(如用，则金额是准确的，但组合项目数量不准确)
--2006/11/14:将按送检医生、按操作者组合进来
CREATE PROCEDURE [dbo].[pro_StaticCombItem] 
@in_StartDate datetime, 
@in_StopDate datetime,
@in_StaticType varchar(50)--统计类型
AS

	CREATE TABLE #temp02
	(
           d_TypeName varchar(50) null,--如送检医生、操作者...
	   d_Combin_Name varchar(50) null,--组合项目名称
	   d_Getmoney money null,--金额,
	   d_sum int null, --数量
	   d_Reserve1 varchar(50) null--保留字段1
	)
  declare @hj_getmoney float,@hj_sum int--合计金额、合计数量

if @in_StaticType='仅按组合项目'
begin	
	insert into #temp02(d_Combin_Name,d_Getmoney,d_sum)
	select Combin_Name,
	  sum(tmpView_Getmoney),
	  count(*)
	  from (
		SELECT 
                Combin_Name,
		sum(getmoney) as tmpView_Getmoney
		FROM chk_valu_bak 
		where (select top 1 CAST(CONVERT(CHAR(10),check_date,121) as datetime) from chk_con_bak where chk_con_bak.unid=chk_valu_bak.pkunid) between @in_StartDate and @in_StopDate
		and Combin_Name is not null
		and Combin_Name<>''
	        and itemvalue<>''
	        and itemvalue is not null
		GROUP BY pkunid,Combin_Name
               ) tmpView --内嵌视图tmpView:按客人分组,然后按组合项目分组的
	  group by Combin_Name
	
	select @hj_Getmoney=sum(d_Getmoney),@hj_sum=sum(d_sum) from #temp02
	insert into #temp02(d_Combin_Name,d_Getmoney,d_sum) values ('合计',@hj_Getmoney,@hj_sum)
	
	select d_Combin_Name as 组合项目名称,
	  d_Getmoney as 金额,
	  d_sum as 数量
	  from #temp02 
end else

if @in_StaticType='按送检医生'
begin
  DECLARE Cur_check_doctor Cursor For 
    select isnull(check_doctor,'') FROM Chk_Con_BAK where 
             CAST(CONVERT(CHAR(10),check_date,121) as datetime) between @in_StartDate and @in_StopDate 
	     group by isnull(check_doctor,'')

  Open Cur_check_doctor

  Declare @check_doctor varchar(50)--经过上面isnull的转换,@check_doctor不可能出现null的情况
  FETCH NEXT FROM Cur_check_doctor INTO @check_doctor
  WHILE @@FETCH_STATUS=0
  BEGIN
      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum)
	select @check_doctor,
        Combin_Name,
        sum(tmpView_Getmoney),
        count(*)
        from (
		SELECT 
		Combin_Name,
		sum(getmoney) as tmpView_Getmoney
		FROM chk_valu_bak 
		where (select top 1 CAST(CONVERT(CHAR(10),check_date,121) as datetime) from chk_con_bak where chk_con_bak.unid=chk_valu_bak.pkunid) between @in_StartDate and @in_StopDate
		and isnull((select top 1 check_doctor from chk_con_bak where chk_con_bak.unid=chk_valu_bak.pkunid),'')=@check_doctor 
		and Combin_Name is not null
		and Combin_Name<>''
	        and itemvalue<>''
	        and itemvalue is not null
		GROUP BY pkunid,Combin_Name
	     ) tmpView --内嵌视图tmpView:按客人分组,然后按组合项目分组的
        group by Combin_Name


      declare @a float,@b int
      select @a=sum(d_Getmoney),@b=sum(d_sum) from #temp02 where d_TypeName=@check_doctor
      if @a is not null and @b is not null
        INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum) values ('小计',null,@a,@b)

    FETCH NEXT FROM Cur_check_doctor INTO @check_doctor
  END
  CLOSE Cur_check_doctor
  DEALLOCATE Cur_check_doctor

	select 
        @hj_getmoney=sum(d_Getmoney),
        @hj_sum=sum(d_sum)
        from #temp02 where d_TypeName='小计'
      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum) values ('合计',null,@hj_getmoney,@hj_sum)

select d_TypeName  as 送检医生,d_Combin_Name as 组合项目名称,
  d_getmoney as 金额,
  d_sum as 数量 
  from #temp02
end else

if @in_StaticType='按操作者'
begin
  DECLARE Cur_operator Cursor For 
    select isnull(operator,'') FROM Chk_Con_BAK where 
             CAST(CONVERT(CHAR(10),check_date,121) as datetime) between @in_StartDate and @in_StopDate 
	     group by isnull(operator,'')

  Open Cur_operator

  Declare @operator varchar(50)--经过上面isnull的转换,@operator不可能出现null的情况
  FETCH NEXT FROM Cur_operator INTO @operator
  WHILE @@FETCH_STATUS=0
  BEGIN
      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum)
	select @operator,
        Combin_Name,
        sum(tmpView_Getmoney),
        count(*)
        from (
		SELECT 
		Combin_Name,
		sum(getmoney) as tmpView_Getmoney
		FROM chk_valu_bak 
		where (select top 1 CAST(CONVERT(CHAR(10),check_date,121) as datetime) from chk_con_bak where chk_con_bak.unid=chk_valu_bak.pkunid) between @in_StartDate and @in_StopDate
		and isnull((select top 1 operator from chk_con_bak where chk_con_bak.unid=chk_valu_bak.pkunid),'')=@operator 
		and Combin_Name is not null
		and Combin_Name<>''
	        and itemvalue<>''
	        and itemvalue is not null
		GROUP BY pkunid,Combin_Name
	     ) tmpView --内嵌视图tmpView:按客人分组,然后按组合项目分组的
 	 group by Combin_Name


      declare @c float,@d int
      select @c=sum(d_Getmoney),@d=sum(d_sum) from #temp02 where d_TypeName=@operator
      if @c is not null and @d is not null
        INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum) values ('小计',null,@c,@d)

    FETCH NEXT FROM Cur_operator INTO @operator
  END
  CLOSE Cur_operator
  DEALLOCATE Cur_operator

	select 
        @hj_getmoney=sum(d_Getmoney),
        @hj_sum=sum(d_sum)
        from #temp02 where d_TypeName='小计'
      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum) values ('合计',null,@hj_getmoney,@hj_sum)

select d_TypeName  as 操作者,d_Combin_Name as 组合项目名称,
  d_getmoney as 金额,
  d_sum as 数量 
  from #temp02

end else

if @in_StaticType='按送检科室'--add by liuying 20100504
begin
  DECLARE Cur_deptname Cursor For 
    select isnull(deptname,'') FROM Chk_Con_BAK where 
             CAST(CONVERT(CHAR(10),check_date,121) as datetime) between @in_StartDate and @in_StopDate 
	     group by isnull(deptname,'')

  Open Cur_deptname

  Declare @deptname varchar(50)--经过上面isnull的转换,@deptname不可能出现null的情况
  FETCH NEXT FROM Cur_deptname INTO @deptname
  WHILE @@FETCH_STATUS=0
  BEGIN
      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum)
	select @deptname,
        Combin_Name,
        sum(tmpView_Getmoney),
        count(*)
        from (
		SELECT 
		Combin_Name,
		sum(getmoney) as tmpView_Getmoney
		FROM chk_valu_bak 
		where (select top 1 CAST(CONVERT(CHAR(10),check_date,121) as datetime) from chk_con_bak where chk_con_bak.unid=chk_valu_bak.pkunid) between @in_StartDate and @in_StopDate
		and isnull((select top 1 deptname from chk_con_bak where chk_con_bak.unid=chk_valu_bak.pkunid),'')=@deptname 
		and Combin_Name is not null
		and Combin_Name<>''
	        and itemvalue<>''
	        and itemvalue is not null
		GROUP BY pkunid,Combin_Name
	     ) tmpView --内嵌视图tmpView:按送检科室分组,然后按组合项目分组的
        group by Combin_Name


      declare @e float,@f int
      select @e=sum(d_Getmoney),@f=sum(d_sum) from #temp02 where d_TypeName=@deptname
      if @e is not null and @f is not null
        INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum) values ('小计',null,@e,@f)

    FETCH NEXT FROM Cur_deptname INTO @deptname
  END
  CLOSE Cur_deptname
  DEALLOCATE Cur_deptname

	select 
        @hj_getmoney=sum(d_Getmoney),
        @hj_sum=sum(d_sum)
        from #temp02 where d_TypeName='小计'
      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum) values ('合计',null,@hj_getmoney,@hj_sum)

select d_TypeName  as 送检科室,d_Combin_Name as 组合项目名称,
  d_getmoney as 金额,
  d_sum as 数量 
  from #temp02
end else

if @in_StaticType='按送检科室+送检医生'--add by liuying 20120830
begin

      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum,d_Reserve1)
        select 
	  deptname,
          combin_name,
          sum(tmpView_Getmoney),
          count(*),
          check_doctor 
	from
	  (
	    select 
	    (select top 1 cc.deptname from chk_con_bak cc where cc.unid=cv.pkunid) as deptname,	    
	    (select top 1 cc.check_doctor from chk_con_bak cc where cc.unid=cv.pkunid) as check_doctor,
	    cv.pkunid,
	    cv.combin_name,
	    sum(cv.getmoney) as tmpView_Getmoney 
	    from chk_valu_bak cv 
	    where (select top 1 CAST(CONVERT(CHAR(10),cc.check_date,121) as datetime) from chk_con_bak cc where cc.unid=cv.pkunid) between @in_StartDate and @in_StopDate
	    and cv.Combin_Name is not null
	    and cv.Combin_Name<>''
	    and cv.itemvalue<>''
	    and cv.itemvalue is not null
	    group by cv.pkunid,cv.combin_name
	  ) tmpView
	group by deptname,check_doctor,combin_name

      select @hj_Getmoney=sum(d_Getmoney),@hj_sum=sum(d_sum) from #temp02
      INSERT INTO #temp02(d_TypeName,d_Combin_Name,d_Getmoney,d_sum,d_Reserve1) values ('合计',null,@hj_getmoney,@hj_sum,null)


select d_TypeName as 送检科室,d_Reserve1 as 送检医生,d_Combin_Name as 组合项目名称,
  d_getmoney as 金额,
  d_sum as 数量 
  from #temp02

end else

select d_TypeName  as 统计类型,d_Combin_Name as 组合项目名称,
  d_getmoney as 金额,
  d_sum as 数量 
  from #temp02

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--pro_PrintDepartWorker创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pro_PrintDepartWorker]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pro_PrintDepartWorker]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[pro_PrintDepartWorker] 
AS

CREATE TABLE #temp01
(
   Unid int IDENTITY PRIMARY KEY,
   ItemID varchar(50) null,
   ItemName varchar(50) null
)

DECLARE Cur_combinitem Cursor For 
	select Unid,ID,Name from CommCode WHERE (TypeName = '部门') order by ID

Open Cur_combinitem

Declare @Unid int,@id varchar(50),@Name varchar(50)
FETCH NEXT FROM Cur_combinitem INTO @Unid,@id,@Name
WHILE @@FETCH_STATUS=0
BEGIN
  --插入部门
  insert into #temp01 (ItemID) values ('部门:'+@id+' '+@Name)
  --插入人员
  insert into #temp01 (ItemID,ItemName)
    select ID,name from WORKER where pkdeptid=@unid

  FETCH NEXT FROM Cur_combinitem INTO @Unid,@id,@Name
END
CLOSE Cur_combinitem
DEALLOCATE Cur_combinitem

select 
   --Unid int IDENTITY PRIMARY KEY,
   ItemID 工号,
   ItemName 名称
from #temp01

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--从varchar(30)改为varchar(500),使之能容纳交叉配血、血流变诊断意见、体检结论、建议等结果值
alter table chk_valu alter column itemvalue varchar(500) null
alter table chk_valu_bak alter column itemvalue varchar(500) null
GO

--从varchar(3000)改为varchar(4000),使之能容纳ActDiff直方图数据
alter table chk_valu alter column histogram varchar(4000) null
alter table chk_valu_bak alter column histogram varchar(4000) null
GO

--2010-05-03从varchar(15)改为varchar(100),使之能容纳直方图X轴的Title
alter table chk_valu alter column Dosage1 varchar(100) null
alter table chk_valu_bak alter column Dosage1 varchar(100) null
GO

--2015-05-30从varchar(15)改为varchar(100),使之能容纳酶标仪ELX800的计算公式
alter table chk_valu alter column Dosage2 varchar(100) null
alter table chk_valu_bak alter column Dosage2 varchar(100) null
GO

--2012-03-08从varchar(30)改为varchar(50),越秀区中医医院的组合项目特长
alter table chk_valu alter column combin_Name varchar(50) null
alter table chk_valu_bak alter column combin_Name varchar(50) null
GO

--2015-06-11从varchar(15)改为varchar(50),使之能容纳HIS申请单号
alter table chk_valu_his alter column Surem1 varchar(50) null
alter table chk_valu_his_bak alter column Surem1 varchar(50) null
GO

--2015-06-11从varchar(15)改为varchar(50),使之能容纳HIS组合项目号
alter table chk_valu_his alter column Surem2 varchar(50) null
alter table chk_valu_his_bak alter column Surem2 varchar(50) null
GO

IF NOT EXISTS (select 1 from syscolumns where name='Photo' and id=object_id('chk_valu'))
  Alter table chk_valu add Photo Image null

IF NOT EXISTS (select 1 from syscolumns where name='Photo' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Photo Image null
go

--20151202增加采样时间字段
IF NOT EXISTS (select 1 from syscolumns where name='TakeSampleTime' and id=object_id('chk_valu'))
  Alter table chk_valu add TakeSampleTime datetime null

IF NOT EXISTS (select 1 from syscolumns where name='TakeSampleTime' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add TakeSampleTime datetime null
go

--20140926创建表ItemExceptionValue
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ItemExceptionValue]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
create table ItemExceptionValue
 (Unid int identity primary key,
  ItemUnid int not null,
  MatchMode int not null,--0：模糊匹配；1：左匹配；2：右匹配；3：全匹配
  ItemValue varchar(100) not null,
  HighOrLowFlag int Not Null--1：偏低；2：偏高
)
GO

--20140926创建ItemExceptionValue与clinicchkitem之间的关系
if not exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_ItemExceptionValue_clinicchkitem' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.ItemExceptionValue ADD CONSTRAINT
	FK_ItemExceptionValue_clinicchkitem FOREIGN KEY
	(
	ItemUnid
	) REFERENCES dbo.clinicchkitem
	(
	unid
	) ON UPDATE CASCADE
	 ON DELETE CASCADE
GO

--函数uf_ValueAlarm创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_ValueAlarm]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_ValueAlarm]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION dbo.uf_ValueAlarm
(
  --20140926修改程序,@ItemChnName传入的值改为项目编码ItemId
  @ItemChnName varchar(50),--项目的中文名.20070128增加,以便特殊项目的报警.如RH血型,中国的实际情况是大多数人为阳性
  @min_value varchar(50),
  @max_value varchar(50),
  @cur_value varchar(50)
)  
RETURNS int AS  
BEGIN 
  --20140926非数值结果异常值管理start
  declare @HighOrLowFlag int

  select @HighOrLowFlag=iev.HighOrLowFlag from ItemExceptionValue iev,clinicchkitem cci where iev.itemunid=cci.unid and cci.itemid=@ItemChnName and iev.MatchMode=0 and @cur_value like '%'+iev.ItemValue+'%'
  if @HighOrLowFlag in (1,2) return @HighOrLowFlag
  select @HighOrLowFlag=iev.HighOrLowFlag from ItemExceptionValue iev,clinicchkitem cci where iev.itemunid=cci.unid and cci.itemid=@ItemChnName and iev.MatchMode=1 and @cur_value like iev.ItemValue+'%'
  if @HighOrLowFlag in (1,2) return @HighOrLowFlag
  select @HighOrLowFlag=iev.HighOrLowFlag from ItemExceptionValue iev,clinicchkitem cci where iev.itemunid=cci.unid and cci.itemid=@ItemChnName and iev.MatchMode=2 and @cur_value like '%'+iev.ItemValue
  if @HighOrLowFlag in (1,2) return @HighOrLowFlag
  select @HighOrLowFlag=iev.HighOrLowFlag from ItemExceptionValue iev,clinicchkitem cci where iev.itemunid=cci.unid and cci.itemid=@ItemChnName and iev.MatchMode=3 and @cur_value = iev.ItemValue
  if @HighOrLowFlag in (1,2) return @HighOrLowFlag
  --20140926非数值结果异常值管理stop

  --20161110参考值支持“大于”、“小于”、“大于等于”、“小于等于” start
  declare @min_value_temp varchar(50),@max_value_temp varchar(50)
  
  set @min_value_temp=@min_value
  set @max_value_temp=@max_value
  
  if LEFT(@min_value,1) in ('≤','＜','<')
  begin
	set @min_value_temp='-99999999999999999999999999999999999999'
	set @max_value_temp=SUBSTRING(@min_value,2,999999999)
  end
  
  if LEFT(@min_value,1) in ('≥','＞','>')
  begin
	set @min_value_temp=SUBSTRING(@min_value,2,999999999)
	set @max_value_temp='99999999999999999999999999999999999999'
  end
  
  if LEFT(@max_value,1) in ('≤','＜','<')
  begin
	set @min_value_temp='-99999999999999999999999999999999999999'
	set @max_value_temp=SUBSTRING(@max_value,2,999999999)
  end
  
  if LEFT(@max_value,1) in ('≥','＞','>')
  begin
	set @min_value_temp=SUBSTRING(@max_value,2,999999999)
	set @max_value_temp='99999999999999999999999999999999999999'
  end    
  --20161110参考值支持“大于”、“小于”、“大于等于”、“小于等于” stop

  declare @min_value_float float,@max_value_float float,@cur_value_float float,@re_Alarm int

  if(ISNUMERIC(@min_value_temp)=0)or(ISNUMERIC(@max_value_temp)=0)or(ISNUMERIC(@cur_value)=0) return 0
  --类似ISNUMERIC('-   0')返回1,但下面的CONVERT转换报错。这样的情况也应返回0
  if CHARINDEX(' ',ltrim(rtrim(@min_value_temp)))<>0 return 0
  if CHARINDEX(' ',ltrim(rtrim(@max_value_temp)))<>0 return 0
  if CHARINDEX(' ',ltrim(rtrim(@cur_value)))<>0 return 0
  
  --ISNUMERIC('-'),ISNUMERIC('+')均返回1,但下面的CONVERT转换报错。这样的情况也应返回0
  if (ltrim(rtrim(@min_value_temp))='+')or(ltrim(rtrim(@min_value_temp))='-')or(ltrim(rtrim(@min_value_temp))='.')or(ltrim(rtrim(@min_value_temp))='+.')or(ltrim(rtrim(@min_value_temp))='-.') return 0
  if (ltrim(rtrim(@max_value_temp))='+')or(ltrim(rtrim(@max_value_temp))='-')or(ltrim(rtrim(@max_value_temp))='.')or(ltrim(rtrim(@max_value_temp))='+.')or(ltrim(rtrim(@max_value_temp))='-.') return 0
  if (ltrim(rtrim(@cur_value))='+')or(ltrim(rtrim(@cur_value))='-')or(ltrim(rtrim(@cur_value))='.')or(ltrim(rtrim(@cur_value))='+.')or(ltrim(rtrim(@cur_value))='-.') return 0

  SELECT @min_value_float=CONVERT(float, @min_value_temp)
  SELECT @max_value_float=CONVERT(float, @max_value_temp)
  SELECT @cur_value_float=CONVERT(float, @cur_value)

  set @re_Alarm=0
      if @cur_value_float<@min_value_float 
        return 1
      else if @cur_value_float>@max_value_float 
        return 2 
  return @re_Alarm
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--存储过程pro_Static创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pro_Static]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pro_Static]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--统计工作量
CREATE  PROCEDURE [dbo].[pro_Static] 
@in_StartDate varchar(50), 
@in_StopDate varchar(50),
@in_tag int
AS

CREATE TABLE #temp01
(
   d_modename varchar(50) null,
   d_itemname varchar(50) null,
   d_number int null,
   d_money money null,
   d_AnomalyRate float null--异常率 
)
if @in_tag=0 --按检验者统计
begin
  DECLARE Cur_operator Cursor For 
    select isnull(operator,'') FROM Chk_Con_BAK where 
             check_date>=@in_StartDate
             and check_date<=@in_StopDate 
	     group by  isnull(operator,'')

  Open Cur_operator

  Declare @operator varchar(50)--经过上面isnull的转换,@operator不可能出现null的情况
  FETCH NEXT FROM Cur_operator INTO @operator
  WHILE @@FETCH_STATUS=0
  BEGIN
    INSERT INTO #temp01 (d_modename,d_itemname,d_number,d_money)
          select isnull(chk_con_bak.operator,''),chk_valu_bak.name, 
             count(chk_valu_bak.itemid),sum(chk_valu_bak.getmoney) 
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate 
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	     and isnull(chk_con_bak.operator,'')=@operator
             group by isnull(chk_con_bak.operator,''),chk_valu_bak.name

    --插入该检验者的小计
    Declare @XJ_operator_NUM INT,@XJ_operator_number INT,@XJ_operator_money MONEY
	select @XJ_operator_NUM=COUNT(*),@XJ_operator_number=sum(d_number),@XJ_operator_money=sum(d_money) from #temp01 
        where d_modename=@operator
    IF @XJ_operator_NUM<>0
      INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('小计',@XJ_operator_number,@XJ_operator_money)
    ------------------

    FETCH NEXT FROM Cur_operator INTO @operator
  END
  CLOSE Cur_operator
  DEALLOCATE Cur_operator

  --插入合计
    Declare @HJ_operator_number INT,@HJ_operator_money MONEY
	select @HJ_operator_number=sum(d_number),@HJ_operator_money=sum(d_money) from #temp01 
        where d_modename='小计'
    INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('合计',@HJ_operator_number,@HJ_operator_money)
  ---------

  select d_modename as 检验者,
       d_itemname AS 项目名称,
       d_number AS 数量,
       d_money as 金额
       from #temp01 
end

if @in_tag=1 --按送检科室统计
begin
  DECLARE Cur_deptname Cursor For 
    select isnull(deptname,'') FROM Chk_Con_BAK where 
             check_date>=@in_StartDate
             and check_date<=@in_StopDate 
	     group by  isnull(deptname,'')

  Open Cur_deptname

  Declare @deptname varchar(50)--经过上面isnull的转换,@deptname不可能出现null的情况
  FETCH NEXT FROM Cur_deptname INTO @deptname
  WHILE @@FETCH_STATUS=0
  BEGIN
    INSERT INTO #temp01 (d_modename,d_itemname,d_number,d_money)
          select isnull(chk_con_bak.deptname,''),chk_valu_bak.name, 
             count(chk_valu_bak.itemid),sum(chk_valu_bak.getmoney) 
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate 
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	     and isnull(chk_con_bak.deptname,'')=@deptname
             group by isnull(chk_con_bak.deptname,''),chk_valu_bak.name

    --插入该送检科室的小计
    Declare @XJ_deptname_NUM INT,@XJ_deptname_number INT,@XJ_deptname_money MONEY
	select @XJ_deptname_NUM=COUNT(*),@XJ_deptname_number=sum(d_number),@XJ_deptname_money=sum(d_money) from #temp01 
        where d_modename=@deptname
    IF @XJ_deptname_NUM<>0
      INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('小计',@XJ_deptname_number,@XJ_deptname_money)
    ------------------

    FETCH NEXT FROM Cur_deptname INTO @deptname
  END
  CLOSE Cur_deptname
  DEALLOCATE Cur_deptname

  --插入合计
    Declare @HJ_deptname_number INT,@HJ_deptname_money MONEY
	select @HJ_deptname_number=sum(d_number),@HJ_deptname_money=sum(d_money) from #temp01 
        where d_modename='小计'    
    INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('合计',@HJ_deptname_number,@HJ_deptname_money)
  ---------


  select d_modename as 送检科室,
       d_itemname AS 项目名称,
       d_number AS 数量,
       d_money as 金额
       from #temp01 
end

if @in_tag=2 --按检验项目统计
begin
    INSERT INTO #temp01 (d_itemname,d_number,d_money)
          select chk_valu_bak.name, 
             count(chk_valu_bak.itemid),sum(chk_valu_bak.getmoney) 
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate 
             and chk_valu_bak.itemid in(select itemid from static_temp) 
             group by chk_valu_bak.name

  --插入合计
    Declare @HJ_item_number INT,@HJ_item_money MONEY
	select @HJ_item_number=sum(d_number),@HJ_item_money=sum(d_money) from #temp01 
    INSERT INTO #temp01 (d_itemname,d_number,d_money)VALUES('合计',@HJ_item_number,@HJ_item_money)
  ---------

  --插入异常率
  DECLARE Cur_itemname_2 Cursor For 
    select 
       d_itemname ,
       d_number 
       from #temp01 where d_itemname<>'合计' and d_itemname<>'小计'

  Open Cur_itemname_2
  Declare @itemname_2 varchar(50),@itemCount_2 float
  FETCH NEXT FROM Cur_itemname_2 INTO @itemname_2,@itemCount_2
  WHILE @@FETCH_STATUS=0
  BEGIN
	declare @AnomalyRate_2 float
          select @AnomalyRate_2=count(*)/@itemCount_2
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	and chk_valu_bak.name=@itemname_2 
 	and dbo.uf_ValueAlarm(Name,Min_value,Max_value,itemvalue)<>0
    update #temp01 set d_AnomalyRate=@AnomalyRate_2 where d_itemname=@itemname_2

    FETCH NEXT FROM Cur_itemname_2 INTO @itemname_2,@itemCount_2
  END
  CLOSE Cur_itemname_2
  DEALLOCATE Cur_itemname_2
  ------------------

  select 
       d_itemname AS 项目名称,
       d_number AS 数量,
       d_money as 金额,
       rtrim(ltrim(str(d_AnomalyRate*100)))+'%' as 异常率
       from #temp01 
end

if @in_tag=3 --按送检医生统计
begin
  DECLARE Cur_check_doctor Cursor For 
    select isnull(check_doctor,'') FROM Chk_Con_BAK where 
             check_date>=@in_StartDate
             and check_date<=@in_StopDate 
	     group by  isnull(check_doctor,'')

  Open Cur_check_doctor

  Declare @check_doctor varchar(50)--经过上面isnull的转换,@check_doctor不可能出现null的情况
  FETCH NEXT FROM Cur_check_doctor INTO @check_doctor
  WHILE @@FETCH_STATUS=0
  BEGIN
    INSERT INTO #temp01 (d_modename,d_itemname,d_number,d_money)
          select isnull(chk_con_bak.check_doctor,''),chk_valu_bak.name, 
             count(chk_valu_bak.itemid),sum(chk_valu_bak.getmoney) 
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate 
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	     and isnull(chk_con_bak.check_doctor,'')=@check_doctor
             group by isnull(chk_con_bak.check_doctor,''),chk_valu_bak.name

    --插入该送检医生的小计
    Declare @XJ_check_doctor_NUM INT,@XJ_check_doctor_number INT,@XJ_check_doctor_money MONEY
	select @XJ_check_doctor_NUM=COUNT(*),@XJ_check_doctor_number=sum(d_number),@XJ_check_doctor_money=sum(d_money) from #temp01 
        where d_modename=@check_doctor
    IF @XJ_check_doctor_NUM<>0
      INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('小计',@XJ_check_doctor_number,@XJ_check_doctor_money)
    ------------------

    FETCH NEXT FROM Cur_check_doctor INTO @check_doctor
  END
  CLOSE Cur_check_doctor
  DEALLOCATE Cur_check_doctor

  --插入合计
    Declare @HJ_check_doctor_number INT,@HJ_check_doctor_money MONEY
	select @HJ_check_doctor_number=sum(d_number),@HJ_check_doctor_money=sum(d_money) from #temp01 
        where d_modename='小计'
    INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('合计',@HJ_check_doctor_number,@HJ_check_doctor_money)
  ---------


  select d_modename as 送检医生,
       d_itemname AS 项目名称,
       d_number AS 数量,
       d_money as 金额
       from #temp01 
end

if @in_tag=4 --按报告日期统计
begin
  DECLARE Cur_report_date Cursor For 
    select convert(varchar(10),report_date,111) FROM Chk_Con_BAK where 
             check_date>=@in_StartDate
             and check_date<=@in_StopDate 
	     group by  convert(varchar(10),report_date,111)  Open Cur_report_date

  Declare @report_date varchar(50)
  FETCH NEXT FROM Cur_report_date INTO @report_date
  WHILE @@FETCH_STATUS=0
  BEGIN
    INSERT INTO #temp01 (d_modename,d_itemname,d_number,d_money)
          select convert(varchar(10),chk_con_bak.report_date,111),chk_valu_bak.name, 
             count(chk_valu_bak.itemid),sum(chk_valu_bak.getmoney) 
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate 
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	     and convert(varchar(10),chk_con_bak.report_date,111)=@report_date
             group by chk_con_bak.report_date,chk_valu_bak.name

    --插入该报告日期的小计
    Declare @XJ_report_date_NUM INT,@XJ_report_date_number INT,@XJ_report_date_money MONEY
	select @XJ_report_date_NUM=COUNT(*),@XJ_report_date_number=sum(d_number),@XJ_report_date_money=sum(d_money) from #temp01 
        where d_modename=@report_date
    IF @XJ_report_date_NUM<>0
      INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('小计',@XJ_report_date_number,@XJ_report_date_money)
    ------------------

    FETCH NEXT FROM Cur_report_date INTO @report_date
  END
  CLOSE Cur_report_date
  DEALLOCATE Cur_report_date

  --插入合计
    Declare @HJ_report_date_number INT,@HJ_report_date_money MONEY
	select @HJ_report_date_number=sum(d_number),@HJ_report_date_money=sum(d_money) from #temp01 
        where d_modename='小计'
    INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('合计',@HJ_report_date_number,@HJ_report_date_money)
  ---------


  select d_modename as 报告日期,
       d_itemname AS 项目名称,
       d_number AS 数量,
       d_money as 金额
       from #temp01 
end

if @in_tag=5 --按病人所属部门统计
begin
  DECLARE Cur_WorkDepartment Cursor For 
    select isnull(WorkDepartment,'') FROM Chk_Con_BAK where 
             check_date>=@in_StartDate
             and check_date<=@in_StopDate 
	     group by  isnull(WorkDepartment,'')

  Open Cur_WorkDepartment

  Declare @WorkDepartment varchar(50)--经过上面isnull的转换,@WorkDepartment不可能出现null的情况
  FETCH NEXT FROM Cur_WorkDepartment INTO @WorkDepartment
  WHILE @@FETCH_STATUS=0
  BEGIN
    INSERT INTO #temp01 (d_modename,d_itemname,d_number,d_money)
          select isnull(chk_con_bak.WorkDepartment,''),chk_valu_bak.name, 
             count(chk_valu_bak.itemid),sum(chk_valu_bak.getmoney) 
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate 
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	     and isnull(chk_con_bak.WorkDepartment,'')=@WorkDepartment
             group by isnull(chk_con_bak.WorkDepartment,''),chk_valu_bak.name

    --插入该检验者的小计
    Declare @XJ_WorkDepartment_NUM INT,@XJ_WorkDepartment_number INT,@XJ_WorkDepartment_money MONEY
	select @XJ_WorkDepartment_NUM=COUNT(*),@XJ_WorkDepartment_number=sum(d_number),@XJ_WorkDepartment_money=sum(d_money) from #temp01 
        where d_modename=@WorkDepartment
    IF @XJ_WorkDepartment_NUM<>0
      INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('小计',@XJ_WorkDepartment_number,@XJ_WorkDepartment_money)
    ------------------

    FETCH NEXT FROM Cur_WorkDepartment INTO @WorkDepartment
  END
  CLOSE Cur_WorkDepartment
  DEALLOCATE Cur_WorkDepartment

  --插入合计
    Declare @HJ_WorkDepartment_number INT,@HJ_WorkDepartment_money MONEY
	select @HJ_WorkDepartment_number=sum(d_number),@HJ_WorkDepartment_money=sum(d_money) from #temp01 
        where d_modename='小计'
    INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('合计',@HJ_WorkDepartment_number,@HJ_WorkDepartment_money)
  ---------

  --插入异常率
  DECLARE Cur_itemname_5 Cursor For 
    select d_modename ,
       d_itemname ,
       d_number 
       from #temp01 where d_modename<>'合计' and d_modename<>'小计'

  Open Cur_itemname_5
  Declare @modename_5 varchar(50),@itemname_5 varchar(50),@itemCount_5 float
  FETCH NEXT FROM Cur_itemname_5 INTO @modename_5,@itemname_5,@itemCount_5
  WHILE @@FETCH_STATUS=0
  BEGIN
	declare @AnomalyRate_5 float
          select @AnomalyRate_5=count(*)/@itemCount_5
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate
             and chk_valu_bak.itemid in(select itemid from static_temp)  
	and isnull(chk_con_bak.WorkDepartment,'')=@modename_5 
	and chk_valu_bak.name=@itemname_5 
 	and dbo.uf_ValueAlarm(Name,Min_value,Max_value,itemvalue)<>0
    update #temp01 set d_AnomalyRate=@AnomalyRate_5 where d_itemname=@itemname_5 and d_modename=@modename_5

    FETCH NEXT FROM Cur_itemname_5 INTO @modename_5,@itemname_5,@itemCount_5
  END
  CLOSE Cur_itemname_5
  DEALLOCATE Cur_itemname_5
  ------------------

  select d_modename as 所属部门,
       d_itemname AS 项目名称,
       d_number AS 数量,
       d_money as 金额,
       rtrim(ltrim(str(d_AnomalyRate*100)))+'%' as 异常率
       from #temp01 
end

if @in_tag=6 --按病人所属工种统计
begin
  DECLARE Cur_WorkCategory Cursor For 
    select isnull(WorkCategory,'') FROM Chk_Con_BAK where 
             check_date>=@in_StartDate
             and check_date<=@in_StopDate 
	     group by  isnull(WorkCategory,'')

  Open Cur_WorkCategory

  Declare @WorkCategory varchar(50)--经过上面isnull的转换,@WorkCategory不可能出现null的情况
  FETCH NEXT FROM Cur_WorkCategory INTO @WorkCategory
  WHILE @@FETCH_STATUS=0
  BEGIN
    INSERT INTO #temp01 (d_modename,d_itemname,d_number,d_money)
          select isnull(chk_con_bak.WorkCategory,''),chk_valu_bak.name, 
             count(chk_valu_bak.itemid),sum(chk_valu_bak.getmoney) 
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate 
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	     and isnull(chk_con_bak.WorkCategory,'')=@WorkCategory
             group by isnull(chk_con_bak.WorkCategory,''),chk_valu_bak.name
    --插入该检验者的小计
    Declare @XJ_WorkCategory_NUM INT,@XJ_WorkCategory_number INT,@XJ_WorkCategory_money MONEY
	select @XJ_WorkCategory_NUM=COUNT(*),@XJ_WorkCategory_number=sum(d_number),@XJ_WorkCategory_money=sum(d_money) from #temp01 
        where d_modename=@WorkCategory
    IF @XJ_WorkCategory_NUM<>0
      INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('小计',@XJ_WorkCategory_number,@XJ_WorkCategory_money)
    ------------------

    FETCH NEXT FROM Cur_WorkCategory INTO @WorkCategory
  END
  CLOSE Cur_WorkCategory
  DEALLOCATE Cur_WorkCategory

  --插入合计
    Declare @HJ_WorkCategory_number INT,@HJ_WorkCategory_money MONEY
	select @HJ_WorkCategory_number=sum(d_number),@HJ_WorkCategory_money=sum(d_money) from #temp01 
        where d_modename='小计'
    INSERT INTO #temp01 (d_modename,d_number,d_money)VALUES('合计',@HJ_WorkCategory_number,@HJ_WorkCategory_money)
  ---------

  --插入异常率
  DECLARE Cur_itemname_6 Cursor For 
    select d_modename ,
       d_itemname ,
       d_number 
       from #temp01 where d_modename<>'合计' and d_modename<>'小计'

  Open Cur_itemname_6
  Declare @modename_6 varchar(50),@itemname_6 varchar(50),@itemCount_6 float
  FETCH NEXT FROM Cur_itemname_6 INTO @modename_6,@itemname_6,@itemCount_6
  WHILE @@FETCH_STATUS=0
  BEGIN
	declare @AnomalyRate_6 float
          select @AnomalyRate_6=count(*)/@itemCount_6
             from chk_con_bak,chk_valu_bak 
             where chk_con_bak.unid=chk_valu_bak.pkunid 
             and chk_valu_bak.itemvalue<>''
             and chk_valu_bak.itemvalue is not null
             and chk_con_bak.check_date>=@in_StartDate
             and chk_con_bak.check_date<=@in_StopDate
             and chk_valu_bak.itemid in(select itemid from static_temp) 
	and isnull(chk_con_bak.WorkCategory,'')=@modename_6 
	and chk_valu_bak.name=@itemname_6 
 	and dbo.uf_ValueAlarm(Name,Min_value,Max_value,itemvalue)<>0
    update #temp01 set d_AnomalyRate=@AnomalyRate_6 where d_itemname=@itemname_6 and d_modename=@modename_6

    FETCH NEXT FROM Cur_itemname_6 INTO @modename_6,@itemname_6,@itemCount_6
  END
  CLOSE Cur_itemname_6
  DEALLOCATE Cur_itemname_6
  ------------------

  select d_modename as 所属工种,
       d_itemname AS 项目名称,
       d_number AS 数量,
       d_money as 金额,
       rtrim(ltrim(str(d_AnomalyRate*100)))+'%' as 异常率
       from #temp01 
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--修改表referencevalue
IF NOT EXISTS (select 1 from syscolumns where name='flagetype' and id=object_id('referencevalue'))
begin
  Alter table referencevalue add flagetype varchar(50) null--样本类型
end
go


--修改表clinicchkitem
IF NOT EXISTS (select 1 from syscolumns where name='CFXS' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add CFXS varchar(10) null--乘法系数
end

IF NOT EXISTS (select 1 from syscolumns where name='JFXS' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add JFXS varchar(10) null--加法系数
end
go

--视图view_chk_valu_All的创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[view_chk_valu_All]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[view_chk_valu_All]
GO

--Asp网络查询及打印每日存根要用到
--2007-03-21
CREATE VIEW view_chk_valu_All
  AS
  SELECT *
  FROM chk_valu
  UNION ALL
  SELECT *
  FROM chk_valu_bak

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[view_HBV_Value]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[view_HBV_Value]
GO

--视图view_HBV_Value的创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create VIEW view_HBV_Value
  AS

SELECT  pkunid,
        (CASE english_name WHEN 'HBsAg' THEN itemvalue ELSE '' END) AS HBsAg,  
        (CASE english_name WHEN 'HBsAb' THEN itemvalue ELSE '' END) AS HBsAb,  
        (CASE english_name when 'HBeAg' THEN itemvalue ELSE '' END) AS HBeAg,
        (CASE english_name when 'HBeAb' THEN itemvalue ELSE '' END) AS HBeAb,
        (CASE english_name WHEN 'HBcAb' THEN itemvalue ELSE '' END) AS HBcAb
FROM dbo.view_chk_valu_All where issure='1' and isnull(itemvalue,'')<>''
	and (english_name='HBsAg' or english_name='HBsAb' or english_name='HBeAg' or english_name='HBeAb' or english_name='HBcAb')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

ALTER TABLE clinicchkitem ALTER COLUMN PYM varchar(15)
ALTER TABLE clinicchkitem ALTER COLUMN WBM varchar(15)
go

alter table chk_con alter column TjJiWangShi varchar(300) null
alter table chk_con_bak alter column TjJiWangShi varchar(300) null
alter table chk_con alter column TjJiaZuShi varchar(300) null
alter table chk_con_bak alter column TjJiaZuShi varchar(300) null
alter table chk_con alter column TjNeiKe varchar(300) null
alter table chk_con_bak alter column TjNeiKe varchar(300) null
alter table chk_con alter column TjWaiKe varchar(300) null
alter table chk_con_bak alter column TjWaiKe varchar(300) null
alter table chk_con alter column TjWuGuanKe varchar(300) null
alter table chk_con_bak alter column TjWuGuanKe varchar(300) null
alter table chk_con alter column TjFuKe varchar(300) null
alter table chk_con_bak alter column TjFuKe varchar(300) null
alter table chk_con alter column TjLengQiangGuang varchar(300) null
alter table chk_con_bak alter column TjLengQiangGuang varchar(300) null
alter table chk_con alter column TjXGuang varchar(300) null
alter table chk_con_bak alter column TjXGuang varchar(300) null
alter table chk_con alter column TjBChao varchar(300) null
alter table chk_con_bak alter column TjBChao varchar(300) null
alter table chk_con alter column TjXinDianTu varchar(300) null
alter table chk_con_bak alter column TjXinDianTu varchar(300) null
alter table chk_con alter column TJAdvice varchar(300) null
alter table chk_con_bak alter column TJAdvice varchar(300) null
GO

--修改表chk_con
IF NOT EXISTS (select 1 from syscolumns where name='TjJianYan' and id=object_id('chk_con'))
begin
  Alter table chk_con add TjJianYan varchar(300) null--检验
end

--修改表chk_con_bak
IF NOT EXISTS (select 1 from syscolumns where name='TjJianYan' and id=object_id('chk_con_bak'))
begin
  Alter table chk_con_bak add TjJianYan varchar(300) null--检验
end
go


--触发器TRIGGER_chk_con_CKZ_Update创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_CKZ_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_con_CKZ_Update
go

CREATE TRIGGER TRIGGER_chk_con_CKZ_Update ON chk_con
FOR UPDATE
AS
--修改参考值
  declare @unid int,@age varchar(50),@sex varchar(50),@ageReal float,@age_old varchar(50),@sex_old varchar(50),@flagetype varchar(50),@flagetype_old varchar(50)
  SELECT @unid=unid,@age=age,@sex=sex,@flagetype=flagetype FROM Inserted
  SELECT @age_old=age,@sex_old=sex,@flagetype_old=flagetype FROM deleted
  if (@unid is null) return --表示没找到刚刚update的记录
  if (isnull(@age_old,'')<>isnull(@age,''))or(isnull(@sex_old,'')<>isnull(@sex,''))or(isnull(@flagetype_old,'')<>isnull(@flagetype,''))--表示修改过年龄或性别字段
  begin
	  set @ageReal=dbo.uf_GetAgeReal(@age)
	  if (@ageReal=0) set @ageReal=18*365*24*60 --没年龄时按18岁来找参考值
	  --if (@sex='')or(@sex is null) set @sex='男'--20130707注释
	
	  DECLARE cur_chk_valu CURSOR FOR 
	    select valueid,itemid from chk_valu where pkunid=@unid
	
	    DECLARE @valueid int,@itemid varchar(50)
	
	  OPEN cur_chk_valu 
	  FETCH NEXT FROM cur_chk_valu INTO  @valueid,@itemid
	
	  WHILE @@FETCH_STATUS = 0 --逐个项目进行循环
	  BEGIN
	    declare @minvalue varchar(250),@maxvalue varchar(250)--20081211,市政要求的细菌参考值很长,故50->250
	    set @minvalue=null
	    set @maxvalue=null
	    select @minvalue=minvalue,@maxvalue=maxvalue from referencevalue where id=@itemid and age_low<=@ageReal and age_high>=@ageReal and (sex=@sex or sex='男/女' or isnull(sex,'')='' or isnull(@sex,'')='')and (flagetype=@flagetype or isnull(flagetype,'')='' or isnull(@flagetype,'')='')--20130707修改性别条件
	    if ((@minvalue is not null) and (@minvalue<>'')) or ((@maxvalue is not null) and (@maxvalue<>''))--20080917,解决问题:导入Excel数据后,重新保存病人信息时清空已有的参考值
	      update chk_valu set min_value=@minvalue,max_value=@maxvalue where valueid=@valueid
	
	    FETCH NEXT FROM cur_chk_valu INTO  @valueid,@itemid
	  END
	
	  CLOSE cur_chk_valu  
	  DEALLOCATE cur_chk_valu
  end  

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--触发器TRIGGER_chk_valu_CKZ_insert创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_CKZ_insert' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_CKZ_insert
go

CREATE TRIGGER TRIGGER_chk_valu_CKZ_insert ON chk_valu
FOR INSERT
AS
--插入参考值
  declare @valueid int,@pkunid int,@itemid varchar(50)
  SELECT @valueid=valueid,@pkunid=pkunid,@itemid=itemid FROM Inserted
  if (@valueid is null) return --表示没找到刚刚插入的记录
  if (@pkunid is null) return  --表示没找到刚刚插入记录相对应的主记录
  declare @patientname varchar(50),@age varchar(50),@sex varchar(50),@report_date datetime,@ageReal float,@flagetype varchar(50)
  select @patientname=patientname,@age=age,@sex=sex,@report_date=report_date,@flagetype=flagetype from chk_con where unid=@pkunid
  set @ageReal=dbo.uf_GetAgeReal(@age)
  if (@ageReal=0) set @ageReal=18*365*24*60 --没年龄时按18岁来找参考值
  --if (@sex='')or(@sex is null) set @sex='男'--20130707注释

  declare @minvalue varchar(250),@maxvalue varchar(250)--20081211,市政要求的细菌参考值很长,故50->250
  select @minvalue=minvalue,@maxvalue=maxvalue from referencevalue where id=@itemid and age_low<=@ageReal and age_high>=@ageReal and (sex=@sex or sex='男/女' or isnull(sex,'')='' or isnull(@sex,'')='') and (flagetype=@flagetype or isnull(flagetype,'')='' or isnull(@flagetype,'')='')--20130707修改性别条件
  if ((@minvalue is not null) and (@minvalue<>'')) or ((@maxvalue is not null) and (@maxvalue<>''))
    update chk_valu set min_value=@minvalue,max_value=@maxvalue where valueid=@valueid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


IF NOT EXISTS (select 1 from syscolumns where name='IsEdited' and id=object_id('chk_valu'))
  Alter table chk_valu add IsEdited int null

IF NOT EXISTS (select 1 from syscolumns where name='IsEdited' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add IsEdited int null
GO

--触发器TRIGGER_chk_valu_IsEdited_Update创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_IsEdited_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_IsEdited_Update
go

CREATE TRIGGER TRIGGER_chk_valu_IsEdited_Update ON [dbo].[chk_valu] 
FOR UPDATE
AS

--插入 “结果是否修改”的标志
  declare @valueid int,@itemvalue varchar(50),@itemvalue_Old varchar(50)
  SELECT @valueid=valueid,@itemvalue=itemvalue FROM Inserted
  SELECT @itemvalue_Old=itemvalue FROM deleted
  if (@valueid is null) return --表示没找到刚刚插入的记录

  if (@itemvalue_Old<>@itemvalue)and(@itemvalue_Old<>'')
     update chk_valu set IsEdited=1 where valueid=@valueid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_chk_con_FastKey创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_FastKey' and type='TR')
  drop TRIGGER TRIGGER_chk_con_FastKey
go

CREATE TRIGGER TRIGGER_chk_con_FastKey ON chk_valu
FOR UPDATE,Insert
AS
--2011-01-10翻译结果值
  declare @valueid int,@itemvalue varchar(100),@itemvalue_Old varchar(100),@name varchar(200)
  SELECT @valueid=valueid,@itemvalue=itemvalue FROM Inserted

  if (@valueid is null) return --表示没找到刚刚update或insert的记录

  set @itemvalue_Old=null
  If Exists(Select 0 From Deleted)--表示UPDATE触发
  Begin
    SELECT @itemvalue_Old=itemvalue FROM Deleted
  End

  if isnull(@itemvalue,'')='' return
  if isnull(@itemvalue_Old,'')=isnull(@itemvalue,'') return--表示结果值没变

  select @name=name from CommCode where typename='结果快捷码' and rtrim(ltrim(upper(id)))=rtrim(ltrim(upper(@itemvalue)))
  if isnull(@name,'')<>'' 
  begin
    update chk_valu set itemvalue=@name where valueid=@valueid
  end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/*前台已有完善的审核机制,且自己审核过的再修改就不用取消审核了,故注释这两个触发器
--因为查询分析器的块注释不能用GO开头，故注释掉GO,如需启用，需取消GO前的注释符
--触发器TRIGGER_chk_con_CancelAudit_Update创建脚本
SET QUOTED_IDENTIFIER ON 
--GO
SET ANSI_NULLS ON 
--GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_CancelAudit_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_con_CancelAudit_Update
--go

CREATE TRIGGER TRIGGER_chk_con_CancelAudit_Update ON chk_con
FOR UPDATE
AS
--取消审核
  declare @unid int,@report_doctor_old varchar(50),@report_doctor varchar(50),@printtimes_old int,@printtimes int
  SELECT @unid=unid,@report_doctor=report_doctor,@printtimes=printtimes FROM Inserted
  SELECT @report_doctor_old=report_doctor,@printtimes_old=printtimes FROM deleted
  if (@unid is null) return --表示没找到刚刚update的记录
  if isnull(@report_doctor_old,'a')<>isnull(@report_doctor,'b') return--表示修改的是审核者字段
  if isnull(@printtimes_old,1)<>isnull(@printtimes,2) return--表示修改的是打印次数字段
  if isnull(@report_doctor,'')='' return
  update chk_con set report_doctor='' where unid=@unid

--GO
SET QUOTED_IDENTIFIER OFF 
--GO
SET ANSI_NULLS ON 
--GO


--触发器TRIGGER_chk_valu_CancelAudit_Update创建脚本
SET QUOTED_IDENTIFIER ON 
--GO
SET ANSI_NULLS ON 
--GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_CancelAudit_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_CancelAudit_Update
--go

CREATE TRIGGER TRIGGER_chk_valu_CancelAudit_Update ON chk_valu
FOR UPDATE
AS
--取消审核
  declare @pkunid int,@report_doctor varchar(50),@itemvalue varchar(100),@itemvalue_Old varchar(100)
  SELECT @pkunid=pkunid,@itemvalue=itemvalue FROM Inserted
  if (@pkunid is null) return --表示没找到刚刚update的记录
  SELECT @itemvalue_Old=itemvalue FROM deleted
  select @report_doctor=report_doctor from chk_con where unid=@pkunid

  if isnull(@itemvalue_Old,'')=isnull(@itemvalue,'') return
  if isnull(@report_doctor,'')='' return
  update chk_con set report_doctor='' where unid=@pkunid

--GO
SET QUOTED_IDENTIFIER OFF 
--GO
SET ANSI_NULLS ON 
--GO
*/


--触发器TRIGGER_chk_con_CommCode创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_CommCode' and type='TR')
  drop TRIGGER TRIGGER_chk_con_CommCode
go

CREATE TRIGGER TRIGGER_chk_con_CommCode ON chk_con
FOR UPDATE,Insert
AS
--将不存在的通用代码插入通用代码表
  declare @IDENTITY int,@unid int,@deptname  varchar(50),@check_doctor varchar(50),@flagetype varchar(50),@typeflagcase varchar(50),@diagnose varchar(50),@GermName varchar(50),@issure varchar(50),@combin_id varchar(50)
  SELECT @unid=unid,@deptname=deptname,@check_doctor=check_doctor,@flagetype=flagetype,@typeflagcase=typeflagcase,@diagnose=diagnose,@GermName=GermName,@issure=issure,@combin_id=combin_id FROM Inserted
  if (@unid is null) return --表示没找到刚刚update的记录
  select @IDENTITY=Unid from commcode where name=@deptname and typename='部门'
  if (@IDENTITY is null)and(isnull(@deptname,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('部门',@deptname,@deptname)
    SELECT @IDENTITY=@@IDENTITY 
  end
  if (@IDENTITY is null) select @IDENTITY=Unid from commcode where typename='部门'--如果实在没有部门,随便给医生找个部门吧
  if (not exists(select 1 from worker where name=@check_doctor))and(isnull(@check_doctor,'')<>'')and(@IDENTITY is not null)
  begin
    insert into worker (pkdeptid,id,name,pinyin) values (@IDENTITY,@check_doctor,@check_doctor,dbo.uf_getpy(@check_doctor))
  end
  if (not exists(select 1 from commcode where name=@flagetype and typename='样本类型'))and(isnull(@flagetype,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('样本类型',@flagetype,@flagetype)
  end
  if (not exists(select 1 from commcode where name=@typeflagcase and typename='样本状态'))and(isnull(@typeflagcase,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('样本状态',@typeflagcase,@typeflagcase)
  end
  if (not exists(select 1 from commcode where name=@diagnose and typename='临床诊断'))and(isnull(@diagnose,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('临床诊断',@diagnose,@diagnose)
  end
  if (not exists(select 1 from commcode where name=@GermName and typename='细菌'))and(isnull(@GermName,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('细菌',@GermName,@GermName)
  end
  if (not exists(select 1 from commcode where name=@issure and typename='备注'))and(isnull(@issure,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('备注',@issure,@issure)
  end
  --2011-01-10为支持His站样本类型的默认工作组别
  if (not exists(select 1 from commcode where name=@combin_id and typename='检验组别'))and(isnull(@combin_id,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('检验组别',@combin_id,@combin_id)
  end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_chk_con_His_Unid创建脚本20101204
--if exists (select name from sysobjects where name='TRIGGER_chk_con_His_Unid' and type='TR')
--  drop TRIGGER TRIGGER_chk_con_His_Unid
--go

--CREATE TRIGGER TRIGGER_chk_con_His_Unid ON chk_con
--FOR UPDATE,Insert
--AS
--His_Unid不允许重复
--  declare @His_unid varchar(50),@His_Unid_Num int
--  SELECT @His_unid=His_unid FROM Inserted
--  if (@His_unid is null)or(@His_unid='') return
--  select @His_Unid_Num=count(*) from chk_con where His_Unid=@His_unid
--  if (@His_Unid_Num>1)
--  begin
--    raiserror ('His_Unid不能重复!',16,1)
--    ROLLBACK TRANSACTION
--  end

--GO

--20160802视图view_Chk_Con_All创建脚本
IF EXISTS (SELECT * FROM dbo.sysobjects where id = OBJECT_ID(N'[dbo].[view_Chk_Con_All]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[view_Chk_Con_All]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE  VIEW [dbo].[view_Chk_Con_All]
  AS
  SELECT chk_con.*,0 as ifCompleted
  FROM chk_con
  UNION ALL
  SELECT chk_con_bak.*,1 as ifCompleted
  FROM chk_con_bak
  
GO

--存储过程pro_StaticHBV创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pro_StaticHBV]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pro_StaticHBV]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create PROCEDURE [dbo].[pro_StaticHBV] 
@in_StartDate datetime, 
@in_StopDate datetime,
@in_HBsAg varchar(50),
@in_HBsAb varchar(50),
@in_HBeAg varchar(50),
@in_HBeAb varchar(50),
@in_HBcAb varchar(50)
AS

CREATE TABLE #temp01
(
t_pkunid int null,
t_HBsAg varchar(50) null,
t_HBsAb varchar(50) null,
t_HBeAg varchar(50) null,
t_HBeAb varchar(50) null,
t_HBcAb varchar(50) null
)

  DECLARE Cur_operator Cursor For 
    select pkunid,HBsAg ,HBsAb, HBeAg ,HBeAb, HBcAb FROM view_HBV_Value,view_Chk_Con_All where 
	(view_HBV_Value.pkunid=view_Chk_Con_All.unid) 
	and (check_date between @in_StartDate and @in_StopDate)

  Open Cur_operator

  Declare @pkunid int,@HBsAg varchar(50),@HBsAb varchar(50),@HBeAg varchar(50),@HBeAb varchar(50),@HBcAb varchar(50)

  FETCH NEXT FROM Cur_operator INTO @pkunid,@HBsAg ,@HBsAb ,@HBeAg ,@HBeAb ,@HBcAb
  WHILE @@FETCH_STATUS=0
  BEGIN
    if EXISTS (select 1 from #temp01 where t_pkunid=@pkunid)
    begin
      update #temp01 set t_HBsAg=t_HBsAg+@HBsAg ,t_HBsAb=t_HBsAb+@HBsAb, t_HBeAg=t_HBeAg+@HBeAg ,t_HBeAb=t_HBeAb+@HBeAb, t_HBcAb=t_HBcAb+@HBcAb where t_pkunid=@pkunid
    end else insert into #temp01 values (@pkunid,@HBsAg ,@HBsAb ,@HBeAg ,@HBeAb ,@HBcAb)

    FETCH NEXT FROM Cur_operator INTO @pkunid,@HBsAg ,@HBsAb ,@HBeAg ,@HBeAb ,@HBcAb
  END
  CLOSE Cur_operator
  DEALLOCATE Cur_operator
  
  declare @RecordNum int 
  select @RecordNum=count(*)
	 from #temp01 B,dbo.view_Chk_Con_All A 
	where t_pkunid=A.unid
	and t_HBsAg like  '%'+@in_HBsAg+'%'
	and t_HBsAb like  '%'+@in_HBsAb+'%'
	and t_HBeAg like  '%'+@in_HBeAg+'%'
	and t_HBeAb like  '%'+@in_HBeAb+'%'
	and t_HBcAb like  '%'+@in_HBcAb+'%'

  select lsh as 流水号,checkid as 联机号,caseno as 病历号,
         patientname as 姓名,sex as 性别,age as 年龄,
         B.t_HBsAg,B.t_HBsAb,B.t_HBeAg,B.t_HBeAb,B.t_HBcAb,
         bedno as 床号,deptname as 送检科室,check_doctor as 送检医生,
         check_date as 检查日期,issure as 备注
	 from #temp01 B,dbo.view_Chk_Con_All A 
	where t_pkunid=A.unid
	and t_HBsAg like  '%'+@in_HBsAg+'%'
	and t_HBsAb like  '%'+@in_HBsAb+'%'
	and t_HBeAg like  '%'+@in_HBeAg+'%'
	and t_HBeAb like  '%'+@in_HBeAb+'%'
	and t_HBcAb like  '%'+@in_HBcAb+'%'
	--order by A.check_date
  UNION ALL
  select '合计',ltrim(rtrim(str(@RecordNum))),null,
	 null,null,null,
	 null,null,null,null,null,
	 null,null,null,
	 null,null
	      
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--修改表clinicchkitem--20081027
IF NOT EXISTS (select 1 from syscolumns where name='ChkMethod' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add ChkMethod varchar(30) null--检验方法
end

--修改表chk_valu--20081027
IF NOT EXISTS (select 1 from syscolumns where name='ChkMethod' and id=object_id('chk_valu'))
begin
  Alter table chk_valu add ChkMethod varchar(30) null--检验方法
end

--修改表chk_valu_bak--20081027
IF NOT EXISTS (select 1 from syscolumns where name='ChkMethod' and id=object_id('chk_valu_bak'))
begin
  Alter table chk_valu_bak add ChkMethod varchar(30) null--检验方法
end

--修改表clinicchkitem--20140312
IF NOT EXISTS (select 1 from syscolumns where name='Reserve1' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve1 varchar(200) null--保留字段1
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve2' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve2 varchar(200) null--保留字段2
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve3' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve3 varchar(200) null--保留字段3
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve4' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve4 varchar(200) null--保留字段4
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve5' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve5 int null--保留字段5
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve6' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve6 int null--保留字段6
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve7' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve7 float null--保留字段7
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve8' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve8 float null--保留字段8
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve9' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve9 datetime null--保留字段9
end

IF NOT EXISTS (select 1 from syscolumns where name='Reserve10' and id=object_id('clinicchkitem'))
begin
  Alter table clinicchkitem add Reserve10 datetime null--保留字段10
end


--2014-04-16 使之能容纳项目超限的建议
alter table clinicchkitem alter column Reserve1 varchar(300) null
alter table clinicchkitem alter column Reserve2 varchar(300) null
GO


--20141123
IF NOT EXISTS (select 1 from syscolumns where name='Reserve1' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve1 varchar(300) null--保留字段1

IF NOT EXISTS (select 1 from syscolumns where name='Reserve1' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve1 varchar(300) null--保留字段1

IF NOT EXISTS (select 1 from syscolumns where name='Reserve2' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve2 varchar(300) null--保留字段2

IF NOT EXISTS (select 1 from syscolumns where name='Reserve2' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve2 varchar(300) null--保留字段2

--保留字段3为Dosage1
--保留字段4为Dosage2

IF NOT EXISTS (select 1 from syscolumns where name='Reserve5' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve5 int null--保留字段5

IF NOT EXISTS (select 1 from syscolumns where name='Reserve5' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve5 int null--保留字段5

IF NOT EXISTS (select 1 from syscolumns where name='Reserve6' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve6 int null--保留字段6

IF NOT EXISTS (select 1 from syscolumns where name='Reserve6' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve6 int null--保留字段6

IF NOT EXISTS (select 1 from syscolumns where name='Reserve7' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve7 float null--保留字段7

IF NOT EXISTS (select 1 from syscolumns where name='Reserve7' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve7 float null--保留字段7

IF NOT EXISTS (select 1 from syscolumns where name='Reserve8' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve8 float null--保留字段8

IF NOT EXISTS (select 1 from syscolumns where name='Reserve8' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve8 float null--保留字段8

IF NOT EXISTS (select 1 from syscolumns where name='Reserve9' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve9 datetime null--保留字段9

IF NOT EXISTS (select 1 from syscolumns where name='Reserve9' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve9 datetime null--保留字段9

IF NOT EXISTS (select 1 from syscolumns where name='Reserve10' and id=object_id('chk_valu'))
  Alter table chk_valu add Reserve10 datetime null--保留字段10

IF NOT EXISTS (select 1 from syscolumns where name='Reserve10' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak add Reserve10 datetime null--保留字段10

GO


--触发器TRIGGER_chk_valu_ItemName创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_ItemName' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_ItemName
go

CREATE TRIGGER TRIGGER_chk_valu_ItemName ON chk_valu
FOR insert
AS
--向chk_valu中插入项目代码时自动插入项目名称、检验结果(默认值、已检值)等附加信息
--有此触发器，则向chk_valu中插入记录时，可不插入项目名称、检验结果等附加信息。当然，插入也无妨!
--20081027,增加检验方法字段ChkMethod
  declare @valueid int,@pkunid int,@itemid varchar(50),@Name varchar(50),@english_name varchar(50),@Unit varchar(50),@printorder int,@getmoney money,@Reserve1 varchar(300),@Reserve2 varchar(300),@Dosage1 varchar(100),@Dosage2 varchar(50),@Reserve5 int,@Reserve6 int,@Reserve7 float,@Reserve8 float,@Reserve9 datetime,@Reserve10 datetime,@itemvalue varchar(100)
  SELECT @valueid=valueid,@pkunid=pkunid,@itemid=itemid,@Name=Name,@english_name=english_name,@itemvalue=itemvalue FROM Inserted
  if @valueid is null return --表示没找到刚刚Inserted的记录
  if @pkunid is null return --表示没找到刚刚Inserted的记录
  if isnull(@itemid,'')='' return --表示没找到刚刚Inserted的记录
  if isnull(@Name,'')='' and isnull(@english_name,'')=''--如果插入了项目基本信息,则不update,如从Excel导入
  begin
    select @Name=Name,@english_name=english_name,@Unit=Unit,@printorder=printorder,@getmoney=price,@Reserve1=Reserve1,@Reserve2=Reserve2,@Dosage1=Dosage1,@Dosage2=Dosage2,@Reserve5=Reserve5,@Reserve6=Reserve6,@Reserve7=Reserve7,@Reserve8=Reserve8,@Reserve9=Reserve9,@Reserve10=Reserve10 from clinicchkitem where itemid=@itemid

    update chk_valu set Name=@Name,english_name=@english_name,Unit=@Unit,printorder=@printorder,getmoney=@getmoney,Reserve1=@Reserve1,Reserve2=@Reserve2,Dosage1=@Dosage1,Dosage2=@Dosage2,Reserve5=@Reserve5,Reserve6=@Reserve6,Reserve7=@Reserve7,Reserve8=@Reserve8,Reserve9=@Reserve9,Reserve10=@Reserve10 where valueid=@valueid
  end

  if isnull(@itemvalue,'')=''--如果插入了检验结果,则不update,如从仪器传入、从Excel导入
  begin
    --select @itemvalue=isnull(defaultvalue,'') from clinicchkitem where itemid=@itemid
    select @itemvalue=isnull(sValue,'') from CommValue,clinicchkitem where CommValue.ItemUnid=clinicchkitem.Unid and clinicchkitem.itemid=@itemid and CommValue.dfValue=1--20110607 add 常见结果表

    --declare @CommaPos int
    --set @CommaPos=charindex(',',@itemvalue)
    --if @CommaPos<>0 set @itemvalue=left(@itemvalue,@CommaPos-1)

    if exists(select 1 from chk_valu where pkunid=@pkunid and itemid=@itemid and valueid<>@valueid)--//病人检验结果集中已有该检验项目,则取该结果
      select @itemvalue=isnull(itemvalue,'') from chk_valu where pkunid=@pkunid and itemid=@itemid and valueid<>@valueid

    if @itemvalue<>'' update chk_valu set itemvalue=@itemvalue where valueid=@valueid
  end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--20081211,市政要求的细菌参考值很长,故50->250
alter table chk_valu alter column Min_value varchar(250) null
alter table chk_valu alter column Max_value varchar(250) null
alter table chk_valu_bak alter column Min_value varchar(250) null
alter table chk_valu_bak alter column Max_value varchar(250) null
alter table referencevalue alter column minvalue varchar(250) null
alter table referencevalue alter column maxvalue varchar(250) null
GO


--20100125打印条码标签工作站的病人基本信息表
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[chk_con_his]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
CREATE TABLE chk_con_his (
        Unid int identity primary key,
	[checkid] [varchar] (50) NULL ,
	[patientname] [varchar] (14) NULL ,
	[sex] [varchar] (8) NULL ,
	[age] [varchar] (14) NULL ,
	[Caseno] [varchar] (10) NULL ,
	[bedno] [varchar] (10) NULL ,
	[deptname] [varchar] (40) NULL ,
	[check_date] [datetime] NULL DEFAULT (getdate()) ,
	[check_doctor] [varchar] (14) NULL ,
	[report_date] [datetime] NULL ,
	[report_doctor] [varchar] (14) NULL ,
	[operator] [varchar] (14) NULL ,
	[printtimes] [datetime] NULL ,--int->datetime 20110613
	[Diagnosetype] [varchar] (4) NULL ,
	[flagetype] [varchar] (60) NULL ,
	[diagnose] [char] (50) NULL ,
	[typeflagcase] [char] (30) NULL ,
	[issure] [varchar] (50) NULL ,
	[combin_id] [varchar] (30) NULL ,
	[LSH] [varchar] (8) NULL ,
	[GermName] [varchar] (50) NULL ,
	[His_Unid] [varchar] (50) NULL ,
	[His_MzOrZy] [varchar] (50) NULL ,
	[WorkDepartment] [varchar] (50) NULL ,
	[WorkCategory] [varchar] (50) NULL ,
	[WorkID] [varchar] (50) NULL ,
	[ifMarry] [varchar] (8) NULL ,
	[OldAddress] [varchar] (100) NULL ,
	[Address] [varchar] (100) NULL ,
	[Telephone] [varchar] (100) NULL ,
	[TjDescription] [varchar] (500) NULL ,
	[WorkCompany] [varchar] (50) NULL ,
	[PushPress] [varchar] (50) NULL ,
	[PullPress] [varchar] (50) NULL ,
	[LeftEyesight] [varchar] (50) NULL ,
	[RightEyesight] [varchar] (50) NULL ,
	[Stature] [varchar] (50) NULL ,
	[Weight] [varchar] (50) NULL ,
	[TjJiWangShi] [varchar] (300) NULL ,
	[TjJiaZuShi] [varchar] (300) NULL ,
	[TjNeiKe] [varchar] (300) NULL ,
	[TjWaiKe] [varchar] (300) NULL ,
	[TjWuGuanKe] [varchar] (300) NULL ,
	[TjFuKe] [varchar] (300) NULL ,
	[TjLengQiangGuang] [varchar] (300) NULL ,
	[TjXGuang] [varchar] (300) NULL ,
	[TjBChao] [varchar] (300) NULL ,
	[TjXinDianTu] [varchar] (300) NULL ,
	[TJAdvice] [varchar] (300) NULL ,
	[TjJianYan] [varchar] (300) NULL ,
	[DNH] [varchar] (30) NULL 
)

CREATE TABLE chk_valu_his (
        valueid int identity primary key,
	[pkunid] [int] NOT NULL ,
	[pkcombin_id] [varchar] (10) not NULL ,--null->not null 20110611
	[itemid] [varchar] (10) NULL ,
	[Name] [varchar] (30) NULL ,
	[english_name] [varchar] (30) NULL ,
	[itemvalue] [varchar] (60) NULL ,
	[Unit] [varchar] (30) NULL ,
	[Min_value] [varchar] (20) NULL ,
	[Max_value] [varchar] (20) NULL ,
	[printorder] [int] NULL ,
	[getmoney] [money] NULL ,
	[issure] [varchar] (10) NULL ,
	[histogram] [varchar] (3000) NULL ,
	[combin_Name] [varchar] (30) NULL ,
	[Dosage1] [varchar] (100) NULL ,
	[Dosage2] [varchar] (15) NULL ,
	[Surem1] [varchar] (15) NULL ,
	[Surem2] [varchar] (15) NULL ,
	[Urine1] [varchar] (15) NULL ,
	[Urine2] [varchar] (15) NULL ,
	[Photo] [image] NULL ,
	[IsEdited] [int] NULL 
)

--创建chk_con_his与chk_valu_his之间的关系
ALTER TABLE dbo.chk_valu_his ADD CONSTRAINT
	FK_chk_valu_his_chk_con_his FOREIGN KEY
	(
	pkunid
	) REFERENCES dbo.chk_con_his
	(
	unid
	) ON UPDATE CASCADE
	 ON DELETE CASCADE

--CREATE UNIQUE NONCLUSTERED INDEX IX_Chk_Con_His_1 ON dbo.chk_con_his
--	(
--	LSH
--	) ON [PRIMARY]

CREATE TABLE chk_con_his_bak (
        Unid int primary key,
	[checkid] [varchar] (50) NULL ,
	[patientname] [varchar] (14) NULL ,
	[sex] [varchar] (8) NULL ,
	[age] [varchar] (14) NULL ,
	[Caseno] [varchar] (10) NULL ,
	[bedno] [varchar] (10) NULL ,
	[deptname] [varchar] (40) NULL ,
	[check_date] [datetime] NULL ,
	[check_doctor] [varchar] (14) NULL ,
	[report_date] [datetime] NULL ,
	[report_doctor] [varchar] (14) NULL ,
	[operator] [varchar] (14) NULL ,
	[printtimes] [datetime] NULL ,--int->datetime 20110613
	[Diagnosetype] [varchar] (4) NULL ,
	[flagetype] [varchar] (60) NULL ,
	[diagnose] [char] (50) NULL ,
	[typeflagcase] [char] (30) NULL ,
	[issure] [varchar] (50) NULL ,
	[combin_id] [varchar] (30) NULL ,
	[LSH] [varchar] (8) NULL ,
	[GermName] [varchar] (50) NULL ,
	[His_Unid] [varchar] (50) NULL ,
	[His_MzOrZy] [varchar] (50) NULL ,
	[WorkDepartment] [varchar] (50) NULL ,
	[WorkCategory] [varchar] (50) NULL ,
	[WorkID] [varchar] (50) NULL ,
	[ifMarry] [varchar] (8) NULL ,
	[OldAddress] [varchar] (100) NULL ,
	[Address] [varchar] (100) NULL ,
	[Telephone] [varchar] (100) NULL ,
	[TjDescription] [varchar] (500) NULL ,
	[WorkCompany] [varchar] (50) NULL ,
	[PushPress] [varchar] (50) NULL ,
	[PullPress] [varchar] (50) NULL ,
	[LeftEyesight] [varchar] (50) NULL ,
	[RightEyesight] [varchar] (50) NULL ,
	[Stature] [varchar] (50) NULL ,
	[Weight] [varchar] (50) NULL ,
	[TjJiWangShi] [varchar] (300) NULL ,
	[TjJiaZuShi] [varchar] (300) NULL ,
	[TjNeiKe] [varchar] (300) NULL ,
	[TjWaiKe] [varchar] (300) NULL ,
	[TjWuGuanKe] [varchar] (300) NULL ,
	[TjFuKe] [varchar] (300) NULL ,
	[TjLengQiangGuang] [varchar] (300) NULL ,
	[TjXGuang] [varchar] (300) NULL ,
	[TjBChao] [varchar] (300) NULL ,
	[TjXinDianTu] [varchar] (300) NULL ,
	[TJAdvice] [varchar] (300) NULL ,
	[TjJianYan] [varchar] (300) NULL ,
	[DNH] [varchar] (30) NULL 
)

CREATE TABLE chk_valu_his_bak (
        valueid int primary key,
	[pkunid] [int] NOT NULL ,
	[pkcombin_id] [varchar] (10) not NULL ,--null->not null 20110611
	[itemid] [varchar] (10) NULL ,
	[Name] [varchar] (30) NULL ,
	[english_name] [varchar] (30) NULL ,
	[itemvalue] [varchar] (60) NULL ,
	[Unit] [varchar] (30) NULL ,
	[Min_value] [varchar] (20) NULL ,
	[Max_value] [varchar] (20) NULL ,
	[printorder] [int] NULL ,
	[getmoney] [money] NULL ,
	[issure] [varchar] (10) NULL ,
	[histogram] [varchar] (3000) NULL ,
	[combin_Name] [varchar] (30) NULL ,
	[Dosage1] [varchar] (100) NULL ,
	[Dosage2] [varchar] (15) NULL ,
	[Surem1] [varchar] (15) NULL ,
	[Surem2] [varchar] (15) NULL ,
	[Urine1] [varchar] (15) NULL ,
	[Urine2] [varchar] (15) NULL ,
	[Photo] [image] NULL ,
	[IsEdited] [int] NULL 
)

end
GO


if exists (select name from sysobjects where name='TRIGGER_chk_con_his_BarCode_insert' and type='TR')
  drop TRIGGER TRIGGER_chk_con_his_BarCode_insert
go

--触发器TRIGGER_chk_con_his_CommCode创建脚本20101223
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_his_CommCode' and type='TR')
  drop TRIGGER TRIGGER_chk_con_his_CommCode
go

CREATE TRIGGER TRIGGER_chk_con_his_CommCode ON chk_con_his
FOR UPDATE,Insert
AS
--将不存在的通用代码插入通用代码表
  declare @IDENTITY int,@unid int,@deptname  varchar(50),@check_doctor varchar(50),@flagetype varchar(50),@typeflagcase varchar(50),@diagnose varchar(50),@GermName varchar(50),@issure varchar(50)
  SELECT @unid=unid,@deptname=deptname,@check_doctor=check_doctor,@flagetype=flagetype,@typeflagcase=typeflagcase,@diagnose=diagnose,@GermName=GermName,@issure=issure FROM Inserted
  if (@unid is null) return --表示没找到刚刚update的记录
  select @IDENTITY=Unid from commcode where name=@deptname and typename='部门'
  if (@IDENTITY is null)and(isnull(@deptname,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('部门',@deptname,@deptname)
    SELECT @IDENTITY=@@IDENTITY 
  end
  if (@IDENTITY is null) select @IDENTITY=Unid from commcode where typename='部门'--如果实在没有部门,随便给医生找个部门吧
  if (not exists(select 1 from worker where name=@check_doctor))and(isnull(@check_doctor,'')<>'')and(@IDENTITY is not null)
  begin
    insert into worker (pkdeptid,id,name,pinyin) values (@IDENTITY,@check_doctor,@check_doctor,dbo.uf_getpy(@check_doctor))
  end
  if (not exists(select 1 from commcode where name=@flagetype and typename='样本类型'))and(isnull(@flagetype,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('样本类型',@flagetype,@flagetype)
  end
  if (not exists(select 1 from commcode where name=@typeflagcase and typename='样本状态'))and(isnull(@typeflagcase,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('样本状态',@typeflagcase,@typeflagcase)
  end
  if (not exists(select 1 from commcode where name=@diagnose and typename='临床诊断'))and(isnull(@diagnose,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('临床诊断',@diagnose,@diagnose)
  end
  if (not exists(select 1 from commcode where name=@GermName and typename='细菌'))and(isnull(@GermName,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('细菌',@GermName,@GermName)
  end
  if (not exists(select 1 from commcode where name=@issure and typename='备注'))and(isnull(@issure,'')<>'')
  begin
    insert into commcode (TypeName,ID,Name) values ('备注',@issure,@issure)
  end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--20100310
if exists (select name from sysobjects where name='TRIGGER_CommCode_PYM' and type='TR')
  drop TRIGGER TRIGGER_CommCode_PYM
go

CREATE TRIGGER TRIGGER_CommCode_PYM ON CommCode
FOR UPDATE,Insert
AS
--自动生成拼音码
  declare @unid int,@name  varchar(80)
  SELECT @unid=unid,@name=name FROM Inserted
  if (@unid is null) return --表示没找到刚刚update的记录
  update CommCode set PYM=dbo.uf_getpy(@name) where unid=@unid
GO

--20150719创建视图view_UT_LIS_RESULT
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[view_UT_LIS_RESULT]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[view_UT_LIS_RESULT]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW view_UT_LIS_RESULT
AS
--LIS提供给标软PEIS的结果视图
select	cv.valueid as RESULT_ID,
	cc.Caseno as SAMPLE_NO,
	cv.itemid as ITEM_CODE,
	cv.name as ITEM_NAME,
	cv.itemvalue as TEST_VALUE,
	dbo.uf_Reference_Ranges(cv.min_value,cv.max_value) as TEXT_RANGE,
	cv.unit as TEXT_DANWEI,
	case dbo.uf_ValueAlarm(cv.itemid,cv.Min_value,cv.Max_value,cv.itemvalue) when 1 then 'L' WHEN 2 THEN 'H' ELSE 'N' END as TEXT_NOTE,
	cc.Audit_Date as REPORT_DATE,
	cc.report_doctor as REPORT_USER,
	CV.COMBIN_NAME as FLAG_YQ
from chk_con cc,chk_valu cv
where cc.unid=cv.pkunid
AND ISNULL(cc.report_doctor,'')<>''
and cv.issure='1'
and isnull(cv.itemvalue,'')<>''

union all

select	cv.valueid as RESULT_ID,
	cc.Caseno as SAMPLE_NO,
	cv.itemid as ITEM_CODE,
	cv.name as ITEM_NAME,
	cv.itemvalue as TEST_VALUE,
	dbo.uf_Reference_Ranges(cv.min_value,cv.max_value) as TEXT_RANGE,
	cv.unit as TEXT_DANWEI,
	case dbo.uf_ValueAlarm(cv.itemid,cv.Min_value,cv.Max_value,cv.itemvalue) when 1 then 'L' WHEN 2 THEN 'H' ELSE 'N' END as TEXT_NOTE,
	cc.Audit_Date as REPORT_DATE,
	cc.report_doctor as REPORT_USER,
	CV.COMBIN_NAME as FLAG_YQ
from chk_con_bak cc,chk_valu_bak cv
where cc.unid=cv.pkunid
and isnull(cv.itemvalue,'')<>''
and cc.check_date>getdate()-180

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF NOT EXISTS (select 1 from syscolumns where name='IfSel' and id=object_id('chk_valu_his'))
  Alter table chk_valu_his add IfSel bit null DEFAULT (1)--选择

IF NOT EXISTS (select 1 from syscolumns where name='IfSel' and id=object_id('chk_valu_his_bak'))
  Alter table chk_valu_his_bak add IfSel bit null--选择
GO

--20151202增加采样时间字段
IF NOT EXISTS (select 1 from syscolumns where name='TakeSampleTime' and id=object_id('chk_valu_his'))
  Alter table chk_valu_his add TakeSampleTime datetime null

IF NOT EXISTS (select 1 from syscolumns where name='TakeSampleTime' and id=object_id('chk_valu_his_bak'))
  Alter table chk_valu_his_bak add TakeSampleTime datetime null
go

--if exists (select name from sysobjects where name='TRIGGER_chk_con_His_DELETE' and type='TR')
--  drop TRIGGER TRIGGER_chk_con_His_DELETE
--GO

--CREATE TRIGGER TRIGGER_chk_con_His_DELETE ON chk_con_his
--FOR DELETE 
--AS
--  declare @unid int,@Checked int
--  SELECT @unid=unid FROM deleted
--  if (@unid is null) return --表示没找到刚刚DELETE的记录
--  select @Checked=count(*) from view_Chk_Con_All where His_Unid=@unid
--  if (@Checked>0)
--  begin
--    raiserror ('该申请已被科室处理,不能删除!',16,1)
--    ROLLBACK TRANSACTION
--  end
--GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_His_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_con_His_Update
GO

CREATE TRIGGER TRIGGER_chk_con_His_Update ON chk_con_his
FOR Update 
AS
  declare @unid int,@Checked int,@printtimes_old datetime,@printtimes datetime,@checkid_old varchar(50),@checkid varchar(50)
  SELECT @unid=unid,@printtimes_old=isnull(printtimes,0),@checkid_old=isnull(checkid,'') FROM deleted
  SELECT @printtimes=isnull(printtimes,0),@checkid=isnull(checkid,'') FROM INSERTED
  if (@unid is null) return --表示没找到刚刚Update的记录
  if @printtimes>@printtimes_old return--表示打印操作
  if @checkid_old<>@checkid return--表示LIS中取申请时，修改联机号的操作
  if exists (select 1 from chk_valu_his where pkunid=@unid and itemvalue=1)
  --select @Checked=count(*) from view_Chk_Con_All where His_Unid=@unid
  --if (@Checked>0)
  begin
    raiserror ('该申请已被科室处理,不能修改!',16,1)
    ROLLBACK TRANSACTION
  end
GO

--允许增加新的组合项目，故注释。
--if exists (select name from sysobjects where name='TRIGGER_chk_valu_His_Insert' and type='TR')
--  drop TRIGGER TRIGGER_chk_valu_His_Insert
--GO

--CREATE TRIGGER TRIGGER_chk_valu_His_Insert ON chk_valu_his
--FOR Insert 
--AS
--  declare @pkunid int,@Checked int
--  SELECT @pkunid=pkunid FROM INSERTED
--  if (@pkunid is null) return --表示没找到刚刚Insert的记录
--  select @Checked=count(*) from view_Chk_Con_All where His_Unid=@pkunid
--  if (@Checked>0)
--  begin
--    raiserror ('该申请已被科室处理,不能增加!',16,1)
--    ROLLBACK TRANSACTION
--  end
--GO

--if exists (select name from sysobjects where name='TRIGGER_chk_valu_His_DELETE' and type='TR')
--  drop TRIGGER TRIGGER_chk_valu_His_DELETE
--GO

--CREATE TRIGGER TRIGGER_chk_valu_His_DELETE ON chk_valu_his
--FOR DELETE 
--AS
--  declare @pkunid int,@Checked int
--  SELECT @pkunid=pkunid FROM deleted
--  if (@pkunid is null) return --表示没找到刚刚Insert的记录
--  select @Checked=count(*) from view_Chk_Con_All where His_Unid=@pkunid
--  if (@Checked>0)
--  begin
--    raiserror ('该申请已被科室处理,不能删除!',16,1)
--    ROLLBACK TRANSACTION
--  end
--GO

--界面上不存在修改的操作，故注释。倒是有修改取走标志的操作，故更加要注释
--if exists (select name from sysobjects where name='TRIGGER_chk_valu_His_Update' and type='TR')
--  drop TRIGGER TRIGGER_chk_valu_His_Update
--GO

--CREATE TRIGGER TRIGGER_chk_valu_His_Update ON chk_valu_his
--FOR Update 
--AS
--  declare @pkunid int,@Checked int
--  SELECT @pkunid=pkunid FROM deleted
--  if (@pkunid is null) return --表示没找到刚刚Insert的记录
--  select @Checked=count(*) from view_Chk_Con_All where His_Unid=@pkunid
--  if (@Checked>0)
--  begin
--    raiserror ('该申请已被科室处理,不能修改!',16,1)
--    ROLLBACK TRANSACTION
--  end
--GO

--20150729
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_Peis_Br_Barcode]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_Peis_Br_Barcode]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION uf_Peis_Br_Barcode
--得到标软公司体检系统的条码
(
  @chk_con_his_unid int
)  
RETURNS varchar(500) AS  
BEGIN 
  declare @ret varchar(500)
  set @ret=''
  select @ret=@ret+','+Urine1+Urine2 from chk_con_his cch,chk_valu_his cvh WHERE cch.unid=cvh.pkunid and cch.unid=@chk_con_his_unid group by Urine1,Urine2
  set @ret=stuff(@ret,1,1,'')

  return @ret
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetExtBarcode]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetExtBarcode]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION uf_GetExtBarcode
--获取条码号
(
  @chk_con_his_unid int
)  
RETURNS varchar(500) AS  
BEGIN 
  declare @ret varchar(500),@tempS1 varchar(500)

  select @tempS1=dbo.uf_Peis_Br_Barcode(@chk_con_his_unid)

  if isnull(@tempS1,'')='' 
    set @ret=@chk_con_his_unid
  else set @ret=@tempS1

  select @ret=','+@ret+','

  return @ret
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--20150728
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetHisStationCombName]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetHisStationCombName]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create FUNCTION uf_GetHisStationCombName
(
  @Unid int --HisStation病人的UNID
)  
RETURNS varchar(500) AS  
BEGIN 
  declare @ret varchar(500)
  set @ret=''
  select @ret=@ret+','+combin_Name from chk_valu_his WHERE PkUnid=@Unid
  set @ret=stuff(@ret,1,1,'')

  return @ret
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--20160907获取指定病人的组合项目串。用于集中打印时界面显示
--if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetPatientCombName]') and xtype in (N'FN', N'IF', N'TF'))
--drop function [dbo].[uf_GetPatientCombName]
--GO

--SET QUOTED_IDENTIFIER ON 
--GO
--SET ANSI_NULLS ON 
--GO

--create FUNCTION uf_GetPatientCombName
--(
--  @ifCompleted int,--0:未结束的(chk_valu);1:已结束的(chk_valu_bak)
--  @Unid int --病人的UNID
--)  
--RETURNS varchar(500) AS  
--BEGIN 
--  declare @ret varchar(500)
--  set @ret=''
--  if @ifCompleted=1 
--    select @ret=@ret+','+combin_Name from chk_valu_bak
--      WHERE PkUnid=@Unid and issure=1 and ltrim(rtrim(isnull(itemvalue,'')))<>'' 
--      GROUP BY combin_Name 
--  else 
--    select @ret=@ret+','+combin_Name from chk_valu 
--      WHERE PkUnid=@Unid and issure=1 and ltrim(rtrim(isnull(itemvalue,'')))<>'' 
--      GROUP BY combin_Name 
    
--  set @ret=stuff(@ret,1,1,'')

--  return @ret
--END

--GO
--SET QUOTED_IDENTIFIER OFF 
--GO
--SET ANSI_NULLS ON 
--GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[view_Show_chk_Con_His]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[view_Show_chk_Con_His]
GO

--2010-12-30视图view_Show_chk_Con_His创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE  VIEW view_Show_chk_Con_His
AS
select cch.* from chk_con_his cch 
where (SELECT count(*) FROM chk_valu_his cvh WHERE cvh.pkunid=cch.unid and isnull(cvh.itemvalue,'')<>'1')>0
--where cch.unid in(
--select cvh.pkunid from chk_valu_his cvh
--where not exists 
--( 
--select 1 from view_Chk_Con_All vcca
--inner join view_chk_valu_All vcva on vcca.unid=vcva.pkunid 
--and cvh.pkunid=vcca.his_unid and cvh.pkcombin_id=vcva.pkcombin_id and vcva.issure='1'
--)
--)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--2011-01-06存储过程PRO_Completion_Chk_His创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PRO_Completion_Chk_His]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PRO_Completion_Chk_His]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE PRO_Completion_Chk_His
AS
--归档全部完成的chk_his
Declare @Current_Date datetime
select @Current_Date=getdate()

insert into chk_con_His_bak 
select cch.* FROM dbo.chk_con_his cch
where (SELECT count(*) FROM chk_valu_his cvh WHERE cvh.pkunid=cch.unid and isnull(cvh.itemvalue,'')<>'1')<=0
      and (SELECT count(*) FROM chk_valu_his cvh3 WHERE cvh3.pkunid=cch.unid)>0
      and cch.check_date<@Current_Date-1
--select cch.* FROM dbo.chk_con_his cch
--WHERE (Unid not IN
--        (SELECT cvh.pkunid
--         FROM chk_valu_his cvh
--         WHERE not EXISTS
--                   (SELECT 1
--                    FROM view_Chk_Con_All vcca INNER JOIN
--                        view_chk_valu_All vcva ON vcca.unid = vcva.pkunid AND 
--                        cvh.pkunid = vcca.his_unid AND 
--                        cvh.pkcombin_id = vcva.pkcombin_id AND vcva.issure = '1')
--        )
--       )

insert into chk_valu_His_bak 
select cvh2.* from chk_VALU_his cvh2 where cvh2.pkunid in
(select cch.UNID FROM dbo.chk_con_his cch
WHERE (SELECT count(*) FROM chk_valu_his cvh WHERE cvh.pkunid=cch.unid and isnull(cvh.itemvalue,'')<>'1')<=0 and cch.check_date<@Current_Date-1
)
--select cvh2.* from chk_VALU_his cvh2 where cvh2.pkunid in
--(select cch.UNID FROM dbo.chk_con_his cch
--WHERE (Unid not IN
--        (SELECT cvh.pkunid
--         FROM chk_valu_his cvh
--         WHERE not EXISTS
--                 (SELECT 1
--                  FROM view_Chk_Con_All vcca INNER JOIN
--                        view_chk_valu_All vcva ON vcca.unid = vcva.pkunid AND 
--                        cvh.pkunid = vcca.his_unid AND 
--                        cvh.pkcombin_id = vcva.pkcombin_id AND vcva.issure = '1')
--        )
--      )
--)

delete FROM chk_con_his
WHERE (SELECT count(*) FROM chk_valu_his cvh WHERE cvh.pkunid=chk_con_his.unid and isnull(cvh.itemvalue,'')<>'1')<=0
      and (SELECT count(*) FROM chk_valu_his cvh3 WHERE cvh3.pkunid=chk_con_his.unid)>0
      and chk_con_his.check_date<@Current_Date-1
--WHERE (Unid not IN
--        (SELECT cvh.pkunid
--         FROM chk_valu_his cvh
--         WHERE not EXISTS
--                 (SELECT 1
--                  FROM view_Chk_Con_All vcca INNER JOIN
--                        view_chk_valu_All vcva ON vcca.unid = vcva.pkunid AND 
--                        cvh.pkunid = vcca.his_unid AND 
--                        cvh.pkcombin_id = vcva.pkcombin_id AND vcva.issure = '1')
--        )
--      )


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--CommCode 20110414
IF not EXISTS (select 1 from syscolumns where name='Reserve2' and id=object_id('CommCode'))
  Alter table CommCode add Reserve2 varchar(200) null
IF not EXISTS (select 1 from syscolumns where name='Reserve3' and id=object_id('CommCode'))
  Alter table CommCode add Reserve3 varchar(200) null
IF not EXISTS (select 1 from syscolumns where name='Reserve4' and id=object_id('CommCode'))
  Alter table CommCode add Reserve4 varchar(200) null
IF not EXISTS (select 1 from syscolumns where name='Reserve5' and id=object_id('CommCode'))
  Alter table CommCode add Reserve5 int null
IF not EXISTS (select 1 from syscolumns where name='Reserve6' and id=object_id('CommCode'))
  Alter table CommCode add Reserve6 int null
IF not EXISTS (select 1 from syscolumns where name='Reserve7' and id=object_id('CommCode'))
  Alter table CommCode add Reserve7 float null
IF not EXISTS (select 1 from syscolumns where name='Reserve8' and id=object_id('CommCode'))
  Alter table CommCode add Reserve8 float null
IF not EXISTS (select 1 from syscolumns where name='Reserve9' and id=object_id('CommCode'))
  Alter table CommCode add Reserve9 datetime null
IF not EXISTS (select 1 from syscolumns where name='Reserve10' and id=object_id('CommCode'))
  Alter table CommCode add Reserve10 datetime null
GO

--CommValue 20110607
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CommValue]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
create table CommValue
 (Unid int identity primary key,
  ItemUnid int not null,
  sValue varchar(100) not null,
  dfValue bit null
)
GO

--创建CommValue与clinicchkitem之间的关系
if not exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_CommValue_clinicchkitem' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.CommValue ADD CONSTRAINT
	FK_CommValue_clinicchkitem FOREIGN KEY
	(
	ItemUnid
	) REFERENCES dbo.clinicchkitem
	(
	unid
	) ON UPDATE CASCADE
	 ON DELETE CASCADE
go

--HisCombItem 20110611
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[HisCombItem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
create table HisCombItem
 (Unid int identity primary key,
  CombUnid int not null,
  HisItem varchar(20) not null,
  HisItemName varchar(50) null
)
GO

--20150719增加字段
IF NOT EXISTS (select 1 from syscolumns where name='ExtSystemId' and id=object_id('HisCombItem'))
  Alter table HisCombItem add ExtSystemId varchar(50) null

IF NOT EXISTS (select 1 from syscolumns where name='Create_Date_Time' and id=object_id('HisCombItem'))
  Alter table HisCombItem add Create_Date_Time datetime null DEFAULT (getdate())
GO

--创建HisCombItem与combinitem之间的关系
if not exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'FK_HisCombItem_combinitem' and user_name(o.uid) = N'dbo')
ALTER TABLE dbo.HisCombItem ADD CONSTRAINT
	FK_HisCombItem_combinitem FOREIGN KEY
	(
	CombUnid
	) REFERENCES dbo.combinitem
	(
	unid
	) ON UPDATE CASCADE
	 ON DELETE CASCADE
go

if not exists(select * from sysindexes where name='IX_HisCombItem')
begin
CREATE UNIQUE NONCLUSTERED INDEX IX_HisCombItem ON dbo.HisCombItem
	(
	CombUnid,
	HisItem
	) ON [PRIMARY]
end
GO

--触发器TRIGGER_chk_valu_His_ItemName创建脚本 20110611
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_His_ItemName' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_His_ItemName
go

CREATE TRIGGER TRIGGER_chk_valu_His_ItemName ON chk_valu_his
FOR insert
AS
--向chk_valu_his中插入项目代码时自动插入项目名称等附加信息
--有此触发器，则向chk_valu_his中插入记录时，可不插入项目名称等附加信息。当然，插入也无妨!
  declare @valueid int,@pkcombin_id varchar(50),@Name varchar(50)
  SELECT @valueid=valueid,@pkcombin_id=pkcombin_id FROM Inserted
  if @valueid is null return --表示没找到刚刚Inserted的记录
  if isnull(@pkcombin_id,'')='' return --表示没找到刚刚Inserted的记录

  select @Name=Name from combinitem where id=@pkcombin_id

  update chk_valu_his set combin_Name=@Name where valueid=@valueid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_Insert_His_Mark' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_Insert_His_Mark
go

CREATE TRIGGER TRIGGER_chk_valu_Insert_His_Mark ON chk_valu
FOR INSERT
AS
  declare @Surem2 varchar(15)
  SELECT @Surem2=Surem2 FROM Inserted

  if (@Surem2 is null) return
  if (@Surem2='') return
  if (cast(@Surem2 AS int)<=0) return

  if exists(select * from chk_valu where Surem2=@Surem2 and issure='1')
    update chk_valu_his set itemvalue=1 where cast(valueid as varchar)=@Surem2 and isnull(itemvalue,'')<>'1'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_Update_His_Mark' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_Update_His_Mark
go

CREATE TRIGGER TRIGGER_chk_valu_Update_His_Mark ON chk_valu
FOR Update
AS
  declare @issure varchar(10),@issure_Old varchar(10),@Surem2 varchar(15),@Surem2_Old varchar(15),@valueid int

  --SELECT @issure_Old=issure,@Surem2_Old=Surem2 FROM Deleted

  DECLARE Cur1 Cursor For 
    SELECT issure,Surem2,valueid FROM Inserted
  Open Cur1
  FETCH NEXT FROM Cur1 INTO @issure,@Surem2,@valueid
  WHILE @@FETCH_STATUS=0
  BEGIN
    if isnull(@Surem2,'')=''
    begin
      FETCH NEXT FROM Cur1 INTO @issure,@Surem2,@valueid
      continue
    end

    if cast(@Surem2 AS int)<=0
    begin
      FETCH NEXT FROM Cur1 INTO @issure,@Surem2,@valueid
      continue
    end

    SELECT @issure_Old=issure,@Surem2_Old=Surem2 FROM Deleted where valueid=@valueid

    if (isnull(@issure_Old,'')=isnull(@issure,''))and(isnull(@Surem2_Old,'')=isnull(@Surem2,'')) 
    --如果可见标志、Chk_Valu_His.ValueId均没更改，则不处理
    begin
      FETCH NEXT FROM Cur1 INTO @issure,@Surem2,@valueid
      continue
    end

    if exists(select * from chk_valu where Surem2=@Surem2 and issure='1')
    begin
      update chk_valu_his set itemvalue=1 where cast(valueid as varchar)=@Surem2 and isnull(itemvalue,'')<>'1'
    end else 
      update chk_valu_his set itemvalue=null where cast(valueid as varchar)=@Surem2 and isnull(itemvalue,'')='1'

    FETCH NEXT FROM Cur1 INTO @issure,@Surem2,@valueid
  END
  CLOSE Cur1
  DEALLOCATE Cur1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--SET QUOTED_IDENTIFIER ON 
--GO
--SET ANSI_NULLS ON 
--GO

--if exists (select name from sysobjects where name='TRIGGER_chk_valu_Delete_His_Mark' and type='TR')
--  drop TRIGGER TRIGGER_chk_valu_Delete_His_Mark
--go

--CREATE TRIGGER TRIGGER_chk_valu_Delete_His_Mark ON chk_valu
--FOR Delete
--AS
--  declare @valueid int,@pkunid int,@his_unid varchar(50),@pkcombin_id varchar(10),@issure varchar(10),@issure_Old varchar(10)
--  SELECT @valueid=valueid,@pkunid=pkunid,@pkcombin_id=pkcombin_id,@issure=issure FROM Deleted
--  if (@valueid is null) return --表示没找到刚刚update或insert的记录
--  if (@pkunid is null) return --表示没有主记录

--  select @his_unid=his_unid from chk_con where unid=@pkunid
--  if (isnull(@his_unid,'')='') return 

--  update chk_valu_his set itemvalue=null where cast(pkunid as varchar)=@his_unid and pkcombin_id=@pkcombin_id

--GO
--SET QUOTED_IDENTIFIER OFF 
--GO
--SET ANSI_NULLS ON 
--GO

--程序搞定，以免影响“结束当前检验工作”
--SET QUOTED_IDENTIFIER ON 
--GO
--SET ANSI_NULLS ON 
--GO

--if exists (select name from sysobjects where name='TRIGGER_chk_con_Delete_His_Mark' and type='TR')
--  drop TRIGGER TRIGGER_chk_con_Delete_His_Mark
--go

--CREATE   TRIGGER TRIGGER_chk_con_Delete_His_Mark ON chk_con
--FOR Delete
--AS
  --该触发器放在chk_valu时，由于找不到chk_con,不生效。故只有放在chk_con中(其实界面操作中,chk_valu也不存在删除)
--  declare @his_unid varchar(50)
--  SELECT @his_unid=his_unid FROM Deleted

--  if (isnull(@his_unid,'')='') return 

--  update chk_valu_his set itemvalue=null where cast(pkunid as varchar)=@his_unid

--GO
--SET QUOTED_IDENTIFIER OFF 
--GO
--SET ANSI_NULLS ON 
--GO


--PIX_TRAN 20111123
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PIX_TRAN]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
CREATE TABLE PIX_TRAN (
	UNID int IDENTITY primary key,
	PKUNID int NULL ,
	Reserve1 varchar(100)  NULL ,
	Reserve2 varchar(100)  NULL ,
	Reserve3 varchar(100)  NULL ,
	Reserve4 varchar(100)  NULL ,
	Reserve5 datetime  NULL ,
	CREATE_DATE_TIME datetime NULL DEFAULT (getdate()),
	OpType varchar(50)  NULL 
) 
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_HisValue_Delete' and type='TR')
  drop TRIGGER TRIGGER_chk_con_HisValue_Delete
go

CREATE TRIGGER TRIGGER_chk_con_HisValue_Delete ON chk_con
FOR DELETE 
AS
--更新PIX_TRAN
  declare @unid int,@report_doctor varchar(50),@his_mzorzy varchar(50)
  SELECT @unid=unid,@report_doctor=report_doctor,@his_mzorzy=his_mzorzy FROM Deleted
  if (isnull(@unid,'')='') return 
  if (isnull(@report_doctor,'')='') return 
  if (isnull(@his_mzorzy,'')='') return--his_mzorzy:HIS的申请单号 

  insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@unid,@his_mzorzy,'Class_Result','Del')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_HisValue_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_con_HisValue_Update
go

CREATE TRIGGER TRIGGER_chk_con_HisValue_Update ON chk_con
FOR UPDATE
AS
--更新PIX_TRAN
  declare @unid int,@report_doctor varchar(50),@report_doctor_Old varchar(50),@his_mzorzy_Old varchar(50)
  SELECT @unid=unid,@report_doctor=report_doctor FROM Inserted
  if (isnull(@unid,'')='') return 
  SELECT @report_doctor_Old=report_doctor,@his_mzorzy_Old=his_mzorzy FROM Deleted
  if (isnull(@his_mzorzy_Old,'')='') return--his_mzorzy:HIS的申请单号 

  if isnull(@report_doctor,'')<>isnull(@report_doctor_Old,'')
  begin
    if isnull(@report_doctor,'')<>''
      insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@unid,@his_mzorzy_Old,'Class_Result','Add')

    if isnull(@report_doctor,'')=''
      insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@unid,@his_mzorzy_Old,'Class_Result','Del')
  end

  if isnull(@report_doctor,'')=isnull(@report_doctor_Old,'')
  begin
    if isnull(@report_doctor,'')<>''
      insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@unid,@his_mzorzy_Old,'Class_Result','Add')
  end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_valu_HisValue_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_valu_HisValue_Update
go

CREATE TRIGGER TRIGGER_chk_valu_HisValue_Update ON chk_valu
FOR update
AS
--更新PIX_TRAN
  declare @pkunid int,@report_doctor varchar(50),@issure varchar(50),@itemvalue varchar(50),@issure_Old varchar(50),@itemvalue_Old varchar(50),@his_mzorzy varchar(50)
    
  SELECT @pkunid=pkunid,@issure=issure,@itemvalue=itemvalue FROM Inserted
  if (isnull(@pkunid,'')='') return 
  SELECT @report_doctor=report_doctor,@his_mzorzy=his_mzorzy FROM chk_con where unid=@pkunid
  if (isnull(@report_doctor,'')='') return
  if (isnull(@his_mzorzy,'')='') return--his_mzorzy:HIS的申请单号 
  SELECT @issure_Old=issure,@itemvalue_Old=itemvalue FROM Deleted
  if isnull(@issure,'')=isnull(@issure_Old,'') and isnull(@itemvalue,'')=isnull(@itemvalue_Old,'') return--结果与检验单标志都没改

  if (isnull(@issure_Old,'')<>'1' or isnull(@itemvalue_Old,'')='') and (isnull(@issure,'')<>'1' or isnull(@itemvalue,'')='') return--表示修改前与修改后都是无效结果

  if exists (select * from chk_valu where pkunid=@pkunid and issure='1' and isnull(itemvalue,'')<>'')
  --该select选出的记录包含修改之后issure='1' and isnull(itemvalue,'')<>''的情况
    insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@pkunid,@his_mzorzy,'Class_Result','Add')
  else insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@pkunid,@his_mzorzy,'Class_Result','Del')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_HIS_Audit_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_con_HIS_Audit_Update
go

CREATE TRIGGER TRIGGER_chk_con_HIS_Audit_Update ON chk_con_his
FOR UPDATE
AS
--更新PIX_TRAN
  declare @unid int,@report_doctor varchar(50),@report_doctor_Old varchar(50),@His_Unid varchar(50)
  SELECT @unid=unid,@report_doctor=report_doctor,@His_Unid=His_Unid FROM Inserted
  if (isnull(@unid,'')='') return 
  SELECT @report_doctor_Old=report_doctor FROM Deleted
  if (isnull(@His_Unid,'')='') return--@His_Unid:HIS的申请单号 

  if isnull(@report_doctor_Old,'')=isnull(@report_doctor,'') return--没更改审核者

  if isnull(@report_doctor_Old,'')='' and isnull(@report_doctor,'')<>'' 
    insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@unid,@His_Unid,'Class_Fee','App_Audit')
  
  if isnull(@report_doctor_Old,'')<>'' and isnull(@report_doctor,'')='' 
    insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@unid,@His_Unid,'Class_Fee','App_UnAudit')
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_His_Audit_Delete' and type='TR')
  drop TRIGGER TRIGGER_chk_con_His_Audit_Delete
go

CREATE TRIGGER TRIGGER_chk_con_His_Audit_Delete ON chk_con_his
FOR DELETE 
AS
--更新PIX_TRAN
  declare @unid int,@report_doctor varchar(50),@His_Unid varchar(50)
  SELECT @unid=unid,@report_doctor=report_doctor,@His_Unid=His_Unid FROM Deleted
  if (isnull(@unid,'')='') return 
  if (isnull(@report_doctor,'')='') return 
  if (isnull(@His_Unid,'')='') return--@His_Unid:HIS的申请单号 

  insert into pix_tran (pkunid,Reserve1,Reserve2,OpType) values (@unid,@His_Unid,'Class_Fee','App_UnAudit')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--修改表chk_con--20120222
IF NOT EXISTS (select 1 from syscolumns where name='Audit_Date' and id=object_id('chk_con'))
begin
  Alter table chk_con add Audit_Date datetime null--审核时间
end

--修改表chk_con_bak--20120222
IF NOT EXISTS (select 1 from syscolumns where name='Audit_Date' and id=object_id('chk_con_bak'))
begin
  Alter table chk_con_bak add Audit_Date datetime null--审核时间
end
go

--修改表chk_con_his--20120313
IF NOT EXISTS (select 1 from syscolumns where name='Audit_Date' and id=object_id('chk_con_his'))
begin
  Alter table chk_con_his add Audit_Date datetime null--审核时间
end

--修改表chk_con_his_bak--20120313
IF NOT EXISTS (select 1 from syscolumns where name='Audit_Date' and id=object_id('chk_con_his_bak'))
begin
  Alter table chk_con_his_bak add Audit_Date datetime null--审核时间
end
go

--20120228,越秀区中医医院导入诊疗卡号,故10->30
alter table chk_con alter column Caseno varchar(30) null
alter table chk_con_bak alter column Caseno varchar(30) null
alter table chk_con_his alter column Caseno varchar(30) null
alter table chk_con_his_bak alter column Caseno varchar(30) null
GO

--2012-03-08从varchar(30)改为varchar(50),越秀区中医医院的组合项目特长
alter table chk_valu_his alter column combin_Name varchar(50) null
alter table chk_valu_his_bak alter column combin_Name varchar(50) null
GO

--20120511,临床诊断,char(50)->varchar(200)
alter table chk_con alter column diagnose varchar(200) null
alter table chk_con_bak alter column diagnose varchar(200) null
alter table chk_con_his alter column diagnose varchar(200) null
alter table chk_con_his_bak alter column diagnose varchar(200) null
GO

--20120528,nvarchar(30)->varchar(100),超级用户记录中的该字段存放试用版有效期
alter table worker alter column account_limit varchar(100) Null
GO

--Worker
IF not EXISTS (select 1 from syscolumns where name='ShowAllTj' and id=object_id('Worker'))
  Alter table Worker add ShowAllTj varchar(2) null
GO

IF EXISTS (select 1 from syscolumns where name='Reserve3' and id=object_id('clinicchkitem'))
BEGIN
  --Reserve3不要了，用Dosage1做为保留字段3.值改到Reserve5
  update clinicchkitem set Reserve5=1 where Reserve3='体检结论' AND Reserve5 IS NULL
  update clinicchkitem set Reserve5=2 where Reserve3='体检建议' AND Reserve5 IS NULL
END
GO

--20141123切变率在20141123前是在dosage2字段中，现转移到Reserve8
update clinicchkitem set Reserve8=dosage2 where isnull(dosage2,'')<>'' AND ISNUMERIC(dosage2)=1 AND Reserve8 IS NULL
GO

--20141123打算删除这些字段，考虑到PEIS可能在用这些字段，暂不删除
/*
IF EXISTS (select 1 from syscolumns where name='Reserve3' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column Reserve3
IF EXISTS (select 1 from syscolumns where name='Reserve4' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column Reserve4
IF EXISTS (select 1 from syscolumns where name='Surem1' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column Surem1
IF EXISTS (select 1 from syscolumns where name='Surem2' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column Surem2
IF EXISTS (select 1 from syscolumns where name='Urine1' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column Urine1
IF EXISTS (select 1 from syscolumns where name='Urine2' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column Urine2
IF EXISTS (select 1 from syscolumns where name='ChkMethod' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem drop column ChkMethod
IF EXISTS (select 1 from syscolumns where name='Surem1' and id=object_id('chk_valu'))
  Alter table chk_valu drop column Surem1
IF EXISTS (select 1 from syscolumns where name='Surem2' and id=object_id('chk_valu'))
  Alter table chk_valu drop column Surem2
IF EXISTS (select 1 from syscolumns where name='Urine1' and id=object_id('chk_valu'))
  Alter table chk_valu drop column Urine1
IF EXISTS (select 1 from syscolumns where name='Urine2' and id=object_id('chk_valu'))
  Alter table chk_valu drop column Urine2
IF EXISTS (select 1 from syscolumns where name='ChkMethod' and id=object_id('chk_valu'))
  Alter table chk_valu drop column ChkMethod
IF EXISTS (select 1 from syscolumns where name='Surem1' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak drop column Surem1
IF EXISTS (select 1 from syscolumns where name='Surem2' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak drop column Surem2
IF EXISTS (select 1 from syscolumns where name='Urine1' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak drop column Urine1
IF EXISTS (select 1 from syscolumns where name='Urine2' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak drop column Urine2
IF EXISTS (select 1 from syscolumns where name='ChkMethod' and id=object_id('chk_valu_bak'))
  Alter table chk_valu_bak drop column ChkMethod
*/
GO

--20150517增加标本发送人、接收人、接收时间
--PushPress（原舒张压）用作 发送人
--PullPress（原收缩压）用作 接收人
--Stature（原身高）用作 接收时间
alter table chk_con alter column Stature datetime Null
GO

alter table chk_con_bak alter column Stature datetime Null
GO

if not exists(select * from CommCode where TypeName='工具菜单' and name='报表编辑器')
begin
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',010,'报表编辑器','FrfSet.exe','1')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',015,'SQL高级查询器','SQLQueryer.exe','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',020,'-','','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',025,'权限设置','PowerSet.exe','1')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',030,'-','','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',035,'激活通信接口','注册COM组件.bat','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',040,'-','','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',055,'串口调试助手','UartAssist.exe','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',060,'网络调试助手','NetAssist.exe','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',070,'-','','')
  insert into CommCode(TypeName,ID,Name,Reserve,Reserve2) values ('工具菜单',075,'操作手册','检验系统操作手册.pdf','')
end
GO

--触发器TRIGGER_RisDescriptType_PYM创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_RisDescriptType_PYM' and type='TR')
  drop TRIGGER TRIGGER_RisDescriptType_PYM
go

CREATE TRIGGER TRIGGER_RisDescriptType_PYM ON RisDescriptType
FOR UPDATE,Insert
AS
--自动生成拼音码
  declare @id varchar(50),@name varchar(80)
  SELECT @id=id,@name=name FROM Inserted
  if (@id is null) return --表示没找到刚刚update的记录
  update RisDescriptType set PYM=dbo.uf_getpy(@name) where id=@id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_Worker_PYM创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_Worker_PYM' and type='TR')
  drop TRIGGER TRIGGER_Worker_PYM
go

CREATE TRIGGER TRIGGER_Worker_PYM ON Worker
FOR UPDATE,Insert
AS
--自动生成拼音码
  declare @unid int,@name varchar(50)
  SELECT @unid=unid,@name=name FROM Inserted
  if (@unid is null) return --表示没找到刚刚update的记录
  update Worker set pinyin=dbo.uf_getpy(@name) where unid=@unid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--触发器TRIGGER_RisDescription_PYM创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_RisDescription_PYM' and type='TR')
  drop TRIGGER TRIGGER_RisDescription_PYM
go

CREATE TRIGGER TRIGGER_RisDescription_PYM ON RisDescription
FOR UPDATE,Insert
AS
--自动生成拼音码
  declare @unid int,@name varchar(100)
  SELECT @unid=unid,@name=name FROM Inserted
  if (@unid is null) return --表示没找到刚刚update的记录
  update RisDescription set PYM=dbo.uf_getpy(@name) where unid=@unid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_clinicchkitem_PYM创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_clinicchkitem_PYM' and type='TR')
  drop TRIGGER TRIGGER_clinicchkitem_PYM
go

CREATE TRIGGER TRIGGER_clinicchkitem_PYM ON clinicchkitem
FOR UPDATE,Insert
AS
--自动生成拼音码
  declare @unid int,@name varchar(100)
  SELECT @unid=unid,@name=name FROM Inserted
  if (@unid is null) return --表示没找到刚刚update的记录
  update clinicchkitem set PYM=dbo.uf_getpy(@name) where unid=@unid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_combinitem_PYM创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_combinitem_PYM' and type='TR')
  drop TRIGGER TRIGGER_combinitem_PYM
go

CREATE TRIGGER TRIGGER_combinitem_PYM ON combinitem
FOR UPDATE,Insert
AS
--自动生成拼音码
  declare @unid int,@name varchar(100)
  SELECT @unid=unid,@name=name FROM Inserted
  if (@unid is null) return --表示没找到刚刚update的记录
  update combinitem set PYM=dbo.uf_getpy(@name) where unid=@unid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--combinitem 20140410
IF not EXISTS (select 1 from syscolumns where name='Department' and id=object_id('combinitem'))
  Alter table combinitem add Department varchar(50) null
GO

--combinitem 20140411
IF not EXISTS (select 1 from syscolumns where name='SysName' and id=object_id('combinitem'))
  Alter table combinitem add SysName varchar(10) null
GO

update combinitem SET SysName='LIS' WHERE isnull(SysName,'')=''
GO

--clinicchkitem 20140411
IF not EXISTS (select 1 from syscolumns where name='SysName' and id=object_id('clinicchkitem'))
  Alter table clinicchkitem add SysName varchar(10) null
GO

update clinicchkitem SET SysName='LIS' WHERE isnull(SysName,'')=''
GO

--CommCode 20140411
IF not EXISTS (select 1 from syscolumns where name='SysName' and id=object_id('CommCode'))
  Alter table CommCode add SysName varchar(10) null
GO

update CommCode SET SysName='LIS' WHERE isnull(SysName,'')=''
GO

--生成参考范围函数 20140412
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_Reference_Ranges]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_Reference_Ranges]
GO

CREATE  FUNCTION uf_Reference_Ranges
(
  @Min_value varchar(250),
  @Max_value varchar(250)
)  
RETURNS varchar(510) AS  
BEGIN 
  if isnull(@Min_value,'')=isnull(@Max_value,'') return @Min_value
   
  if isnull(@Min_value,'')<>''and isnull(@Max_value,'')='' return @Min_value

  if isnull(@Min_value,'')=''and isnull(@Max_value,'')<>'' return @Max_value

  if isnull(@Min_value,'')<>isnull(@Max_value,'') return @Min_value+'--'+@Max_value

  return null
END

GO

--20140906质控修改
if EXISTS (select 1 from information_schema.columns where table_name = 'QCGHEAD' and column_name='qc_month' and data_type='varchar')
begin
  DELETE FROM QCGHEAD WHERE qc_month='AA'--处理历史数据
  alter table qcghead alter column qc_year int NOT NULL
  alter table qcghead alter column qc_month int NOT NULL
end
GO

IF not EXISTS (select 1 from syscolumns where name='itemid' and id=object_id('qcghead'))
  Alter table qcghead add itemid varchar(10) null
GO

--处理历史数据
update qcghead set itemid='-1' where itemid is null
GO

Alter table qcghead alter column itemid varchar(10) NOT null
GO

alter table qcghead alter column itemname varchar(30) null
GO

--创建qcghead.itemid不能为空字符串的约束
if not exists(select OBJECTPROPERTY(o.id,N'IsSystemTable') from sysobjects o where o.name = N'CK_qcghead_ITEMID' and user_name(o.uid) = N'dbo')
ALTER TABLE qcghead ADD CONSTRAINT CK_qcghead_ITEMID CHECK (len(itemID) > 0)
GO

--触发器TRIGGER_qcghead_insert创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_qcghead_insert' and type='TR')
  drop TRIGGER TRIGGER_qcghead_insert
go

CREATE TRIGGER TRIGGER_qcghead_insert ON qcghead
FOR INSERT,UPDATE
AS
--根据项目ID插入项目名称
  declare @unid int,@itemID varchar(10),@Name varchar(60),@COMMWORD varchar(10),@equip varchar(30)
  SELECT @unid=unid,@itemID=itemID,@equip=equip FROM Inserted
  if (@unid is null) return --表示没找到刚刚插入的记录
  select @Name=Name,@COMMWORD=COMMWORD from clinicchkitem where itemID=@itemID
  if (isnull(@Name,'')<>'')
    update qcghead set itemname=@Name where Unid=@unid

  if isnull(@equip,'')=''
    update qcghead set equip=@COMMWORD where Unid=@unid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--20140906性别自定义
if not exists (select 1 from CommCode where TypeName='性别')
begin
  insert into CommCode (typename,id,name,sysname) values ('性别','0','未知的性别','LIS')
  insert into CommCode (typename,id,name,sysname) values ('性别','1','男','LIS')
  insert into CommCode (typename,id,name,sysname) values ('性别','2','女','LIS')
  insert into CommCode (typename,id,name,sysname) values ('性别','5','女变男','LIS')
  insert into CommCode (typename,id,name,sysname) values ('性别','6','男变女','LIS')
  insert into CommCode (typename,id,name,sysname) values ('性别','9','未说明的性别','LIS')
end
GO

--20150201软件过期时间
if not exists (select 1 from CommCode where TypeName='系统代码' and Remark='软件过期时间')
  insert into CommCode (typename,id,name,remark,sysname) values ('系统代码','0005','B6BB07900F8E5B81BBDEC78B685A68B8','软件过期时间','LIS')
GO

--20150517
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TRIGGER_Lsh_Verify_Con]') and OBJECTPROPERTY(id, N'IsTrigger') = 1) 
  drop trigger [dbo].[TRIGGER_Lsh_Verify_Con]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TRIGGER_Lsh_Verify]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
  drop trigger [dbo].[TRIGGER_Lsh_Verify]
GO

--存储过程pro_MergeRequestBill创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pro_MergeRequestBill]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
  drop procedure [dbo].[pro_MergeRequestBill]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--根据病历号、样本类型、样本分隔符合并申请单
--满足以下条件的申请单才参与合并
--1、从接口传入的申请单；2、病历号不为空
--20151202越秀中医PEIS要求采样时间一样的才合并
CREATE PROCEDURE [dbo].[pro_MergeRequestBill] 
AS

  DECLARE Cur_WaitMergeRequestBill Cursor For 
	select min(cch.unid) as unid,
               cch.caseno,
               isnull(cbi.specimentype_DfValue,'') as specimentype_DfValue,
               isnull(cbi.itemtype,'') as itemtype,
	       isnull(cvh.TakeSampleTime,0) as TakeSampleTime
        from chk_con_his cch
        inner join chk_valu_his cvh on cch.unid=cvh.pkunid
        inner join combinitem cbi on cbi.id=cvh.pkcombin_id
        where isnull(cch.his_unid,'')<>''--表示接口传入的申请单
        and 
        isnull(cch.caseno,'')<>''--表示有病历号的申请单
        and (select count(*) from chk_valu_his cvh2 where cvh2.pkunid=cch.unid and isnull(cvh2.itemvalue,'')='1')<=0--表示未被LIS取过的申请单
        group by cch.caseno,isnull(cbi.specimentype_DfValue,''),isnull(cbi.itemtype,''),isnull(cvh.TakeSampleTime,0)

  Open Cur_WaitMergeRequestBill

  Declare @Unid int,@CaseNo varchar(30),@SpecimenType varchar(60),@ItemType varchar(50),@TakeSampleTime datetime
  FETCH NEXT FROM Cur_WaitMergeRequestBill INTO @Unid,@CaseNo,@SpecimenType,@ItemType,@TakeSampleTime
  WHILE @@FETCH_STATUS=0
  BEGIN
    update chk_valu_his set pkunid=@Unid where valueid in (
	select cvh.valueid
        from chk_con_his cch
        inner join chk_valu_his cvh on cch.unid=cvh.pkunid
        inner join combinitem cbi on cbi.id=cvh.pkcombin_id
        where isnull(cch.his_unid,'')<>''--表示接口传入的申请单
        and 
        isnull(cch.caseno,'')<>''--表示有病历号的申请单
        and (select count(*) from chk_valu_his cvh2 where cvh2.pkunid=cch.unid and isnull(cvh2.itemvalue,'')='1')<=0--表示未被LIS取过的申请单
        --非当前申请单
        and cch.unid<>@Unid
        --病历号、样本类型、样本分隔符、采样时间一样的合并
        and cch.caseno=@CaseNo and isnull(cbi.specimentype_DfValue,'')=isnull(@SpecimenType,'') and isnull(cbi.itemtype,'')=isnull(@ItemType,'') and isnull(cvh.TakeSampleTime,0)=isnull(@TakeSampleTime,0)
      )
      
    FETCH NEXT FROM Cur_WaitMergeRequestBill INTO @Unid,@CaseNo,@SpecimenType,@ItemType,@TakeSampleTime
  END
  CLOSE Cur_WaitMergeRequestBill
  DEALLOCATE Cur_WaitMergeRequestBill

  --删除无明细(组合项目)的主记录
  delete from chk_con_his 
  where isnull(chk_con_his.his_unid,'')<>''--表示接口传入的申请单
  and 
  isnull(chk_con_his.caseno,'')<>''--表示有病历号的申请单
  and (select count(*) from Chk_Valu_His cvh where cvh.PkUnid=chk_con_his.Unid)=0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--存储过程pro_SplitRequestBill创建脚本
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pro_SplitRequestBill]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
  drop procedure [dbo].[pro_SplitRequestBill]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--根据样本类型、样本分隔符拆分申请单
--满足以下条件的申请单才参与拆分
--1、从接口传入的申请单；
--20151202越秀中医PEIS要求按采样时间拆开
CREATE PROCEDURE [dbo].[pro_SplitRequestBill] 
AS

  DECLARE Cur_WaitSplitRequestBill Cursor For 
	select cch.unid
        from chk_con_his cch
        where isnull(cch.his_unid,'')<>''--表示接口传入的申请单
        and 
        (select count(*) from chk_valu_his cvh2 where cvh2.pkunid=cch.unid and isnull(cvh2.itemvalue,'')='1')<=0--表示未被LIS取过的申请单

  Open Cur_WaitSplitRequestBill

  Declare @Unid int
  FETCH NEXT FROM Cur_WaitSplitRequestBill INTO @Unid
  WHILE @@FETCH_STATUS=0
  BEGIN
    declare @Num_Value int

    select @Num_Value=count(*) from chk_valu_his where pkunid=@Unid
    if @Num_Value<=0 
    begin
      FETCH NEXT FROM Cur_WaitSplitRequestBill INTO @Unid
      continue
    end

    SELECT @Num_Value=COUNT(*) FROM
	(
	select 0 as A
	from chk_valu_his cvh3 
	    inner join combinitem cbi3 on cbi3.id=cvh3.pkcombin_id
	    where cvh3.pkunid=@Unid
	    group by isnull(cbi3.specimentype_DfValue,''),isnull(cbi3.itemtype,''),isnull(cvh3.TakeSampleTime,0)
	) as TempA
    if @Num_Value<=1
    begin
      update chk_con_his set chk_con_his.flagetype=
	(select top 1 cbi.specimentype_DfValue from chk_valu_his cvh,combinitem cbi where cvh.pkunid=chk_con_his.unid and cbi.id=cvh.pkcombin_id) 
	where unid=@Unid
	and isnull(chk_con_his.flagetype,'')<>
	(select top 1 isnull(cbi.specimentype_DfValue,'') from chk_valu_his cvh,combinitem cbi where cvh.pkunid=chk_con_his.unid and cbi.id=cvh.pkcombin_id) 
      FETCH NEXT FROM Cur_WaitSplitRequestBill INTO @Unid
      continue
    end
    
    DECLARE Cur_1 Cursor For 
	select isnull(cbi3.specimentype_DfValue,''),isnull(cbi3.itemtype,''),isnull(cvh3.TakeSampleTime,0)
	from chk_valu_his cvh3 
	    inner join combinitem cbi3 on cbi3.id=cvh3.pkcombin_id
	    where cvh3.pkunid=@Unid
	    group by isnull(cbi3.specimentype_DfValue,''),isnull(cbi3.itemtype,''),isnull(cvh3.TakeSampleTime,0)

    Open Cur_1
    Declare @specimentype_DfValue varchar(60),@itemtype varchar(50),@i int,@SCOPE_IDENTITY int,@TakeSampleTime datetime
    set @i=0
    FETCH NEXT FROM Cur_1 INTO @specimentype_DfValue,@itemtype,@TakeSampleTime
    WHILE @@FETCH_STATUS=0
    BEGIN
      set @i=@i+1
      if @i=1
      begin
        update chk_con_his set flagetype=@specimentype_DfValue where unid=@Unid and isnull(flagetype,'')<>@specimentype_DfValue
        FETCH NEXT FROM Cur_1 INTO @specimentype_DfValue,@itemtype,@TakeSampleTime
        continue
      end

      insert into chk_con_his (patientname,flagetype,sex,age,report_date,bedno,His_Unid,check_doctor,deptname,combin_id,Caseno,diagnose,Diagnosetype,typeflagcase,WorkCompany,WorkDepartment,ifMarry)  
      	select patientname,flagetype,sex,age,report_date,bedno,His_Unid,check_doctor,deptname,combin_id,Caseno,diagnose,Diagnosetype,typeflagcase,WorkCompany,WorkDepartment,ifMarry from chk_con_his where unid=@Unid
      SELECT @SCOPE_IDENTITY=SCOPE_IDENTITY()
      update chk_valu_his set chk_valu_his.pkunid=@SCOPE_IDENTITY 
	where chk_valu_his.pkunid=@Unid 
	and (select isnull(cbi5.specimentype_DfValue,'') from combinitem cbi5 where cbi5.id=chk_valu_his.pkcombin_id)=@specimentype_DfValue
	and (select isnull(cbi6.itemtype,'') from combinitem cbi6 where cbi6.id=chk_valu_his.pkcombin_id)=@itemtype
        and isnull(chk_valu_his.TakeSampleTime,0)=@TakeSampleTime

      FETCH NEXT FROM Cur_1 INTO @specimentype_DfValue,@itemtype,@TakeSampleTime
    END
    CLOSE Cur_1
    DEALLOCATE Cur_1
      
    FETCH NEXT FROM Cur_WaitSplitRequestBill INTO @Unid
  END
  CLOSE Cur_WaitSplitRequestBill
  DEALLOCATE Cur_WaitSplitRequestBill

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--20150808获取最新流水号
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[uf_GetNextSerialNum]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[uf_GetNextSerialNum]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION uf_GetNextSerialNum
(
  @WorkGroup varchar(30), --工作组
  @CHECK_DATE varchar(10),--检查日期,YYYY-MM-DD
  @Diagnosetype varchar(10) --优先级别
)  
RETURNS varchar(50) AS  
BEGIN 
  --获取最新流水号

  if isnull(@Diagnosetype,'')<>'常规' and isnull(@Diagnosetype,'')<>'急诊' and isnull(@Diagnosetype,'')<>'加急'
    set @Diagnosetype='常规'

  declare @MaxSerialNum varchar(50),@ret varchar(50)

  select @MaxSerialNum=max(right('0000'+lsh,4)) from chk_con 
  WHERE CONVERT(CHAR(10),check_date,121)=@CHECK_DATE
  AND combin_id=@WorkGroup
  and Diagnosetype=@Diagnosetype

  if isnumeric(@MaxSerialNum)=1
    set @ret=right('0000'+cast(cast(@MaxSerialNum as int)+1 as varchar),4)     
  else set @ret='0001'

  return @ret
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_chk_con_PatientInfo_From_HisUnid创建脚本
if exists (select name from sysobjects where name='TRIGGER_chk_con_PatientInfo_From_HisUnid' and type='TR')
  drop TRIGGER TRIGGER_chk_con_PatientInfo_From_HisUnid
go

CREATE TRIGGER TRIGGER_chk_con_PatientInfo_From_HisUnid ON chk_con
FOR Insert,Update
AS
--根据His_Unid从chk_con_his取病人信息
  declare @ChkCon_unid int,@ChkCon_His_Unid varchar(50)
  SELECT @ChkCon_unid=unid,@ChkCon_His_Unid=His_Unid FROM Inserted
  
  if @ChkCon_unid is null return
  if @ChkCon_unid<=0 return
  if @ChkCon_His_Unid is null return
  if @ChkCon_His_Unid='' return

  if not exists(select 1 from chk_con_his where cast(unid as varchar)=@ChkCon_His_Unid) return

  declare @patientname varchar(50),@sex varchar(50),@age varchar(50),@Caseno varchar(50),
          @bedno varchar(50),@deptname varchar(50),@check_doctor varchar(50),
          @report_date datetime,@Diagnosetype varchar(50),@flagetype varchar(100),
          @diagnose varchar(200),@typeflagcase varchar(50),@issure varchar(50),
          @WorkCompany varchar(50),@WorkDepartment varchar(50),@ifMarry varchar(50)

  select @patientname=patientname,@sex=sex,@age=age,@Caseno=Caseno,
         @bedno=bedno,@deptname=deptname,@check_doctor=check_doctor,
         @report_date=report_date,@Diagnosetype=Diagnosetype,@flagetype=flagetype,
         @diagnose=diagnose,@typeflagcase=typeflagcase,@issure=issure,
         @WorkCompany=WorkCompany,@WorkDepartment=WorkDepartment,@ifMarry=ifMarry 
  from chk_con_his 
  where cast(unid as varchar)=@ChkCon_His_Unid

  if exists(select 1 from Deleted)--表示修改
  begin
    update chk_con set 
         patientname=@patientname,sex=@sex,age=@age,Caseno=@Caseno,
         bedno=@bedno,deptname=@deptname,check_doctor=@check_doctor,
         report_date=@report_date,Diagnosetype=@Diagnosetype,flagetype=@flagetype,
         diagnose=@diagnose,/*typeflagcase=@typeflagcase,issure=@issure,*/
         WorkCompany=@WorkCompany,WorkDepartment=@WorkDepartment,ifMarry=@ifMarry 
    where unid=@ChkCon_unid  
  end else--表示插入
  begin
    update chk_con set 
         patientname=@patientname,sex=@sex,age=@age,Caseno=@Caseno,
         bedno=@bedno,deptname=@deptname,check_doctor=@check_doctor,
         report_date=@report_date,Diagnosetype=@Diagnosetype,flagetype=@flagetype,
         diagnose=@diagnose,typeflagcase=@typeflagcase,issure=@issure,
         WorkCompany=@WorkCompany,WorkDepartment=@WorkDepartment,ifMarry=@ifMarry 
    where unid=@ChkCon_unid  
  end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_chk_con_PatientInfo_From_HisUnid_Insert创建脚本
--20151021用TRIGGER_chk_con_PatientInfo_From_HisUnid替代
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_PatientInfo_From_HisUnid_Insert' and type='TR')
  drop TRIGGER TRIGGER_chk_con_PatientInfo_From_HisUnid_Insert
go

/*CREATE TRIGGER TRIGGER_chk_con_PatientInfo_From_HisUnid_Insert ON chk_con
FOR Insert
AS
--根据His_Unid从chk_con_his取病人信息
  declare @ChkCon_unid int,@ChkCon_His_Unid varchar(50)
  SELECT @ChkCon_unid=unid,@ChkCon_His_Unid=His_Unid FROM Inserted
  
  if @ChkCon_unid is null return
  if @ChkCon_unid<=0 return
  if @ChkCon_His_Unid is null return
  if @ChkCon_His_Unid='' return

  if not exists(select 1 from chk_con_his where cast(unid as varchar)=@ChkCon_His_Unid) return

  declare @patientname varchar(50),@sex varchar(50),@age varchar(50),@Caseno varchar(50),
          @bedno varchar(50),@deptname varchar(50),@check_doctor varchar(50),
          @report_date datetime,@Diagnosetype varchar(50),@flagetype varchar(100),
          @diagnose varchar(200),@typeflagcase varchar(50),@issure varchar(50),
          @WorkCompany varchar(50),@WorkDepartment varchar(50),@ifMarry varchar(50)

  select @patientname=patientname,@sex=sex,@age=age,@Caseno=Caseno,
         @bedno=bedno,@deptname=deptname,@check_doctor=check_doctor,
         @report_date=report_date,@Diagnosetype=Diagnosetype,@flagetype=flagetype,
         @diagnose=diagnose,@typeflagcase=typeflagcase,@issure=issure,
         @WorkCompany=WorkCompany,@WorkDepartment=WorkDepartment,@ifMarry=ifMarry 
  from chk_con_his 
  where cast(unid as varchar)=@ChkCon_His_Unid

  update chk_con set 
         patientname=@patientname,sex=@sex,age=@age,Caseno=@Caseno,
         bedno=@bedno,deptname=@deptname,check_doctor=@check_doctor,
         report_date=@report_date,Diagnosetype=@Diagnosetype,flagetype=@flagetype,
         diagnose=@diagnose,typeflagcase=@typeflagcase,issure=@issure,
         WorkCompany=@WorkCompany,WorkDepartment=@WorkDepartment,ifMarry=@ifMarry 
  where unid=@ChkCon_unid  
*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--触发器TRIGGER_chk_con_PatientInfo_From_HisUnid_Update创建脚本
--20151021用TRIGGER_chk_con_PatientInfo_From_HisUnid替代
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select name from sysobjects where name='TRIGGER_chk_con_PatientInfo_From_HisUnid_Update' and type='TR')
  drop TRIGGER TRIGGER_chk_con_PatientInfo_From_HisUnid_Update
go

/*CREATE TRIGGER TRIGGER_chk_con_PatientInfo_From_HisUnid_Update ON chk_con
FOR Update
AS
--根据His_Unid从chk_con_his取病人信息
--1、当His_Unid修改时，取病人信息
--2、表示以下字段不允许修改，只会从CHK_CON_HIS中取
  declare @ChkCon_unid int,@ChkCon_His_Unid varchar(50)
  SELECT @ChkCon_unid=unid,@ChkCon_His_Unid=His_Unid FROM Inserted
  
  if @ChkCon_unid is null return
  if @ChkCon_unid<=0 return
  if @ChkCon_His_Unid is null return
  if @ChkCon_His_Unid='' return

  if not exists(select 1 from chk_con_his where cast(unid as varchar)=@ChkCon_His_Unid) return

  declare @patientname varchar(50),@sex varchar(50),@age varchar(50),@Caseno varchar(50),
          @bedno varchar(50),@deptname varchar(50),@check_doctor varchar(50),
          @report_date datetime,@Diagnosetype varchar(50),@flagetype varchar(100),
          @diagnose varchar(200),
          @WorkCompany varchar(50),@WorkDepartment varchar(50),@ifMarry varchar(50)

  select @patientname=patientname,@sex=sex,@age=age,@Caseno=Caseno,
         @bedno=bedno,@deptname=deptname,@check_doctor=check_doctor,
         @report_date=report_date,@Diagnosetype=Diagnosetype,@flagetype=flagetype,
         @diagnose=diagnose,
         @WorkCompany=WorkCompany,@WorkDepartment=WorkDepartment,@ifMarry=ifMarry 
  from chk_con_his 
  where cast(unid as varchar)=@ChkCon_His_Unid

  update chk_con set 
         patientname=@patientname,sex=@sex,age=@age,Caseno=@Caseno,
         bedno=@bedno,deptname=@deptname,check_doctor=@check_doctor,
         report_date=@report_date,Diagnosetype=@Diagnosetype,flagetype=@flagetype,
         diagnose=@diagnose,
         WorkCompany=@WorkCompany,WorkDepartment=@WorkDepartment,ifMarry=@ifMarry 
  where unid=@ChkCon_unid  
*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--20151205表ApiToken创建脚本
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ApiToken]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
CREATE TABLE ApiToken (
	UserId varchar (20) primary key ,
	Token varchar (50) NOT NULL ,
	Mod_Date_Time datetime NULL ,
	Create_Date_Time datetime NULL DEFAULT (getdate())
) 
GO

--20160422用户访问应用程序记录表(用户信息收集)创建脚本
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AppVisit]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
create table AppVisit
 (Unid int identity primary key,
  SysName varchar (20) NULL,
  PageName varchar (10) NULL,
  IP varchar (20) NULL,
  Customer varchar (50) NULL,
  UserName varchar (20) NULL,
  ActionName varchar (50) NULL,
  ActionTime datetime NULL,
  Remark varchar (100) NULL,
  Reserve varchar(100) NULL,
  Reserve2 varchar (200) NULL,
  Reserve3 varchar (200) NULL,
  Reserve4 varchar (200) NULL,
  Reserve5 int NULL,
  Reserve6 int NULL,
  Reserve7 float NULL,
  Reserve8 float NULL,
  Reserve9 datetime NULL,
  Reserve10 datetime NULL,
  Create_Date_Time datetime NULL DEFAULT (getdate())
)
GO

--重新编译视图
sp_refreshview  'dbo.view_chk_valu_All'
GO
sp_refreshview  'dbo.view_HBV_Value'
GO
sp_refreshview  'dbo.view_UT_LIS_RESULT'
GO
sp_refreshview  'dbo.view_Chk_Con_All'
GO
sp_refreshview  'dbo.view_Show_chk_Con_His'
GO