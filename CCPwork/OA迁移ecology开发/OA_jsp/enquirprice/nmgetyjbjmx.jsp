<%@ page contentType="text/html; charset=UTF-8"%>
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

<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>

<%@ page import="com.eweaver.app.configsap.SapSync"%>

<%@ page import="java.text.DecimalFormat;"%>

<%
String requestid = StringHelper.null2String(request.getParameter("requestid"));//requestid
String yjno = StringHelper.null2String(request.getParameter("yjno"));//议价单号
BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");

%>
<style type="text/css"> 


tr.tr1{     
    TEXT-INDENT: -1pt; 
    TEXT-ALIGN: left; 
    height: 22px; 
    background-color:#f8f8f0; 
} 
tr.title{ 
	font-size:12px; 
	font-weight:bold;
    TEXT-INDENT: -1pt; 
    TEXT-ALIGN: left; 
    height: 22px; 
    background-color:#f8f8f0; 
} 
tr.hj{     
    TEXT-INDENT: -1pt; 
    TEXT-ALIGN: left; 
    height: 22px; 
    background-color:#e46d0a; 
} 
td.td1{ 
    font-size:12px; 
    PADDING-RIGHT: 4px; 
    PADDING-LEFT: 4px;     
    TEXT-DECORATION: none 

} 
td.td2{ 
	height: 22px;
    font-size:12px; 
    PADDING-RIGHT: 4px; 
    PADDING-LEFT: 4px;     
    TEXT-DECORATION: none; 
    color:#000; 

} 


</style>
<script type='text/javascript' language="javascript" src='/js/main.js'>


</script>


<!--<div id="warpp" style="height:600px;overflow-y:auto">-->
<%
String delsql = "delete uf_lo_yjbjsub where requestid='"+requestid+"'";
baseJdbc.update(delsql);
String sql = "select lineno,linename,linetype,trantype,hxarea,qygang,gycity,mdgang,mdcity,vehicle,gx,danger,dangerlv,pritype,stone,etone,requir,pro,gl,sl,timee,price,baojia,curr,boat,zdprice,a.bjid,a.xjrequestid,gxfee,a.gxty,a.hxty from uf_lo_yijiadetail a where a.requestid='"+yjno+"' order by a.sno asc";
System.out.println(sql);
List sublist = baseJdbc.executeSqlForList(sql);
int count=0;
if(sublist.size()>0){
	for(int k=0,sizek=sublist.size();k<sizek;k++){
		Map mk = (Map)sublist.get(k);
		int m = k;
		int no=m+1;
		String lineno=StringHelper.null2String(mk.get("lineno"));
		String linename=StringHelper.null2String(mk.get("linename"));
		String linetype=StringHelper.null2String(mk.get("linetype"));
		String trantype=StringHelper.null2String(mk.get("trantype"));
		String hxarea=StringHelper.null2String(mk.get("hxarea"));
		String qygang=StringHelper.null2String(mk.get("qygang"));
		String gycity=StringHelper.null2String(mk.get("gycity"));
		String mdgang=StringHelper.null2String(mk.get("mdgang"));
		String mdcity=StringHelper.null2String(mk.get("mdcity"));
		String vehicle=StringHelper.null2String(mk.get("vehicle"));
		String gx=StringHelper.null2String(mk.get("gx"));
		String danger=StringHelper.null2String(mk.get("danger"));
		String dangerlv=StringHelper.null2String(mk.get("dangerlv"));
		String pritype=StringHelper.null2String(mk.get("pritype"));
		String stone=StringHelper.null2String(mk.get("stone"));
		String etone=StringHelper.null2String(mk.get("etone"));
		String requir=StringHelper.null2String(mk.get("requir"));
		String gxfee=StringHelper.null2String(mk.get("gxfee"));
		String gl=StringHelper.null2String(mk.get("gl"));
		String sl=StringHelper.null2String(mk.get("sl"));
		String timee=StringHelper.null2String(mk.get("timee"));
		String price=StringHelper.null2String(mk.get("price"));
		String baojia=StringHelper.null2String(mk.get("baojia"));
		String curr=StringHelper.null2String(mk.get("curr"));
		String pro=StringHelper.null2String(mk.get("pro"));
		String boat=StringHelper.null2String(mk.get("boat"));
		String zdprice=StringHelper.null2String(mk.get("zdprice"));
		String bijsubid=StringHelper.null2String(mk.get("bjid"));//比价明细id
		String xjrequestid=StringHelper.null2String(mk.get("xjrequestid"));
		String gxty=StringHelper.null2String(mk.get("gxty"));
		String hxty=StringHelper.null2String(mk.get("hxty"));
		if(price.equals(""))
		{
			price="null";
		}
		if(baojia.equals(""))
		{
			baojia="null";
		}
		String insql = "insert into uf_lo_yjbjsub   (id,requestid,sno,lineno,linename,linetype,trantype,hxarea,qygang,gycity,mdgang,mdcity,vehicle,gx,danger,dangerlv,pritype,stone,etone,requir,pro,gl,timee,price,gxfee,baojia,curr,boat,zdprice,xjrequestid,bijsubid,gxty,hxty)values('"+IDGernerator.getUnquieID()+"','"+requestid+"',"+no+",'"+lineno+"','"+linename+"','"+linetype+"','"+trantype+"','"+hxarea+"','"+qygang+"','"+gycity+"','"+mdgang+"','"+mdcity+"','"+vehicle+"','"+gx+"','"+danger+"','"+dangerlv+"','"+pritype+"','"+stone+"','"+etone+"','"+requir+"','"+pro+"',"+gl+",'"+timee+"',"+price+","+gxfee+","+baojia+",'"+curr+"','"+boat+"',"+zdprice+",'"+xjrequestid+"','"+bijsubid+"','"+gxty+"','"+hxty+"')";
		baseJdbc.update(insql);
	}
}
%>

                                                                                       