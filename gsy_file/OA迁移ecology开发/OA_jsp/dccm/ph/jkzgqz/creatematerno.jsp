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
	//System.oiut.println(requestid);
	String pztitle = StringHelper.null2String(request.getParameter("pztitle"));//ƾ̧֤ͷ
	String gzdate = StringHelper.null2String(request.getParameter("gzdate"));//��������
	gzdate = gzdate.replace("-","");
	String comcode = StringHelper.null2String(request.getParameter("comcode"));//��˾����
	String flowno = StringHelper.null2String(request.getParameter("flowno"));//���̵���
	String fact = StringHelper.null2String(request.getParameter("fact"));//����
	String ref = StringHelper.null2String(request.getParameter("ref"));//����
	String area = StringHelper.null2String(request.getParameter("area"));//������
	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	//����SAP����		
	//System.out.println("���������Ƿ���ȷ������");
	SapConnector sapConnector = new SapConnector();
	String functionName = "ZOA_MM_DOC_POST";
	if(area.equals("40285a8d54cce9860154f15fccb5627d"))//����
	{
		functionName = "ZOA_MM_DOC_POST_CL";
	}
/*	
	JCoFunction function = null;
	try {
		function = SapConnector.getRfcFunction(functionName);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//�����ֶ�

	function.getImportParameterList().setValue("BKTXT",pztitle);//ƾ̧֤ͷ

	function.getImportParameterList().setValue("BUDAT",gzdate);//��������

	function.getImportParameterList().setValue("BUKRS",comcode);//��˾����

	
	function.getImportParameterList().setValue("RUN_MODE","N");//���÷�ʽ
	function.getImportParameterList().setValue("WERKS",fact);//����
	function.getImportParameterList().setValue("XBLNR",ref);//����
*/
	String sql = "select sno,materialid,money,notesid,orderno,item from uf_dmph_mdliteminfo where requestid = '"+requestid+"' order by sno asc";
	
	List list = baseJdbc.executeSqlForList(sql);
	if(list.size()>0)
	{	System.out.println("jkfyqz wlpzh start��"+requestid);
		for(int i = 0;i<list.size();i++)
		{
			JCoFunction function = null;
			System.out.println(functionName);
			try {
				function = SapConnector.getRfcFunction(functionName);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//�����ֶ�
			function.getImportParameterList().setValue("BKTXT",pztitle);//ƾ̧֤ͷ
			function.getImportParameterList().setValue("BUDAT",gzdate);//��������
			function.getImportParameterList().setValue("BUKRS",comcode);//��˾����			
			function.getImportParameterList().setValue("RUN_MODE","N");//���÷�ʽ
			function.getImportParameterList().setValue("WERKS",fact);//����
			function.getImportParameterList().setValue("XBLNR",ref);//����	
			
			
			Map map = (Map)list.get(i);
			
			String materialid = StringHelper.null2String(map.get("materialid"));//���Ϻ�
			String money = StringHelper.null2String(map.get("money"));//���
			String sno = StringHelper.null2String(map.get("sno"));//���
			String notesid = StringHelper.null2String(map.get("notesid"));//NotesID
			String orderno = StringHelper.null2String(map.get("orderno"));//����
			String item = StringHelper.null2String(map.get("item"));//���
			System.out.println(notesid);
			function.getImportParameterList().setValue("NOTESID",notesid);//NotesID
			JCoTable retTable = function.getTableParameterList().getTable("MM_DOC_ITEM");//����ƾ֤���
			retTable.appendRow();
			retTable.setValue("MATNR",materialid);//���Ϻ�
			System.out.println("materialid="+materialid);
			retTable.setValue("ZUUMB",money);//���
			System.out.println("money="+money);
			if(area.equals("40285a8d54cce9860154f15fccb5627d"))//����
			{
				retTable.setValue("EBELN",orderno);//����
				System.out.println("orderno="+orderno);
				retTable.setValue("EBELP",item);//���
				System.out.println("item="+item);
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
			String ERR_MSG = function.getExportParameterList().getValue("ERR_MSG").toString();//������Ϣ
			System.out.println(ERR_MSG);
			String AC_DOC_NO = function.getExportParameterList().getValue("MBLNR").toString();//ƾ֤��
			String FLAG = function.getExportParameterList().getValue("FLAG").toString();//��Ϣ����
			String insql = "update uf_dmph_mdliteminfo  set sapreceiptid = '"+AC_DOC_NO+"',msgtype='"+FLAG+"',msg='"+ERR_MSG+"' where requestid = '"+requestid+"' and sno = '"+sno+"'";
			System.out.println("lalala"+insql+"lalla");
			baseJdbc.update(insql);
		}
		System.out.println("jkfyqz wlpzh end��"+requestid);
	}
	
	//����ֵ
	sql = "select sno,materialid,money,sapreceiptid from uf_dmph_mdliteminfo where requestid = '"+requestid+"' order by sno asc";
	List list1 = baseJdbc.executeSqlForList(sql);
	JSONArray jsonArray = new JSONArray();
	if(list1.size()>0)
	{
		for(int m = 0;m<list1.size();m++)
		{
			Map map1 = (Map)list1.get(m);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("sno", StringHelper.null2String(map1.get("sno")));//���
			jsonObject.put("sapreceiptid", StringHelper.null2String(map1.get("sapreceiptid")));//SAPƾ֤��
			jsonArray.add(jsonObject);
		}
	}	
	JSONObject jo = new JSONObject();		
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jsonArray.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
