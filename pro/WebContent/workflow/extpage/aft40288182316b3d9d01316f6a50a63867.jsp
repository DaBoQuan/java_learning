<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.eweaver.base.IDGernerator"%>
<%@page import="com.eweaver.humres.base.dao.HumresDao"%>
<%@page import="com.eweaver.base.util.StringHelper"%>
<%@page import="com.eweaver.base.util.NumberHelper"%>
<%@page import="com.eweaver.humres.base.model.Humres"%>
<%@page import="com.eweaver.base.BaseContext"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.eweaver.base.BaseJdbcDao"%>
<%@page import="com.eweaver.base.security.service.acegi.EweaverUser"%>
<%@page import="com.eweaver.base.util.DateHelper"%>
<%@page import="com.eweaver.base.DataService"%>
<%@page import="com.eweaver.workflow.request.service.RequestbaseService"%>
<%
//��ǰ�������������ǳ����
//��Ʒ-��Ʒ����-������ϸ	ID:40288182309608260130960e2b0a0005
//��Ʒ������ϸ��:uf_gift_storeout_dt
//	��Ʒ����:	giftname
//	��Ʒ����:	gifttype
//	���:	norms
//	��������:	belongdept
//	����:	unitprice
//	С��:	subtotal
//	����:	relations
//	�ֿ�����:	whname
//	��ע:	remarks
//	��������:	applyno
//	ԭ��:	reason
//	���:	safeline
//��Ʒ-��Ʒ����-����	ID:40288182309608260130960debde0004
//��Ʒ��������:uf_gift_storeout
//	���ⵥ��:	flowno
//	��ȡ��ʽ:	getway
//	������:	req
//	���벿��:	reqdept
//	����:	reason
//	��ʵ����:	realreason
//	��������:	dealtime
//	������Ա:	dealer
//---------------------------------------

//---------------------------------------
//��Ҫ���¿���:uf_gift_store 
//��Ʒ����:  giftname
//��Ʒ����:  gifttype
//���:  norms
//�ֿ�����:  whname
//��������:  bdept
//�������:  storeno
////����:  price
//�Ƿ�˾�ƶ�:  isxxx
//�����:  total
//����ۼ�:  numin
//�����ۼ�:  numout
//����������:  rnumber

String targeturl = StringHelper.null2String(request.getParameter("targeturl"));
String operatemode = StringHelper.null2String(request.getParameter("operatemode"));
String otherextpages = StringHelper.null2String(request.getParameter("otherextpages"));
String requestid= StringHelper.null2String(request.getParameter("requestid"));
String directnodeid = StringHelper.null2String(request.getParameter("directnodeid"));
EweaverUser newUser = BaseContext.getRemoteUser();
String newuserid = newUser.getId();
DataService dataService = new DataService();
String gdate=DateHelper.getCurrentDate();
String gtime=DateHelper.getCurrentTime();
String gift="";


