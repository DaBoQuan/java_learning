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
<%
	BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
	String supcode=StringHelper.null2String(request.getParameter("supcode"));//供应商简码
	String cabtype1=StringHelper.null2String(request.getParameter("cabtype"));
	StringBuffer buf = new StringBuffer();

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
.float_header{ 
	position: relative;
	top: expression(eval(this.parentElement.parentElement.parentElement.scrollTop-2)); 
}
td.td3{ 
 position: relative ; 
 LEFT: expression(this.parentElement.offsetParent.parentElement.scrollLeft);
	white-space: nowrap; left:0;
	height: 22px;
    font-size:12px; 
    PADDING-RIGHT: 4px; 
    PADDING-LEFT: 4px;     
    TEXT-DECORATION: none; 
    color:#000; 

} 
</style>
<script type='text/javascript' language="javascript" src='/js/main.js'></script>


<!--<div id="warpp" style="height:600px;overflow-y:auto">-->

<div id="warpp" style="BORDER-BOTTOM: #000000 0px solid; BORDER-LEFT: #000000 0px solid; WIDTH: 100%; OVERFLOW: scroll; BORDER-TOP: #000000 0px solid; BORDER-RIGHT: #000000 0px solid">

<table id="dataTable" style="BORDER-COLLAPSE: collapse" border=1 cellSpacing=0 cellPadding=0   style="width: 100%;font-size:12" bordercolor="#adae9d">
<TR height="25"  class="title">
	<TD  noWrap class="td3"  align=center>出口编号</TD>
	<TD  noWrap class="td2"  align=center>销售凭证</TD>
	<TD  noWrap class="td2"  align=center>支付对象</TD>
	<TD  noWrap class="td2"  align=center>产品大类</TD>
	<TD  noWrap class="td2"  align=center>预计结关日期</TD>
	<TD  noWrap class="td2"  align=center>起运港</TD>
	<TD  noWrap class="td2"  align=center>目的港</TD>
	<TD  noWrap class="td2"  align=center>柜型</TD>
	<TD  noWrap class="td2"  align=center>柜数</TD>
	<TD  noWrap class="td2"  align=center>USD/保险费</TD>
	<TD  noWrap class="td2"  align=center>委托人</TD>

</TR>
	<%

	String sql="select a.exnum,a.yjjgdate,a.cabitype,a.cabnum,a.payto,(select (select pcategory from uf_tr_prodcate where requestid=goodsgroup) from uf_tr_expboxmain where requestid=a.exnumid ) as groupname,(select salepzno from uf_tr_expboxmain where requestid=a.exnumid ) as salepzno,(select describe from uf_tr_gkwhd where requestid=a.gygang) gygang1,(select describe from uf_tr_gkwhd where requestid=a.mdgang) mdgang1,(select wm_concat(objname) from humres where instr(a.jbname,id)>0) as objname,sum(taxamount) taxamount from uf_tr_exdzdetailf a group by a.exnum,a.yjjgdate,a.cabitype,a.cabnum,a.payto,exnumid,gygang,mdgang,jbname order by exnumid";
	List list = baseJdbc.executeSqlForList(sql);
	Map map=null;
	//System.out.println(list.size());
	if(list.size()>0){
		for(int k=0;k<list.size();k++)
		{

			map = (Map)list.get(k);
			String exnum=StringHelper.null2String(map.get("exnum"));//出口编号
			String salepzno=StringHelper.null2String(map.get("salepzno"));//产品大类
			String goodsgroup=StringHelper.null2String(map.get("groupname"));//产品大类
			String yjjgdate=StringHelper.null2String(map.get("yjjgdate"));//预计结关日期
			String gygang=StringHelper.null2String(map.get("gygang1"));//起运港
			String mdgang=StringHelper.null2String(map.get("mdgang1"));//目的港
			String cabitype=StringHelper.null2String(map.get("cabitype"));//柜型
			String cabnum=StringHelper.null2String(map.get("cabnum"));//柜数
			String jbname=StringHelper.null2String(map.get("objname"));//委托人
			String taxamount=StringHelper.null2String(map.get("taxamount"));
			String payto=StringHelper.null2String(map.get("payto"));
			supcode=payto;
			%>
			<TR >


				<TD  noWrap class="td3"  align=center><%=exnum%></TD>
				<TD  noWrap class="td2"  align=center><%=salepzno%></TD>
				<TD  noWrap class="td2"  align=center><%=supcode%></TD>
				<TD  noWrap class="td2"  align=center><%=goodsgroup%></TD>
				<TD  noWrap class="td2"  align=center><%=yjjgdate%></TD>
				<TD  noWrap class="td2"  align=center><%=gygang%></TD>
				<TD  noWrap class="td2"  align=center><%=mdgang%></TD>
				<TD  noWrap class="td2"  align=center><%=cabitype%></TD>
				<TD  noWrap class="td2"  align=center><%=cabnum%></TD>
				<TD  noWrap class="td2"  align=center><%=taxamount%></TD>
				<TD  noWrap class="td2"  align=center><%=jbname%></TD>
			</TR>
			<%

		}
	}
%>
</table>
</div>                    