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
<%@ page import="com.sap.conn.jco.JCoTable" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>
<%@ page import="com.eweaver.app.configsap.SapSync"%>
<%@ page import="java.text.DecimalFormat;"%>

<%
String requestid = StringHelper.null2String(request.getParameter("requestid"));
BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
//String nodeshow=StringHelper.null2String(request.getParameter("nodeshow"));//עǰޚ֣ìӾӘؖ׎c

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

<div id="warpp"  >
<table id="dataTable1" style="BORDER-COLLAPSE: collapse" border=1 cellSpacing=0 cellPadding=0   style="width: 100%;font-size:12" bordercolor="#adae9d">
<COLGROUP>
<COL width="8%">
<COL width="10%">
<COL width="8%">
<COL width="10%">
<COL width="8%">
<COL width="8%">
<COL width="8%">
<COL width="8%">
<COL width="8%">
<COL width="8%">
<COL width="8%">
<COL width="8%">

</COLGROUP>
<TR height="25"  class="title">
<TD  noWrap class="td2"  align=center>Serial Number</TD><!--���-->
<TD  noWrap class="td2"  align=center>Customer/Supplier Logo</TD><!--�ͻ�/��Ӧ�̱�ʶ-->
<TD  noWrap class="td2"  align=center>Subject</TD><!--��Ŀ-->
<TD  noWrap class="td2"  align=center>Special Ledger Logo</TD><!--�ر����˱�ʶ-->
<TD  noWrap class="td2"  align=center>Clear Voucher Number</TD><!--������ƾ֤���-->
<TD  noWrap class="td2"  align=center>Fiscal Year</TD><!--������-->
<TD  noWrap class="td2"  align=center>Clear Voucher Line</TD><!--������ƾ֤���-->
<TD  noWrap class="td2"  align=center>Clear Lave Amount</TD><!--����ʣ����-->
<TD  noWrap class="td2"  align=center>Local Amount</TD><!--��λ�ҽ��-->
<TD  noWrap class="td2"  align=center>Order NO</TD><!--�ɹ�������-->
<TD  noWrap class="td2"  align=center>Order Item</TD><!--�ɹ��������-->
<TD  noWrap class="td2"  align=center>Clear Text</TD><!--�����ı�-->
</tr>

<%
String sql = "select id,requestid,sno,custsuppflag,custsuppcode,ledgerflag,clearreceiptid,fiscalyear,clearreceiptitem,surplusmoney,cleartext,rmbamount,pono,poitem from uf_dmph_uncleariinfo where requestid = '"+requestid+"' order by sno asc";
List sublist = baseJdbc.executeSqlForList(sql);
if(sublist.size()>0)
{
	for(int i = 0;i<sublist.size();i++)
	{
		Map m = (Map)sublist.get(i);
		String no = StringHelper.null2String(m.get("sno"));//���
		String custsuppflag = StringHelper.null2String(m.get("custsuppflag"));//�ͻ�/��Ӧ�̱�ʶ
		String custsuppcode = StringHelper.null2String(m.get("custsuppcode"));//�ͻ�/��Ӧ�̱���
		String ledgerflag = StringHelper.null2String(m.get("ledgerflag"));//�������˱�ʶ
		String clearreceiptid = StringHelper.null2String(m.get("clearreceiptid"));//������ƾ֤���
		String fiscalyear = StringHelper.null2String(m.get("fiscalyear"));//������
		String clearreceiptitem = StringHelper.null2String(m.get("clearreceiptitem"));//������ƾ֤���
		String surplusmoney = StringHelper.null2String(m.get("surplusmoney"));//����ʣ����
		String cleartext = StringHelper.null2String(m.get("cleartext"));//�����ı�
		String rmbamount = StringHelper.null2String(m.get("rmbamount"));
		String pono = StringHelper.null2String(m.get("pono"));//�ɹ�������
		String poitem = StringHelper.null2String(m.get("poitem"));//�ɹ��������
	%>
			<TR id="<%="dataDetail_"+no %>">
			<TD   class="td2"  align=center><input type="checkbox" id="<%="checkbox_"+no %>" name="no"><%=no %></TD>
			<TD  class="td2"   align=center ><%=custsuppflag %></TD>
			<TD  class="td2"   align=center ><%=custsuppcode %></TD>
			<TD  class="td2"   align=center ><%=ledgerflag %></TD>
			<TD   class="td2"  align=center><%=clearreceiptid %></TD>
			<TD   class="td2"  align=center><%=fiscalyear %></TD>
			<TD   class="td2"  align=center><%=clearreceiptitem %></TD>
			<TD   class="td2"  align=center><%=surplusmoney %></TD>
			<TD   class="td2"  align=center><%=rmbamount %></TD>
			<TD   class="td2"  align=center><%=pono %></TD>
			<TD   class="td2"  align=center><%=poitem %></TD>
			<TD   class="td2"  align=center><%=cleartext %></TD>
			</TR>
	<%
	}
}else{%> 
	<TR class="tr1"><TD class="td2" colspan="12">NO Message!</TD></TR>
<%} %>
</table>
</div>
