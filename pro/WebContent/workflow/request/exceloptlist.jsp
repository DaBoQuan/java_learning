<%@ page import="com.eweaver.base.sequence.SequenceService" %>
<%@ page import="com.eweaver.base.sequence.Sequence" %>
<%@ page import="com.eweaver.base.menu.service.PagemenuService" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/base/init.jsp"%>
<%
SequenceService sequenceService = (SequenceService)BaseContext.getBean("sequenceService");
String action=request.getContextPath()+"/ServiceAction/com.eweaver.excel.servlet.ExceloptAction?action=getlist";
%>
<%
    pagemenustr +=  "addBtn(tb,'"+labelService.getLabelName("402881e60aa85b6e010aa85e6aed0001")+"','S','accept',function(){onCreate()});";
    pagemenustr +="addBtn(tb,'"+labelService.getLabelNameByKeyId("402881e60aa85b6e010aa8624c070003")+"','D','delete',function(){onDelete()});";//删除

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
      <style type="text/css">
    .x-panel-btns-ct {
          padding: 0px;
      }
      .x-panel-btns-ct table {width:0}
      #pagemenubar table {width:0}
       .x-toolbar table {width:0}
    .x-grid3-row-body{white-space:normal;}
  </style>
  <%--<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-latest.pack.js"></script>--%>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/ext/ux/toolbar.js"></script>
   <script type="text/javascript" src="<%= request.getContextPath()%>/js/ext/ux/iconMgr.js"></script>
   <script type="text/javascript" src="<%= request.getContextPath()%>/js/ext/ux/miframe.js"></script>
         <script language="javascript">
          Ext.LoadMask.prototype.msg='<%=labelService.getLabelNameByKeyId("402883d934cbbb380134cbbb39320021") %>';//加载中,请稍后...
             var store;
             var selected=new Array();
             var dlg0;
                   Ext.onReady(function(){
                       Ext.QuickTips.init();
                   <%if(!pagemenustr.equals("")){%>
                       var tb = new Ext.Toolbar();
                       tb.render('pagemenubar');
                   <%=pagemenustr%>
                   <%}%>
             store = new Ext.data.Store({
                 proxy: new Ext.data.HttpProxy({
                     url: '<%=action%>'
                 }),
                 reader: new Ext.data.JsonReader({
                     root: 'result',
                     totalProperty: 'totalcount',
                       fields: ['objname','objtype','category','workflowinfo','forminfo','creator','toopt','id']

                 })

             });
             //store.setDefaultSort('id', 'desc');

             var sm=new Ext.grid.CheckboxSelectionModel();

             var cm = new Ext.grid.ColumnModel([sm, {header: "<%=labelService.getLabelNameByKeyId("402881eb0bcbfd19010bcc16ecb1000b") %>", width:100, sortable: false,  dataIndex: 'objname'},//名称
                         {header: "<%=labelService.getLabelNameByKeyId("402881e80c194e0a010c1a2abc860026") %>", sortable: false, width:100 ,dataIndex: 'objtype'},//类型
                         {header: "<%=labelService.getLabelNameByKeyId("402881e90bcbc9cc010bcbcb1aab0008") %>", width:100, sortable: false, dataIndex: 'category'},//分类
                         {header: "<%=labelService.getLabelNameByKeyId("402883d934cfcad30134cfcad45a0044") %>", width:100, sortable: false, dataIndex: 'workflowinfo'},//流程
                         {header:"<%=labelService.getLabelNameByKeyId("402883d934cfcad30134cfcad45a004a") %>" , width:100, sortable: false, dataIndex: 'forminfo'},//表单
                         {header: "<%=labelService.getLabelNameByKeyId("402881eb0bd74dcf010bd752d0860006") %>", width:100, sortable: false, dataIndex: 'creator'},//创建者
                         {header: "", width:100, sortable: false, dataIndex: 'toopt'}
                         ]);
             cm.defaultSortable = true;

                            var grid = new Ext.grid.GridPanel({
                                region: 'center',
                                store: store,
                                cm: cm,
                                trackMouseOver:false,
                                  sm:sm ,
                                  loadMask: true,
                                viewConfig: {
                                    forceFit:true,
                                    enableRowBody:true,
                                    sortAscText:'<%=labelService.getLabelNameByKeyId("402883d934c0f44b0134c0f44c780000") %>',//升序
		                           sortDescText:'<%=labelService.getLabelNameByKeyId("402883d934c0f59f0134c0f5a0140000") %>',//降序
		                           columnsText:'<%=labelService.getLabelNameByKeyId("402883d934c0f6b10134c0f6b1eb0000") %>',//列定义
                                    getRowClass : function(record, rowIndex, p, store){
                                        return 'x-grid3-row-collapsed';
                                    }
                                },
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 20,
                     store: store,
                     displayInfo: true,
                     beforePageText:"<%=labelService.getLabelNameByKeyId("402883d934c0f88e0134c0f88f420000") %>",//第
		            afterPageText:"<%=labelService.getLabelNameByKeyId("402883d934c0f9ec0134c0f9ed5f0000") %>/{0}",//页
		            firstText:"<%=labelService.getLabelNameByKeyId("402881e60aabb6f6010aabbb63210003") %>",//第一页
		            prevText:"<%=labelService.getLabelNameByKeyId("402883d934c0fb120134c0fb134c0000") %>",//上页
		            nextText:"<%=labelService.getLabelNameByKeyId("402883d934c0fc220134c0fc22940000") %>",//下页
		            lastText:"<%=labelService.getLabelNameByKeyId("402881e60aabb6f6010aabbc0c900006") %>",//最后页
		            displayMsg: '<%=labelService.getLabelNameByKeyId("402881eb0bd66c95010bd67f5e310002") %> {0} - {1}<%=labelService.getLabelNameByKeyId("402883d934c0fe860134c0fe868d0000") %> / {2}',//显示  条记录
		            emptyMsg: "<%=labelService.getLabelNameByKeyId("402883d934c1001a0134c1001ac50000") %>"
                 })

             });

                      store.on('load',function(st,recs){
        for(var i=0;i<recs.length;i++){
            var reqid=recs[i].get('id');
        for(var j=0;j<selected.length;j++){
                    if(reqid ==selected[j]){
                         sm.selectRecords([recs[i]],true);
                     }
                 }
    }
    }
            );
    sm.on('rowselect',function(selMdl,rowIndex,rec ){
        var reqid=rec.get('id');
        for(var i=0;i<selected.length;i++){
                    if(reqid ==selected[i]){
                         return;
                     }
                 }
        selected.push(reqid)
    }
            );
    sm.on('rowdeselect',function(selMdl,rowIndex,rec){
        var reqid=rec.get('id');
        for(var i=0;i<selected.length;i++){
                    if(reqid ==selected[i]){
                        selected.remove(reqid)
                         return;
                     }
                 }

    }
            );


             //Viewport
         var viewport = new Ext.Viewport({
                   layout: 'border',
                 items: [{region:'north',autoScroll:true,contentEl:'divSearch',split:true,collapseMode:'mini'},grid]
             });
               store.load({params:{start:0, limit:20}});
             dlg0 = new Ext.Window({
                         layout:'border',
                         closeAction:'hide',
                         plain: true,
                         modal :true,
                         width:viewport.getSize().width*0.8,
                         height:viewport.getSize().height*0.8,
                         buttons: [{
                             text     : '<%=labelService.getLabelNameByKeyId("297eb4b8126b334801126b906528001d") %>',//关闭
                             handler  : function(){
                                 dlg0.hide();
                                 store.load({params:{start:0, limit:20}});
                             }

                         }],
                         items:[{
                         id:'dlgpanel',
                         region:'center',
                         xtype     :'iframepanel',
                         frameConfig: {
                             autoCreate:{id:'dlgframe', name:'dlgframe', frameborder:0} ,
                             eventsFollowFrameLinks : false
                         },
                         autoScroll:true
                     }]
                     });
         });
          </script>
  </head>
  <body>


