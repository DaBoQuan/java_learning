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
String requestid = StringHelper.null2String(request.getParameter("requestid"));

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
<script type='text/javascript' language="javascript" src='/js/main.js'></script>


<!--<div id="warpp" style="height:600px;overflow-y:auto">-->

 <DIV id="warpp">


<TABLE id=oTable40285a8d4d1ce05e014d1ce3ea1f001a class=detailtable border=1>
<CAPTION>总务用品验收明细表<SPAN id=div40285a8d4d1ce05e014d1ce3ea1f001abutton name="div40285a8d4d1ce05e014d1ce3ea1f001abutton">&nbsp;</SPAN></CAPTION>
<COLGROUP>
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%"></COLGROUP>
<TBODY>

<TR class=Header>
<TD noWrap>序号</TD>
<TD noWrap>&nbsp;申请单号</TD>
<TD noWrap>&nbsp;行号</TD>
<TD noWrap>申请部门</TD>
<TD noWrap>申请人</TD>
<TD noWrap>&nbsp;物品编码</TD>
<TD noWrap>品名</TD>
<TD noWrap>规格</TD>
<TD noWrap>单位</TD>
<TD noWrap>单价</TD>
<TD noWrap>申请数量</TD>
<TD noWrap>已发送数量</TD>
<TD noWrap>已验收数量</TD>
<TD noWrap>发送中数量</TD>
<TD noWrap>库存数量</TD>
<TD noWrap>未发送数量</TD>
<TD noWrap>本次发送数量</TD>
<TD noWrap>验收数量</TD>
<TD noWrap>是否结案</TD></TR>

<%
	String sql="select a.rowno,(select appnumber from uf_oa_generalsuppapp where requestid=a.zwsqnum) as zwsqnum,a.zwsqnum as zwrequestid,a.rowsidx,(select objname from orgunit where id=a.dept) as dept,(select objname from humres where id=a.applyer ) as applyer,(select goodsid from uf_oa_goodsmaintain  where requestid =a.doodsno) doodsno,a.doodsno as goodid,a.goodsname,a.specify,a.unit,a.price,a.neednum,a.hadsend,a.hadreceive,a.sendnore,a.storenum,a.notsendnum,a.sendnum,a.receivenum,(select objname from selectitem where id=a.isend) isend from uf_oa_recvdetail a  where a.requestid='"+requestid+"' order by a.rowno asc";

	List sublist = baseJdbc.executeSqlForList(sql);
	if(sublist.size()>0)
	{
		for(int k=0,sizek=sublist.size();k<sizek;k++)
		{
			Map mk = (Map)sublist.get(k);
			String rowno=StringHelper.null2String(mk.get("rowno"));
			String zwsqnum=StringHelper.null2String(mk.get("zwsqnum"));
			String zwrequestid=StringHelper.null2String(mk.get("zwrequestid"));
			String rowsidx=StringHelper.null2String(mk.get("rowsidx"));
			String dept=StringHelper.null2String(mk.get("dept"));
			String applyer=StringHelper.null2String(mk.get("applyer"));
			String doodsno=StringHelper.null2String(mk.get("doodsno"));
			String goodid=StringHelper.null2String(mk.get("goodid"));
			String goodsname=StringHelper.null2String(mk.get("goodsname"));
			String specify=StringHelper.null2String(mk.get("specify"));;
			String unit=StringHelper.null2String(mk.get("unit"));
			String price=StringHelper.null2String(mk.get("price"));
			String neednum=StringHelper.null2String(mk.get("neednum"));
			String hadsend=StringHelper.null2String(mk.get("hadsend"));
			String hadreceive=StringHelper.null2String(mk.get("hadreceive"));
			String sendnore=StringHelper.null2String(mk.get("sendnore"));
			String storenum=StringHelper.null2String(mk.get("storenum"));
			String notsendnum=StringHelper.null2String(mk.get("notsendnum"));
			String sendnum=StringHelper.null2String(mk.get("sendnum"));
			String receivenum=StringHelper.null2String(mk.get("receivenum"));
			String isend=StringHelper.null2String(mk.get("isend"));  
			String str="/workflow/request/workflow.jsp?requestid="+zwrequestid;
			String str1="/workflow/request/formbase.jsp?requestid="+goodid;		

			%>
			<TR >
			<TD noWrap><%=rowno%></TD>
			<TD noWrap><a href="javascript:onUrl('<%=str%>','<%=zwsqnum%>','<%="tab"+zwrequestid%>') "><%=zwsqnum%></a></TD>
			<TD noWrap><%=rowsidx%></TD>
			<TD noWrap><%=dept%></TD>
			<TD noWrap><%=applyer%></TD>
			<TD noWrap><a href="javascript:onUrl('<%=str1%>','<%=doodsno%>','<%="tab"+goodid%>') "><%=doodsno%></a></TD>
			<TD noWrap><%=goodsname%></TD>
			<TD noWrap><%=specify%></TD>
			<TD noWrap><%=unit%></TD>
			<TD noWrap><%=price%></TD>
			<TD noWrap><%=neednum%></TD>
			<TD noWrap><%=hadsend%></TD>
			<TD noWrap><%=hadreceive%></TD>
			<TD noWrap><%=sendnore%></TD>
			<TD noWrap><%=storenum%></TD>
			<TD noWrap><%=notsendnum%></TD>
			<TD noWrap><%=sendnum%></TD>
			<TD noWrap><%=receivenum%></TD>
			<TD noWrap><%=isend%></TD></TR>
			<%
		}
	}
	else
	{
	%> 
    <TR >
	<TD colspan=19>无相应数据</TD></TR>
	<%
	}
%>
</TBODY>
</table>
</div>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 