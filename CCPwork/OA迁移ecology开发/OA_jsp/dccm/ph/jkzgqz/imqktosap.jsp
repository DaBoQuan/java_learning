<%@ page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.dccm.SapConnector" %>
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
	String pzdate = StringHelper.null2String(request.getParameter("pzdate"));//ƾ֤����
	String jzdate = StringHelper.null2String(request.getParameter("jzdate"));//��������
	String reportday = StringHelper.null2String(request.getParameter("reportday"));//Text Reporting Date
	String pztype = StringHelper.null2String(request.getParameter("pztype"));//ƾ֤����
	String comcode = StringHelper.null2String(request.getParameter("comcode"));//��˾����
	String jzdur = StringHelper.null2String(request.getParameter("jzdur"));//�����ڼ�
	String user = StringHelper.null2String(request.getParameter("user"));//�û���
	String cur = StringHelper.null2String(request.getParameter("cur"));//���Ҵ���
	String rate = StringHelper.null2String(request.getParameter("rate"));//����
	String ref = StringHelper.null2String(request.getParameter("ref"));//ƾ֤����
	String pztitle = StringHelper.null2String(request.getParameter("pztitle"));//̧ͷ�ı�
	String flowno=StringHelper.null2String(request.getParameter("flowno"));//Notesid
	String taxtype = StringHelper.null2String(request.getParameter("taxtype"));//˰��
	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	String flag = "Import-" + taxtype;//��������ƾ֤��Duties����GST

	pzdate = pzdate.replace("-", "");//ƾ֤����
	jzdate = jzdate.replace("-", "");//��������
	reportday = reportday.replace("-", "");//Text Reporting Date
	
	//����SAP����		
	SapConnector sapConnector = new SapConnector();
	String functionName = "ZOA_FI_DOC_CREATE_MY";
	JCoFunction function = null;
	try {
		function = SapConnector.getRfcFunction(functionName);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//�����ֶ�
	//System.out.println("123...........................................................................................");
	function.getImportParameterList().setValue("DOC_DATE",pzdate);//ƾ֤����
	function.getImportParameterList().setValue("PSTNG_DATE",jzdate);//��������
	function.getImportParameterList().setValue("VATDATE",reportday);//Text Reporting Date
	function.getImportParameterList().setValue("DOC_TYPE",pztype);//ƾ֤����
	function.getImportParameterList().setValue("COMP_CODE",comcode);//��˾����
	function.getImportParameterList().setValue("PSTNG_PERIOD",jzdur);//�����ڼ�
	function.getImportParameterList().setValue("CURRENCY",cur);//���Ҵ���
	function.getImportParameterList().setValue("EXCHNG_RATE",rate);//����
	//System.out.println(rate);
	function.getImportParameterList().setValue("HEADER_TXT",pztitle);//̧ͷ�ı�
	function.getImportParameterList().setValue("USER_NAME",user);//�û���
	//function.getImportParameterList().setValue("RUN_MODE","N");//����ģʽ
	function.getImportParameterList().setValue("REF_DOC_NO",ref);//ƾ֤����
	function.getImportParameterList().setValue("NOTESID",flowno);//Notesid

	
	

	//����(ƾ֤����Ŀ)
	JCoTable retTable1 = function.getTableParameterList().getTable("FI_DOC_ITEMS");
	String sql = "select serialno,subject,amount,sjjs,payterm,paydate,paydj,payway,curr,taxcode,costcenter,text,qty,unit from uf_dmph_sjpzdet where requestid = '"+requestid+"' and flag='"+flag+"'";
	List list1 = baseJdbc.executeSqlForList(sql);
	if(list1.size()>0)
	{
		//System.out.println("456................................................................................................................................");
		for(int i=0;i<list1.size();i++)
		{
			Map map1 = (Map)list1.get(i);
			String subject = StringHelper.null2String(map1.get("subject"));//���˿�Ŀ
			if(subject.indexOf("5506")!=-1||subject.indexOf("21710101")!=-1||subject.indexOf("11710020")!=-1||subject.indexOf("21910904")!=-1)
			{
				for(int ts=subject.length();ts<10;ts++)
				{
					subject = "0" + subject;//���˿�Ŀ����10λ
				}
			}
			else
			{
			}
			//System.out.println("subject:"+subject);
			String money = StringHelper.null2String(map1.get("amount"));//���
			String sjjs = StringHelper.null2String(map1.get("sjjs"));//˰�����
			String paydate = StringHelper.null2String(map1.get("paydate"));//�����׼����
			paydate = paydate.replace("-", "");//ƾ֤����
			String payfreeze = StringHelper.null2String(map1.get("paydj"));//�����
			String payitem = StringHelper.null2String(map1.get("payterm"));//��������
			String paytype = StringHelper.null2String(map1.get("payway"));//���ʽ
			String taxcode = StringHelper.null2String(map1.get("taxcode"));//˰��
			String costcenter = StringHelper.null2String(map1.get("costcenter"));//�ɱ�����
			if(comcode.equals("7010")&&!costcenter.equals(""))
			{
				costcenter=costcenter.substring(2, costcenter.length());
			}
			//String receiptid = StringHelper.null2String(map1.get("receiptid"));//����ƾ֤
			//String receiptitem = StringHelper.null2String(map1.get("receiptitem"));//����ƾ֤���
			//System.out.println("item:"+receiptitem);
			//receiptitem = receiptitem.replaceFirst("^0*", "");//ȥ����ο�ͷ��0 
			//String banktype = StringHelper.null2String(map1.get("banktype"));//��������
			String text1 = StringHelper.null2String(map1.get("text"));//�ı�
			String qty = StringHelper.null2String(map1.get("qty"));//����
			String unit = StringHelper.null2String(map1.get("unit"));//��λ
			
			String mark = "";//���
			if(subject.indexOf("21710101")==-1&&subject.indexOf("5506")==-1&&subject.indexOf("11710020")==-1&&subject.indexOf("21910904")==-1)
			{
				mark = "K";
			}
			if(subject.indexOf("21710101")!=-1)
			{
				mark = "T";
			}
			
			retTable1.appendRow();
			retTable1.setValue("GL_ACCOUNT", subject);//���˿�Ŀ
			retTable1.setValue("MONEY", money);//���
			retTable1.setValue("TAX_BASE", sjjs);//˰�����
			retTable1.setValue("PAY_TERMS", payitem);//��������
			retTable1.setValue("PAY_DATE", paydate);//�����׼����
			retTable1.setValue("PAY_LOCK", payfreeze);//�����
			retTable1.setValue("PAY_WAY", paytype);//���ʽ
			retTable1.setValue("PAY_MONEY", money); //֧�����ҽ��
			retTable1.setValue("TAX_CODE", taxcode);//˰��
			retTable1.setValue("COST_CENTER", costcenter);//�ɱ�����
			retTable1.setValue("SO_NO", "");//����ƾ֤
			retTable1.setValue("SO_ITEM", "");//����ƾ֤���
			retTable1.setValue("BANK_TYPE", "");//��������
			retTable1.setValue("ITEM_TEXT", text1);//�ı�
			retTable1.setValue("BASE_UOM", unit);//��λ
			retTable1.setValue("QUANTITY", qty);//����
			retTable1.setValue("MARK", mark);//��ʶ
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
	//System.out.println("ERR_MSG:"+ERR_MSG);
	String AC_DOC_NO = function.getExportParameterList().getValue("AC_DOC_NO").toString();
	//System.out.println("AC_DOC_NO:"+AC_DOC_NO);
	String FLAG = function.getExportParameterList().getValue("FLAG").toString();
	//System.out.println("FLAG:"+FLAG);
	
	JSONObject jo = new JSONObject();		
	jo.put("msg", ERR_MSG);
	jo.put("acdocno", AC_DOC_NO);
	jo.put("flag", FLAG);
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