<!--页面菜单开始-->

<div id="divSearch">
 <div id="pagemenubar"></div>

</div>


<script language="javascript">
 <!--
    function onCreate(){
     <%--var url="<%= request.getContextPath()%>/workflow/request/exceloptsave.jsp";--%>
	 <%--window.location.href=url;--%>

	 <%--openWin("<%= request.getContextPath()%>/workflow/request/exceloptsave.jsp","新建任务","","","");--%>

	 onPopup("<%= request.getContextPath()%>/workflow/request/exceloptsave.jsp");
   }

   function onPopup(url){
        this.dlg0.getComponent('dlgpanel').setSrc(url);
        this.dlg0.show()
   }
   function onModify(id){
     var url="<%= request.getContextPath()%>/base/sequence/sequencemodify.jsp?id="+id;
	 window.location.href=url;
   }
   function onDelete(id){
   <%--  if( confirm('<%=labelService.getLabelName("402881e90aac1cd3010aac1d97730001")%>')){
     	var url="/ServiceAction/com.eweaver.base.sequence.SequenceAction?action=delete&id="+id;
		window.location.href=url;
   	}--%>
   	 if(selected.length==0){
              Ext.Msg.buttonText={ok:'<%=labelService.getLabelNameByKeyId("402881eb0bcbfd19010bcc6e71870022") %>'};//确定
              Ext.MessageBox.alert('', '<%=labelService.getLabelNameByKeyId("402883d934c1a71a0134c1a71b1d0000") %>');//请选择要删除的内容！
              return;
              }
          Ext.Msg.buttonText={yes:'<%=labelService.getLabelNameByKeyId("402881eb0bd66c95010bd6d13003000c") %>',no:'<%=labelService.getLabelNameByKeyId("402881eb0bd66c95010bd6d19cf5000d") %>'};//是  否
        Ext.MessageBox.confirm('', '<%=labelService.getLabelNameByKeyId("402883d934cbbb380134cbbb39380075") %>', function (btn, text) {//您确定要删除吗?
                     if (btn == 'yes') {
                         Ext.Ajax.request({
                             url: '<%= request.getContextPath()%>/ServiceAction/com.eweaver.excel.servlet.ExceloptAction?action=delete',
                             params:{ids:selected.toString()},
                             success: function() {
                                 selected=[];
                                 store.load({params:{start:0, limit:20}});
                             }
                         });
                     } else {
                         selected=[];
                        store.load({params:{start:0, limit:20}});
                     }
                 });
   }
 -->
 </script>
  </body>
</html>