<script>


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
        String suppliercode=StringHelper.null2String(request.getParameter("suppliercode"));
		String requestid=StringHelper.null2String(request.getParameter("requestid"));//���뵥��requestid
		String Pztt = StringHelper.null2String(request.getParameter("Pztt"));//ƾ̧֤ͷ
		String jzmonth = StringHelper.null2String(request.getParameter("jzmonth"));//�����ڼ�
		String pztype = StringHelper.null2String(request.getParameter("pztype"));//ƾ֤����
		String Zzdate = StringHelper.null2String(request.getParameter("Zzdate"));//��������
		//String Hl = StringHelper.null2String(request.getParameter("Hl"));//����
		String Pzdate = StringHelper.null2String(request.getParameter("Pzdate"));//ƾ֤����
		String username = StringHelper.null2String(request.getParameter("username"));//�û���
		String pznumber = StringHelper.null2String(request.getParameter("pznumber"));//ƾ֤����
		String hbcode = StringHelper.null2String(request.getParameter("hbcode"));//���Ҵ���
		String Comcode = StringHelper.null2String(request.getParameter("Comcode"));//��˾����
		String fpno = StringHelper.null2String(request.getParameter("fpno"));//��Ʊ����

		BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");

		
			SapConnector sapConnector = new SapConnector();
			String functionName = "ZOA_FI_CDOC_CREATE";
			JCoFunction function = null;
			try {
				function = SapConnector.getRfcFunction(functionName);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//�����ֶ�
            Pzdate = Pzdate.replace("-","");
			Zzdate = Zzdate.replace("-","");
			function.getImportParameterList().setValue("DOC_DATE",Pzdate);//ƾ֤����
			function.getImportParameterList().setValue("PSTNG_DATE",Zzdate);//��������

			function.getImportParameterList().setValue("DOC_TYPE",pztype);//ƾ֤����
			function.getImportParameterList().setValue("COMP_CODE",Comcode);//��˾����
			function.getImportParameterList().setValue("PSTNG_PERIOD",jzmonth);//�����ڼ�


			function.getImportParameterList().setValue("CURRENCY",hbcode);//���Ҵ���
			//function.getImportParameterList().setValue("EXCHNG_RATE",Hl);//����
			function.getImportParameterList().setValue("HEADER_TXT",Pztt);//̧ͷ�ı�
			function.getImportParameterList().setValue("USER_NAME",username);//�û���
			function.getImportParameterList().setValue("REF_DOC_NO",fpno);//�ο�ƾ֤��
			function.getImportParameterList().setValue("NOTESID",requestid);//NotesID
			function.getImportParameterList().setValue("RUN_MODE","N");//
			

			//����(ƾ֤����Ŀ)
			JCoTable retTable1 = function.getTableParameterList().getTable("FI_DOC_ITEMS");
			String sql = "select jzcode,feeaccount,amount,payterm,paydate,paytype,frozen,bank,text from uf_fn_wkcredit   where requestid='"+requestid+"'";
			List list = baseJdbc.executeSqlForList(sql);;
			for(int i = 0;i<list.size();i++)
			{
				Map map1 = (Map)list.get(i);
				String jzcode = StringHelper.null2String(map1.get("jzcode"));//������
				String feeaccount = StringHelper.null2String(map1.get("feeaccount"));//��Ŀ
				String amount = StringHelper.null2String(map1.get("amount"));//���
				String payterm = StringHelper.null2String(map1.get("payterm"));//��������
				String paydate = StringHelper.null2String(map1.get("paydate"));//�����׼����
                String paydate1=paydate.split("-")[0]+paydate.split("-")[1]+paydate.split("-")[2];
				String paytype = StringHelper.null2String(map1.get("paytype"));//���ʽ
				String frozen = "A";//���Ḷ��
				String bank = StringHelper.null2String(map1.get("bank"));//��������
				String text = StringHelper.null2String(map1.get("text"));//�ı�

				retTable1.appendRow();//����һ��


				retTable1.setValue("PAY_TERMS",payterm);//��������
				System.out.println("SSS"+payterm+"SSSS");
				retTable1.setValue("MONEY",amount);//���
				//System.out.println(money);
				retTable1.setValue("GL_ACCOUNT",feeaccount);//���˿�Ŀ
				retTable1.setValue("PSTNG_CODE",jzcode);//������
				retTable1.setValue("PAY_LOCK",frozen);//
				retTable1.setValue("PAY_WAY",paytype);//���ʽ
				retTable1.setValue("BANK_TYPE",bank);//��������
				retTable1.setValue("ITEM_TEXT",text);//�ı�
				retTable1.setValue("PAY_DATE",paydate1);//�����׼����



			}
						//����(δ��������Ŀ)
			JCoTable retTable = function.getTableParameterList().getTable("FI_DOC_CLEAR");
			String sql1 = "select jznum,subject,money,Specialid,pznum,year,unrepair,text from uf_oa_unrepair where requestid = '"+requestid+"'";
			List list1 = baseJdbc.executeSqlForList(sql1);
			//System.out.println("��ѯ����δ���������:"+list1.size()+"test");
			for(int i = 0;i<list1.size();i++)
			{
				Map map = (Map)list1.get(i);
				

				String money = StringHelper.null2String(map.get("money")); //���

				String Generalledger = StringHelper.null2String(map.get("subject"));//�ͻ�/��Ӧ�̼���
				//String chargecode = "27";//������
				String texttwo = StringHelper.null2String(map.get("text"));//�ı�
				String year = StringHelper.null2String(map.get("year")); //������
				String num1 = StringHelper.null2String(map.get("unrepair")); //������ƾ֤���
				String expco = StringHelper.null2String(map.get("Specialid"));//�������˱�ʶ
				String need= StringHelper.null2String(map.get("pznum"));//�����˱���
				String jznum=StringHelper.null2String(map.get("suppliercode"));//�ͻ�/��Ӧ�̱�ʶ

				retTable.appendRow();//����һ��
				retTable.setValue("VC_NO",jznum);//���ʿ�Ŀ
				//System.out.println("NJX003");
				retTable.setValue("VC_FLAG", "K"); //�ͻ���Ӧ�̱�ʶ
				System.out.println(jznum);
				retTable.setValue("SGL_FLAG","");//�������ʱ�ʶ
				retTable.setValue("DOC_NO",need);//������ƾ֤���
				System.out.println(need);
				retTable.setValue("DOC_YEAR",year);//������
				System.out.println(year);
				retTable.setValue("DOC_ITEM",num1);//����Ŀ��
				System.out.println(num1);
				retTable.setValue("CL_MONEY",money);//���˽��
				System.out.println(money);
				System.out.println(texttwo);
				retTable.setValue("CL_TEXT",texttwo);//�����ı�
              
				
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
			System.out.println("DOCNUM:"+AC_DOC_NO);
			String FLAG = function.getExportParameterList().getValue("FLAG").toString();
			String upsql = "update uf_fn_wkoneoffpay  set creditno='"+AC_DOC_NO+"',creflag='"+FLAG+"',errmsg='"+ERR_MSG+"' where  requestid = '"+requestid+"'";
			System.out.println(upsql);
			baseJdbc.update(upsql);
			JSONObject jo = new JSONObject();		
			jo.put("msg", ERR_MSG);
			jo.put("acdocno", AC_DOC_NO);
			jo.put("flag", FLAG);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(jo.toString());
			//System.out.println(jo.toString());
			response.getWriter().flush();
			response.getWriter().close();
	

%>










</script>