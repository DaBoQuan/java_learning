<%@ page contentType="text/html; charset=gb2312"%>
<%@ page
	import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*"%>
<%@page import="com.eweaver.document.base.model.*" %>
<html>
	<head>
		<title>PDF�鿴</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script type="text/javascript">
	function Load() {
		webform.WebPDF.WebUrl = "/ServiceAction/com.eweaver.document.file.FileDownload?action=getKingGridPDF"; //WebUrl:ϵͳ������·������������ļ������������籣�桢���ĵ� 
		webform.WebPDF.RecordID = "<%=((Attach)request.getAttribute("attach")).getId()%>"; //RecordID:���ĵ���¼���
		webform.WebPDF.FileName = "<%=((Attach)request.getAttribute("attach")).getObjname()%>"; //FileName:�ĵ�����
		webform.WebPDF.UserName = "undefine"; //UserName:�����û���

		webform.WebPDF.ShowMenus = 0;//�˵����Ƿ�ɼ�
		webform.WebPDF.EnableTools("���Ϊ",2);//���Ϊ�Ƿ�ɼ�(0,���ã�1,���ã�2,���ɼ�)
		webform.WebPDF.EnableTools("�����ĵ�",2);//�����ĵ��Ƿ�ɼ�(0,���ã�1,���ã�2,���ɼ�)
		
		webform.WebPDF.ShowTools = 1; //�������ɼ���1,�ɼ���0,���ɼ���
		webform.WebPDF.SaveRight = 1; //�Ƿ������浱ǰ�ĵ���1,����0,������
		webform.WebPDF.PrintRight = 0; //�Ƿ������ӡ��ǰ�ĵ���1,����0,������
		webform.WebPDF.AlterUser = false; //�Ƿ������ɿؼ�������ʾ�� true��ʾ����  false��ʾ������

		webform.WebPDF.ShowBookMark = 1; //�Ƿ���ʾ��ǩ����ť��1,��ʾ��0,����ʾ��
		webform.WebPDF.ShowSigns = 1; //����ǩ�¹�������ǰ�Ƿ�ɼ���1,�ɼ���0,���ɼ���
		webform.WebPDF.SideWidth = 0; //���ò�����Ŀ��
		
		webform.WebPDF.WebOpen(); //�򿪸��ĵ�    ����OfficeServer��OPTION="LOADFILE"
		webform.WebPDF.Zoom = 100; //���ű���
		webform.WebPDF.Rotate = 360; //����ʾҳ�ͷŽǶ�
		webform.WebPDF.CurPage = 1; //��ǰ��ʾ��ҳ��
	}
</script>
	</head>
	<body onLoad="Load()" onUnload="" style="margin: 0px;">
		<!--�������˳�iWebPDF-->
		<form name="webform" method="post" action="DocumentSave.jsp">
			<object id="WebPDF" width="100%" height="100%" align="middle"
				border="0" classid="clsid:39E08D82-C8AC-4934-BE07-F6E816FD47A1"
				codebase="iWebPDF.cab#version=7,2,0,338" VIEWASTEXT>
			</object>
		</form>
	</body>
</html>