<%@ page contentType="text/html;charset=gb2312" pageEncoding="GB2312" session="true"%>
<%request.setCharacterEncoding("GB2312");%>
<%@ include file="private.jsp"%>
<%
/*
*######################################
* eWebEditor v3.80 - Advanced online web based WYSIWYG HTML editor.
* Copyright (c) 2003-2006 eWebSoft.com
*
* For further information go to http://www.ewebsoft.com/
* This copyright notice MUST stay intact for use.
*######################################
*/


sPosition = sPosition + "��̨������ҳ";

out.print(Header());


	%>

	<table border=0 cellspacing=1 align=center class=navi>
	<tr><th><%=sPosition%></th></tr>
	</table>

	<br>

	<table border=0 cellspacing=1 align=center class=list>
	<tr><th colspan=2>eWebEditor 3.8 ��Ȩ��������ϵ����������֧��</th></tr>
	<tr>
		<td width="15%">����汾��</td>
		<td width="85%">eWebEditor Version 3.8 ��������רҵ��</td>
	</tr>
	<tr>
		<td width="15%">��Ȩ���У�</td>
		<td width="85%"><a href="http://www.ewebsoft.com" target="_blank">eWebSoft.com</a>&nbsp;&nbsp;�ѻ�ù��Ұ�Ȩ�ְ䷢�ġ�������������Ȩ�Ǽ�֤�顷,�ǼǺ�:2004SR06549</td>
	</tr>
	<tr>
		<td width="15%">����������</td>
		<td width="85%">eWeb�����Ŷ�</td>
	</tr>
	<tr>
		<td width="15%">��ҳ��ַ��</td>
		<td width="85%"><a href="http://www.eWebSoft.com" target=_blank>http://www.eWebSoft.com</a>&nbsp;&nbsp;&nbsp;<a href="http://www.webasp.net" target=_blank>http://www.webasp.net</a></td>
	</tr>
	<tr>
		<td width="15%">��Ʒ���ܣ�</td>
		<td width="85%"><a href="http://www.eWebEditor.net" target=_blank>http://www.eWebEditor.net</a></td>
	</tr>
	<tr>
		<td width="15%">��̳��ַ��</td>
		<td width="85%"><a href="http://bbs.webasp.net" target=_blank>http://bbs.webasp.net</a></td>
	</tr>
	<tr>
		<td width="15%">��ϵ��ʽ��</td>
		<td width="85%">OICQ:589808&nbsp;&nbsp;&nbsp;&nbsp;Email:<a href="mailto:service@ewebsoft.com">service@ewebsoft.com</a></td>
	</tr>
	</table>

	<br>

	<table border=0 cellspacing=1 align=center class=list>
	<tr><th colspan=2>���������йز���</th></tr>
	<tr>
		<td width="20%">����������</td>
		<td width="80%"><%=request.getServerName()%></td>
	</tr>
	<tr>
		<td width="20%">������IP��</td>
		<td width="80%"><%=request.getRemoteAddr()%></td>
	</tr>
	<tr>
		<td width="20%">�������˿ڣ�</td>
		<td width="80%"><%=String.valueOf(request.getServerPort())%></td>
	</tr>
	<tr>
		<td width="20%">������ʱ�䣺</td>
		<td width="80%"><%=(new java.util.Date() ).toLocaleString()%></td>
	</tr>
	<tr>
		<td width="20%">URI·����</td>
		<td width="80%"><%=request.getRequestURI()%></td>
	</tr>
	<tr>
		<td width="20%">Servlet·����</td>
		<td width="80%"><%=request.getServletPath()%></td>
	</tr>
	<tr>
		<td width="20%">Context·����</td>
		<td width="80%"><%=request.getContextPath()%></td>
	</tr>
	<tr>
		<td width="20%">����·����</td>
		<td width="80%"><%=application.getRealPath("/")%></td>
	</tr>
	<tr>
		<td width="20%">Server Info��</td>
		<td width="80%"><%=getServletConfig().getServletContext().getServerInfo()%></td>
	</tr>
	</table>

<%
out.print(Footer());
%>
