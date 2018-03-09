<%@ page import="com.eweaver.email.service.EmailsetinfoService" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/base/init.jsp"%>
<html>
<%

    BaseJdbcDao baseJdbcDao  = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
    EmailsetinfoService emailsetinfoService  = (EmailsetinfoService) BaseContext.getBean("emailsetinfoService");
      String sql="select * from emailsetinfo where userid='"+eweaveruser.getId()+"'";
   List list=baseJdbcDao.getJdbcTemplate().queryForList(sql);
     String subject = StringHelper.null2String(request.getParameter("subject"));
    String sendto = StringHelper.null2String(request.getParameter("sendto"));
    String sendtoother = StringHelper.null2String(request.getParameter("sendtoother"));
    String accountid = StringHelper.null2String(request.getParameter("accountid"));
    String searchrang = StringHelper.null2String(request.getParameter("searchrang"));
    String time1 = StringHelper.null2String(request.getParameter("time1"));
    String time2 = StringHelper.null2String(request.getParameter("time2"));
      String action=request.getContextPath()+"/ServiceAction/com.eweaver.email.servlet.EmailAction?action=onsearch";
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Feed Viewer 3</title>
 <script type="text/javascript" src="<%= request.getContextPath()%>/js/ext/adapter/ext/ext-base.js"></script>
   <script type="text/javascript" src="<%= request.getContextPath()%>/js/ext/ext-all.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/ext/feed-viewer/SessionProvider.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ext/feed-viewer/TabCloseMenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ext/ux/iconMgr.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/ext/ux/miframe.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/ext/ux/dynamicmenu.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/ext/feed-viewer/feed-viewer.css" />
       <style type="text/css">
      .x-toolbar table {width:0}
      #pagemenubar table {width:0}
        .x-panel-btns-ct {
          padding: 0px;
      }
      .x-panel-btns-ct table {width:0}
          .t1 {
              cursor: pointer;   }
       a { color:blue; cursor:pointer; }
  </style>
  <script type="text/javascript">

      var tbmenu;
      var mainPanel;
      var attachid;
      Ext.LoadMask.prototype.msg='<%=labelService.getLabelNameByKeyId("402883d934c0e39a0134c0e39afa0000")%>';//加载...
