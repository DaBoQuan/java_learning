<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/tags/eweaver.tld" prefix="ew"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.base.util.FileHelper" %>
<%@ page import="com.eweaver.sysinterface.base.*" %>
<%@ page import="com.eweaver.base.IDGernerator" %>
<%@ page import="java.io.*" %>
<%@ page import="com.eweaver.workflow.workflow.model.Nodeinfo" %>
<%@ page import="com.eweaver.workflow.workflow.service.NodeinfoService" %>
<%@ page import="com.eweaver.base.BaseContext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>接口配置</title>   
    <link rel="stylesheet" type="text/css" href="/css/global.css">
    <link rel="stylesheet" type="text/css" href="/css/eweaver-default.css">
    <link href="/js/jquery/plugins/asyncbox/skins/ZCMS/asyncbox.css" type="text/css" rel="stylesheet" />   
    <script src="/js/jquery/1.6.2/jquery.min.js"/></script>
  	<script src="/js/jquery/1.6.2/jq.eweaver.js"/></script> 	
  	<script src="/js/jquery/plugins/asyncbox/AsyncBox.v1.4.js"/></script>
  	<base target="_self">
  </head>
  <body>
  <!--页面菜单开始-->     
<%
String objtype = StringHelper.null2String(request.getParameter("objtype")); 
String objid = StringHelper.null2String(request.getParameter("objid"));
NodeinfoService nodeinfoService = (NodeinfoService)BaseContext.getBean("nodeinfoService");
String actiontypestr = "<select name=\"ew_actionType\" id=\"ew_actionType\" value=\"\">" 
                     + "<option value=\"-1\"></option> " 
                     + "<option value=\"0\">保存</option> " 
                     + "<option value=\"1\">提交</option> " 
                     + "<option value=\"4\">退回</option> " 
                     + "<option value=\"3\">撤回</option> " 
                     + "<option value=\"2\">提交到达</option> " 
                     + "<option value=\"6\">退回到达</option> " 
                     + "<option value=\"5\">撤回到达</option> " 
                     + "<option value=\"7\">干预到达</option> " 
                     + "<option value=\"9\">提交离开</option> " 
                     + "</select>";
if("node".equalsIgnoreCase(objtype) && !StringHelper.isEmpty(objid)) {
	Nodeinfo nodeinfo = nodeinfoService.get(objid);
	Integer nodetype = nodeinfo.getNodetype();	
	if(nodetype!= null && 1== nodetype) {
		actiontypestr = "<select name=\"ew_actionType\" id=\"ew_actionType\" value=\"\">" 
                     + "<option value=\"-1\"></option> " 
                     + "<option value=\"0\">保存</option> " 
                     + "<option value=\"10\">删除</option> " 
                     + "<option value=\"1\">提交</option> " 
                     + "<option value=\"6\">退回到达</option> " 
                     + "<option value=\"5\">撤回到达</option> " 
                     + "<option value=\"7\">干预到达</option> " 
                     + "</select>";
	} else if(nodetype!= null && 4== nodetype) {
	    actiontypestr = "<select name=\"ew_actionType\" id=\"ew_actionType\" value=\"\">" 
                     + "<option value=\"-1\"></option> " 
                     + "<option value=\"0\">保存</option> " 
                     + "<option value=\"2\">提交到达</option> " 
                     + "<option value=\"7\">干预到达</option> " 
                     + "</select>";
	}
} else if("category".equalsIgnoreCase(objtype) && !StringHelper.isEmpty(objid)) {
	 actiontypestr = "<select name=\"ew_actionType\" id=\"ew_actionType\" value=\"\">" 
                     + "<option value=\"-1\"></option> " 
                     + "<option value=\"0\">保存</option> " 
                     + "<option value=\"11\">新建</option> " 
                     + "<option value=\"12\">修改</option> " 
                     + "<option value=\"10\">删除</option> " 
                     + "</select>";
}
%>
<a id="reload" href="" style="display:none"></a>
<div id="pagemenubar" style="z-index:100;">
</div> 
  <div>
	<ew:entity 
	    fields="interfaceId,actionType,objtype,objid" 
	    tags="select,select,hidden,hidden" 
	    subject="接口配置" 
	    contents="[{interfaceId:\"select id as objid,name as objname from interfaceconfigdetail where objid='{objid}' and isdelete=0 \"},
	    {actionType:\"0__保存,1__提交,4__退回,3__撤回,2__提交到达,6__退回到达,5__撤回到达,7__干预到达,9__提交离开\"}]"
	    action="/ServiceAction/com.eweaver.sysinterface.base.servlet.InterfaceConfigAction?action=linksave" 
	    names="选择已有接口,触发类型,关联对象,关联对象ID"
	>
	</ew:entity>  
	<script language="javascript">
	
	var objid = '<%=objid%>';
	var objtype = '<%=objtype%>';
	function onDelete(id){
	  asyncbox.confirm('确实要删除此项吗?','删除确认',function(action){
	　　　if(action == 'ok'){
	　　　　　postToUrl('id='+id,'/ServiceAction/com.eweaver.sysinterface.base.servlet.InterfaceConfigAction?action=dellink',function(){
			loadInterfaceList();
			});
	　　　}
　 	  });	
   }
   function onEdit(id) {
   		var url = '/ServiceAction/com.eweaver.sysinterface.base.servlet.InterfaceConfigAction?action=view&id='+id+'&objid='+objid+'&objtype='+objtype;
   		openWind(url,'');
   }
	function loadInterfaceList() {
		if(objid.length > 0){
		    var loadUrl = '/ServiceAction/com.eweaver.sysinterface.base.servlet.InterfaceConfigAction?action=loadinterface';		    
		    loadFromDbForList(loadUrl,'objid='+objid,'interfaceList');			        
	    }
	}
		$(document).ready(	   
			function(){		    
			    $('#ew_objid').val(objid);		    
			    $('#ew_objtype').val(objtype);
			    var html = $('#actionType_td').html();
		        $('#actionType_td').html('<%=actiontypestr%>');	
			    //loadInterfaceList();
				$('#submit').click(function(){
					var checkfs = [{name:'interfaceId',text:'接口配置'},{name:'actionType',text:'操作类型'}];
			    	if(checkFields(checkfs)) {
			    		return;
			    	}
				    var url = '/ServiceAction/com.eweaver.sysinterface.base.servlet.InterfaceConfigAction?action=linksave';
					saveToUrl('#EweaverForm',url,function(data){
						if(data && data.length == 32) {
						    asyncbox.tips('保存成功!','success');
						} else {
							asyncbox.tips(data,'failure');
						}
					});			
				});
			}			
	);
	
	function openWindow(url,param){
			openWind(url,param,'接口配置',function(action) {
			if(action == 'close'){
		        document.getElementById('reload').href = window.location.href+ "&random="+Math.random();
		        reload.click();
		　　}
		});
   }
</script>
  </body>
</html>