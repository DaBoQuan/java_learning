<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.eweaver.base.BaseJdbcDao"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.BaseContext" %>
<%@ page import="com.eweaver.base.label.service.LabelService" %>
<%@ page import="com.eweaver.base.security.service.acegi.EweaverUser" %>
<%@ page import="com.eweaver.humres.base.model.Humres" %>
<%@ page import="com.eweaver.humres.base.service.HumresService" %>
<%@ page import="com.eweaver.base.setitem.service.SetitemService"%>
<%@ page import="com.eweaver.base.util.DateHelper"%>

<%
        System.out.println("��ʫ**************************************************");
		BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
		String cktype=StringHelper.null2String(request.getParameter("cktype"));//��������
		String feetype=StringHelper.null2String(request.getParameter("feetype"));//��������
		String supcode=StringHelper.null2String(request.getParameter("supcode"));//��Ӧ�̼���
		String zgcurr=StringHelper.null2String(request.getParameter("zgcurr"));//�ݹ�����
		String area=StringHelper.null2String(request.getParameter("area"));//������
		String comtype=StringHelper.null2String(request.getParameter("comtype"));//��˾��
		String jbman=StringHelper.null2String(request.getParameter("jbman"));//������
		String taxcode=StringHelper.null2String(request.getParameter("taxcode"));//˰��
		String bgdegin=StringHelper.null2String(request.getParameter("bgdegin"));//������
		String bgend=StringHelper.null2String(request.getParameter("bgend"));//����ֹ
		String delsql="delete from uf_tr_exdzdetailf";
		baseJdbc.update(delsql);
		System.out.println(cktype);
		System.out.println(feetype);
		String sql="";
		int no=0;
		if(cktype.equals("40285a90497a8f7801497d7b4cbd0032"))//����
		{
			String sqlwhere="";
			sqlwhere=sqlwhere+" and f.payto='"+supcode+"' and f.currency='"+zgcurr+"' and b.factory='"+area+"'";
			if(!comtype.equals(""))
			{
				sqlwhere=sqlwhere+" and b.comname='"+comtype+"'";
			}
			if(!taxcode.equals(""))
			{
				sqlwhere=sqlwhere+" and f.taxcode='"+taxcode+"'";
			}
			if(!bgdegin.equals(""))
			{
				sqlwhere=sqlwhere+" and c.notifydate>='"+bgdegin+"'";
			}
			if(!bgend.equals(""))
			{
				sqlwhere=sqlwhere+" and c.notifydate<='"+bgend+"'";
			}
			if(feetype.equals("40285a8d51cc34e10151cc527339002a"))//����
			{
				//���ڱ�� �ᵥ�� Ԥ�ƽ������ �������� ���� Ŀ�ĸ� ���� ���� ���� ë�� �������� ���� ��˰��� δ˰��� ��˰���� δ˰���� �ɱ����� ˰�� ���۶����� ���ƾ֤ 
				//uf_tr_feesea ���ڷ����ݹ�-���˷�  7���� 8���� 9���� 13 δ˰��� 14 δ˰���� 15 �ⶥ���
				//uf_tr_feetentative ���ڷ����ݹ�����
				//uf_tr_expboxmain �������絥��  1���ڱ�� 2�ᵥ�� 3Ԥ�ƽ������ 4�������� 5���� 6Ŀ�ĸ� 18 ���۶�����
				//uf_tr_shipment �������絥-������ϸ 16 �ɱ�����
				//uf_tr_packtype �������絥-װ�䷽ʽ 10ë�� 
				//uf_tr_feedivvy ���ڷ����ݹ�-���÷�̯ 11�������� 12 ���� 17 ˰�� 
				//uf_tr_exfeedtdivvy ���ڻ����ϸ-���÷�̯��ϸ
				//uf_tr_exfeetentdtmain ���ڷ��û����ϸ��  19���ƾ֤��
				sql="select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,a.cabtype,a.cabnum,a.nw,e.gw,f.feetype,f.currency,a.notaxvalue,a.notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feesea a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join (select requestid,cabtype,sum(gw) gw from uf_tr_packtype group by requestid,cabtype ) e on c.requestid=e.requestid and a.cabtype=e.cabtype inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype=a.freighttype and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere;
			}
			else if(feetype.equals("40285a8d51cc34e10151cc52733a002b"))//����
			{
				//���ڱ�� �ᵥ�� Ԥ�ƽ������ �������� ���˸� Ŀ�ĸ� ���� ���� ���� ë�� �������� ���� ��˰��� δ˰��� ��˰���� δ˰���� �ⶥ��� �ɱ����� ˰�� ���۶����� ���ƾ֤
				sql="select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,a.cabtype,a.cabnum,a.nw,e.gw,f.feetype,f.currency,a.notaxvalue,a.notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feefreight a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join (select requestid,cabtype,sum(gw) gw from uf_tr_packtype group by requestid,cabtype ) e on c.requestid=e.requestid and a.cabtype=e.cabtype inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype=a.freighttype and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210')";
				sql=sql+sqlwhere;
				sql=sql+"union all (";
				//����
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,'' cabtype,null as cabnum,a.nw,null as gw,f.feetype,f.currency,a.amount notaxvalue,a.feetax notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,(select topamount from uf_tr_customsexp  ap where ap.freightcode='"+supcode+"' and ap.imexptype='40285a90497a8f7801497d7b4cbd0032' and (ap.cabinet=a.cabtype or (ap.cabinet<>a.cabtype and ap.cabinet='����')) and ap.factory='"+area+"' and 0=(select isdelete from formbase where id=ap.requestid) and ap.status='40285a8d4f5ef62f014f62573ca0038e' and ap.begindate<=c.closedate and c.closedate<=ap.enddate) fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feeclearance a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d4de019da014de0bbe98255c2' and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere;
				sql=sql+") union all (";
				//�ļ�
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,'' cabtype,null as cabnum,'' nw,null as gw,f.feetype,f.currency,a.amount notaxvalue,'' notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feefile a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d4de019da014de0bbe8d4555f' and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere;
				sql=sql+") union all (";
				//���
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,'' cabtype,null as cabnum,'' nw,null as gw,f.feetype,f.currency,a.amount notaxvalue,'' notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feeelecty a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d4de019da014de0bbe95855ac' and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere;
				sql=sql+") union all (";
				//�̼�Σ������֤�� uf_tr_feesjwbcdz
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,'' cabtype,null as cabnum,'' nw,null as gw,f.feetype,f.currency,a.amount notaxvalue,'' notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feesjwbcdz a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype=(select fy.requestid from uf_tr_fymcwhd fy left join formbase bas on fy.requestid=bas.id where fy.costname=a.feetype and fy.importandexport='40285a90497a8f7801497d7b4cbd0032' and bas.isdelete=0) and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere;
				sql=sql+") union all (";
				//Σ�걨��
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,'' cabtype,null as cabnum,'' nw,null as gw,f.feetype,f.currency,a.amount notaxvalue,'' notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feedanger a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d4de019da014de0bbe8f4556a' and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere;
				sql=sql+") union all (";
				//���⺽�߷�
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,'' cabtype,null as cabnum,'' nw,null as gw,f.feetype,f.currency,a.amount notaxvalue,'' notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feeairline a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d4faf85e1014fb0fba9f1334b' and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere;
				sql=sql+") union all (";
				//��֤����
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,c.departure,c.destport,'' cabtype,null as cabnum,'' nw,null as gw,f.feetype,f.currency,a.amount notaxvalue,'' notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,'' suminsured,'' factor,'' covercurrency,'' hl,'' notaxinsure,'' lowestinsure from uf_tr_feeczm a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d5122d2fa01513c7c0b2938ad' and f.currency=a.currency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210') ";
				sql=sql+sqlwhere+")";

			}
			else//���� ��Ͷ�����ַ�̯
			{
				//���ڱ�� �ᵥ�� Ԥ�ƽ������ �������� ���˸� Ŀ�ĸ� ���� ���� ���� ë�� �������� ���� ��˰��� δ˰��� ��˰���� δ˰���� �ⶥ��� �ɱ����� ˰�� ���۶����� ���ƾ֤
				//���ڱ�� �ᵥ�� Ԥ�ƽ������ �������� �������� ���� ϵ�� δ˰���� ���� δ˰��� Ͷ������ ���� δ˰���ѽ�� ��ͱ��ѽ�� �ɱ����� ˰�� ���۶����� �����ϸ 
				//ˮ��
				sql="select c.expno,c.deliveryno,c.closedate,c.notifydate,'' departure,'' destport,'' cabtype,'' as cabnum,'' nw,'' as gw,f.feetype,f.currency as covercurrency,a.notaxsum notaxvalue,a.notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,a.suminsured,a.factor,a.currency,a.rate as hl,a.notaxinsure,a.lowestinsure from uf_tr_feewater a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d4de019da014de0bbe9055575' and f.currency=a.covercurrency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210')";
				sql=sql+sqlwhere;
				sql=sql+"union all (";
				//����԰
				sql=sql+"select c.expno,c.deliveryno,c.closedate,c.notifydate,'' departure,'' destport,'' cabtype,'' as cabnum,'' nw,'' as gw,f.feetype,f.currency as covercurrency,a.notaxsum notaxvalue,a.notaxfee,d.costctr,f.taxcode,c.salepzno,h.hadcreate,'' fdje,a.suminsured,a.factor,a.currency,a.rate as hl,a.notaxinsure,a.lowestinsure from uf_tr_feelogis a inner join uf_tr_feetentative b on a.requestid=b.requestid inner join uf_tr_expboxmain c on b.noticeno=c.requestid inner join (select requestid,wm_concat(distinct(costctr)) costctr from uf_tr_shipment group by requestid)  d on c.requestid=d.requestid inner join uf_tr_feedivvy f on f.requestid=b.requestid and f.feetype='40285a8d4de019da014de0bbe8c35554' and f.currency=a.covercurrency inner join uf_tr_exfeedtdivvy g on g.zgid=f.id inner join uf_tr_exfeetentdtmain h on h.requestid=g.requestid left join formbase re1 on re1.id=a.requestid left join requestbase re2 on re2.id=c.requestid left join requestbase re3 on re3.id=h.requestid where 0=re1.isdelete and 0=re2.isdelete and 0=re3.isdelete and (b.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (h.isvalid is null or b.isvalid='40288098276fc2120127704884290210') and (c.isvalid is null or c.isvalid='40288098276fc2120127704884290210')";
				sql=sql+sqlwhere;
				sql=sql+")";
			}
			System.out.println(sql);
			List list = baseJdbc.executeSqlForList(sql);
			Map map=null;
			if(list.size()>0){
				for(int k=0;k<list.size();k++)
				{
					map = (Map)list.get(k);
					String expno=StringHelper.null2String(map.get("expno"));//���ڱ��
					String deliveryno=StringHelper.null2String(map.get("deliveryno"));//�ᵥ��
					String closedate=StringHelper.null2String(map.get("closedate"));//Ԥ�ƽ������
					String notifydate=StringHelper.null2String(map.get("notifydate"));//��������
					String departure=StringHelper.null2String(map.get("departure"));//���˸�
					String destport=StringHelper.null2String(map.get("destport"));//Ŀ�ĸ�
					String cabtype=StringHelper.null2String(map.get("cabtype"));//����
					String cabnum=StringHelper.null2String(map.get("cabnum"));//����
					String nw=StringHelper.null2String(map.get("nw"));//����
					String gw=StringHelper.null2String(map.get("gw"));//ë��
					String feetype1=StringHelper.null2String(map.get("feetype"));//��������
					String currency=StringHelper.null2String(map.get("currency"));//����
					String notaxvalue=StringHelper.null2String(map.get("notaxvalue"));//δ˰���
					String notaxfee=StringHelper.null2String(map.get("notaxfee"));//δ˰����
					String costctr=StringHelper.null2String(map.get("costctr"));//�ɱ�����
					String taxcode1=StringHelper.null2String(map.get("taxcode"));//˰��
					String salepzno=StringHelper.null2String(map.get("salepzno"));//����ƾ֤��
					String hadcreate=StringHelper.null2String(map.get("hadcreate"));//���ƾ֤
					String fdje=StringHelper.null2String(map.get("fdje"));//�ⶥ���
					String suminsured=StringHelper.null2String(map.get("suminsured"));//����
					String factor=StringHelper.null2String(map.get("factor"));//ϵ��
					String covercurrency=StringHelper.null2String(map.get("covercurrency"));//Ͷ������
					String hl=StringHelper.null2String(map.get("hl"));//����
					String notaxinsure=StringHelper.null2String(map.get("notaxinsure"));//δ˰���ѽ��
					String lowestinsure=StringHelper.null2String(map.get("lowestinsure"));//��󱣷ѽ��
					String taxvalue="";
					String taxfee="";
					no++;
					//40285a8d51e694c20151e70b57100aa4
					String tcodesql="select taxtype,taxrate from uf_oa_taxcode where taxcode='"+taxcode1+"' and 0=(select isdelete from formbase where id=requestid)";
					List list1 = baseJdbc.executeSqlForList(tcodesql);
					Map map1=null;
					String taxtype="";
					String taxrate="0";
					if(list1.size()>0){
						map1 = (Map)list1.get(0);
						taxtype=StringHelper.null2String(map1.get("taxtype"));
						taxrate=StringHelper.null2String(map1.get("taxrate"));
					}
					//���� δ˰=��˰/1+˰��
					//���� δ˰=��˰*1-˰��	
					if(taxtype.equals("40285a9048f924a70148fe66247a0dc9"))//����˰
					{
						Double a=Double.valueOf(notaxvalue)*(100+Double.valueOf(taxrate))/100;
						Double b=Double.valueOf(notaxfee)*(100+Double.valueOf(taxrate))/100;
						DecimalFormat df = new DecimalFormat("#0.00");   
						taxvalue =String.valueOf( df.format(a)); 
						taxfee = String.valueOf(df.format(b)); 
						
					}
					else
					{
						Double c=Double.valueOf(notaxvalue)*100/(100-Double.valueOf(taxrate));
						Double d=Double.valueOf(notaxfee)*100/(100-Double.valueOf(taxrate));
						DecimalFormat df = new DecimalFormat("#0.00");   
						taxvalue =String.valueOf( df.format(c)); 
						taxfee = String.valueOf(df.format(d)); 
					}
					String insql="insert into uf_tr_exdzdetailf (id,requestid,no,exnum,tdnum,yjjgdate,bgdate,gygang,mdgang,cabitype,cabnum,netvalue,roughvalue,feetype,curr,taxamount,notaxamount,taxrate,notaxrate,costcen,taxcode,saleno,kjpzno,jbname,fdje,baoe,xishu,tbcurr,hl,wsbaoe,zdbaoe)values((select sys_guid() from dual),'40285a8d51e694c20151e70b57100aa4',"+no+",'"+expno+"','"+deliveryno+"','"+closedate+"','"+notifydate+"','"+departure+"','"+destport+"','"+cabtype+"','"+cabnum+"','"+nw+"','"+gw+"','"+feetype1+"','"+currency+"','"+taxvalue+"','"+notaxvalue+"','"+taxfee+"','"+notaxfee+"','"+costctr+"','"+taxcode1+"','"+salepzno+"','"+hadcreate+"','','"+fdje+"','"+suminsured+"','"+factor+"','"+covercurrency+"','"+hl+"','"+notaxinsure+"','"+lowestinsure+"')";
					//System.out.println(insql);
					baseJdbc.update(insql);
				}
			}

		}
		else//����
		{
			sql = "";
			//����
			//���ڵ������ �ᵥ�� �������� ���˸� Ŀ�ĸ� ���� ���� ���� ë�� �������� ���� ��˰��� δ˰��� ��˰���� δ˰���� �ɱ����� ˰��  ������ 
			//���� 
			//���ڵ������ �ᵥ�� �������� ���˸� Ŀ�ĸ� ���� ���� ���� ë�� �������� ���� ��˰��� δ˰��� ��˰���� δ˰���� �ⶥ��� �ɱ����� ˰�� ������
			//���� 
			//���ڵ������ �ᵥ�� �������� �������� ���� ϵ�� δ˰���� ���� δ˰��� Ͷ������ ���� δ˰���ѽ�� ��ͱ��ѽ�� �ɱ����� ˰�� ������


		}

		
%>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               