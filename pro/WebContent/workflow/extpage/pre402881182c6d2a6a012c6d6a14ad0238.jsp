<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ��Ŀ֧����ͬ����鵵ǰ���ɺ�̨ͬ�� -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="com.eweaver.interfaces.workflow.*" %>
<%@ page import="com.eweaver.interfaces.form.*" %>
<%@ page import="com.eweaver.interfaces.model.*" %>
<%
BaseJdbcDao baseJdbcDao=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
String requestid=request.getParameter("requestid");
//String requestid="2c91a0302c5cbb33012c5cd24cc30077";
String targeturl = request.getParameter("targeturl");
String operatemode=request.getParameter("operatemode");
String categoryId="2c91a0302c7bdddd012c7c6625ac02dc";//��ʽ��ͬ
if(StringHelper.isEmpty(requestid)){
	out.println("requestid is null!");
	return;
}
baseJdbcDao.update("update uf_ctr_income set flowstate='2c91a0302bbcd476012be610f27e0a39' where requestid='"+requestid+"'");
FormdataServiceImpl formdataService=new FormdataServiceImpl();
Formdata formdata=new Formdata();
formdata.setCreator(BaseContext.getRemoteUser().getId());
formdata.setTypeid(categoryId);
Dataset data=new Dataset();
formdata.setData(data);
String sql1="select contract,flowNO,supplier,planstarttime,planendtime,10000*ctrmoney as ctrmoney,ctrtype,divideclasses,reqdept,content,attach,content2,10000*money1 as money1,reqman,csman,10000*money2 as money2,10000*money3 as money3,content3,orgid,csdate,ifreturn,buystyles,buyobject from uf_ctr_income where requestid='"+requestid+"'";
List<Map> list=baseJdbcDao.executeSqlForList(sql1);
Map mainData=list.get(0);//ȡlist��һ�����ݣ�

//���ú�ͬ�������ֶ���Ϣ
List<Cell> mainList=new ArrayList<Cell>();
List<Map> ls =baseJdbcDao.executeSqlForList("select requestid from uf_contract where no='"+StringHelper.null2String(mainData.get("flowNO"))+"'");

