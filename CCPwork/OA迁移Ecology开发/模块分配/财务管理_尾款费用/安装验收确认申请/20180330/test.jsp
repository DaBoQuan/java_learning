<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="weaver.general.StaticObj"%>
<%@page import="weaver.interfaces.datasource.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="com.weaver.integration.log.LogInfo"%>
<%@page import="com.sap.mw.jco.IFunctionTemplate"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@page
        import="com.weaver.integration.datesource.SAPInterationDateSourceImpl"%>

<%	
    String ponos = request.getParameter("ponos");
    String path = request.getParameter("");
    JCO.Client sapconnection = null;
	
    try {
		RecordSet rs = new RecordSet();
        RecordSet rs1 = new RecordSet();
        RecordSet rs2 = new RecordSet();
        String sources = "1";
        String outcall = "";
        rs1.writeLog("++++++++++++++++++++++++++++++");
		
	    SAPInterationDateSourceImpl sapidsi = new  SAPInterationDateSourceImpl();
	   
	    sapconnection = (JCO.Client) sapidsi.getConnection(sources, new LogInfo());
	    rs1.writeLog("20180404__________创建SAP连接");

       
        rs1.writeLog("20180330_______________创建SAP连接");
    


        rs1.writeLog(outcal______suceess：" + outcall);
        out.write("20180330__________");
    } catch (Exception e) {
        // TODO: handle exception
        out.write("20180330_______________fail" + e);
        e.printStackTrace();

    }

%>