if(operatemode.equals("submit")){

    BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");

    String sql="select  giftname,whname,belongdept,applyno,subtotal  from uf_gift_storeout_dt   where requestid='"+requestid+"'";
    List list = baseJdbc.executeSqlForList(sql);
    for(int i=0;i<list.size();i++){
	    Map map = new HashMap();
	    map = (Map)list.get(i);
	    String giftname=StringHelper.null2String(map.get("giftname"));
               String sqlselect="select giftname as gift from outstore where requestid='"+giftname+"'";
               List listname = baseJdbc.executeSqlForList(sqlselect);
               if(listname.size()>0)
               {
               Map mapname = new HashMap();
	    mapname = (Map)listname.get(0);
	    gift=StringHelper.null2String(mapname.get("gift"));
               }



               String txtitle=gift+"��Ʒ�������";
               String whname=StringHelper.null2String(map.get("whname"));
	    String belongdept=StringHelper.null2String(map.get("belongdept"));	    
	    Integer applyno=Integer.parseInt(StringHelper.null2String(map.get("applyno")));
	    Double subtotal=Double.parseDouble(StringHelper.null2String(map.get("subtotal")));

	    String SqlUpdate="update uf_gift_store set storeno=(storeno-"+applyno+"),total=(total-"+subtotal+"),rnumber=(rnumber-"+applyno+"),numout=(nvl(numout,0)+"+applyno+") where id='"+giftname+"' and  whname='"+whname+"' and bdept='"+belongdept+"'";
	    baseJdbc.update(SqlUpdate);   


    String selectstore="select a.bdept,a.giftname,sum(storeno) as sumstoreno,b.safeline as sumsafeline from uf_gift_store a,uf_gift_safe_dt b where a.bdept=b.belongdept and a.giftname=b.giftname and a.id='"+giftname+"' and a.bdept='"+belongdept+"' group by a.bdept,a.giftname,b.safeline";   
    List list1 = baseJdbc.executeSqlForList(selectstore);
    if(list1.size()>0)
    {
    Map map1 = new HashMap();
    map1 = (Map)list1.get(0);
    int sumstoreno=NumberHelper.string2Int(map1.get("sumstoreno"),0);
    int sumsafeline=NumberHelper.string2Int(map1.get("sumsafeline"),0);
    String txnr="���ã�"+gift+"��Ʒ�����Ϊ"+StringHelper.null2String(sumstoreno)+"���ѵ����䰲ȫ�����"+StringHelper.null2String(sumsafeline)+"���뼰ʱ�����棬лл��"; 
    String txURL="/app/bom/bomredirect.jsp?type=lp"; 
    if(sumstoreno<sumsafeline)
    {

     if(belongdept.equals("4028818231402b05013141f634690cdc"))
     {
     String selectman="select a.id,a.objname from humres a,sysuser b, sysuserrolelink c,sysrole d where a.id=b.objid and b.id=c.userid and c.roleid=d.id and c.roleid='4028818230929f5701309325531b0123' and c.rolelevel='HRMDEPARTMENTECOLOGYAA0000000004'";
     List list2 = baseJdbc.executeSqlForList(selectman);
     for(int j=0;j<list2.size();j++){
     	    Map map2 = new HashMap();
	    map2 = (Map)list2.get(j);
	    String humresid=StringHelper.null2String(map2.get("id"));
	    String SqlInsert = "insert into uf_configuration_xx(id,requestid,txtitle,txnr,txopera,txDate,txURL,txrequestid,txifoper,txremindtype,txtop,txtodo)  values('"+IDGernerator.getUnquieID()+"','"+IDGernerator.getUnquieID()+"','"+txtitle+"','"+txnr+"','"+humresid+"','"+gdate+"','"+txURL+"','"+requestid+"','0','��Ʒ���Ԥ��','0','0')";
    baseJdbc.update(SqlInsert);
}
}
     else
     {
      String selectman="select a.id,a.objname from humres a,sysuser b, sysuserrolelink c,sysrole d where a.id=b.objid and b.id=c.userid and c.roleid=d.id and c.roleid='4028818230929f5701309325531b0123' and c.rolelevel!='HRMDEPARTMENTECOLOGYAA0000000004'";
     List list2 = baseJdbc.executeSqlForList(selectman);
     for(int j=0;j<list2.size();j++){
     	    Map map2 = new HashMap();
	    map2 = (Map)list2.get(j);
	    String humresid=StringHelper.null2String(map2.get("id"));
	    String SqlInsert = "insert into uf_configuration_xx(id,requestid,txtitle,txnr,txopera,txDate,txURL,txrequestid,txifoper,txremindtype,txtop,txtodo)  values('"+IDGernerator.getUnquieID()+"','"+IDGernerator.getUnquieID()+"','"+txtitle+"','"+txnr+"','"+humresid+"','"+gdate+"','"+txURL+"','"+requestid+"','0','��Ʒ���Ԥ��','0','0')";
    baseJdbc.update(SqlInsert);
    }
     
    }
    

    }


    }

       
    }


}



if(!StringHelper.isEmpty(otherextpages)){
		if(otherextpages.indexOf("/workflow/extpage/")<0)
			otherextpages = "/workflow/extpage/"+otherextpages;
		otherextpages += "?requestid="+StringHelper.null2String(requestid)

+"&operatemode="+operatemode+"&directnodeid="+directnodeid+"&targeturl="+URLEncoder.encode

(targeturl);
		response.sendRedirect(otherextpages);
		return;
	}
targeturl="/workflow/request/close.jsp?mode=submit&requestname="+StringHelper.getEncodeStr("��Ʒ����")+"&requestid="+requestid;
%>

<script>
 window.location.href="<%=targeturl%>";
</script>


