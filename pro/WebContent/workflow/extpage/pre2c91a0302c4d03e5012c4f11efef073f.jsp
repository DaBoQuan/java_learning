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
//��ID:2c91a0302c2fe2d1012c358dc96306ab	�豸������
//	����:	reqdate
//	�豸����:	devicename
//	�ʲ�ԭֵ:	originalcost
//	���벿��:	imporg
//	ǩ��1:	sign1
//	ǩ��3:	sign3
//	ǩ��5:	sign5
//	ǩ������2:	signdate2
//	ǩ������3:	signdate3
//	ǩ������5:	signdate5
//	����:	numbers
//	����רҵ��:	extdept
//	����ԭ�������:	reason
//	ǩ��2:	sign2
//	�������:	deviceNO
//	����רҵ��:	impdept
//	ǩ��4:	sign4
//	������:	reqman
//	�豸����:	devicecoding
//	ǩ������1:	signdate1
//	ǩ������4:	signdate4
//	���:	flowno
//	����ͺ�:	model
//	��������:	exporg
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
		baseJdbc.update("update uf_device_equipment set reqorgunit=(select imporg from uf_device_allot where requestid='"+requestid+"'),specialtys=(select impdept from uf_device_allot where requestid='"+requestid+"') where requestid=(select to_char(devicecoding) from uf_device_allot where requestid = '"+requestid+"')");
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



