<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.eweaver.utility.*" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.BaseContext"%>
<%@ page import="com.eweaver.humres.base.service.HumresService"%>
<%@ page import="com.eweaver.humres.base.model.Humres"%>
<%@ page import="com.eweaver.base.selectitem.model.Selectitem" %>
<%@ page import="com.eweaver.base.selectitem.service.SelectitemService"%>
<%@ page import="com.eweaver.base.orgunit.service.OrgunitService"%>
<%@ page import="com.eweaver.humres.base.service.HumresService"%>
<%
String senddatebeg =request.getParameter("senddatebeg");
String operator =request.getParameter("operator");
if(operator==null) operator="";
Date date=new Date();
String shijian="";
SimpleDateFormat formater=new SimpleDateFormat();
formater.applyPattern("yyyy-MM-dd");
shijian=formater.format(date);
if(senddatebeg==null) senddatebeg="";
if(senddatebeg.length()<1) senddatebeg=shijian; 
String senddateend =request.getParameter("senddateend");
if(senddateend==null) senddateend="";
if(senddateend.length()<1) senddateend= shijian;
senddateend = senddateend;
String action=request.getParameter("action");
if(action==null) action="";
String 	where="";
where = " and a.operator='"+operator+"' and f.submitdate||' '||f.submittime>= '"+senddatebeg+"' and f.submitdate||' '||f.submittime<='"+senddateend+" 23:59:59"+"'";
DataService ds = new DataService();
%>
<%!
	/**
	 * 取select字段字典值。
	 * @param dicID。
	 * @return dicValue。
	 */
	private String getSelectDicValue(String dicID)
	{
		if(dicID==null||dicID.length()<1)return "";
		String dicValue="";
		DataService ds = new DataService();
		return ds.getValue("select OBJNAME from selectitem where id='"+dicID+"'");
	}
	/**
	 * 取brower框字典值。
	 * @param dicID。
	 * @return dicValue。
	 */
	private String getBrowserDicValue(String tab,String idCol,String valueCol,String dicID)
	{
		if(dicID==null||dicID.length()<1)return "";
		String dicValue="";
		DataService ds = new DataService();
		return ds.getValue("select "+valueCol+" from "+tab+" where "+idCol+"='"+dicID+"'");
	}
	
	/**
	 * 取批量brower框字典值。
	 * @param dicID。
	 * @return dicValue。
	 */
	private String getBrowserDicValues(String tab,String idCol,String valueCol,String dicID)
	{
		String dicValue="";
		if(dicID==null||dicID.length()<1)return "";
		String[] dicIDs = dicID.split(",");
		DataService ds = new DataService();
		for(int i=0,size=dicIDs.length;i<size;i++)
		{
			dicValue=dicValue+","+ds.getValue("select "+valueCol+" from "+tab+" where "+idCol+"='"+dicIDs[i]+"'");
		}
		if(dicValue.length()<1)dicValue="";
		else dicValue=dicValue.substring(1,dicValue.length());
		return dicValue;
	}

%>
<%@ include file="/base/init.jsp"%>
<%

if(request.getMethod().equalsIgnoreCase("post") && action.equalsIgnoreCase("search")){
	String excel=request.getParameter("exportType");
	if(excel==null) excel="";
	boolean isExcel=excel.equalsIgnoreCase("excel");
	pageContext.setAttribute("isExcel",isExcel);
	if(isExcel){//导出Ｅｘｃｅｌ
		String fname=labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003a")+getBrowserDicValue("humres","id","objname",operator)+".xls";//工作流处理响应详情-
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("content-type","application/vnd.ms-excel");
		response.addHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(fname,"utf-8"));
	}
}
%>
<c:if test="${!isExcel}">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003b")%><!-- 工作流处理响应详情 --></title>
<link rel="stylesheet" type="text/css" href="/js/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/js/ext/resources/css/tree.css" />
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/ext/ux/iconMgr.js"></script>
<script type="text/javascript" src="/js/ext/ux/toolbar.js"></script>
<link rel="stylesheet" type="text/css" href="/css/eweaver.css" />
<script src='/dwr/interface/DataService.js'></script>
<script src='/dwr/engine.js'></script>
<script src='/dwr/util.js'></script>

