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
String delsql = "delete uf_tr_yjbjsub where requestid='"+requestid+"'";
baseJdbc.update(delsql);
String sql = "select a.gx,a.isdanger,a.dengerllv,a.hxarea,a.hx,a.qygang,a.mdgang,a.equair,a.pro,a.gl,a.yujiprice,a.xjrequestid,a.bjsum,nvl(a.hyfee,0) hyfee,nvl(a.gxfee,0)gxfee,nvl(a.baf,0) baf,nvl(a.yas,0) yas,nvl(a.gbf,0) gbf,nvl(a.caf,0) caf,nvl(a.ebs,0) ebs,nvl(a.cic,0) cic,nvl(a.ens,0) ens,nvl(a.ams,0) ams,nvl(a.rcs,0) rcs,nvl(a.pss,0) pss,nvl(a.days21,0) days21,nvl(a.days30,0) days30,nvl(a.days45,0) days45,nvl(a.days60,0) days60,a.shipcom,a.shipdate,a.xjrequestid,a.bjid,a.gxty,a.hxty from uf_tr_yijiasub a where a.requestid='"+yjno+"' order by a.sno asc";
//System.out.println(sql);
List sublist = baseJdbc.executeSqlForList(sql);
int count=0;
if(sublist.size()>0){
	for(int k=0,sizek=sublist.size();k<sizek;k++){
		Map mk = (Map)sublist.get(k);
		int m = k;
		int no=m+1;
		String gx=StringHelper.null2String(mk.get("gx"));
		String isdanger=StringHelper.null2String(mk.get("isdanger"));
		String dengerllv=StringHelper.null2String(mk.get("dengerllv"));
		String hxarea=StringHelper.null2String(mk.get("hxarea"));
		String hx=StringHelper.null2String(mk.get("hx"));
		String qygang=StringHelper.null2String(mk.get("qygang"));
		String mdgang=StringHelper.null2String(mk.get("mdgang"));
		String equair=StringHelper.null2String(mk.get("equair"));
		String pro=StringHelper.null2String(mk.get("pro"));
		String hyfee=StringHelper.null2String(mk.get("hyfee"));
		String gxfee=StringHelper.null2String(mk.get("gxfee"));
		String baf=StringHelper.null2String(mk.get("baf"));
		String yas=StringHelper.null2String(mk.get("yas"));
		String gbf=StringHelper.null2String(mk.get("gbf"));
		String caf=StringHelper.null2String(mk.get("caf"));
		String ebs=StringHelper.null2String(mk.get("ebs"));
		String cic=StringHelper.null2String(mk.get("cic"));
		String ens=StringHelper.null2String(mk.get("ens"));
		String ams=StringHelper.null2String(mk.get("ams"));
		String rcs=StringHelper.null2String(mk.get("rcs"));
		String pss=StringHelper.null2String(mk.get("pss"));
		String days21=StringHelper.null2String(mk.get("days21"));
		String days30=StringHelper.null2String(mk.get("days30"));
		String days45=StringHelper.null2String(mk.get("days45"));
		String days60=StringHelper.null2String(mk.get("days60"));
		String shipcom=StringHelper.null2String(mk.get("shipcom"));
		String shipdate=StringHelper.null2String(mk.get("shipdate"));
		String gl=StringHelper.null2String(mk.get("gl"));
		String bjsum=StringHelper.null2String(mk.get("bjsum"));
		String yujiprice=StringHelper.null2String(mk.get("yujiprice"));
		String xjrequestid=StringHelper.null2String(mk.get("xjrequestid"));
		String bijsubid=StringHelper.null2String(mk.get("bjid"));//比价明细id
		String gxty=StringHelper.null2String(mk.get("gxty"));
		String hxty=StringHelper.null2String(mk.get("hxty"));
		String insql = "insert into uf_tr_yjbjsub   (id,requestid,sno,gx,isdanger,dengerllv,hxarea,hx,qygang,mdgang,equair,pro,hyfee,gxfee,baf,yas,gbf,caf,ebs,cic,ens,ams,rcs,pss,days21,days30,days45,days60,shipcom,shipdate,bjsum,gl,yujiprice,xjrequestid,bjid,gxty,hxty)values('"+IDGernerator.getUnquieID()+"','"+requestid+"',"+no+",'"+gx+"','"+isdanger+"','"+dengerllv+"','"+hxarea+"','"+hx+"','"+qygang+"','"+mdgang+"','"+equair+"','"+pro+"',"+hyfee+","+gxfee+","+baf+","+yas+","+gbf+","+caf+","+ebs+","+cic+","+ens+","+ams+","+rcs+","+pss+","+days21+","+days30+","+days45+","+days60+",'"+shipcom+"','"+shipdate+"',"+bjsum+","+gl+","+yujiprice+",'"+xjrequestid+"','"+bijsubid+"','"+gxty+"','"+hxty+"')";
		baseJdbc.update(insql);
	}
}
%>

                                                                                       