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
//��Ʒ-������ϸ uf_gift_receive_dt
//��Ʒ-��Ʒ����-������ϸ	ID:4028818230935a7d0130960250300003
//	��Ʒ����:	gifttype
//	���:	norms
//	��������:	belongdept
//	����:	unitprice
//	С��:	subtotal
//	�ֿ�����:	whname
//	����:	relations
//	��������:	applyno
//	����г��:	relmarket
//	��Ʒ����:	giftname
//	���:	stock
//��Ʒ-�������� uf_gift_receive
//��Ʒ-��Ʒ����-����	ID:4028818230935a7d013095fe4c0d0002
//	��������:	reqtime
//	������:	reqman
//	���벿��:	reqdept
//	�ܼ�:	sumprice
//	��ʵ����:	realreason
//	��ȡ��ʽ:	getway
//	ǩ�����:	relsign
//	���뵥��:	flowno
//	����:	title
//	��������:	reasonfor
//	�Ƿ��ܾ�������:	ismanager
//---------------------------------------
//����:uf_gift_store 
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


if(operatemode.equals("submit")){

    BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
    String sql="select  giftname,whname,belongdept,applyno from uf_gift_receive_dt  where  requestid='"+requestid+"'";
    List list = baseJdbc.executeSqlForList(sql);
    for(int i=0;i<list.size();i++){
	    Map map = new HashMap();
	    map = (Map)list.get(i);
	    String giftname=StringHelper.null2String(map.get("giftname"));
	    String whname=StringHelper.null2String(map.get("whname"));
	    String belongdept=StringHelper.null2String(map.get("belongdept"));
	    Integer applyno=Integer.parseInt(StringHelper.null2String(map.get("applyno")));

	    String SqlUpdate="update uf_gift_store set rnumber=(rnumber-"+applyno+") where id='"+giftname+"'and  whname='"+whname+"' and bdept='"+belongdept+"' ";
	    baseJdbc.update(SqlUpdate);
           
    }


}



if(!StringHelper.isEmpty(otherextpages)){
		if(otherextpages.indexOf("/workflow/extpage/")<0)
			otherextpages = "/workflow/extpage/"+otherextpages;
		otherextpages += "?requestid="+StringHelper.null2String(requestid)

+"&operatemode="+operatemode+"&directnodeid="+directnodeid+"&targeturl="+URLEncoder.encode(targeturl);
		response.sendRedirect(otherextpages);
		return;
	}
targeturl="/workflow/request/close.jsp?mode=submit&requestname="+StringHelper.getEncodeStr("��Ʒ����")+"&requestid="+requestid;
%>

<script>
 window.location.href="<%=targeturl%>";
</script>