<script language="JScript.Encode" src="/js/rtxint.js"></script>
<script language="JScript.Encode" src="/js/browinfo.js"></script>
<script type="text/javascript" src="/js/jquery-latest.pack.js"></script>
<script type="text/javascript" src="/js/ext/ux/miframe.js"></script>
<script type="text/javascript" src="/js/jquery-latest.pack.js"></script>
<script type='text/javascript' src='/js/tx/jquery.autocomplete.pack.js'></script>
<script type="text/javascript" src="/js/ext/ux/iconMgr.js"></script>
<script type="text/javascript" src="/js/ext/ux/AutoRefresher.js"></script>
<link rel="stylesheet" type="text/css" href="/js/tx/jquery.autocomplete.css"/>
<script type="text/javascript" language="javascript" src="/datapicker/WdatePicker.js"></script>
<style>
ul li ol{margin-left:10px;}
table{width:auto;}
.x-window-footer table,.x-toolbar table{width:auto;}
</style>
</head>
<script type="text/vbscript">
sub getrefobj(inputname,inputspan,refid,viewurl,isneed)
	ids = window.showModalDialog("/base/popupmain.jsp?url=/base/refobj/baseobjbrowser.jsp?id="+refid)
	if (Not IsEmpty(ids)) then
	if ids(0) <> "0" then
		document.all(inputname).value = ids(0)
		document.all(inputspan).innerHtml = ids(1)
	else 
		document.all(inputname).value = ""
		if isneed="0" then
		document.all(inputspan).innerHtml = ""
		else
		document.all(inputspan).innerHtml = "<img src=/images/checkinput.gif>"
		end if
	end if
	end if
end sub

sub getdate(inputname,spanname,isneed)
	returnvalue = window.showModalDialog("/plugin/calendar.jsp",,"dialogHeight:320px;dialogwidth:275px")
	if (Not IsEmpty(returnvalue)) then
		document.all(inputname).value = returnvalue
		document.all(spanname).innerHtml = returnvalue
		if (returnvalue="" and isneed="1") then
			document.all(spanname).innerHtml = "<img src=/images/checkinput.gif>"
		end if
	end if
end sub
</script>
<script type="text/javascript">
WeaverUtil.imports(['/dwr/engine.js','/dwr/util.js','/dwr/interface/TreeViewer.js']);
Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';

var topBar=null;
WeaverUtil.load(function(){
	var div=document.createElement("div");
	div.id="pagemenubar";
	Ext.getBody().insertFirst(div);
	topBar = new Ext.Toolbar();
	topBar.render('pagemenubar');
	topBar.addSeparator();
	//addBtn(topBar,'保存为HTML','H','html_go',Save2Html);
	
	addBtn(topBar,'<%=labelService.getLabelNameByKeyId("402881eb0bcbfd19010bcc6e71870022")%>','S','accept',function(){onSearch()});//确定
	topBar.addSpacer();
	topBar.addSpacer();
	topBar.addSeparator();
	addBtn(topBar,'<%=labelService.getLabelNameByKeyId("402883d934c2275b0134c2275c7c0025")%>','E','page_excel',Save2Excel);//导出为Excel
	var idx=location.href.indexOf('?');
    if(idx>0)
    document.formExport.action= document.formExport.action+location.href.substring(idx);
});
function Save2Html(){
	document.getElementById('exportType').value="html";
	document.formExport.target="_blank";
	document.formExport.submit();
}
function Save2Excel(){
	document.getElementById('exportType').value="excel";
	//document.formExport.target="_blank";
	document.formExport.submit();
}
function onSearch(){
	if(checkIsNull())
		document.formExport.submit();
}
function checkIsNull()
{
	var year=document.getElementsByName('year');
	if(year[0].value==null||year[0].value=='')
	{
		alert("<%=labelService.getLabelNameByKeyId("402883de35273f910135273f955b005e")%>");//年度必须选择!
		return false;
	}
	return true;
}
</script>
</head>

<body>
<form action="/app/humres/workflowRoportDetail.jsp" name="formExport" method="post">
<input type="hidden" name="action" value="search"/>
<input type="hidden" name="operator" value="<%=operator%>"/>
<input type="hidden" name="exportType" id="exportType" value=""/>
<TABLE id=myTable width="100%" bgcolor="#BDEBF7">
<TBODY>
<TR class=title>
<TD  noWrap width="5%"><%=labelService.getLabelNameByKeyId("402883de352db85b01352db85e150034")%><!-- 工作到达时间 --></td> 
<TD class=FieldValue width="25%"><input type=text class=inputstyle readonly size=20 name="senddatebeg"  value="<%=senddatebeg%>" onclick="WdatePicker()">
                    -
                <input type=text class=inputstyle size=20 readonly name="senddateend"  value="<%=senddateend%>" onclick="WdatePicker()"> <span style="color:red">不填写默认当天<span/>  </TD>
