
<%@ page language="java" contentType="text/html; charset=GBK" %>

<%
	response.setHeader("Expires", "-1") ; // '����ǰҳ����ΪΨһ���ҳ��,����ر����ҳ���Ժ�,������ҳ����ܱ�����
%>
<HTML xmlns:IE>
<HEAD>
	<TITLE>Calendar</TITLE>
	<STYLE>
	@media all 
	{
	  IE\:Calendar 
	  {
	    behavior: url(<%=request.getContextPath()%>/plugin/calendar.htc) ;
	  }
	}
	</STYLE>
<script>
function getTheDate() {
	themonth =cal.month;
	theday = cal.day;
	if(themonth<10) themonth ="0"+themonth;
	if(theday<10) theday ="0"+theday;
	window.returnValue =cal.year+'-'+themonth+'-'+theday ;
	window.close();
}
</script>	
</HEAD>

<BODY scroll="no">

<TABLE width=100% height=100% border=0 cellpadding=0 cellspacing=0>
<TR>
	<TD>
		<IE:Calendar id=cal style="height:100%;width:100%;border:1px solid black;">
		</IE:Calendar>
	</TD>
</TR>
<TR>
	<TD align=center height=30px>
		<TABLE border=0 cellpadding=2 cellspacing=0>
		<TR>
			<TD align="center"><input type="BUTTON" value="S-ȷ��" ACCESSKEY=S onclick="getTheDate()"></TD>
			<TD align="center"><input type="BUTTON" value="D-���" ACCESSKEY=D onclick="window.returnValue = '';window.close()"></TD>
			<TD align="center"><input type="BUTTON" value="C-ȡ��" ACCESSKEY=C onclick="window.close()"></td>                     
		</TR>
		</TABLE>
	</TD>
</TR>
</TABLE>
</BODY>
</HTML>


