<%@ page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.BaseContext" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>
<%@ page import="com.sap.conn.jco.JCoTable"%>


<%

	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	String requestid=StringHelper.null2String(request.getParameter("requestid"));
	
	String sql = "select jcjxy,flowno from uf_hr_monthreward where requestid='"+requestid+"'";
	List tlist = baseJdbc.executeSqlForList(sql);
	JSONObject jo = new JSONObject();
	if(tlist.size()>0){
		Map map = (Map)tlist.get(0);
		String theMonth = StringHelper.null2String(map.get("jcjxy"));//��Ч�·�
        String flowno =  StringHelper.null2String(map.get("flowno"));//���뵥��
        //System.out.println("flowno="+flowno +" theMonth="+theMonth);
		theMonth = theMonth.replace("-", "");
		//����SAP����		
		SapConnector sapConnector = new SapConnector();
		String functionName = "ZHR_IT9001_CREATE";
		JCoFunction function = null;
		try {
			function = SapConnector.getRfcFunction(functionName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//�����ֶ�
		function.getImportParameterList().setValue("MONTH",theMonth);
		//����
		JCoTable retTable = function.getTableParameterList().getTable("IT9001");
		sql = "select sapid,pubresult,tosap from uf_hr_monthrewardsub where requestid='"+requestid+"'";
		List list = baseJdbc.executeSqlForList(sql);
        
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				Map m = (Map)list.get(i);
				String sapid = StringHelper.null2String(m.get("sapid"));
				String pubid = StringHelper.null2String(m.get("pubresult"));  
				String tosap = StringHelper.null2String(m.get("tosap"));
				if(tosap.equals("40288098276fc2120127704884290210")){ //��Ҫ��д
					retTable.appendRow();
					retTable.setValue("PERNR", sapid);
					retTable.setValue("ZETYP", pubid);
					retTable.setValue("ZENUM", flowno);
					System.out.println("PERNR="+sapid +" ZETYP="+pubid+" ZENUM="+flowno);
				}
                
			}
		}
		try {
			function.execute(sapConnector.getDestination(sapConnector.fdPoolName));
			//����ֵ
			String MESSAGE = function.getExportParameterList().getValue("MESSAGE").toString();
			String MSGTY = function.getExportParameterList().getValue("MSGTY").toString();
			String upsql="update uf_hr_monthreward set errmsg='"+MESSAGE+"',tohr='"+MSGTY+"',stateflag='3' where requestid='"+requestid+"'";
			System.out.println("upsql="+upsql);		
			baseJdbc.update(upsql);			
			jo.put("msg","true");
		} catch (JCoException e) {
			// TODO Auto-generated catch block
			jo.put("msg","false");
			e.printStackTrace();
		} catch (Exception e) {
			jo.put("msg","false");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(jo.toString());
		response.getWriter().flush();
		response.getWriter().close();		
	}

	/*
	String action=StringHelper.null2String(request.getParameter("action"));
	if (action.equals("tosap")){
		JSONObject jo = new JSONObject();
		String requestid=StringHelper.null2String(request.getParameter("requestid"));
		ConfigSapAction c = new ConfigSapAction();
		try {
			c.syncSap("40285a904999a7ad01499d431c7e2312", requestid);
			jo.put("msg","true");
		} catch (Exception e) {
			jo.put("msg","false");
			e.printStackTrace();
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(jo.toString());
		response.getWriter().flush();
		response.getWriter().close();
		
	}
		*/
%>