</tr></tbody></table>
<br>
</c:if>
<div style="font-size:15;font-weight:bold;height:20;" valign='middle'><CENTER><%=labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003a")%><!-- 工作流处理响应详情- --><%=getBrowserDicValue("humres","id","objname",operator)%></CENTER></div>
<CENTER>
<table cellspacing="0" cellpadding="0" border="1" style="border-collapse:collapse;width:900" bordercolor="#333333" width="100%">
	<colgroup>
	<col width="200" />
  <col width="120" />
  <col width="100" />
  <col width="40" />
	<col width="120" />
  <col width="120" />
  <col width="80" />
  </colgroup>
   <tr style="background:#E0ECFC;border:1px solid #c3daf9;height:30;">
    <td colspan="7"  align="center" style="font-size:15;"><%=labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003b")%><!-- 工作流处理响应详情 --></td>
  </tr>
   <tr style="background:#E0ECFC;border:1px solid #c3daf9;height:30;">
	 <td rowspan="2"  align="center"><%=labelService.getLabelNameByKeyId("402881eb0bcbfd19010bcc0939c60009")%><!-- 标题 --></td>
	 <td rowspan="2"  align="center"><%=labelService.getLabelNameByKeyId("402881e90c63546b010c638f6bcc0032")%><!-- 工作流 --></td>
	 <td rowspan="2"  align="center"><%=labelService.getLabelNameByKeyId("402881f00c7690cf010c76b1f3260037")%><!-- 节点 --></td>
	 <td rowspan="2"  align="center"><%=labelService.getLabelNameByKeyId("402881eb0c9fadb1010c9fd1a069000e")%><!-- 操作 --></td>
	 <td colspan="3"  align="center"><%=labelService.getLabelNameByKeyId("402883d934cfcad30134cfcad45f0074")%><!-- 处理 --></td>
  </tr>
	<tr height="39">
	<td colspan="1" height="30"  align="center"><%=labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003c")%><!-- 到达时间 --></td>
	<td colspan="1" align="center" ><%=labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003d")%><!-- 处理时间 --></td>
	<td colspan="1" align="center" ><%=labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003e")%><!-- 处理耗时(小时) --></td>
	</tr>