FeedViewer = {};
  var store1;
      MainPanel = function(){
    this.preview = new Ext.Panel({
        id: 'preview',
        region: 'south',
        cls:'preview',
        autoScroll: true,
        listeners: FeedViewer.LinkInterceptor,

        tbar: [{
            id:'tab',
            text: '<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f8002d")%>',//新页面展开
            iconCls: 'new-tab',
            disabled:true,
            handler : this.openTab,
            scope: this
        },
          '->',
            {
                id:'attachs',
                xtype: 'tbsplit',
                iconCls: Ext.ux.iconMgr.getIcon('wbs_attach'),
                text: '<%=labelService.getLabelNameByKeyId("402881eb0bcd354e010bcd9dfe6b0017")%>',//附件
                menu:new Ext.menu.Menu({
                    id:'attachsmenu',
                    items: [
                        {
                            text:'<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f8002e")%>',//下载附件
                            checked:true,
                            iconCls: Ext.ux.iconMgr.getIcon('wbs_attach'),
                            checkHandler :onItCheck
                        }
                    ]
                })
            }
        ],

        clear: function(){
            this.body.update('');
            var items = this.topToolbar.items;
            items.get('tab').disable();
        }
    });
        <%
       String strmenulist="";
                for(int i=0;i<list.size();i++){
                 String objname=StringHelper.null2String((String)((Map)list.get(i)).get("objname"));
                String id=StringHelper.null2String((String)((Map)list.get(i)).get("id"));
                if(i==0){
                   strmenulist="{id:'"+id+"',text:'"+objname+"',checked:true, iconCls: Ext.ux.iconMgr.getIcon('email'),checkHandler :onItemCheck}";
                }else{
                    strmenulist+=",{id:'"+id+"',text:'"+objname+"',checked:true, iconCls: Ext.ux.iconMgr.getIcon('email'),checkHandler :onItemCheck}";
                }
                }
                %>
       var menu = new Ext.menu.Menu({
        id: 'mainMenu',
        items: [<%=strmenulist%>  ]
    });

    this.grid = new FeedGrid(this, {
        tbar:[
        {
            split:true,
            text:'<%=labelService.getLabelNameByKeyId("4028831534ee5d830134ee5d8522000b")%>',//显示方式
            tooltip: {title:'<%=labelService.getLabelNameByKeyId("4028831534ee5d830134ee5d8522000b")%>',text:'<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f8002f")%>'},//显示方式//展现不同的布局
            iconCls: 'preview-bottom',
            handler: this.movePreview.createDelegate(this, []),
            menu:{
                id:'reading-menu',
                cls:'reading-menu',
                width:100,
                items: [{
                    text:'Bottom',
                    checked:true,
                    group:'rp-group',
                    checkHandler:this.movePreview,
                    scope:this,
                    iconCls:'preview-bottom'
                },{
                    text:'Right',
                    checked:false,
                    group:'rp-group',
                    checkHandler:this.movePreview,
                    scope:this,
                    iconCls:'preview-right'
                },{
                    text:'Hide',
                    checked:false,
                    group:'rp-group',
                    checkHandler:this.movePreview,
                    scope:this,
                    iconCls:'preview-hide'
                }]
            }
        },
        '-',
        {
            pressed: true,
            enableToggle:true,
            text:'<%=labelService.getLabelNameByKeyId("402881eb0bcd354e010bcdaaae37001e")%>',//摘要
            iconCls: 'summary',
            scope:this,
            toggleHandler: function(btn, pressed){
                this.grid.togglePreview(pressed);
            }
        }
        ,


        {
            split:true,
            text:'<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f8003b")%>',
            hidden:true,
            tooltip: {title:'<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f8003b")%>',text:'<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f80042")%>'},//收取邮件
            iconCls: Ext.ux.iconMgr.getIcon('email_open'),
            menu:menu
        },

              Ext.get('divloadinga').dom.innerHTML
            ,
        '->',
        Ext.get('searchfield').dom.innerHTML
          ,{
           pressed: true,
            enableToggle:true,
            text:'<%=labelService.getLabelNameByKeyId("40288035249ddfdb01249e0985720006")%>',//搜索
            iconCls: Ext.ux.iconMgr.getIcon('zoom'),
              handler: function() {
                  var subject=document.getElementById('subject').value;
                mainPanel.grid.store.baseParams.subject =subject;
                  mainPanel.grid.store.load({params:{start:0, limit:20}});
              }
            }
        ]
    });

    MainPanel.superclass.constructor.call(this, {
        id:'main-tabs',
        activeTab:0,
        region:'center',
        margins:'0 5 5 0',
        resizeTabs:true,
        tabWidth:150,
        minTabWidth: 120,
        enableTabScroll: true,
        plugins: new Ext.ux.TabCloseMenu(),
        items: {
            id:'main-view',
            layout:'border',
            title:'<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f80040")%>',//收件箱
            hideMode:'offsets',
            items:[
                this.grid, {
                id:'bottom-preview',
                layout:'fit',
                items:this.preview,
                height: 250,
                split: true,
                border:false,
                region:'south'
            }, {
                id:'right-preview',
                layout:'fit',
                border:false,
                region:'east',
                width:350,
                split: true,
                hidden:true
            }]
        }
    });

    this.gsm = this.grid.getSelectionModel();
    this.gsm.on('rowselect', function(sm, index, record) {
        FeedViewer.getTemplate().overwrite(this.preview.body, record.data);
        var items = this.preview.topToolbar.items;
        Ext.getCmp('attachsmenu').removeAll();
        attachid = record.data.attachid;
        var attachname = record.data.attachnamestr;
        var i = 0;
        var attachids = attachid.split(',');
        var attachnames = attachname.split(',');

        if (record.data.attachid == '') {  //没有附件
            items.get('attachs').hide();
        } else {
           for (; i < attachids.length; i++) {
                var attachid = attachids[i];
                var aname = attachnames[i];
                Ext.getCmp('attachsmenu').add(
                {
                    id:attachid,
                    text:aname,
                    checked:true,
                    iconCls: Ext.ux.iconMgr.getIcon('wbs_attach'),
                    checkHandler :onItCheck
                });
            }
            items.get('attachs').show();

        }
        items.get('tab').enable();
    }, this, {buffer:250});

    this.grid.store.on('beforeload', this.preview.clear, this.preview);
    this.grid.store.on('load', this.gsm.selectFirstRow, this.gsm);

    this.grid.on('rowdblclick', this.openTab, this);
};

