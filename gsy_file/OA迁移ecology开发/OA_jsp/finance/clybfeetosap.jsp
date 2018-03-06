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

	String sql="select gzdate,pzhuilv,pzleixing,(select objno from getcompanyview where requestid=pzcocode) as pzcocode,(select objname from humres where id=pzman) as pzman,pzbibie,gzqijian,pzdate,fpno,pztop from uf_fn_clmainfeeapp  where requestid='"+requestid+"'";
	List list1 = baseJdbc.executeSqlForList(sql);
	if(list1.size()>0){
		for(int i=0;i<list1.size();i++){
			Map map1 = (Map)list1.get(i);
			jzdate = StringHelper.null2String(map1.get("gzdate"));//�������ڡ�����������
			rate = StringHelper.null2String(map1.get("pzhuilv"));//���ʡ�������(ƾ֤)
			pztype = StringHelper.null2String(map1.get("pzleixing"));//ƾ֤���͡���ƾ֤����
			comcode = StringHelper.null2String(map1.get("pzcocode"));//��˾���롪����˾����(ƾ֤)
			user = StringHelper.null2String(map1.get("pzman"));//�û���������֤��
			cur = StringHelper.null2String(map1.get("pzbibie"));//���Ҵ��롪���ұ�(ƾ֤)
			jzdur = StringHelper.null2String(map1.get("gzqijian"));//�����ڼ䡪�������ڼ�(�·�)
			pzdate = StringHelper.null2String(map1.get("pzdate"));//ƾ֤���ڡ���ƾ֤����
			ref=StringHelper.null2String(map1.get("fpno"));//�ο�ƾ֤�š�����Ʊ����
			pztitle=StringHelper.null2String(map1.get("pztop"));//ƾ̧֤ͷ�ı�������Ʊ���
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
	function.getImportParameterList().setValue("NOTESID","");//Notesid


    //System.out.println("------------------");
	//����(ƾ֤����Ŀ)
	JCoTable retTable1 = function.getTableParameterList().getTable("FI_DOC_ITEMS");
		sql = "select a.jzno,a.kemu,a.jine,a.fkdate,a.fkdj,a.fktj,a.fkfs,a.zfhb,a.zfhbje,a.shuima,a.cbcenter,a.nbdd,a.xsdd,a.xsddxc,a.cgdd,a.cgddxc,a.hzbank,a.text from uf_fn_clcertificateitem a  where a.requestid = '"+requestid+"' order by a.no asc ";
	list1 = baseJdbc.executeSqlForList(sql);
	System.out.println(sql);
	if(list1.size()>0){
		for(int i=0;i<list1.size();i++){
			Map map1 = (Map)list1.get(i);
			String accountcode = StringHelper.null2String(map1.get("jzno"));//������
			String subject = StringHelper.null2String(map1.get("kemu"));//���˿�Ŀ
			String money = StringHelper.null2String(map1.get("jine"));//���

			String paydate = StringHelper.null2String(map1.get("fkdate"));//�����׼����
			paydate = paydate.replace("-", "");//ƾ֤����
			String payfreeze = StringHelper.null2String(map1.get("fkdj"));//�����

			String payitem = StringHelper.null2String(map1.get("fktj"));//��������
			String paytype = StringHelper.null2String(map1.get("fkfs"));//���ʽ

			String currency = StringHelper.null2String(map1.get("zfhb"));//ʵ�ʻ���(֧������)
			String paymoney = StringHelper.null2String(map1.get("zfhbje"));//ʵ�ʻ��ҽ��(֧�����ҽ��)

			String taxcaode = StringHelper.null2String(map1.get("shuima"));//˰��
			String costcenter = StringHelper.null2String(map1.get("cbcenter"));//�ɱ�����
			String internalorder = StringHelper.null2String(map1.get("nbdd"));//�ڲ�����
			String receiptid = StringHelper.null2String(map1.get("xsdd"));//����ƾ֤
			String receiptitem = StringHelper.null2String(map1.get("xsddxc"));//����ƾ֤���
			String purchaseorder = StringHelper.null2String(map1.get("cgdd"));//�ɹ�����
			String purchaseorderitem = StringHelper.null2String(map1.get("cgddxc"));//�ɹ��������
			String banktype = StringHelper.null2String(map1.get("hzbank"));//��������
			String text1 = StringHelper.null2String(map1.get("text"));//�ı�

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
	String upsql="update uf_fn_clmainfeeapp  set documentnumber='"+AC_DOC_NO+"',successfulident='"+FLAG+"',errorcode='"+ERR_MSG+"' where requestid='"+requestid+"'";
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
