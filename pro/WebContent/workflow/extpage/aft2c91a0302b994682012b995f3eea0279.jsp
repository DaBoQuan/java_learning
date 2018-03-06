<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.eweaver.base.security.service.acegi.EweaverUser" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.eweaver.base.msg.*"%>
<%@ page import="org.springframework.jdbc.core.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
//---------------------------------------
String requestid= request.getParameter("requestid");
String targeturl = request.getParameter("targeturl");
String operatemode = request.getParameter("operatemode");
String otherextpages = StringHelper.null2String(request.getParameter("otherextpages"));
String directnodeid = StringHelper.null2String(request.getParameter("directnodeid"));
String userId = BaseContext.getRemoteUser().getId();
DataService dataService = new DataService();
BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
//�ύ��
if(operatemode.equals("submit")||operatemode.equals("save")){
	String sql = "select mainbodyattach from uf_doc_ratifymain where requestid='"+requestid+"'";
          String docId ="";
	List checklist= baseJdbc.executeSqlForList(sql);

	if(checklist.size()>0){
		Map m1 = (Map)checklist.get(0);
         docId = StringHelper.null2String(m1.get("mainbodyattach"));
      //ɾ���༭Ȩ��
        String permissionSQL = "update permissiondetail set opttype=3 where objid='"+docId+"' and userid='"+userId+"' and opttype>14";
        dataService.executeSql(permissionSQL);
		//����ǩ��
		EweaverMessageProducer producer = (EweaverMessageProducer) BaseContext.getBean("eweaverMessageProducer");
		EweaverMessage msg = new EweaverMessage();
		Map map = new HashMap();
		map.put("docId",docId);//�ĵ�ID
		map.put("nodeNO",2);//�ڵ���(��Ӧ�����е�5���ڵ㣬1Ϊ�����ڵ㣬5δ��ӡ�ڵ㣬2��3��4Ϊ�����ڵ�)
		map.put("userId",userId);//��ǰ�ڵ������ID
		msg.setParaMap(map);
		msg.setMsgtype(EweaverMessage.MESSAGE_TYPE_USER);
		msg.setUserKey("signatureMessage");
		producer.send(msg);
	}
           if("submit".equals(operatemode)){
                     String getIds="select mainbodyattach from uf_doc_ratifymain where requestid='"+requestid+"'";
                     List<Map> listIds=baseJdbc.executeSqlForList(getIds);
                     String docid="";
                     if(listIds.size()>0){
                         Map map=(Map)listIds.get(0);
                         docid=StringHelper.null2String(map.get("mainbodyattach"));
                     }
		String sql1="select humres.objname as ZRZ,attach.id as did, uf.docno as JSH,attach.filedir as EFILENAME,"
				+"uf.remark as BZ,"
				+"nvl(uf.a3+uf.a4,0) as pages ,case when docbase.attachnum=0 then 0 else 1  end as ISCOVEREFILE, "
				+"uf.docname as title,attach.objname as docstyle "
				+"from uf_doc_ratifymain uf,docbase ,docattach  ,attach  ,humres   " 
				+"where uf.mainbodyattach=docbase.id  "
				+"and docbase.id=docattach.objid  "
				+"and docbase.creator=humres.id "
				+"and attach.id=docattach.attachid "
				+"and uf.requestid='"+requestid+"'"
                                           +" and docbase.id='"+docid+"'";
				
		List list1=baseJdbc.executeSqlForList(sql1);
		if(list1.size()>0){
			Map map = (Map)list1.get(0);
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			//����ʱ��
			String CREATETIME = sdf.format(date);
			//����id--DID
			String id1=StringHelper.null2String(map.get("did"));
			//�ĵ����
			String docno = StringHelper.null2String(map.get("JSH"));
			//���ĸ�����
			String title = StringHelper.null2String(map.get("title"));
			//��ע
			String remark = StringHelper.null2String(map.get("BZ"));
			//ҳ��
			int pages = Integer.parseInt(map.get("pages").toString());
			//������
			String ZRZ = StringHelper.null2String(map.get("ZRZ"));
			//�Ƿ��и���
			int ISCOVEREFILE = Integer.parseInt(map.get("ISCOVEREFILE").toString());
			//��չ��
			String extall = StringHelper.null2String(map.get("docstyle"));
			String ext = "";
			String[] extArray =extall.split("\\.");
			if(extArray.length>0){
				ext=extArray[extArray.length-1];
			}
			//������������
			String pzm="ftpserver";
			String efilenameAll =  StringHelper.null2String(map.get("efilename"));
			//�����ļ�·��
			String[] pathnameArray = efilenameAll.split("\\\\");
			String pathname1="";
			String pathname2="";
			String filenamemd5="";
			if(pathnameArray.length>0){
				pathname1 = pathnameArray[pathnameArray.length-3];
				pathname2 = pathnameArray[pathnameArray.length-2];
				filenamemd5= pathnameArray[pathnameArray.length-1];
			}
			String pathname=pathname1+"\\"+pathname2;
			//�����ļ����ƣ����ܺ������.��չ����
			String efilename =filenamemd5;
			System.out.println("filenamemd5---"+filenamemd5);
			//----------------------------

                                JdbcTemplate jdbctemp=BaseContext.getJdbcTemp("ftds");
			String sql3="";
                                List  ls=jdbctemp.queryForList("select did from D_FILE9 where JSH='"+docno+"'");
System.out.println("---------docno-------------"+docno);
			if(ls.size()>0){
		          }
			else{
				sql3="insert into D_FILE9(DID,JSH,TITLE,Createtime,YS,ZRZ,ISCOVEREFILE,BZ,isConverted)"
				+" values('"+id1+"','"+docno+"','"+StringHelper.filterSqlChar(title)+"','"+CREATETIME+"',"+pages+",'"+ZRZ
				+"',"+ISCOVEREFILE+",'"+StringHelper.filterSqlChar(remark)+"',0)";
                                jdbctemp.execute(sql3);
			}
                                 ls=jdbctemp.queryForList("select did from E_FILE9 where DID='"+id1+"'");
                                 if(ls.size()>0){
		            } else{
			        sql3="insert into E_FILE9(DID,PID,JSH,EFILENAME,TITLE,EXT,PZM,PATHNAME,isConverted)"
				+" values('"+id1+"','"+id1+"','"+docno+"','"+StringHelper.filterSqlChar(efilename)+"','"+StringHelper.filterSqlChar(title)+"','"+ext
				+"','"+pzm+"','"+StringHelper.filterSqlChar(pathname)+"',0)";
                                        jdbctemp.execute(sql3);

			}
								

//---------------
		}
	}
	if(!StringHelper.isEmpty(otherextpages)){
		if(otherextpages.indexOf("/workflow/extpage/")<0)
			otherextpages = "/workflow/extpage/"+otherextpages;
		otherextpages += "?requestid="+StringHelper.null2String(requestid)+"&operatemode="+operatemode+"&directnodeid="+directnodeid+"&targeturl="+URLEncoder.encode(targeturl);
		response.sendRedirect(otherextpages);
		return;
	}
}
targeturl="/workflow/request/close.jsp?mode=submit";

%>
<script>
var commonDialog=top.leftFrame.commonDialog;
if(commonDialog){
	var frameid=parent.contentPanel.getActiveTab().id+'frame';
	var tabWin=parent.Ext.getDom(frameid).contentWindow;
	if(!commonDialog.hidden){
		commonDialog.hide();
		tabWin.location.reload();
	}else{
		tabWin.location.href="<%=targeturl%>";
	}
}
</script>