Ext.extend(MainPanel, Ext.TabPanel, {
    movePreview : function(m, pressed){
        if(!m){ // cycle if not a menu item click
            var readMenu = Ext.menu.MenuMgr.get('reading-menu');
            readMenu.render();
            var items = readMenu.items.items;
            var b = items[0], r = items[1], h = items[2];
            if(b.checked){
                r.setChecked(true);
            }else if(r.checked){
                h.setChecked(true);
            }else if(h.checked){
                b.setChecked(true);
            }
            return;
        }
        if(pressed){
            var preview = this.preview;
            var right = Ext.getCmp('right-preview');
            var bot = Ext.getCmp('bottom-preview');
            var btn = this.grid.getTopToolbar().items.get(2);
            switch(m.text){
                case 'Bottom':
                    right.hide();
                    bot.add(preview);
                    bot.show();
                    bot.ownerCt.doLayout();
                    btn.setIconClass('preview-bottom');
                    break;
                case 'Right':
                    bot.hide();
                    right.add(preview);
                    right.show();
                    right.ownerCt.doLayout();
                    btn.setIconClass('preview-right');
                    break;
                case 'Hide':
                    preview.ownerCt.hide();
                    preview.ownerCt.ownerCt.doLayout();
                    btn.setIconClass('preview-hide');
                    break;
            }
        }
    },

    openTab : function(record){
        record = (record && record.data) ? record : this.gsm.getSelected();
        var d = record.data;
        var id = !d.link ? Ext.id() : d.link.replace(/[^A-Z0-9-_]/gi, '');
        var tab;
        if(!(tab = this.getItem(id))){
            tab = new Ext.Panel({
                id: id,
                cls:'preview single-preview',
                title: d.subject,
                tabTip: d.subject,
                html: FeedViewer.getTemplatepage().apply(d),
                closable:true,
                listeners: FeedViewer.LinkInterceptor,
                autoScroll:true,
                border:true
            });
            this.add(tab);
        }
        this.setActiveTab(tab);
    },

    openAll : function(){
        this.beginUpdate();
        this.grid.store.data.each(this.openTab, this);
        this.endUpdate();
    }
});


