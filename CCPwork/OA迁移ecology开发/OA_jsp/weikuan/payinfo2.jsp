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
	String action=StringHelper.null2String(request.getParameter("action"));
	System.out.println("TEST");
	
	if (action.equals("getDa")){
		System.out.println("777");
		String requestid=StringHelper.null2String(request.getParameter("requestid"));
		String orderno=StringHelper.null2String(request.getParameter("orderno")); 
		BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");


			//����SAP����		
			SapConnector sapConnector = new SapConnector();
			String functionName = "ZOA_MM_PAYMENT02";
			JCoFunction function = null;
			try {
				function = SapConnector.getRfcFunction(functionName);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//�����ֶ�
			//function.getImportParameterList().setValue("LGART","7030");

			function.getImportParameterList().setValue("EBELN",orderno);//������
			function.getImportParameterList().setValue("ZTYPE","B");
			
			try {
				function.execute(sapConnector.getDestination(sapConnector.fdPoolName));
			} catch (JCoException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			//String WKURS = function.getExportParameterList().getValue("NETWR").toString();//˰��
			//System.out.println("����:"+WKURS);
			//ץȡ��SAP�ķ���ֵ
			JCoTable newretTable = function.getTableParameterList().getTable("ZMM_PAY02");
			System.out.println("line:"+newretTable.getNumRows());
			if(newretTable.getNumRows()>0){
				for(int j = 0;j<newretTable.getNumRows();j++)
				{
					if(j == 0)
					{
			newretTable.firstRow();//��ȡ���ر�������еĵ�һ��
			String BUKRS = newretTable.getString("BUKRS");//��˾����
			//System.out.println("EBELP:   "+EBELP);
			String BELNR = newretTable.getString("BELNR");//ƾ֤����
			String GJAHR = newretTable.getString("GJAHR");//���
			String WRBTR = newretTable.getString("WRBTR");//������
			String PSWSL = newretTable.getString("PSWSL");//ƾ֤����
            String HKONT = newretTable.getString("HKONT");//��Ŀ
			String ZTERM = newretTable.getString("ZTERM");//��������
			String ZLSCH = newretTable.getString("ZLSCH");//���ʽ
			String ZFBDT = newretTable.getString("ZFBDT");//�����׼��
			String ZLSPR = newretTable.getString("ZLSPR");//���Ḷ��
			String BVTYP = newretTable.getString("BVTYP");//��������
			String SGTXT = newretTable.getString("SGTXT");//�ı�
			//System.out.println("orderno:   "+orderno);
			//�������ݿ��ж�Ӧ��������Ϣ
			String upsql="delete uf_fn_wkpayinfo  where requestid='"+requestid+"'";
			System.out.println(upsql);
			baseJdbc.update(upsql);
			upsql = "insert into uf_fn_wkpayinfo   (id,requestid,comcode,creditno,finyear,payamt,currency,feeaccount,payterm,paytype,paydate,frozen,bank,text) values((select sys_guid() from dual),'"+requestid+"','"+BUKRS+"','"+BELNR+"','"+GJAHR+"','"+WRBTR+"','"+PSWSL+"','"+HKONT+"','"+ZTERM+"','"+ZLSCH+"','"+ZFBDT+"','"+ZLSPR+"','"+BVTYP+"','"+SGTXT+"')";
			baseJdbc.update(upsql);
			System.out.println(upsql);
			System.out.println(orderno);
					}
			else
			{
				newretTable.nextRow();//��ȡ��һ������
				//HKNT = newretTable.getString("HKONT");//��Ŀ
				String BUKRS = newretTable.getString("BUKRS");//���
				String BELNR = newretTable.getString("BELNR");//���ı�
				String GJAHR = newretTable.getString("GJAHR");//�ɹ���λ
				String WRBTR = newretTable.getString("WRBTR");//�ɹ�����
				String PSWSL = newretTable.getString("PSWSL");//����
				String ZLSCH = newretTable.getString("ZLSCH");//˰��
				String HKONT = newretTable.getString("HKONT");//��Ŀ
				String ZTERM = newretTable.getString("ZTERM");//��������
				//money=Float.parseFloat(NETPR)*Float.parseFloat(WKURS);//��˰���=�۸�* ˰��
				String ZFBDT = newretTable.getString("ZFBDT");//��˰���
				String ZLSPR = newretTable.getString("ZLSPR");//����
				String BVTYP = newretTable.getString("BVTYP");//����
				String SGTXT = newretTable.getString("SGTXT");//����
			String upsql1 = "insert into uf_fn_wkpayinfo   (id,requestid,comcode,creditno,finyear,payamt,currency,feeaccount,payterm,paytype,paydate,frozen,bank,text) values((select sys_guid() from dual),'"+requestid+"','"+BUKRS+"','"+BELNR+"','"+GJAHR+"','"+WRBTR+"','"+PSWSL+"','"+HKONT+"','"+ZTERM+"','"+ZLSCH+"','"+ZFBDT+"','"+ZLSPR+"','"+BVTYP+"','"+SGTXT+"')";
				baseJdbc.update(upsql1);
				//System.out.println("fqwfwefuweuf");
				System.out.println(upsql1);
			}
			/*
			while(newretTable.isLastRow());//��������һ��
			{
				//newretTable.nextRow();//��ȡ��һ������
				//HKNT = newretTable.getString("HKONT");//��Ŀ
				BUKRS = newretTable.getString("BUKRS");//���
				BELNR = newretTable.getString("BELNR");//���ı�
				GJAHR = newretTable.getString("GJAHR");//�ɹ���λ
				WRBTR = newretTable.getString("WRBTR");//�ɹ�����
				PSWSL = newretTable.getString("PSWSL");//����
				ZLSCH = newretTable.getString("ZLSCH");//˰��
				//money=Float.parseFloat(NETPR)*Float.parseFloat(WKURS);//��˰���=�۸�* ˰��
				ZFBDT = newretTable.getString("ZFBDT");//��˰���
				ZLSPR = newretTable.getString("ZLSPR");//����
				BVTYP = newretTable.getString("BVTYP");//����
				SGTXT = newretTable.getString("SGTXT");//����
			upsql = "insert into uf_fn_wkpayinfo   (id,requestid,comcode,creditno,finyear,payamt,currency,feeaccount,payterm,paytype,paydate,frozen,bank,text) values((select sys_guid() from dual),'"+requestid+"','"+BUKRS+"','"+BELNR+"','"+GJAHR+"','"+WRBTR+"','"+PSWSL+"','"+HKONT+"','"+ZTERM+"','"+ZLSCH+"','"+ZFBDT+"','"+ZLSPR+"','"+BVTYP+"','"+SGTXT+"')";
				baseJdbc.update(upsql);
				//System.out.println("fqwfwefuweuf");
				System.out.println(upsql);
			}*/
					}
			}
			JSONObject jo = new JSONObject();		
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(jo.toString());
			response.getWriter().flush();
			response.getWriter().close();
			

	}
%>