<%
		//String sql = "select distinct c.workflowid,c.requestname,c.createdate||' '||c.createtime createtime,c.flowno,a.stepid,a.operator,a.logtype,b.submitdate||' '||b.submittime operatortime,f.submitdate||' '||f.submittime receivetime, round((to_date(b.submitdate||' '||b.submittime,'yyyy-mm-dd hh24:mi:ss')-to_date(f.submitdate||' '||f.submittime,'yyyy-mm-dd hh24:mi:ss'))*24,1) timeout, B.REQUESTID,b.nodeid,f.submitdate,f.submittime from requestlog a,requeststep b,requestbase c ,requeststatus e,requeststep f where A.STEPID=B.ID and C.ID=A.REQUESTID and b.id=e.curstepid andf.id=nvl((select laststepid from (select h.laststepid,g.id from requeststep g,requeststatus h where g.id=h.curstepid and g.requestid=a.requestid and h.requestid=a.requestid  and g.requestid=h.requestid and g.nodeid=b.nodeid) start with id=e.laststepid   connect by prior  laststepid=id and rownum=1 ),e.laststepid)   and logtype<>'402881e50c5b4646010c5b5afd170008' and b.submitdate is not null and f.submitdate is not null and round((to_date(b.submitdate||' '||b.submittime,'yyyy-mm-dd hh24:mi:ss')-to_date(f.submitdate||' '||f.submittime,'yyyy-mm-dd hh24:mi:ss'))*1440,1)>0 and c.workflowid in (select workflowid from uf_work_flowmonitor where nvl(ifmonitor,'4028803b213cb1c001213cfd84fc00b4')='4028803b213cb1c001213cfd84fc00b3') "+where+" order by f.submitdate desc,f.submittime desc";
		String sql = "select distinct c.workflowid,c.requestname,c.createdate||' '||c.createtime createtime,c.flowno,a.stepid,a.operator,a.logtype,b.submitdate||' '||b.submittime operatortime,f.submitdate||' '||f.submittime receivetime, round((to_date(b.submitdate||' '||b.submittime,'yyyy-mm-dd hh24:mi:ss')-to_date(f.submitdate||' '||f.submittime,'yyyy-mm-dd hh24:mi:ss'))*24,1) timeout, B.REQUESTID,b.nodeid,f.submitdate,f.submittime from requestlog a,requeststep b,requestbase c ,requeststatus e,requeststep f where A.STEPID=B.ID and C.ID=A.REQUESTID and b.id=e.curstepid and f.id=nvl((select laststepid from (select h.laststepid,g.id from requeststep g,requeststatus h where g.id=h.curstepid and g.requestid=a.requestid and h.requestid=a.requestid  and g.requestid=h.requestid and g.nodeid=b.nodeid) start with id=e.laststepid   connect by prior  laststepid=id and rownum=1 ),e.laststepid)   and logtype<>'402881e50c5b4646010c5b5afd170008' and b.submitdate is not null and f.submitdate is not null and round((to_date(b.submitdate||' '||b.submittime,'yyyy-mm-dd hh24:mi:ss')-to_date(f.submitdate||' '||f.submittime,'yyyy-mm-dd hh24:mi:ss'))*1440,1)>0 and c.workflowid in (select workflowid from uf_work_flowmonitor where nvl(ifmonitor,'4028803b213cb1c001213cfd84fc00b4')='4028803b213cb1c001213cfd84fc00b3') "+where+" order by f.submitdate desc,f.submittime desc";
		List mnglist = ds.getValues(sql);
		StringBuffer cont = new StringBuffer();
		double sumtimeout = 0.0;
		for(int i=0,size=mnglist.size();i<size;i++)
		{
			Map m = (Map)mnglist.get(i);
			String workflowid = m.get("workflowid").toString();
			String requestname = m.get("requestname").toString();
			String flowno = m.get("flowno")==null?"":m.get("flowno").toString();
			String logtype =  m.get("logtype")==null?"":m.get("logtype").toString();
			String operatortime =m.get("operatortime")==null?"":m.get("operatortime").toString(); 
			String receivetime = m.get("receivetime")==null?"":m.get("receivetime").toString();
			String timeout = m.get("timeout")==null?"":m.get("timeout").toString();
			sumtimeout=sumtimeout+Double.valueOf(timeout);
			String nodeid = m.get("nodeid")==null?"":m.get("nodeid").toString();
			cont.append("<tr height=\"39\">");
			cont.append("<td height=\"39\"  align=\"center\">"+requestname+"</td>");
			cont.append("<td colspan=\"1\"  align=\"center\">"+getBrowserDicValue("WORKFLOWINFO","id","objname",workflowid)+"</td>");
			cont.append("<td colspan=\"1\"  align=\"center\">"+getBrowserDicValue("NODEINFO","id","objname",nodeid)+"</td>");
			cont.append("<td colspan=\"1\"  align=\"center\" style=\"color:#C92BDB\">"+getSelectDicValue(logtype)+"</td>");
			cont.append("<td colspan=\"1\"  align=\"center\">"+receivetime+"</td>");
			cont.append("<td colspan=\"1\"  align=\"center\">"+operatortime+"</td>");
			cont.append("<td colspan=\"1\"  align=\"center\" style=\"color:#220DDD\">"+timeout+"</td>");
			cont.append("</tr>");

	}
	if(mnglist.size()>0)
	{
		cont.append("<tr height=\"39\" bgcolor=\"#717171\">");
		cont.append("<td height=\"39\" colspan=4  align=\"center\">"+labelService.getLabelNameByKeyId("402883d934c2013a0134c2013b71000e")+"：</td>");//合计
		cont.append("<td colspan=\"1\"  align=\"center\">"+labelService.getLabelNameByKeyId("402883de352db85b01352db85e15003f")+"&nbsp;"+mnglist.size()+"&nbsp;"+labelService.getLabelNameByKeyId("402883d934ca4ec50134ca4ec713003e")+"</td>");//工作//项
		cont.append("<td colspan=\"2\"  align=\"center\">"+labelService.getLabelNameByKeyId("402883de352db85b01352db85e150040")+":&nbsp;"+Math.round(sumtimeout/mnglist.size()*100)/100.0+"&nbsp;"+labelService.getLabelNameByKeyId("402883de352db85b01352db85e150041")+"</td>");//平均耗时//分钟
		cont.append("</tr>");
	}
	out.println(cont.toString());
%>
</table>
</div>
<c:if test="${!isExcel}">
</body>
</html>
</c:if>