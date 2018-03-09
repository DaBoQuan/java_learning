<%@ page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>

<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eweaver.base.security.service.acegi.EweaverUser" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.sysinterface.base.Param" %>
<%@ page import="com.eweaver.sysinterface.javacode.EweaverExecutorBase" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>

<%
	String action=StringHelper.null2String(request.getParameter("action"));
	if (action.equals("getData")){
		String requestid=StringHelper.null2String(request.getParameter("requestid"));//流程Id
		String flowno=StringHelper.null2String(request.getParameter("flowno"));//流程号
		String flow=StringHelper.null2String(request.getParameter("flow"));//单号
		String flag=StringHelper.null2String(request.getParameter("flag"));//标识2
		BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
		//String sql = "select a.sapno,a.rleavedate,b.objdesc,a.compen,a.renegemoney from uf_hr_leave a,selectitem b where a.leavepattern=b.id and a.requestid='"+requestid+"'";
		String sql ="select t.requestid,a.exttextfield15 from uf_hr_outlesson t,humres a,uf_hr_outtrainsap  c where a.id=t.objname and  t.requestid='"+flowno+"' and t.requestid=c.requestid and c.msgty='E'"; 
		List list = baseJdbc.executeSqlForList(sql);
		String sapid="";
		if(list.size()>0){
			for(int i = 0;i<list.size();i++)
			{
				Map map = (Map)list.get(i);
				sapid = StringHelper.null2String(map.get("exttextfield15"));//SAP员工工号

				//创建SAP对象
				SapConnector sapConnector = new SapConnector();
				String functionName = "ZZHR_IT2002_DELETE";
				JCoFunction function = null;
				try {
					function = SapConnector.getRfcFunction(functionName);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
				//插入字段
				function.getImportParameterList().setValue("PERNR",sapid);
				function.getImportParameterList().setValue("AWART",flag);//出勤类型
				function.getImportParameterList().setValue("ZZNUM",flow);//审批单号

				try {
					function.execute(sapConnector.getDestination(sapConnector.fdPoolName));
				} catch (JCoException e) {
					// TODO Auto-generated catch block  
					e.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				//返回值
				String MESSAGE = function.getExportParameterList().getValue("MESSAGE").toString();
				String MSGTY = function.getExportParameterList().getValue("MSGTY").toString();
				String upsql="update uf_hr_outtrainsap  set msgty='"+MSGTY+"',msgtx='"+MESSAGE+"' where requestid='"+requestid+"' and sapid='"+sapid+"'";
				//String upsql="update uf_hr_leave set message='"+MESSAGE+"',msgtype='"+MSGTY+"' where requestid='"+requestid+"'";
				baseJdbc.update(upsql);
				
			}
		}
		
	}
%>