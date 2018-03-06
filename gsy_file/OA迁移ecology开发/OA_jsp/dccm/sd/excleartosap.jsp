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
	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");


	pzdate = pzdate.replace("-", "");//ƾ֤����
	jzdate = jzdate.replace("-", "");//��������
	reportday = reportday.replace("-", "");//Text Reporting Date
	
	//����SAP����		
	SapConnector sapConnector = new SapConnector();
	//String functionName = "ZOA_FI_CDOC_CREATE";
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
	function.getImportParameterList().setValue("HEADER_TXT",pztitle);//̧ͷ�ı�
	function.getImportParameterList().setValue("USER_NAME",user);//�û���
	//function.getImportParameterList().setValue("RUN_MODE","N");//����ģʽ
	function.getImportParameterList().setValue("REF_DOC_NO",ref);//ƾ֤����
	function.getImportParameterList().setValue("NOTESID",flowno);//Notesid

	
	

	//����(ƾ֤����Ŀ)
	JCoTable retTable1 = function.getTableParameterList().getTable("FI_DOC_ITEMS");
	String sql = "select sno,subject,money,sjjs,payitem,paydate,payfreeze,paytype,currency,paymoney,taxcaode,costcenter,receiptid,receiptitem,banktype,text1,iskmsupplier from uf_dmsd_exfeeqzpz where requestid = '"+requestid+"' order by sno asc ";
	List list1 = baseJdbc.executeSqlForList(sql);
	if(list1.size()>0)
	{
		//System.out.println("456................................................................................................................................");
		for(int i=0;i<list1.size();i++)
		{
			Map map1 = (Map)list1.get(i);
			String subject = StringHelper.null2String(map1.get("subject"));//���˿�Ŀ
			String iskmsupplier = StringHelper.null2String(map1.get("iskmsupplier"));//���˿�Ŀ�Ƿ�Ϊ��Ӧ��
			if(iskmsupplier.equals("40285a8d5763da3c0157646db1b4053b"))//NO
			{
				for(int ts=subject.length();ts<10;ts++)
				{
					subject = "0" + subject;//���˿�Ŀ����10λ
				}
			}
			//��ʱ����
			/*if(subject.equals("21710101"))
			{
				subject = "0021710101";
			}
			if(subject.equals("55061600"))
			{
				subject = "0055061600";
			}
			if(subject.equals("55063800"))
			{
				subject = "0055063800";
			}*/
			
			String money = StringHelper.null2String(map1.get("money"));//���
			String sjjs = StringHelper.null2String(map1.get("sjjs"));//˰�����
			String paydate = StringHelper.null2String(map1.get("paydate"));//�����׼����
			paydate = paydate.replace("-", "");//ƾ֤����
			String payfreeze = StringHelper.null2String(map1.get("payfreeze"));//�����
			String payitem = StringHelper.null2String(map1.get("payitem"));//��������
			String paytype = StringHelper.null2String(map1.get("paytype"));//���ʽ
			String paymoney = StringHelper.null2String(map1.get("paymoney"));//ʵ�ʻ��ҽ��
			String taxcaode = StringHelper.null2String(map1.get("taxcaode"));//˰��
			String costcenter = StringHelper.null2String(map1.get("costcenter"));//�ɱ�����
			String receiptid = StringHelper.null2String(map1.get("receiptid"));//����ƾ֤
			
			String receiptitem = StringHelper.null2String(map1.get("receiptitem"));//����ƾ֤���
			receiptitem = receiptitem.replaceFirst("^0*", "");//ȥ����ο�ͷ��0 
			
			String banktype = StringHelper.null2String(map1.get("banktype"));//��������
			String text1 = StringHelper.null2String(map1.get("text1"));//�ı�
			
			String mark = "";//���
			//��ʱ����
			/*if(subject.indexOf("DCM")!=-1)
			{
				mark = "K";
			}*/
			
			if(iskmsupplier.equals("40285a8d5763da3c0157646db1b4053a"))//YES
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
			retTable1.setValue("PAY_MONEY", paymoney); //֧�����ҽ��
			retTable1.setValue("TAX_CODE", taxcaode);//˰��
			retTable1.setValue("COST_CENTER", costcenter);//�ɱ�����
			retTable1.setValue("SO_NO", receiptid);//����ƾ֤
			retTable1.setValue("SO_ITEM", receiptitem);//����ƾ֤���
			retTable1.setValue("BANK_TYPE", banktype);//��������
			retTable1.setValue("ITEM_TEXT", text1);//�ı�
			retTable1.setValue("MARK", mark);//�ı�
		}
	}
	
	
	//����(δ��������Ŀ)
	/*JCoTable retTable = function.getTableParameterList().getTable("FI_DOC_CLEAR");
	sql = "select sno,custsuppcode,custsuppflag,ledgerflag,rmbamount,fiscalyear,clearreceiptitem,clearreceiptid,surplusmoney,cleartext from uf_dmsd_exfeeqzno a  where a.requestid = '"+requestid+"' order by sno asc";
	List list = baseJdbc.executeSqlForList(sql);
	if(list.size()>0)
	{
		for(int i=0;i<list.size();i++)
		{
			Map map = (Map)list.get(i);
			String custsuppflag = StringHelper.null2String(map.get("custsuppflag"));//�ͻ���Ӧ�̱�ʶ
			String custsuppcode = StringHelper.null2String(map.get("custsuppcode"));//�ͻ�/��Ӧ�̱���
			String ledgerflag = StringHelper.null2String(map.get("ledgerflag"));//�������˱�ʶ

			String clearreceiptid = StringHelper.null2String(map.get("clearreceiptid"));//������ƾ֤���
			String fiscalyear = StringHelper.null2String(map.get("fiscalyear"));//������
			String clearreceiptitem = StringHelper.null2String(map.get("clearreceiptitem"));//������ƾ֤���
			String surplusmoney = StringHelper.null2String(map.get("surplusmoney"));//����ʣ����
			String cleartext = StringHelper.null2String(map.get("cleartext"));//�����ı�

			retTable.appendRow();
			retTable.setValue("VC_FLAG", custsuppflag); //�ͻ���Ӧ�̱�ʶ
			retTable.setValue("VC_NO", custsuppcode);//�ͻ�/��Ӧ�̱���
			retTable.setValue("SGL_FLAG", "");//�������˱�ʶ
			retTable.setValue("DOC_NO", clearreceiptid);//������ƾ֤���
			retTable.setValue("DOC_YEAR", fiscalyear);//������
			retTable.setValue("DOC_ITEM", clearreceiptitem);//������ƾ֤���
			retTable.setValue("CL_MONEY", surplusmoney);//����ʣ����
			retTable.setValue("CL_TEXT", cleartext);//�����ı�
		}
	}*/
	
	
	
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
	
	String upsql="update uf_dmsd_exfeeqz set receiptid='"+AC_DOC_NO+"',succflag='"+FLAG+"',errorid='"+ERR_MSG+"' where requestid='"+requestid+"'";
	baseJdbc.update(upsql);
	JSONObject jo = new JSONObject();		
	jo.put("msg", ERR_MSG);
	jo.put("acdocno", AC_DOC_NO);
	jo.put("flag", FLAG);
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
