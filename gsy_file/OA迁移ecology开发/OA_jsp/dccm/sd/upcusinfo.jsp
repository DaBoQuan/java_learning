<%@ page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@ page import="com.eweaver.base.BaseJdbcDao"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.BaseContext" %>
<%@ page import="com.eweaver.base.label.service.LabelService" %>
<%@ page import="com.eweaver.base.security.service.acegi.EweaverUser" %>
<%@ page import="com.eweaver.humres.base.model.Humres" %>
<%@ page import="com.eweaver.humres.base.service.HumresService" %>
<%@ page import="com.eweaver.base.setitem.service.SetitemService"%>
<%@ page import="com.eweaver.base.util.DateHelper"%>
<%@ page import="com.sap.conn.jco.JCoTable" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.dccm.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>
<%@ page import="com.eweaver.app.configsap.SapSync"%>
<%@ page import="java.util.List" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="java.util.Map" %>


<%
 	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	String resid = StringHelper.null2String(request.getParameter("requestid"));//����֪ͨ��requestid
	String sql = "select mx.salno,mx.num from uf_dmsd_deldetail mx left join uf_dmsd_delnotes fh on mx.requestid=fh.requestid left join requestbase req on fh.requestid=req.id where req.isdelete=0 and fh.isvalid='40288098276fc2120127704884290210' and fh.requestid='"+resid+"'";

	List list = baseJdbc.executeSqlForList(sql);
	if(list.size()>0)
	{
		for(int i=0;i<list.size();i++)
		{
			Map map = (Map)list.get(i);
			String orderno = StringHelper.null2String(map.get("salno"));//order number
			String item = StringHelper.null2String(map.get("num"));//order item

			//����SAP����
			SapConnector sapConnector = new SapConnector();
			String functionName = "ZOA_SD_UPDATE_MY";
			JCoFunction function = null;
			try {
				function = SapConnector.getRfcFunction(functionName);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//�����ֶ�
			function.getImportParameterList().setValue("VBELN",);//���۶�����
			function.getImportParameterList().setValue("POSNR",);//���۶������

			try {
				function.execute(sapConnector.getDestination(sapConnector.fdPoolName));
			} 
			catch (JCoException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//��ȡSAP����ֵ
			String cusorderno = function.getExportParameterList().getValue("BSTNK").toString();//�ͻ��ɹ��������
			String cuswldes = function.getExportParameterList().getValue("KMATNR").toString();//�ͻ���������
			String ordernum = function.getExportParameterList().getValue("KWMENG").toString();//��������

			//���·���֪ͨ��ĳ�����ϸ��
			String upsql = "update uf_dmsd_deldetail set ordno='"+cusorderno+"',materdes='"+cuswldes+"',amount='"+ordernum+"' where requestid='"+resid+"' and salno='"+orderno+"' and num='"+item+"'";
			baseJdbc.update(upsql);
			
			//�жϸ÷���֪ͨ���Ӧ���������絥�Ƿ����
			String tsql = "select wx.* from uf_dmsd_expboxmain wx left join requestbase req on wx.requestid=req.id where 0=req.isdelete and wx.isvalid='40288098276fc2120127704884290210' and wx.shipnotice='"+resid+"'";
			List tlist = baseJdbc.executeSqlForList(tsql);
			if(tlist.size()>0)
			{
				Map tmap = (Map)tlist.get(0);
				String tresid = StringHelper.null2String(tmap.get("requestid"));//�������絥requestid
				//�����������絥�ĳ�����ϸ��
				String tupsql = "update uf_dmsd_shipment set cusordno='"+cusorderno+"',materdes='"+cuswldes+"',shipnum='"+ordernum+"' where requestid='"+tresid+"' and saleorder='"+orderno+"' and orderitem='"+item+"'";
				baseJdbc.update(tupsql);
			}
		}
	}

	JSONObject jo = new JSONObject();		
	jo.put("res", "true");
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
