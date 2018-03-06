<%@ page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>

<%@ page import="com.eweaver.base.BaseContext" %>
<%@ page import="com.eweaver.base.BaseJdbcDao" %>
<%@ page import="com.eweaver.sysinterface.base.Param" %>
<%@ page import="com.eweaver.sysinterface.javacode.EweaverExecutorBase" %>
<%@ page import="com.sap.conn.jco.JCoTable" %>

<%@ page import="java.util.List" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="java.util.Map" %>
<%
	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	String requestid = StringHelper.null2String(request.getParameter("requestid"));
	String flowno = StringHelper.null2String(request.getParameter("flowno"));//���̵���
	String pzdate = StringHelper.null2String(request.getParameter("pzdate"));//ƾ֤����
	String jzdate = StringHelper.null2String(request.getParameter("jzdate"));//ƾ֤����
	String pztype = StringHelper.null2String(request.getParameter("pztype"));//ƾ֤����
	String comcode = StringHelper.null2String(request.getParameter("comcode"));//��˾����
	String jzdur = StringHelper.null2String(request.getParameter("jzdur"));//�����ڼ�
	String user = StringHelper.null2String(request.getParameter("user"));//�û���
	String cur = StringHelper.null2String(request.getParameter("cur"));//���Ҵ���
	String payto = StringHelper.null2String(request.getParameter("payto"));//֧������
	String rate = StringHelper.null2String(request.getParameter("rate"));//����
	String pztitle = StringHelper.null2String(request.getParameter("pztitle"));//̧ͷ�ı�
	String strflag = payto + "-" + cur;//��������ƾ֤��Ϣ��ʶ

	pzdate = pzdate.replace("-", "");//ƾ֤����
	jzdate = jzdate.replace("-", "");//��������

	//����SAP����		
	SapConnector sapConnector = new SapConnector();
	String functionName = "ZOA_FI_DOC_CREATE";
	JCoFunction function = null;
	try {
		function = SapConnector.getRfcFunction(functionName);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	//�����ֶ�

	function.getImportParameterList().setValue("DOC_DATE",pzdate);//ƾ֤����
	function.getImportParameterList().setValue("PSTNG_DATE",jzdate);//��������
	function.getImportParameterList().setValue("DOC_TYPE",pztype);//ƾ֤����
	function.getImportParameterList().setValue("COMP_CODE",comcode);//��˾����
	function.getImportParameterList().setValue("PSTNG_PERIOD",jzdur);//�����ڼ�
	function.getImportParameterList().setValue("CURRENCY",cur);//���Ҵ���
	function.getImportParameterList().setValue("EXCHNG_RATE",rate);//����
	function.getImportParameterList().setValue("HEADER_TXT",pztitle);//̧ͷ�ı�
	function.getImportParameterList().setValue("USER_NAME",user);//�û���
	function.getImportParameterList().setValue("REF_DOC_NO","");//�ο�ƾ֤��
	function.getImportParameterList().setValue("NOTESID",flowno);//NotesID
	function.getImportParameterList().setValue("RUN_MODE","N");
	 

	//����
	JCoTable retTable = function.getTableParameterList().getTable("FI_DOC_ITEMS");
	String sql = "select accountcode,subject,estamount,currency,ccenter,purchaseorder,orderlineitem,text from uf_dmph_icdocumentinfo   where requestid='"+requestid+"' and flag='"+strflag+"' ";
	//System.out.println("���ڷ����ݹ������ϸ��"+sql);
	
	//�����룬���˿�Ŀ��˰��,�ݹ����ݹ����֣��ɱ����ģ��ɹ������ţ��ɹ���������Ŀ���ı�
	List list = baseJdbc.executeSqlForList(sql);
	if(list.size()>0){
		for(int i=0;i<list.size();i++){
			Map map = (Map)list.get(i);
			String accountcode = StringHelper.null2String(map.get("accountcode"));
			String subject = StringHelper.null2String(map.get("subject"));
			String estamount = StringHelper.null2String(map.get("estamount"));
			String estcurrency = StringHelper.null2String(map.get("currency"));
			String costcenter = StringHelper.null2String(map.get("ccenter"));
			String purorder = StringHelper.null2String(map.get("purchaseorder"));
			String purorderitem = StringHelper.null2String(map.get("orderlineitem"));
			String text1 = StringHelper.null2String(map.get("text"));
			
			retTable.appendRow();
			retTable.setValue("PSTNG_CODE", accountcode); //������
			retTable.setValue("GL_ACCOUNT", subject);//���˿�Ŀ
			retTable.setValue("MONEY", estamount);//���
			retTable.setValue("COST_CENTER", costcenter);//�ɱ�����
			retTable.setValue("PO_NO", purorder);//�ڲ�������
			retTable.setValue("PO_ITEM", purorderitem);//�ڲ����������
			retTable.setValue("ITEM_TEXT", text1);//�ı�
		}
	}
	
	try {
		function.execute(sapConnector.getDestination(sapConnector.fdPoolName));
	} catch (JCoException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	String ERR_MSG = function.getExportParameterList().getValue("ERR_MSG").toString();
	String AC_DOC_NO = function.getExportParameterList().getValue("AC_DOC_NO").toString();
	String FLAG = function.getExportParameterList().getValue("FLAG").toString();
	System.out.println(AC_DOC_NO);

	JSONObject jo = new JSONObject();		
	jo.put("msg", ERR_MSG);
	jo.put("acdocno", AC_DOC_NO);
	jo.put("flag", FLAG);
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
