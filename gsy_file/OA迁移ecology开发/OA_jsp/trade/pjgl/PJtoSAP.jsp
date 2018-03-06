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
 
	String requestid = StringHelper.null2String(request.getParameter("requestid"));//requestid
	String flowno = StringHelper.null2String(request.getParameter("flowno"));//���̵���
	String pzdate = StringHelper.null2String(request.getParameter("pzdate"));//ƾ֤����
	String jzdate = StringHelper.null2String(request.getParameter("jzdate"));//��������

	String pztype = StringHelper.null2String(request.getParameter("pztype"));//ƾ֤����
	String comcode = StringHelper.null2String(request.getParameter("comcode"));//��˾����
	String jzdur = StringHelper.null2String(request.getParameter("jzdur"));//�����ڼ�
	String user = StringHelper.null2String(request.getParameter("user"));//�û���
	String cur = StringHelper.null2String(request.getParameter("cur"));//���Ҵ���
	String ref = StringHelper.null2String(request.getParameter("refno"));//ƾ֤����
	String pztitle = StringHelper.null2String(request.getParameter("pztitle"));//̧ͷ�ı�

	String arr = StringHelper.null2String(request.getParameter("arr"));//ƾ֤����Ŀ��Ϣ

	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");


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
	function.getImportParameterList().setValue("HEADER_TXT",pztitle);//̧ͷ�ı�
	function.getImportParameterList().setValue("USER_NAME",user);//�û���
	function.getImportParameterList().setValue("RUN_MODE","N");//����ģʽ
	function.getImportParameterList().setValue("REF_DOC_NO",ref);//�ο�ƾ֤��
	function.getImportParameterList().setValue("NOTESID",flowno);//Notesid


	//����(ƾ֤����Ŀ)
	JCoTable retTable1 = function.getTableParameterList().getTable("FI_DOC_ITEMS");
	String aa[] = arr.split(",");
	for(int i = 0;i<aa.length;i++)
	{
		String bb[] = aa[i].split(";");
		//System.out.println("������ַ���Ϊ:"+aa[i]);
		//System.out.println("���������ĳ���Ϊ:"+bb.length);
		//System.out.println(bb[7]);
		
		retTable1.appendRow();
		if(bb[0].equals("#"))
		{
			retTable1.setValue("PSTNG_CODE", ""); //������
		}
		else
		{
			retTable1.setValue("PSTNG_CODE", bb[0]); //������
		}
		if(bb[1].equals("#"))
		{
			retTable1.setValue("GL_ACCOUNT", "");//���˿�Ŀ
		}
		else
		{
			retTable1.setValue("GL_ACCOUNT", bb[1]);//���˿�Ŀ
		}

		if(bb[2].equals("#"))
		{
			retTable1.setValue("PAY_DATE", "");//�����׼����
		}
		else
		{
			 bb[2] =  bb[2].replace("-", "");//ƾ֤����
			retTable1.setValue("PAY_DATE", bb[2]);//�����׼����
		}

		if(bb[3].equals("#"))
		{
			retTable1.setValue("MONEY","");//���
		}
		else
		{
			retTable1.setValue("MONEY", bb[3]);//���
		}
		if(bb[4].equals("#"))
		{
			retTable1.setValue("ASSGN_NUM","");//����
		}
		else
		{
			retTable1.setValue("ASSGN_NUM", bb[4]);//����
		}
		if(bb[5].equals("#"))
		{
			retTable1.setValue("SGL_FLAG","");//SQL��ʶ
		}
		else
		{
			retTable1.setValue("SGL_FLAG", bb[5]);//SQL��ʶ
		}
		if(bb[6].equals("#"))
		{
			retTable1.setValue("PAY_REF","");//����ο�
		}
		else
		{
			retTable1.setValue("PAY_REF", bb[6]);//����ο�
		}
		if(bb[7].equals("#"))
		{
			retTable1.setValue("ITEM_TEXT", "");//�ı�
		}
		else
		{
			retTable1.setValue("ITEM_TEXT", bb[7]);//�ı�
		}
		if(bb[8].equals("#"))
		{
			retTable1.setValue("BANK_NAME", ""); //��������
		}
		else
		{
			retTable1.setValue("BANK_NAME", bb[8]); //��������
		}
		if(bb[9].equals("#"))
		{
			retTable1.setValue("PAY_WAY","");//���ʽ
		}
		else
		{
			retTable1.setValue("PAY_WAY", bb[9]);//���ʽ
			//System.out.println("333"+bb[9]);
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
	//����ֵ

	String ERR_MSG = function.getExportParameterList().getValue("ERR_MSG").toString();
	String AC_DOC_NO = function.getExportParameterList().getValue("AC_DOC_NO").toString();
	String FLAG = function.getExportParameterList().getValue("FLAG").toString();

	String insql = "update uf_tr_billmanage set acdocnum = '"+AC_DOC_NO+"',flag = '"+FLAG+"',msg = '"+ERR_MSG+"' where requestid = '"+requestid+"'";
	baseJdbc.update(insql);
	JSONObject jo = new JSONObject();		
	jo.put("msg", ERR_MSG);
	jo.put("acdocno", AC_DOC_NO);
	jo.put("flag", FLAG);
	//System.out.println(AC_DOC_NO);
	//System.out.println(ERR_MSG);
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
