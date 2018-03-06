<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.eweaver.base.security.service.acegi.EweaverUser" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.eweaver.base.msg.*"%>
<%
//---------------------------------------
String requestid= request.getParameter("requestid");
String targeturl = request.getParameter("targeturl");
String operatemode = request.getParameter("operatemode");
String otherextpages = StringHelper.null2String(request.getParameter("otherextpages"));
String directnodeid = StringHelper.null2String(request.getParameter("directnodeid"));
String userId = BaseContext.getRemoteUser().getId();
DataService dataService = new DataService();
BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
//�ύ��
if(operatemode.equals("submit")||operatemode.equals("save")){
	String sql = "select mainbodyattach from uf_doc_ratifymain where requestid='"+requestid+"'";
	List checklist= baseJdbc.executeSqlForList(sql);
	if(checklist.size()>0){
		Map m1 = (Map)checklist.get(0);
        String docId = StringHelper.null2String(m1.get("mainbodyattach"));
      	//ɾ���༭Ȩ��
        String permissionSQL = "update permissiondetail set opttype=3 where objid='"+docId+"' and userid='"+userId+"' and opttype>14";
        dataService.executeSql(permissionSQL);
        //����ǩ��
		EweaverMessageProducer producer = (EweaverMessageProducer) BaseContext.getBean("eweaverMessageProducer");
		EweaverMessage msg = new EweaverMessage();
		Map map = new HashMap();
		map.put("docId",docId);//�ĵ�ID
		map.put("nodeNO",3);//�ڵ���(��Ӧ�����е�5���ڵ㣬1Ϊ�����ڵ㣬5δ��ӡ�ڵ㣬2��3��4Ϊ�����ڵ�)
		map.put("userId",userId);//��ǰ�ڵ������ID
		msg.setParaMap(map);
		msg.setMsgtype(EweaverMessage.MESSAGE_TYPE_USER);
		msg.setUserKey("signatureMessage");
		producer.send(msg);
	}
	
	if(!StringHelper.isEmpty(otherextpages)){
		otherextpages = "/workflow/extpage/"+otherextpages;
		otherextpages += "?requestid="+StringHelper.null2String(requestid)+"&operatemode="+operatemode+"&directnodeid="+directnodeid+"&targeturl="+URLEncoder.encode(targeturl);
		response.sendRedirect(otherextpages);
		return;
	}
}

targeturl="/workflow/request/close.jsp?mode=submit";
%>
<script>
var commonDialog=top.leftFrame.commonDialog;
if(commonDialog){
	var frameid=parent.contentPanel.getActiveTab().id+'frame';
	var tabWin=parent.Ext.getDom(frameid).contentWindow;
	if(!commonDialog.hidden){
		commonDialog.hide();
		tabWin.location.reload();
	}else{
		tabWin.location.href="<%=targeturl%>";
	}
}
</script>