Ext.onReady(function(){
    Ext.QuickTips.init();

  Ext.state.Manager.setProvider(new Ext.state.SessionProvider({state: Ext.appState}));

    var tpl = Ext.Template.from('preview-tpl', {
        compiled:true,
        getBody : function(v, all){
            return Ext.util.Format.stripScripts(v || all.description);
        }
    });
    FeedViewer.getTemplate = function(){
        return tpl;
    };
     FeedViewer.getTemplatepage = function(){
        return tp1page;
    };
    var tp1page=Ext.Template.from('preview-tplpage', {
        compiled:true,
        getBody : function(v, all){
            return Ext.util.Format.stripScripts(v || all.description);
        }
    });
    mainPanel = new MainPanel();
    var viewport = new Ext.Viewport({
        layout:'border',
        items:[
            mainPanel
         ]
    });
    //mainPanel.grid.tbar.add('->');
    //alert(mainPanel.grid.tbar)//.add('searchfield');
    dlg0 = new Ext.Window({
               layout:'border',
               closeAction:'hide',
               plain: true,
               modal :true,
               width:viewport.getSize().width * 0.8,
               height:viewport.getSize().height * 0.8,
               buttons: [{text     : '<%=labelService.getLabelNameByKeyId("402881eb0bcbfd19010bcc6f1e6e0023")%>',//取消
                   handler  : function() {
                       dlg0.hide();
                       dlg0.getComponent('dlgpanel').setSrc('about:blank');
                   }
               },{
                   text     : '<%=labelService.getLabelNameByKeyId("297eb4b8126b334801126b906528001d")%>',//关闭
                   handler  : function() {
                       dlg0.hide();
                       dlg0.getComponent('dlgpanel').setSrc('about:blank');
                      this.store.load({params:{start:0, limit:20}});
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
           dlg0.render(Ext.getBody());

});




FeedGrid = function(viewer, config) {

    this.viewer = viewer;
    Ext.apply(this, config);

    this.store = new Ext.data.Store({
        proxy: new Ext.data.HttpProxy({
            url: '<%=action%>'
        }),
              reader: new Ext.data.JsonReader({
               root: 'result',
               totalProperty: 'totalcount',
               fields: ['sendtostr','subject','datetime','accessorystr','id',,'accountname','content','attachid','attachnamestr']

           })
    });
    this.store.setDefaultSort('datetime', "DESC");

    this.columns = [

         {
             <%
            if("2".equals(searchrang)) {
            %>
             header: "<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f80034")%>",//发件人
             <%}else{%>
             header: "<%=labelService.getLabelNameByKeyId("402883d934ca4ec50134ca4ec71a0075")%>",//收件人

             <%}%>
             dataIndex: 'sendfrom',
             width: 100,
             hidden: true,
             sortable:true
      },
        {
        id: 'title',
        header: "<%=labelService.getLabelNameByKeyId("402881eb0bd712c6010bd71c27e80004")%>",//主题
        dataIndex: 'subject',
        sortable:true,
        width: 420,
        renderer: this.formatTitle
      },{
        id: 'last',
        header: "<%=labelService.getLabelNameByKeyId("4028834734b27dbd0134b27dbe7e0000")%>",//日期
        dataIndex: 'datetime',
        width: 150,
        sortable:true
    },{
        header: "<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f80035")%>",//账户
        dataIndex: 'accountname',
        width: 150

    },{
        header: "<%=labelService.getLabelNameByKeyId("402881eb0bcd354e010bcd9dfe6b0017")%>",//附件
        dataIndex: 'accessorystr',
        width: 150

    }
    ];

    FeedGrid.superclass.constructor.call(this, {
        region: 'center',
        id: 'topic-grid',
        loadMask: {msg:'Loading Feed...'},

        sm: new Ext.grid.RowSelectionModel({
            singleSelect:true
        }),
        loadMask: true,
        viewConfig: {
            forceFit:true,
            enableRowBody:true,
            showPreview:true,
            getRowClass : this.applyRowClass
        },
          bbar: new Ext.PagingToolbar({
                                    pageSize: 20,
                     store: this.store,
                     displayInfo: true,
                     beforePageText:"<%=labelService.getLabelNameByKeyId("402883d934c0f88e0134c0f88f420000")%>",//第
                     afterPageText:"<%=labelService.getLabelNameByKeyId("402883d934c0f9ec0134c0f9ed5f0000")%>/{0}",//页
                     firstText:"<%=labelService.getLabelNameByKeyId("402881e60aabb6f6010aabbb63210003")%>",//第一页
                     prevText:"<%=labelService.getLabelNameByKeyId("402883d934c0fb120134c0fb134c0000")%>",//上页
                     nextText:"<%=labelService.getLabelNameByKeyId("402883d934c0fc220134c0fc22940000")%>",//下页
                     lastText:"<%=labelService.getLabelNameByKeyId("402881e60aabb6f6010aabbc0c900006")%>",//最后页
                     displayMsg: '<%=labelService.getLabelNameByKeyId("402881eb0bd66c95010bd67f5e310002")%> {0} - {1}<%=labelService.getLabelNameByKeyId("402883d934c0fe860134c0fe868d0000")%> / {2}',//显示//条记录
                     emptyMsg: "<%=labelService.getLabelNameByKeyId("402883d934c1001a0134c1001ac50000")%>"//没有结果返回
                 })
    });
    this.store.baseParams.subject = '<%=subject%>';
    this.store.baseParams.sendto = '<%=sendto%>';
    this.store.baseParams.sendtoother = '<%=sendtoother%>';
    this.store.baseParams.accountid = '<%=accountid%>';
    this.store.baseParams.searchrang = '<%=searchrang%>';
    this.store.baseParams.time1 = '<%=time1%>';
    this.store.baseParams.time2 = '<%=time2%>';
    this.store.load();
    this.on('rowcontextmenu', this.onContextClick, this);

};

Ext.extend(FeedGrid, Ext.grid.GridPanel, {

    onContextClick : function(grid, index, e){
        if(!this.menu){ // create context menu on first right click
            this.menu = new Ext.menu.Menu({
                id:'grid-ctx',
                items: [{
                    text: '<%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f80036")%>',//新页面查看
                    iconCls: 'new-tab',
                    scope:this,
                    handler: function(){
                        this.viewer.openTab(this.ctxRecord);
                    }
                },
                /*{
                    text: '删除',
                    iconCls: Ext.ux.iconMgr.getIcon('delete'),
                    scope:this,
                    handler: function() {
                        var id = this.ctxRecord.data.id;
                        Ext.Msg.buttonText = {yes:'是',no:'否'};
                        _this=this;
                        Ext.MessageBox.confirm('', '您确定要删除吗?', function (btn, text) {
                            if (btn == 'yes') {
                                Ext.Ajax.request({
                                    url: '<%= request.getContextPath()%>/ServiceAction/com.eweaver.email.servlet.EmailAction?action=deletegetemails',
                                    params:{id:id},
                                    success: function() {
                                        _this.store.load({params:{start:0, limit:20}});
                                    }
                                });
                            } else {

                            }
                        });
                    }
                },{
                     text: '查看邮件',
                    iconCls: 'new-tab',
                    scope:this,
                    handler: function(){
                          var id=this.ctxRecord.data.id;
                        dlg0.getComponent('dlgpanel').setSrc('<%=request.getContextPath()%>/email/emailsendto.jsp?id='+id);
                         dlg0.show();
                    }
                    },*/{

                     text: '<%=labelService.getLabelNameByKeyId("402881e50b60af4a010b60e027890002")%>',//回复
                    iconCls: 'new-tab',
                    scope:this,
                    handler: function(){
                         var id=this.ctxRecord.data.id;
                        location.href='<%=request.getContextPath()%>/email/replyemail.jsp?id='+id;
                    }

                    },{

                     text: '<%=labelService.getLabelNameByKeyId("40288035248e728b01248e814b060007")%>',//转发
                    iconCls: 'new-tab',
                    scope:this,
                    handler: function(){
                        var id=this.ctxRecord.data.id;
                         location.href='<%=request.getContextPath()%>/email/sendemail.jsp?transmit=2&id='+id;
                    }

                    }
                ]
            });
            this.menu.on('hide', this.onContextHide, this);
        }
        e.stopEvent();
        if(this.ctxRow){
            Ext.fly(this.ctxRow).removeClass('x-node-ctx');
            this.ctxRow = null;
        }
        this.ctxRow = this.view.getRow(index);
        this.ctxRecord = this.store.getAt(index);
        Ext.fly(this.ctxRow).addClass('x-node-ctx');
        this.menu.showAt(e.getXY());
    },

    onContextHide : function(){
        if(this.ctxRow){
            Ext.fly(this.ctxRow).removeClass('x-node-ctx');
            this.ctxRow = null;
        }
    },

    togglePreview : function(show){
        this.view.showPreview = show;
        this.view.refresh();
    },

    // within this function "this" is actually the GridView
    applyRowClass: function(record, rowIndex, p, ds) {
        if (this.showPreview) {
            var xf = Ext.util.Format;
            p.body = '<p>' + xf.ellipsis(xf.stripTags(record.data.content), 200) + '</p>';
            return 'x-grid3-row-expanded';
        }
        return 'x-grid3-row-collapsed';
    },
    formatTitle: function(value, p, record) {
        return String.format(
                '<div class="topic"><b>{0}</b><span class="author">{1}</span></div>',
                value, record.data.sendfrom, record.id, record.data.forumid
                );
    }
});
   function onItemCheck(item, checked){
           document.getElementById("divloading").style.display="block";
             var id=item.id;
              Ext.Ajax.request({
                     url: '<%= request.getContextPath()%>/ServiceAction/com.eweaver.email.servlet.EmailAction?action=getemail',
                     params:{id:id},
                     success: function() {
                         document.getElementById("divloading").style.display="none";
                         mainPanel.grid.store.load({params:{start:0, limit:20}});
                     }
                 });
    }
  function onItCheck(item,checked){
  location.href='<%=request.getContextPath()%>/ServiceAction/com.eweaver.document.file.FileDownload?download=1&attachid='+item.id ;
  }

  </script>
</head>
<body>
<script>Ext.BLANK_IMAGE_URL = '<%=request.getContextPath()%>/js/ext/resources/images/default/s.gif';</script>
    <form action="">
    <div id="searchfield">
        <table>
            <tr>
                <td><input align="center" type="text" id="subject" name="subject" size="20"></td>
            </tr>
        </table>
    </div>
    <div id="divloadinga" >
     <span id="divloading" style="display:none"><img src="<%=request.getContextPath()%>/images/base/loading.gif" alt="" > <%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f80038")%></span><!-- 正在加载 请稍后...... -->
    </div>
 </form>
<div id="header"><div style="float:right;margin:5px;" class="x-small-editor"></div></div>

<!-- Template used for Feed Items -->
<textarea id="preview-tpl" style="display:none;">
  <div class="post-data">
        <span class="post-date">{datetime}</span>
        <h3 class="post-title">{subject}</h3>
      <h4 class="post-sendfrom">{sendfrom}</h4>
    </div>
  <div class="post-body">
      {content:this.getBody}</div>
</textarea>

<textarea id="preview-tplpage" style="display:none;">
  <div class="post-body">
       <b><%=labelService.getLabelNameByKeyId("4028834734b27dbd0134b27dbe7e0000")%>:</b> &nbsp;&nbsp;&nbsp;  {datetime}<!-- 日期 -->
      <br>
      <br>
      <b><%=labelService.getLabelNameByKeyId("402883c134f8ef330134f8ef33f80034")%>:</b> &nbsp;&nbsp;&nbsp;  {sendfrom}<!-- 发件人 -->
      <br>
      <br>
     <b><%=labelService.getLabelNameByKeyId("402881eb0bd712c6010bd71c27e80004")%>:</b> &nbsp;&nbsp;&nbsp; {subject}<!-- 主题 -->
      <br>
      <br>
     <b> <%=labelService.getLabelNameByKeyId("402881eb0bd712c6010bd71d7ade0005")%>:</b> &nbsp;&nbsp;&nbsp;<!-- 内容 -->
      <br>
      <br>
      {content:this.getBody}


  </div>
</textarea>
</body>
</html>