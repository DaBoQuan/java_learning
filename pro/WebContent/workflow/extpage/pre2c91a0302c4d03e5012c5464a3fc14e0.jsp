<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.eweaver.base.BaseContext" %>
<%@ page import="com.eweaver.base.BaseJdbcDao" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.eweaver.base.msg.EweaverMessage" %>
<%@ page import="com.eweaver.base.msg.EweaverMessageProducer" %>
<%@ page import="com.eweaver.base.util.DateHelper" %>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.remind.base.AbstractNodeRemind" %>
<%@ page import="com.eweaver.workflow.request.model.Messageurl" %>
<%@ page import="com.eweaver.workflow.request.model.Requestbase" %>
<%@ page import="com.eweaver.workflow.request.service.RequestOperatorService" %>
<%@ page import="com.eweaver.workflow.request.service.RequestbaseService" %>
<%@ page import="com.eweaver.workflow.request.service.WorkflowService" %>
<%
//��ǰ��������������ʵ�ʱ�
//��ID:402881172c4885c0012c4936855002bf	�ǹ̶��ʲ��������豸���ϼ�����
//	���:	flowno
//	����:	reqorgid
//	������:	reqman
//	����:	devicename
//	���쳧:	manufactory
//	�豸���:	deviceNO
//	ԭֵ:	originalcost
//	���뱨������:	reason
//	���ż������:	advise1
//	��Ӫ�߻���������:	advise2
//	��Ӫ�߻������ǩ��:	sign2
//	����ǩ��:	sign3
//	���벿��:	reqdept
//	������:	FZdept
//	����:	reqdate
//	����ͺ�:	model
//	��������:	purchasedate
//	�������:	advise3
//---------------------------------------
%>
<%
String requestid= request.getParameter("requestid");
String targeturl = request.getParameter("targeturl");
String operatemode = request.getParameter("operatemode");
//�ύ��
if(operatemode.equals("submit")||operatemode.equals("save")){
		String sql = "";
		BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
		//ִ�и��£���Ҫ������ִ���е�sql
		baseJdbc.update("update uf_device_equipment set equipmentstate='2c91a0302c2fe2d1012c349aa31e0391',dumpingdate='"+DateHelper.getCurrentDate()+"' where requestid in (select devicename from uf_device_scrapfgd where requestid='"+requestid+"')");
}
//�˻�
else if(operatemode.equals("reject"))
{
   

}

%>
<%
targeturl="/workflow/request/close.jsp?mode=submit";
%>
<script>
var commonDialog=top.leftFrame.commonDialog;

if(commonDialog){
 var frameid=parent.contentPanel.getActiveTab().id+'frame';
 var tabWin=parent.Ext.getDom(frameid).contentWindow;
 if(!commonDialog.hidden)
{
commonDialog.hide();
tabWin.location.reload();
}
 else
{

tabWin.location.href="<%=targeturl%>";
}

}
</script>


