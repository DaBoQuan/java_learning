<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//��ǰ�������������ǳ����
//�����ͬ��������	ID:2c91a0302bbcd476012c063ea1422a51
//	���:	flowNO
//	�嵥:	attach2
//	��������5:	review5
//	���1:	advise1
//	��Ŀ������:	prjdept
//	�˿�����:	customer
//	��ͬ�ƻ�����ʱ��:	planendtime
//	��������7:	review7
//	��������10:	review10
//	���3:	advise3
//	���������A���Ͳο��ļ���R���嵥:	attach3
//	����״̬:	flowstate
//	֧��Ԥ���ܽ��:	money3
//	��ͬ�ƻ���ʼʱ��:	planstarttime
//	��ͬ����:	ctrtype
//	Ԥ���м��Ʒ(����ڲ���):	content3
//	���벿�Ÿ�����:	reqdeptprincipal
//	��ͬ��Ҫ����:	content
//	Ԥ��ɹ�������Ҫ����:	content2
//	�ܽ��2:	money2
//	��������2:	review2
//	��������4:	review4
//	��ͬ����:	contract
//	����:	attach
//	��������6:	review6
//	��������9:	review9
//	��������12:	review12
//	��������14:	review14
//	��������15:	review15
//	�������:	reviewtimes
//	��ͬ���:	ctrmoney
//	�ܽ��:	money1
//	������:	reqman
//	��������1:	review1
//	��������8:	review8
//	��������11:	review11
//	��������16:	review16
//	ʵʩ����:	impldept
//	����:	amount
//	��������3:	review3
//	��������13:	review13
//	ǩ��1:	sign1
//	ǩ��2:	sign2
//	ǩ��3:	sign3
//	���2:	advise2
//	���4:	advise4
//	���5:	advise5
//	ҵ����:	orgid
//	��ǰ�ڵ�:	currentnode
//	��������ҵ��:	orgunit
//	���벿��:	reqdept
//	��ͬǢ̸���Ա:	groupmember
//	Ǣ̸���:	talkcase
//	���6:	advise6
//	��������:	supplier
//	�����ɹ���׼:	relbug
//	�ɹ�����:	buyobject
//	��Դ����:	sourcetype
//	Ǣ̸���:	talkresult
//	ǩ��4:	sign4
//��ͬ-����ҵ����ֱ�	ID:2c91a0302b98c1b4012b99022b270015
//	��ע:	remark
//	��ͬ��:	contractno
//	������:	distsum
//	ҵ����:	orgid
//	pid:	pid
//---------------------------------------
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.eweaver.base.security.service.acegi.EweaverUser" %>
<%@ page import="com.eweaver.base.BaseContext" %>
<%@ page import="com.eweaver.base.BaseJdbcDao" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eweaver.base.BaseContext"%>
<%@ page import="com.eweaver.base.msg.*"%>
<%
//---------------------------------------
String requestid= request.getParameter("requestid");
String targeturl = request.getParameter("targeturl");
String operatemode = request.getParameter("operatemode");
//�ύ��
if(operatemode.equals("reject")){
	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	baseJdbc.update("update uf_ctr_income set reviewtimes=nvl(reviewtimes,1)+1 where requestid='"+requestid+"'");
}
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

