<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//��ǰ��������������ʵ�ʱ�
//��ID:4028818230686b49013069007363003b	�������뵥
//	��������:	mtype
//	��������:	mtopic
//	����״̬:	mstatus
//	��ʼ����:	mbdate
//	����ص�:	mloc
//	��������:	medate
//	�ڲ��μ���Ա:	iparticipant
//	�ⲿ�μ���Ա:	oparticipant
//	��������:	mpopu
//	��������:	mcircle
//	�ټ���:	morganizer
//	��ϵ��:	mcontact
//	������:	msponsor
//	������:	spondept
//	��������:	spontime
//	����:	attach
//	�Ƿ���Ҫ�ͻ�����:	isimportant
//	���õ�λ:	visitor
//	��������:	popuvs
//	�Ӵ�����:	reception
//	�д�������:	receman
//	��ע:	remarks
//	ǰ̨ppt:	ppt
//	ϯ������:	seatcard
//	��Ȫˮ:	mwater
//	��ˮ:	mtea
//	����:	mcoffee
//	����:	msbmilk
//	ˮ��:	mfruit
//	�ʻ�:	mflower
//	��Ӱ:	mfilm
//	¼��:	mreco
//	����:	others
//	������:	reqman
//	���벿��:	reqdept
//	����ʱ��:	reqtime
//	�ܲ���/�ֹ�˾:	orgid
//	��ǩ����:	csigndept
//	��ǩ��:	csignman
//	������:	copyreader
//	�Ƿ���ӵ������ճ�:	isadd
//	��������:	mname
//---------------------------------------
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/base/init.jsp"%>
<%@ page import="com.eweaver.base.util.StringHelper"%>
<%@ page import="com.eweaver.base.util.DateHelper"%>
<%@ page import="com.eweaver.base.BaseJdbcDao"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.eweaver.base.IDGernerator"%>
<%@ page import="java.util.*"%>
<%@page import="com.eweaver.workflow.request.service.RequestbaseService"%>
<%
   String requestid = request.getParameter("requestid");
   String operatemode = StringHelper.null2String(request.getParameter("operatemode"));
   String targeturl = request.getParameter("targeturl");
   String otherextpages = StringHelper.null2String(request.getParameter("otherextpages"));
   String directnodeid = StringHelper.null2String(request.getParameter("directnodeid"));
   BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
   String meetroominfosql = "select mloc,mbdate,medate,mcircle from uf_admin_meeting " + 
            "where requestid = '" + requestid + "'";
   List mriList = baseJdbc.executeSqlForList(meetroominfosql);
    if (mriList!= null && mriList.size() > 0) {
      Iterator mriIter = mriList.iterator();
	   if (mriIter.hasNext()) {
		   Map mriMap = (Map) mriIter.next();
		   String mloc = StringHelper.null2String(mriMap.get("mloc"));//������id
           String mbdate = StringHelper.null2String(mriMap.get("mbdate"));//��ʼ����
           String medate = StringHelper.null2String(mriMap.get("medate"));//��������
		   String mbtime = "";
           String metime = "";
		   if(!StringHelper.isEmpty(mbdate)){
			   mbtime = mbdate.split(" ")[1];
		   }
		   
		   if(!StringHelper.isEmpty(medate)){
			   metime = medate.split(" ")[1];
		   }
		   
		   String mcircle = StringHelper.null2String(mriMap.get("mcircle"));//��������
           Long disDays = DateHelper.getDaysBetween(medate,mbdate,false);
           for (int i = 0 ; i <= disDays ; i++) {
			   StringBuffer insertMeetingRoomSqlBuffer = new StringBuffer("insert into " +
				   "uf_meetingroomuser(id,requestid,roomid,startdate,starttime,endtime,enddate) " +
				   "values('" + IDGernerator.getUnquieID() + "','" + requestid + "','" + 
				    mloc + "','");
			   String startdate = DateHelper.dayMove(mbdate,i).split(" ")[0];
			   if(!StringHelper.isEmpty(startdate)){
				   if (DateHelper.getDayOfWeek(new Date(startdate.replace("-","/"))) == 7 
						   || DateHelper.getDayOfWeek(new Date(startdate.replace("-","/"))) == 1) {
					   continue;
				   }
			   }
		//����4028818231a311210131a3539e7a00ec
              if ("4028818231a311210131a3539e7a00ec".equals(mcircle)) {
				if (disDays == 0) {
                  insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
					.append("','").append(metime).append("','").append(startdate).append("')");
				   baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
				} else {
				    if (i == 0) {
                       insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
						.append("','").append("20:00:00").append("','").append(startdate).append("')");
					    baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
                    } else if (i != 0 && i != disDays) {
                       insertMeetingRoomSqlBuffer.append(startdate).append("','").append("08:00:00")
					 .append("','").append("20:00:00").append("','").append(startdate).append("')");
					    baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
				    } else {
                      insertMeetingRoomSqlBuffer.append(startdate).append("','").append("08:00:00")
					 	   .append("','").append(metime).append("','").append(startdate).append("')");
					  baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
				    }
				}
			    //ÿ��
			  } else if ("4028818231a311210131a3539e7a00ed".equals(mcircle)) {
                   insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
					 .append("','").append(metime).append("','").append(startdate).append("')");
				  baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
			    //ÿ��һ
			  } else if ("4028818231a311210131a3539e7a00ee".equals(mcircle)) {
       		     if(!StringHelper.isEmpty(startdate)){
       		    	if (DateHelper.getDayOfWeek(new Date(startdate.replace("-","/"))) == 2) {
                        insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
  					     .append("','").append(metime).append("','").append(startdate).append("')");
                           	baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
  				    }
       		     }
              //ÿ�ܶ�
			  } else if ("4028818231a311210131a3539e7a00ef".equals(mcircle)) {
                if(!StringHelper.isEmpty(startdate)){
                	if (DateHelper.getDayOfWeek(new Date(startdate.replace("-","/"))) == 3) {
                        insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
      				 .append("','").append(metime).append("','").append(startdate).append("')");
      				   baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
      				}
                }
              //ÿ����
			  } else if ("4028818231a311210131a3539e7a00f0".equals(mcircle)) {
                if(!StringHelper.isEmpty(startdate)){
                	if (DateHelper.getDayOfWeek(new Date(startdate.replace("-","/"))) == 4) {
                        insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
      					  .append("','").append(metime).append("','").append(startdate).append("')");
      				   baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
      				}
                }
              //ÿ����
			  } else if ("4028818231a311210131a3539e7a00f1".equals(mcircle)) {
                if(!StringHelper.isEmpty(startdate)){
                	if (DateHelper.getDayOfWeek(new Date(startdate.replace("-","/"))) == 5) {
                        insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
      					  .append("','").append(metime).append("','").append(startdate).append("')");
      				   baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
      				}
                }
			  //ÿ����
			  } else if ("4028818231a311210131a3539e7a00f2".equals(mcircle)) {
                if(!StringHelper.isEmpty(startdate)){
                	if (DateHelper.getDayOfWeek(new Date(startdate.replace("-","/"))) == 6) {
                        insertMeetingRoomSqlBuffer.append(startdate).append("','").append(mbtime)
      					  .append("','").append(metime).append("','").append(startdate).append("')");
      				   baseJdbc.update(insertMeetingRoomSqlBuffer.toString());
      				}
                }
			  }
		   }
	   }
   }
   if(!StringHelper.isEmpty(otherextpages)){
		if(otherextpages.indexOf("/workflow/extpage/")<0)
			otherextpages = "/workflow/extpage/"+otherextpages;
		otherextpages += "?requestid="+StringHelper.null2String(requestid)+"&operatemode="
		    +operatemode+"&directnodeid="+directnodeid+"&targeturl="+URLEncoder.encode(targeturl);
		response.sendRedirect(otherextpages);
		return;
	}
   targeturl="/workflow/request/close.jsp?mode=submit&requestname="
      +StringHelper.getEncodeStr("����Ԥ������")+"&requestid="+requestid;
%>
<script>
  window.location.href="<%=targeturl%>";
</script>

