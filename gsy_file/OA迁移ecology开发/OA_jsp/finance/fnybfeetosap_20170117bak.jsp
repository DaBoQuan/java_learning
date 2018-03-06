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
	String requestid = StringHelper.null2String(request.getParameter("requestid"));//requestid
	String pzdate = "";//ƾ֤����
	String jzdate = "";//��������

	String pztype = "";//ƾ֤����
	String comcode = "";//��˾����
	String jzdur ="";//�����ڼ�
	String user = "";//�û���
	String cur = "";//���Ҵ���
	String rate ="";//����
	String pztitle = "";//̧ͷ�ı�
	String ref="";//����
	//String sql="select postingdate,changerate,certificatetype,(select objno from getcompanyview where requestid=firmcode) as firmcode,(select objname from humres where id=systemwitness) as systemwitness,currencycode,postingmonth,certificatedate,invoicenumber,(select objname  from selectitem where id=feetype) as pztitle  from uf_fn_mainfeeapp  where requestid='"+requestid+"'";
	String sql="select postingdate,changerate,certificatetype,(select objno from getcompanyview where requestid=firmcode) as firmcode,(select objname from humres where id=systemwitness) as systemwitness,currencycode,postingmonth,certificatedate,invoicenumber,proofrise from uf_fn_mainfeeapp  where requestid='"+requestid+"'";
	List list1 = baseJdbc.executeSqlForList(sql);
	if(list1.size()>0){
		for(int i=0;i<list1.size();i++){
			Map map1 = (Map)list1.get(i);
			jzdate = StringHelper.null2String(map1.get("postingdate"));//�������ڡ�����������
			rate = StringHelper.null2String(map1.get("changerate"));//���ʡ�������(ƾ֤)
			pztype = StringHelper.null2String(map1.get("certificatetype"));//ƾ֤���͡���ƾ֤����
			comcode = StringHelper.null2String(map1.get("firmcode"));//��˾���롪����˾����(ƾ֤)
			user = StringHelper.null2String(map1.get("systemwitness"));//�û���������֤��
			cur = StringHelper.null2String(map1.get("currencycode"));//���Ҵ��롪���ұ�(ƾ֤)
			jzdur = StringHelper.null2String(map1.get("postingmonth"));//�����ڼ䡪�������ڼ�(�·�)
			pzdate = StringHelper.null2String(map1.get("certificatedate"));//ƾ֤���ڡ���ƾ֤����
			ref=StringHelper.null2String(map1.get("invoicenumber"));//�ο�ƾ֤�š�����Ʊ����
			//pztitle=StringHelper.null2String(map1.get("pztitle"));//ƾ̧֤ͷ�ı�������������
			pztitle=StringHelper.null2String(map1.get("proofrise"));//ƾ̧֤ͷ�ı�������Ʊ���
		}
	}




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
	//System.out.println(rate);
	function.getImportParameterList().setValue("HEADER_TXT",pztitle);//̧ͷ�ı�
	function.getImportParameterList().setValue("USER_NAME",user);//�û���
	function.getImportParameterList().setValue("RUN_MODE","N");//����ģʽ
	function.getImportParameterList().setValue("REF_DOC_NO",ref);//ƾ֤����
	function.getImportParameterList().setValue("NOTESID",requestid);//Notesid


    System.out.println("NOTESID------------------"+requestid);
	//����(ƾ֤����Ŀ)
	JCoTable retTable1 = function.getTableParameterList().getTable("FI_DOC_ITEMS");
	//sql = "select chargecode,subject,amount,paydate,freezpay,payterms,paytype,paycurrency,paycurrencyamount,taxcode,costcenter,internalorder,salesorder,salesorderitem,purchaseorder,purchaseorderitem,cooperativebanktype,text from uf_fn_certificateitems  where requestid = '"+requestid+"' order by ordernumber asc ";
	sql = "select a.chargecode,a.subject,a.amount,a.paydate,a.freezpay,a.payterms,a.paytype,a.paycurrency,a.paycurrencyamount,a.taxcode,a.costcenter,a.internalorder,a.salesorder,a.salesorderitem,a.purchaseorder,a.purchaseorderitem,a.cooperativebanktype,a.text,a.sgl from uf_fn_certificateitems a  where a.requestid = '"+requestid+"' order by to_number(a.ordernumber) asc ";
	list1 = baseJdbc.executeSqlForList(sql);
	System.out.println(sql);
	if(list1.size()>0){
		for(int i=0;i<list1.size();i++){
			Map map1 = (Map)list1.get(i);
			String accountcode = StringHelper.null2String(map1.get("chargecode"));//������
			String subject = StringHelper.null2String(map1.get("subject"));//���˿�Ŀ
			String money = StringHelper.null2String(map1.get("amount"));//���
			if(money.indexOf(".")!=-1)
			{
				if(money.split("\\.")[1].equals("00")||money.split("\\.")[1].equals("0")||money.split("\\.")[1].equals("000"))
				{
					money=money.split("\\.")[0];
				}
			}


			String paydate = StringHelper.null2String(map1.get("paydate"));//�����׼����
			paydate = paydate.replace("-", "");//ƾ֤����
			String payfreeze = StringHelper.null2String(map1.get("freezpay"));//�����

			String payitem = StringHelper.null2String(map1.get("payterms"));//��������
			String paytype = StringHelper.null2String(map1.get("paytype"));//���ʽ

			String currency = StringHelper.null2String(map1.get("paycurrency"));//ʵ�ʻ���(֧������)
			String paymoney = StringHelper.null2String(map1.get("paycurrencyamount"));//ʵ�ʻ��ҽ��(֧�����ҽ��)

			String taxcaode = StringHelper.null2String(map1.get("taxcode"));//˰��
			String costcenter = StringHelper.null2String(map1.get("costcenter"));//�ɱ�����
			String internalorder = StringHelper.null2String(map1.get("internalorder"));//�ڲ�����
			String receiptid = StringHelper.null2String(map1.get("salesorder"));//����ƾ֤
			String receiptitem = StringHelper.null2String(map1.get("salesorderitem"));//����ƾ֤���
			String purchaseorder = StringHelper.null2String(map1.get("purchaseorder"));//�ɹ�����
			String purchaseorderitem = StringHelper.null2String(map1.get("purchaseorderitem"));//�ɹ��������
			String banktype = StringHelper.null2String(map1.get("cooperativebanktype"));//��������
			String text1 = StringHelper.null2String(map1.get("text"));//�ı�
			String sgl = StringHelper.null2String(map1.get("sgl"));//�ı�

			retTable1.appendRow();

			retTable1.setValue("PSTNG_CODE", accountcode); //������
			retTable1.setValue("GL_ACCOUNT", subject);//���˿�Ŀ

			retTable1.setValue("MONEY", money);//���
			retTable1.setValue("PAY_TERMS", payitem);//��������

			retTable1.setValue("PAY_DATE", paydate);//�����׼����
			retTable1.setValue("PAY_LOCK", payfreeze);//�����

			retTable1.setValue("PAY_WAY", paytype);//���ʽ
			retTable1.setValue("PAY_CUR", currency);//֧������

			retTable1.setValue("PAY_MONEY", paymoney); //֧�����ҽ��
			retTable1.setValue("TAX_CODE", taxcaode);//˰��

			retTable1.setValue("COST_CENTER", costcenter);//�ɱ�����
			retTable1.setValue("ORDER_ID", internalorder);//�ڲ�����

			retTable1.setValue("SO_NO", receiptid);//����ƾ֤
			retTable1.setValue("SO_ITEM", receiptitem);//����ƾ֤���

			retTable1.setValue("PO_NO", purchaseorder);//�ɹ�����
			retTable1.setValue("PO_ITEM", purchaseorderitem);//�ɹ��������

			retTable1.setValue("BANK_TYPE", banktype);//��������
			retTable1.setValue("ITEM_TEXT", text1);//�ı�
			retTable1.setValue("SGL_FLAG", sgl);//�ı�

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
	String upsql="update uf_fn_mainfeeapp  set documentnumber='"+AC_DOC_NO+"',successfulident='"+FLAG+"',errorcode='"+ERR_MSG+"' where requestid='"+requestid+"'";
	baseJdbc.update(upsql);
	JSONObject jo = new JSONObject();		
	jo.put("msg", ERR_MSG);
	jo.put("res", "true");
	jo.put("acdocno", AC_DOC_NO);
	jo.put("flag", FLAG);
	System.out.println("AC_DOC_NO:"+AC_DOC_NO);
	System.out.println("ERR_MSG:"+ERR_MSG);
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
