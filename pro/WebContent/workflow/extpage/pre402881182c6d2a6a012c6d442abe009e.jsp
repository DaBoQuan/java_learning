<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ǩ��֧����ͬ���̹鵵ǰ���ɺ�̨ͬ�� -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="com.eweaver.interfaces.workflow.*" %>
<%@ page import="com.eweaver.interfaces.form.*" %>
<%@ page import="com.eweaver.interfaces.model.*" %>
<%
BaseJdbcDao baseJdbcDao=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
String requestid=request.getParameter("requestid");
//String requestid="2c91a0302c5cbb33012c5cd24cc30077";
String targeturl = request.getParameter("targeturl");
String operatemode=request.getParameter("operatemode");
String categoryId="2c91a0302c7bdddd012c7c6625ac02dc";//��ʽ��ͬ
if(StringHelper.isEmpty(requestid)){
	out.println("requestid is null!");
	return;
}
FormdataServiceImpl formdataService=new FormdataServiceImpl();
Formdata formdata=new Formdata();
formdata.setCreator(BaseContext.getRemoteUser().getId());
formdata.setTypeid(categoryId);
Dataset data=new Dataset();
formdata.setData(data);

//���ú�ͬ�������ֶ���Ϣ
List<Cell> mainList=new ArrayList<Cell>();

String sql1="select contract,flowNO,supplier,planstarttime,planendtime,10000*ctrmoney as ctrmoney,ctrtype,divideclasses,reqdept,content,attach,content2,10000*money1 as money1,reqman,csman,10000*money2 as money2,10000*money3 as money3,content3,orgid,csdate,ifreturn,buystyles from uf_ctr_income where requestid='"+requestid+"'";
List<Map> list=baseJdbcDao.executeSqlForList(sql1);
Map mainData=list.get(0);//ȡlist��һ�����ݣ�
mainList.add(new Cell("name",StringHelper.null2String(mainData.get("contract"))));//��ͬ����
mainList.add(new Cell("no",StringHelper.null2String(mainData.get("flowNO"))));//��ͬ���
mainList.add(new Cell("customercoding",StringHelper.null2String(mainData.get("supplier"))));//�׷���λ
mainList.add(new Cell("predictbgdate",StringHelper.null2String(mainData.get("planstarttime"))));//Ԥ�ƿ�ʼ
mainList.add(new Cell("predictdate",StringHelper.null2String(mainData.get("planendtime"))));//Ԥ�����
mainList.add(new Cell("money",StringHelper.null2String(mainData.get("ctrmoney"))));//��ͬ���
mainList.add(new Cell("hosttypep",StringHelper.null2String(mainData.get("ctrtype"))));//��ͬ������
mainList.add(new Cell("divideclasses",StringHelper.null2String(mainData.get("divideclasses"))));//��ͬ������
mainList.add(new Cell("dodept",StringHelper.null2String(mainData.get("reqdept"))));//ʵʩ����
mainList.add(new Cell("mainpoint",StringHelper.null2String(mainData.get("content"))));//��ͬ��Ҫ����
mainList.add(new Cell("electrontext",StringHelper.null2String(mainData.get("attach"))));//��ͬ�����ı�
mainList.add(new Cell("field002",StringHelper.null2String(mainData.get("content2"))));//�ɹ������м��Ʒ
mainList.add(new Cell("bg1",StringHelper.null2String(mainData.get("money1"))));//Ԥ���м��ƷA1
mainList.add(new Cell("pjprincipal",StringHelper.null2String(mainData.get("reqman"))));//��Ŀ������
mainList.add(new Cell("csman",StringHelper.null2String(mainData.get("csman"))));//��ͬǩ����
mainList.add(new Cell("budgetall",StringHelper.null2String(mainData.get("money3"))));//��Ԥ��
mainList.add(new Cell("budget",StringHelper.null2String(mainData.get("content3"))));//��ǩ���ڲ��ϵ�Ԥ��
mainList.add(new Cell("bg2",StringHelper.null2String(mainData.get("money2"))));//Ԥ����ڲ���A2
mainList.add(new Cell("orgunit",StringHelper.null2String(mainData.get("orgid"))));//����ҵ��
//mainList.add(new Cell("isback","2c91a0302b278cea012b28d82e7f001d"));//�Ƿ񷵻�
mainList.add(new Cell("isback",StringHelper.null2String(mainData.get("ifreturn"))));//�Ƿ񷵻�2c91a0302b278cea012b28d82e7f001d
mainList.add(new Cell("issign","2c91a8512b9a1688012b9a44255d0001"));//��ͬ����
mainList.add(new Cell("state","2c91a0302a8cef72012a8eabe0e803f0"));//��ͬĬ��״̬
mainList.add(new Cell("classes","2c91a0302a8cef72012a8ea9390903c7"));//��ͬ���-֧����ͬ
mainList.add(new Cell("csdate",StringHelper.null2String(mainData.get("csdate"))));//ǩ������
mainList.add(new Cell("ctrflow",StringHelper.null2String(requestid)));//��������
mainList.add(new Cell("buystyles",StringHelper.null2String(mainData.get("buystyles"))));//�ɹ���ʽ
baseJdbcDao.update("update uf_ctr_income set flowstate='2c91a0302bbcd476012be610f27e0a39' where requestid='"+requestid+"'");

data.setMaintable(mainList);
//���ɺ�̨ͬ��
formdataService.createFormdata(formdata);

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