if(ls.size()<1)
{

	mainList.add(new Cell("name",StringHelper.null2String(mainData.get("contract"))));//��ͬ����
	mainList.add(new Cell("no",StringHelper.null2String(mainData.get("flowNO"))));//��ͬ���
	mainList.add(new Cell("customercoding",StringHelper.null2String(mainData.get("supplier"))));//�׷���λ
	mainList.add(new Cell("predictbgdate",StringHelper.null2String(mainData.get("planstarttime"))));//Ԥ�ƿ�ʼ
	mainList.add(new Cell("predictdate",StringHelper.null2String(mainData.get("planendtime"))));//Ԥ�����
	mainList.add(new Cell("money",StringHelper.null2String(mainData.get("ctrmoney"))));//��ͬ���
	mainList.add(new Cell("hosttypep",StringHelper.null2String(mainData.get("ctrtype"))));//��ͬ������
	mainList.add(new Cell("divideclasses",StringHelper.null2String(mainData.get("divideclasses"))));//��ͬ������
	mainList.add(new Cell("dodept",StringHelper.null2String(mainData.get("reqdept"))));//ʵʩ����
	mainList.add(new Cell("mainpoint",StringHelper.null2String(mainData.get("content"))));//��ͬ��Ҫ����
	mainList.add(new Cell("electrontext",StringHelper.null2String(mainData.get("attach"))));//��ͬ�����ı�
	mainList.add(new Cell("field002",StringHelper.null2String(mainData.get("content2"))));//�ɹ������м��Ʒ
	mainList.add(new Cell("bg1",StringHelper.null2String(mainData.get("money1"))));//Ԥ���м��ƷA1
	mainList.add(new Cell("pjprincipal",StringHelper.null2String(mainData.get("reqman"))));//��Ŀ������
	mainList.add(new Cell("csman",StringHelper.null2String(mainData.get("csman"))));//��ͬǩ����
	mainList.add(new Cell("budgetall",StringHelper.null2String(mainData.get("money3"))));//��Ԥ��
	mainList.add(new Cell("budget",StringHelper.null2String(mainData.get("content3"))));//��ǩ���ڲ��ϵ�Ԥ��
	mainList.add(new Cell("bg2",StringHelper.null2String(mainData.get("money2"))));//Ԥ����ڲ���A2
	mainList.add(new Cell("orgunit",StringHelper.null2String(mainData.get("orgid"))));//����ҵ��
	mainList.add(new Cell("isback",StringHelper.null2String(mainData.get("ifreturn"))));//�Ƿ񷵻�
	mainList.add(new Cell("issign","2c91a8512b9a1688012b9a44255d0001"));//��ͬ����
	mainList.add(new Cell("state","2c91a0302a8cef72012a8eabe0e803f0"));//��ͬĬ��״̬
	mainList.add(new Cell("classes","2c91a0302a8cef72012a8ea9390903c7"));//��ͬ���-֧����ͬ
	mainList.add(new Cell("csdate",StringHelper.null2String(mainData.get("csdate"))));//ǩ������
	mainList.add(new Cell("ctrflow",StringHelper.null2String(requestid)));//��������
           mainList.add(new Cell("buystyles",StringHelper.null2String(mainData.get("buystyles"))));//�ɹ���ʽ
           mainList.add(new Cell("protype",StringHelper.null2String(mainData.get("buyobject"))));//�ɹ�����
	data.setMaintable(mainList);
	//���ɺ�̨ͬ��
	formdataService.createFormdata(formdata);
}
else
{
	String sqlupdate="update uf_contract set name='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("contract")))+"',customercoding='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("supplier")))+"',predictbgdate='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("planstarttime")))+"',predictdate='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("planendtime")))+"',money="+StringHelper.null2String(mainData.get("ctrmoney"),"0.0")+",hosttypep='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("ctrtype")))+"',divideclasses='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("content")))+"',dodept='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("impldept")))+"',mainpoint='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("contract")))+"',electrontext='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("attach")))+"',field002='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("content2")))+"',bg1='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("money1"),"0.0"))+"',pjprincipal='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("reqman")))+"',csman='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("csman")))+"',budgetall='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("money3"),"0.0"))+"',budget='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("content3")))+"',bg2='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("money2"),"0.0"))+"',orgunit='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("orgid")))+"',isback='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("ifreturn")))+"',csdate='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("csdate")))+"',ctrflow='"+StringHelper.filterSqlChar(StringHelper.null2String(mainData.get("requestid")))+"' where no='"+StringHelper.null2String(mainData.get("flowNO"))+"'";
	baseJdbcDao.update(sqlupdate);
	/*Map mm = (Map)ls.get(0);
	String htrequestid=mm.get("requestid").toString();
	//TODO
	String hql="select rowindex,nodeid,pid,orgid,10000*distsum as distsum,contractno,remark from uf_contract_dist where requestid='"+requestid+"'";//
	List<Map> subDataList=baseJdbcDao.executeSqlForList(hql);
	for(int i=0;i<subDataList.size();i++){
		Map m = subDataList.get(i);
		String sorgid=m.get("orgid").toString();
		hql="select id from uf_contract_dist where requestid='"+htrequestid+"' and orgid='"+sorgid+"'";//
		List<Map> ls1=baseJdbcDao.executeSqlForList(hql);
		if(ls1.size()>0)
		{
			Map submap = (Map)ls1.get(0);
			sqlupdate="update uf_contract_dist set pid='"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("pid")))+"',orgid='"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("orgid")))+"',distsum="+StringHelper.null2String(m.get("distsum"),"0.0")+",contractno='"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("contractno")))+"',remark='"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("remark")))+"',nodeid='"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("nodeid")))+"',rowindex='"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("rowindex")))+"'  where id='"+StringHelper.null2String(submap.get("id"))+"'";
	
		}
		else
		{
				sqlupdate="insert uf_contract_dist(id,requestid,rowindx,nodeid,pid,orgid,distsum,contractno,remark) values('"+IDGernerator.getUnquieID()+"','"+htrequestid+"','"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("rowindex")))+"','"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("nodeid")))+"','"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("pid")))+"','"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("orgid")))+"',"+StringHelper.null2String(m.get("distsum"),"0.0")+",'"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("contractno")))+"','"+StringHelper.filterSqlChar(StringHelper.null2String(m.get("remark")))+"')";  
		}
		baseJdbcDao.update(sqlupdate);
	}*/
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

