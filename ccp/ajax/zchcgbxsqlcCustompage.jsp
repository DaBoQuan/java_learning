<%@page import="weaver.file.Prop"%>
<%@page import="weaver.general.*"%>
<%@page import="org.json.JSONObject"%> 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<jsp:useBean id="SubCompanyComInfo"
	class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%@page import="weaver.interfaces.xiyf.util.BillFieldUtil"%>
<%@ page import="weaver.general.Util,java.util.*,java.math.*" %>
<%@ page import="weaver.interfaces.hzjjnew.util.CWGXLCUtil" %>
<!-- 21.�ʲ��ɹ������������� -->
<%
	BaseBean bb = new BaseBean();
	String init_json_userId = Util.null2String(
			new String(Util.null2String(
					bb.getPropValue("zjxt", "init_json_userId"))
					.getBytes("ISO-8859-1"), "gbk")).trim();
	String init_json_userName = Util.null2String(
			new String(Util.null2String(
					bb.getPropValue("zjxt", "init_json_userName"))
					.getBytes("ISO-8859-1"), "gbk")).trim();
	String init_json_ecmAddr = Util.null2String(
			new String(Util.null2String(
					bb.getPropValue("zjxt", "init_json_ecmAddr"))
					.getBytes("ISO-8859-1"), "gbk")).trim();
	String init_json_ecmUserId = Util.null2String(
			new String(Util.null2String(
					bb.getPropValue("zjxt", "init_json_ecmUserId"))
					.getBytes("ISO-8859-1"), "gbk")).trim();
	String init_json_ecmPwd = Util.null2String(
			new String(Util.null2String(
					bb.getPropValue("zjxt", "init_json_ecmPwd"))
					.getBytes("ISO-8859-1"), "gbk")).trim();

	String showModalDialogUrl = Util.null2String(
			new String(Util.null2String(
					bb.getPropValue("zjxt", "showModalDialogUrl"))
					.getBytes("ISO-8859-1"), "gbk")).trim();

	String workflowid = Util.null2String(request
			.getParameter("workflowid"));
	String requestid = Util.null2String(request
			.getParameter("requestid"));
	int formid = Util.getIntValue(request.getParameter("formid"), 0);//��id
	int isbill = Util.getIntValue(request.getParameter("isbill"), 0);//�����ͣ�1���ݣ�0��
	int nodeid = Util.getIntValue(request.getParameter("nodeid"), 0);//�����ͣ�1���ݣ�0��
	rs.execute("select nownodeid from workflow_nownode where requestid="
			+ requestid);
	rs.next();
	int nownodeid = Util.getIntValue(rs.getString("nownodeid"), nodeid);
	rs.execute("select nodeid from workflow_flownode where nodetype=0 and workflowid="
			+ workflowid);
	rs.next();
	int onodeid = Util.getIntValue(rs.getString("nodeid"), 0);
	BillFieldUtil butil = new BillFieldUtil();
	Map mMap = butil.getFieldId(formid, "0");

	Map arrayD1 = new HashMap();//��ϸ�� 1
	arrayD1 = BillFieldUtil.getFieldId(formid, "1");//��ϸ��1

	Map arrayD2 = new HashMap();//��ϸ�� 2
	arrayD2 = BillFieldUtil.getFieldId(formid, "2");//��ϸ��2
	
	Map arrayD3 = new HashMap();//��ϸ�� 3
	arrayD3 = BillFieldUtil.getFieldId(formid, "3");//��ϸ��3
	
	Map arrayD5 = new HashMap();//��ϸ�� 5
	arrayD5 = BillFieldUtil.getFieldId(formid, "6");//��ϸ��5 ��Ԥ����
	
	Map arrayD6 = new HashMap();//��ϸ�� 6
	arrayD6 = BillFieldUtil.getFieldId(formid, "7");//��ϸ��6 �ݹ�

	Map arrayD8 = new HashMap();//��ϸ�� 8
	arrayD8 = BillFieldUtil.getFieldId(formid, "9");//��ϸ��8 �ʲ�
	
	rs.execute("select b.tablename from workflow_base a ,workflow_bill b where a.formid=b.id and a.id="
			+ workflowid);
	rs.next();
	String tablename = Util.null2String(rs.getString("tablename"));

	rs.execute("select id from " + tablename + " where requestid="
			+ requestid);
	rs.next();
	String mainid = Util.null2String(rs.getString("id"));
	if ("".equals(mainid)) {
		mainid = "0";
	}
	
	String tablename_yzpz = tablename+"_dt2";
	CWGXLCUtil cWGXLCUtil = new CWGXLCUtil();//��ȡԭʼ���ɵ�Ԥƾ֤��ϸid
	String yyzpzMxIds = cWGXLCUtil.getYyzpzMxIds(tablename_yzpz, mainid);
	String cj_nodeid = bb.getPropValue("cwlcxx2q", "wf21nodeid_cj");
 %>
 <%@ include file="/interface/hzjjNew/commUtil/zjjs.jsp"%>
 <script src="/interface/hzjjNew/commUtil/cwgxComm.js" type="text/javascript"></script>
<script>

jQuery(document).ready(function(){
	
	    //Add by dingty on 20160607   /����Ҫ���޸Ĵ����ڵ��ֵ����
// 	    if(<%=cj_nodeid%>==<%=nodeid%>){
// 	    	jQuery("input[name='check_node_0']").each(function(){
// 	    		var nowIndex = this.value;
// 	    		jQuery("#field"+<%=arrayD1%>.get("hdje")+"_"+nowIndex).hide();
// 	    		jQuery("#field"+<%=arrayD1%>.get("hdse")+"_"+nowIndex).hide();
// 	    	});
// 	    }
	
        // add by panwei  bxzehj δ����
		bxzehj =  jQuery("#field"+<%=mMap.get("bxzehj")%>).val(); 
	    //Add by dingty on 20160606     /�����˻�֧�����Ϊ��������
	    var cxjkhj =  jQuery("#field"+<%=mMap.get("cxjkhj")%>).val()*1.0;
		var cxyfkhj =  jQuery("#field"+<%=mMap.get("cxyfkhj")%>).val()*1.0;
		var zfje =accSub(bxzehj,accAdd(cxyfkhj,cxjkhj));
		
		 jQuery("#field"+<%=mMap.get("zfje")%>).val(zfje);
		 jQuery("#field"+<%=mMap.get("zfje")%>+"span").html(zfje);
	var str = window.location.href;
	jQuery("#barCodeiframe").attr("src","/interface/hzjjNew/commUtil/barcode.jsp"+str.substring(str.indexOf('?'))+"&lch=21");
 
	jQuery("#field"+<%=mMap.get("zrrgh")%>).bind("propertychange",function(){  
		datainput('field'+<%=mMap.get("zrrgh")%>);
		//datainput('field'+ZRR);
	});
	
	//����֧������   ��Ӧ����ʾ������
	jQuery("#field"+<%=mMap.get("zfdx")%>).bind("change",function(){
		zfdxChange();
	});
	//�Ƿ�������
			select_show_SFCXJK();
	jQuery("#field"+<%=mMap.get("sfcxjk")%>).bind("change",function(){
		select_show_SFCXJK();
	});
	//�Ƿ����Ԥ����
	select_show_SFCXYFK();
	jQuery("#field"+<%=mMap.get("sfcxyfk")%>).bind("change",function(){
 
		select_show_SFCXYFK();
	});
	
	//�Ƿ��ݹ�
		select_show_SFZG();
	jQuery("#field"+<%=mMap.get("iszg")%>).bind("change",function(){ 
		select_show_SFZG();
	});
	 
	//����֧����� start
	jQuery("#field"+<%=mMap.get("zfje")%>).hide();
	//�����ܶ�ϼƱ��
	jQuery("#field"+<%=mMap.get("bxzehj")%>).bind("propertychange",function(){ 
 			var bxzehj = jQuery("#field"+<%=mMap.get("bxzehj")%>).val()*1.0;
 			var cxjkhj =  jQuery("#field"+<%=mMap.get("cxjkhj")%>).val()*1.0;
 			var cxyfkhj =  jQuery("#field"+<%=mMap.get("cxyfkhj")%>).val()*1.0;
 			//Add by dingty on 20160605   /����Ҫ��  ����֧����� ʱ �����ݹ��ϼ�
//  			var cxzghj =   jQuery("#field"+<%=mMap.get("cxzghj")%>).val()*1.0;
//  			var zfje =accSub(bxzehj,accAdd(cxyfkhj,cxzghj));
 			var zfje =accSub(bxzehj,accAdd(cxyfkhj,cxjkhj));
 			
 			 jQuery("#field"+<%=mMap.get("zfje")%>).val(zfje);
 			 jQuery("#field"+<%=mMap.get("zfje")%>+"span").html(zfje);
	});
	//����Ԥ����ϼƱ��
	jQuery("#field"+<%=mMap.get("cxyfkhj")%>).bind("propertychange",function(){ 
			var bxzehj = jQuery("#field"+<%=mMap.get("bxzehj")%>).val()*1.0;
			var cxjkhj =  jQuery("#field"+<%=mMap.get("cxjkhj")%>).val()*1.0;
			var cxyfkhj =  jQuery("#field"+<%=mMap.get("cxyfkhj")%>).val()*1.0;
			//Add by dingty on 20160605   /����Ҫ��  ����֧����� ʱ �����ݹ��ϼ�
// 			var cxzghj =   jQuery("#field"+<%=mMap.get("cxzghj")%>).val()*1.0;
// 			var zfje =accSub(bxzehj,accAdd(cxyfkhj,cxzghj));
			var zfje =accSub(bxzehj,accAdd(cxyfkhj,cxjkhj));
			 jQuery("#field"+<%=mMap.get("zfje")%>).val(zfje);
			 jQuery("#field"+<%=mMap.get("zfje")%>+"span").html(zfje);
	});
	//�����ݹ��ϼƱ��
	//alter by dingty on 20160605   /����Ҫ��  ����֧����� ʱ �����ݹ��ϼ�
// 	jQuery("#field"+<%=mMap.get("cxzghj")%>).bind("propertychange",function(){ 
// 		var bxzehj = jQuery("#field"+<%=mMap.get("bxzehj")%>).val()*1.0;
// 		var cxjkhj =  jQuery("#field"+<%=mMap.get("cxjkhj")%>).val()*1.0;
// 		var cxyfkhj =  jQuery("#field"+<%=mMap.get("cxyfkhj")%>).val()*1.0;
// 		var cxzghj =   jQuery("#field"+<%=mMap.get("cxzghj")%>).val()*1.0;
// 		var zfje =accSub(bxzehj,accAdd(cxyfkhj,cxzghj));
// 		 jQuery("#field"+<%=mMap.get("zfje")%>).val(zfje);
// 		 jQuery("#field"+<%=mMap.get("zfje")%>+"span").html(zfje);
// });
	
	//��Ӧ�������¼���
	jQuery("#field"+<%=mMap.get("gysmc")%>).bind("propertychange",function(){      
		//������ϸ1
  
			jQuery("input[name='check_node_0']").each(function(i) {
				var nowIndex = this.value;   
				setTimeout('setZY_BX(' + nowIndex + ')', 500);
			});
 
			var gysyhzh =  jQuery("#field"+<%=mMap.get("gysyhzh")%>).val();
	 		if(gysyhzh!=""){
	 			alert('��Ӧ�̱����Ѹı䣬������ѡ�������˻����ͬ�ţ�');
				//���������˺���Ϣ
				jQuery("#field"+ <%=mMap.get("gysyhzh")%>).val('');
				jQuery("#field"+ <%=mMap.get("gysyhzh")%>+ "span a:eq(0)").html('');
				fieldViewAttr("field" + <%=mMap.get("gysyhzh")%>,1);
				jQuery("#field"+ <%=mMap.get("gyskhh")%>).val('');
				jQuery("#field"+ <%=mMap.get("gyskhh")%>+ "span").html('');
				jQuery("#field"+ <%=mMap.get("gyskhm")%>).val('');
				jQuery("#field"+ <%=mMap.get("gyskhm")%>+ "span").html('');
				//���ú�ͬ����Ϣ
				jQuery("#field"+ <%=mMap.get("hth")%>).val('');
				jQuery("#field"+ <%=mMap.get("hth")%>+ "span a:eq(0)").html('');
				fieldViewAttr("field" + <%=mMap.get("hth")%>,1);
				jQuery("#field"+ <%=mMap.get("htje")%>).val('');
				jQuery("#field"+ <%=mMap.get("htje")%>+ "span").html('');
				jQuery("#field"+ <%=mMap.get("htmc")%>).val('');
				jQuery("#field"+ <%=mMap.get("htmc")%>+ "span").html('');
				jQuery("#field"+ <%=mMap.get("htsy")%>).val('');
				jQuery("#field"+ <%=mMap.get("htsy")%>+ "span").html('');
	 		}
	}); 
 
 
 	/**
 		�����ύ��д
 	**/
	checkCustomize = function (){


       <%
		/**
		*add by BL 
		*Date:2016.06.06
		**/
		//���21���̺�ͬ�ʽ���ƽڵ�
		String nodeid_ht = String.valueOf(nodeid);
		BaseBean  bb1 = new BaseBean();
		String node_ht = bb1.getPropValue("hzjjworkflowimp", "node");
		if(""!= node_ht)
		{
			String[] nodes = node_ht.split(",");
			for(int i = 0 ; i < nodes.length;i++)
			{
				   String[] compare = nodes[i].split("_");
				   
				   if(compare[0].equals("21"))
				   {
					   for(int j = 1;j < compare.length; j++)
					   {
						   if(compare[j].equals(nodeid_ht))
						   {
							   %>
							    if(!checkJe())
						        {
							      return false;
							    } 
							   <%
						   }
					   }
				   }
			}
		}
		
		%>



		if(!checkjslx()){
	      return false;
	    }   
 		var zfje = jQuery("#field"+<%=mMap.get("zfje")%>).val()*1.0;
 		var bczfje = jQuery("#field"+<%=mMap.get("bczfje")%>).val()*1.0;
 		if(parseFloat(zfje)<0){
			alert("֧���ܶ��С��0");
			return false;
		}
 		if(parseFloat(bczfje)>parseFloat(zfje)){
			alert("����֧���ܶ�ܴ���֧�����");
			return false;
		}
		var num1 =0;
		if($G("submitdtlid0").value!=""){
			var submitdtlidArray= $G("submitdtlid0").value.split(',');
			for(var k=0; k<submitdtlidArray.length; k++){ 
	    		var idl0 = submitdtlidArray[k]*1.0; 
	    		var bxje_val=jQuery("#field"+<%=arrayD1.get("bxje")%>+"_"+idl0).val()*1.0;
	    		var zzsse_val = jQuery("#field"+<%=arrayD1.get("zzsse")%>+"_"+idl0).val()*1.0;
	    		var hdje_val = jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+idl0).val()*1.0;
	    		var hdse_val = jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+idl0).val()*1.0;
	    		if(parseFloat(hdse_val)>parseFloat(hdje_val)){
 					alert("��ϸ��"+(num1+1)+"�к˶�˰��ܴ��ں˶����");
 					return false;
 				}
 				if(parseFloat(hdje_val)>parseFloat(bxje_val)){
 					alert("��ϸ��"+(num1+1)+"�к˶����ܴ��ڱ������");
 					return false;
 				}
 				if(parseFloat(hdse_val)>parseFloat(zzsse_val)){
 					alert("��ϸ��"+(num1+1)+"�к˶�˰��ܴ�����ֵ˰˰��");
 					return false;
 				}
 				num1++;
			}
		}
		var num5 =0;
		if( $G("submitdtlid5").value!=""){
			var submitdtlidArray= $G("submitdtlid5").value.split(',');
			for(var k=0; k<submitdtlidArray.length; k++){ 
	    		var idl5 = submitdtlidArray[k];   
	    		var wqzgje = jQuery("#field"+<%=arrayD6.get("wqzgje")%>+"_"+idl5).val();    
	    		var bccxje =  jQuery("#field"+<%=arrayD6.get("bccxje")%>+"_"+idl5).val();   
	    		if(parseFloat(bccxje)>parseFloat(wqzgje)){
 					alert("��ϸ��"+(num5+1)+"�б��γ������ܴ���δ���ݹ����");
 					return false;
 				}
	    		num5++;
			}
		}
		
		var num4 =0; 
		if( $G("submitdtlid4").value!=""){ 
			var submitdtlidArray= $G("submitdtlid4").value.split(',');
			for(var k=0; k<submitdtlidArray.length; k++){ 
	    		var idl4 = submitdtlidArray[k];
	    		var wqyfkje = jQuery("#field"+<%=arrayD5.get("wqyfkje")%>+"_"+idl4).val();    
	    		var bccxje =  jQuery("#field"+<%=arrayD5.get("bccxje")%>+"_"+idl4).val();   
	     
	    		if(parseFloat(bccxje)>parseFloat(wqyfkje)){
 					alert("��ϸ��"+(num4+1)+"�б��γ������ܴ���δ��Ԥ������");
 					return false;
 				}
	    		num4++;
			}
		}
		return true;
	}
 	
});	

//������ϸ1
jQuery("#indexnum0").bind("propertychange",function(){
	bindfee1(1); 
});
bindfee1(2);

function bindfee1(value){
    var indexnum0 = 0; 
    if(document.getElementById("indexnum0")){
    	indexnum0 = document.getElementById("indexnum0").value * 1.0 - 1;
	}    
    if(indexnum0>=0){
		if(value==1){ //��ǰ��ӵ���   
			//��Ŀ�����¼���
				jQuery("#field"+<%=arrayD1.get("cbzx")%>+"_"+indexnum0).val(jQuery("#field"+'<%=mMap.get("bmbm")%>').val());
				jQuery("#field"+<%=arrayD1.get("cbzx")%>+"_"+indexnum0+"span").html(jQuery("#field"+'<%=mMap.get("bmmc")%>').val());
				
				jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+indexnum0).hide(); 
	    		jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+indexnum0).hide();
	    	    jQuery("#field"+<%=arrayD1.get("hdze")%>+"_"+indexnum0).hide();
	    	     
	    	    jQuery("#field"+<%=arrayD1.get("bxje")%>+"_"+indexnum0).bind("propertychange",function(){ 
					jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+indexnum0).val(this.value);
					//Add by dingty on 20160607 //����Ҫ������ֵ
					jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+indexnum0).hide();
					
					jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+indexnum0+"span").html(this.value);
				});
	    	    
	    	    jQuery("#field"+<%=arrayD1.get("zzsse")%>+"_"+indexnum0).bind("propertychange",function(){ 
					jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+indexnum0).val(this.value);
					//Add by dingty on 20160607 //����Ҫ������ֵ
					jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+indexnum0).hide();
					
					jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+indexnum0+"span").html(this.value);
				});
				   jQuery("#field"+<%=arrayD1.get("bzsx")%>+"_"+indexnum0).bind("propertychange",function(){
	    				setTimeout('setZY_BX(' + indexnum0 + ')', 500);
				   });
		}else if(value==2){//��ʼ��  
			var GSDMval = jQuery("#field"+<%=mMap.get("gsdm")%>).val();
			var bzsxlch = '<%=workflowid%>'; 
			  jQuery("input[name='check_node_0']").each(function(i) {
					var idl0 = this.value;    

				var CBZXval =jQuery("#field"+<%=arrayD1.get("cbzx")%>+"_"+idl0).val();
			
				var BZSXid = jQuery("#field"+<%=arrayD1.get("bzsx")%>+"_"+idl0).val();	
 
				getVal("field"+<%=arrayD1.get("cbzx")%>+"_"+idl0,CBZXval,GSDMval); //����cwgxComm�е�getVal()���������ڳɱ�����NC�Զ��������ť����ʾ 		
				getBZSX("field"+<%=arrayD1.get("bzsx")%>+"_"+idl0,BZSXid,bzsxlch); //����cwgxComm�е�getBZSX()���������ڱ�������NC�Զ��������ť����ʾ 			
			
	    	    jQuery("#field"+<%=arrayD1.get("bxje")%>+"_"+idl0).bind("propertychange",function(){ 
					jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+idl0).val(this.value);
					//Add by dingty on 20160607 //����Ҫ������ֵ
					jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+indexnum0).hide();
					
					jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+idl0+"span").html(this.value);
				});
	    	    
	    	    jQuery("#field"+<%=arrayD1.get("zzsse")%>+"_"+idl0).bind("propertychange",function(){ 
					jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+idl0).val(this.value);
					//Add by dingty on 20160607 //����Ҫ������ֵ
					jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+indexnum0).hide();
					
					jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+idl0+"span").html(this.value);
				});
				   jQuery("#field"+<%=arrayD1.get("bzsx")%>+"_"+idl0).bind("propertychange",function(){
		    		setTimeout('setZY_BX(' + idl0 + ')', 500);
				   });
				 //Ԥ�ƽ���޸� �˶����
					jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+idl0).bind("change",function(){   
							var f_name =jQuery(this).attr("name"); 
							var _index = f_name.replace("field"+<%=arrayD1.get("hdje")%> +"_",""); 
							var hdje =  jQuery("#field"+<%=arrayD1.get("hdje")%>+"_"+_index).val();   

							editYzje2(hdje,<%=formid%>,0,_index,1,<%=arrayD2.get("je")%>,<%=mainid%>,<%=workflowid%>,1,"1"); 
					});
				
					//Ԥ�ƽ���޸� �˶��ܶ�
					jQuery("#field"+<%=arrayD1.get("hdze")%>+"_"+idl0).bind("propertychange",function(){
							var f_name =jQuery(this).attr("name"); 
							var _index = f_name.replace("field"+<%=arrayD1.get("hdze")%> +"_",""); 
							var hdje =  jQuery("#field"+<%=arrayD1.get("hdze")%>+"_"+_index).val();    
							editYzje2(hdje,<%=formid%>,0,_index,1,<%=arrayD2.get("je")%>,<%=mainid%>,<%=workflowid%>,1,"2"); 
					});
				
					//Ԥ�ƽ���޸� �˶�˰��
					jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+idl0).bind("change",function(){  
						
							var f_name =jQuery(this).attr("name"); 
							var _index = f_name.replace("field"+<%=arrayD1.get("hdse")%> +"_",""); 
							var hdse =  jQuery("#field"+<%=arrayD1.get("hdse")%>+"_"+_index).val();   
				 
							editYzje2(hdse,<%=formid%>,0,_index,1,<%=arrayD2.get("je")%>,<%=mainid%>,<%=workflowid%>,2,""); 
					});
				//Ԥ��ժҪ
				jQuery("#field"+<%=arrayD1.get("zy")%>+"_"+idl0).bind("change",function(){  
			
						var f_name =jQuery(this).attr("name"); 
						var _index = f_name.replace("field"+<%=arrayD1.get("zy")%> +"_","");  
						var zyvalue = this.value; 
					 	editZY(zyvalue,<%=formid%>,0,_index,1,<%=arrayD2.get("zy")%>,<%=mainid%>,<%=workflowid%>); 

				});
 
			});
		}
	} 
}




//������ϸ5 �ݹ���ϸ
jQuery("#indexnum5").bind("propertychange",function(){
	bindfee6(1); 
});
bindfee6(2);


function bindfee6(value){
    var indexnum5 = 0; 
    if(document.getElementById("indexnum5")){
    	indexnum5 = document.getElementById("indexnum5").value * 1.0 - 1;
	}    
    if(indexnum5>=0){
		if(value==1){ //��ǰ��ӵ���   
			//��Ŀ�����¼��� 
			jQuery("#field"+<%=arrayD6.get("zgje")%>+"_"+indexnum5).hide(); 
			jQuery("#field"+<%=arrayD6.get("wqzgje")%>+"_"+indexnum5).hide();                    
			 
	        jQuery("#field"+<%=arrayD6.get("zgmx")%>+"_"+indexnum5).bind("propertychange",function(){ 
	    	    	var dtid = this.value;
			    	setTimeout('zgxx('+dtid+',' + indexnum5 + ')', 500); 
	    	    	//zgxx(dtid,indexnum5);
		    });
	     
	        jQuery("#field"+<%=arrayD6.get("lscx")%>+"_"+indexnum5+"span").html("<a href='#' onclick='openLscxmx(<%=arrayD6.get("zgmx")%>,"+indexnum5+","+(indexnum5+1)+",6);return false;'>��ѯ</a>");
		}else if(value==2){//��ʼ��  
			if( $G("submitdtlid5").value!=""){
				var submitdtlidArray= $G("submitdtlid5").value.split(',');
				for(var k=0; k<submitdtlidArray.length; k++){ 
		    		var idl5 = submitdtlidArray[k];   
		    		<%if(onodeid==nownodeid){%>
			    		jQuery("#field"+<%=arrayD6.get("zgje")%>+"_"+idl5).hide(); 
						jQuery("#field"+<%=arrayD6.get("wqzgje")%>+"_"+idl5).hide();      
						jQuery("#field"+<%=arrayD6.get("zgje")%>+"_"+idl5+"span").html(checkFloatForJJ(	jQuery("#field"+<%=arrayD6.get("zgje")%>+"_"+idl5).val()));
						jQuery("#field"+<%=arrayD6.get("wqzgje")%>+"_"+idl5+"span").html(checkFloatForJJ(jQuery("#field"+<%=arrayD6.get("wqzgje")%>+"_"+idl5).val()));
					<%}%>
				      jQuery("#field"+<%=arrayD6.get("lscx")%>+"_"+idl5+"span").html("<a href='#' onclick='openLscxmx(<%=arrayD6.get("zgmx")%>,"+idl5+","+(idl5+1)+",6);return false;'>��ѯ</a>");

				}
				
				jQuery("input[name='check_node_5']").each(function(i) {
					var nowIndex = this.value;    
				     jQuery("#field"+<%=arrayD6.get("zgmx")%>+"_"+nowIndex).bind("propertychange",function(){ 
			    	    	var dtid = this.value;
			    	    	//zgxx(dtid,nowIndex);
			    	    	setTimeout('zgxx('+dtid+',' + nowIndex + ')', 500); 
				    });
				     //Ԥ��ժҪ
						jQuery("#field"+<%=arrayD6.get("zy")%>+"_"+nowIndex).bind("change",function(){   
								var f_name =jQuery(this).attr("name"); 
								var _index = f_name.replace("field"+<%=arrayD6.get("zy")%> +"_","");  
								var zyvalue = this.value; 
							 	editZY(zyvalue,<%=formid%>,5,_index,1,<%=arrayD2.get("zy")%>,<%=mainid%>,<%=workflowid%>); 

						});
 
				});
			}
		}
	} 
}


//������ϸ5 Ԥ������ϸ
jQuery("#indexnum4").bind("propertychange",function(){
 
	bindfee5(1); 
});
bindfee5(2);


function bindfee5(value){
    var indexnum4 = 0; 
    if(document.getElementById("indexnum4")){
    	indexnum4 = document.getElementById("indexnum4").value * 1.0 - 1;
	}    
    if(indexnum4>=0){
		if(value==1){ //��ǰ��ӵ���   
			//��Ŀ�����¼��� 
			jQuery("#field"+<%=arrayD5.get("hkr")%>+"_"+indexnum4).hide(); 
			jQuery("#field"+<%=arrayD5.get("yfkje")%>+"_"+indexnum4).hide();                    
			jQuery("#field"+<%=arrayD5.get("yfkje")%>+"_"+indexnum4).hide(); 
 
	        jQuery("#field"+<%=arrayD5.get("yfkmx")%>+"_"+indexnum4).bind("propertychange",function(){ 
	    	    	var dtid = this.value;  
			    	setTimeout('yfkcx('+dtid+',' + indexnum4 + ')', 500); 
	    	    	//zgxx(dtid,indexnum5);
		    });
	    	setTimeout('setZY_YFK(' + indexnum4 + ')', 500); 
	        jQuery("#field"+<%=arrayD5.get("lscx")%>+"_"+indexnum4+"span").html("<a href='#' onclick='openLscxmx(<%=arrayD5.get("yfkmx")%>,"+indexnum4+","+(indexnum4+1)+",5);return false;'>��ѯ</a>");
		}else if(value==2){//��ʼ��  
			if( $G("submitdtlid4").value!=""){
				var submitdtlidArray= $G("submitdtlid4").value.split(',');
				for(var k=0; k<submitdtlidArray.length; k++){ 
		    		var idl4 = submitdtlidArray[k];   
		    		<%if(onodeid==nownodeid){%>
			    		jQuery("#field"+<%=arrayD5.get("yfkje")%>+"_"+idl4).hide(); 
						jQuery("#field"+<%=arrayD5.get("wqyfkje")%>+"_"+idl4).hide();      
						jQuery("#field"+<%=arrayD5.get("yfkje")%>+"_"+idl4+"span").html(checkFloatForJJ(	jQuery("#field"+<%=arrayD5.get("yfkje")%>+"_"+idl4).val()));
						jQuery("#field"+<%=arrayD5.get("wqyfkje")%>+"_"+idl4+"span").html(checkFloatForJJ(jQuery("#field"+<%=arrayD5.get("wqyfkje")%>+"_"+idl4).val()));
					<%}%>
				      jQuery("#field"+<%=arrayD5.get("lscx")%>+"_"+idl4+"span").html("<a href='#' onclick='openLscxmx(<%=arrayD5.get("yfkmx")%>,"+idl4+","+(idl4+1)+",5);return false;'>��ѯ</a>");

				}
				
				jQuery("input[name='check_node_4']").each(function(i) {
					var nowIndex = this.value;    
				     jQuery("#field"+<%=arrayD5.get("yfkmx")%>+"_"+nowIndex).bind("propertychange",function(){ 
			    	    	var dtid = this.value; 
			    	    	//zgxx(dtid,nowIndex);
			    	    	setTimeout('yfkcx('+dtid+',' + nowIndex + ')', 500); 
				    });
					
				   //Ԥ��ժҪ
						jQuery("#field"+<%=arrayD5.get("zy")%>+"_"+nowIndex).bind("change",function(){  
					
								var f_name =jQuery(this).attr("name"); 
								var _index = f_name.replace("field"+<%=arrayD5.get("zy")%> +"_","");  
								var zyvalue = this.value; 
							 	editZY(zyvalue,<%=formid%>,4,_index,1,<%=arrayD2.get("zy")%>,<%=mainid%>,<%=workflowid%>); 

						});
				});
			}
		}
	} 
}

//�����ݹ���Ϣ
function zgxx(dtid,i){
	var zcmc = "";
	var zgje = 0;
    //Add by dingty on 20160605 /����Ҫ���޸�ժҪ����
	var urls = "/interface/hzjjNew/zchcgbxsqlc21/xiyf/zgxxAjax.jsp?dtid="+dtid+"&time="+new Date().getTime();
	jQuery.getJSON(urls,function(ret){
		if(ret.status == 'succ'){ 
			jQuery("#field"+<%=arrayD6.get("zgje")%>+"_"+i).val(checkFloatForJJ(ret.hdje));
			jQuery("#field"+<%=arrayD6.get("zgje")%>+"_"+i+"span").html(checkFloatForJJ(ret.hdje));
			jQuery("#field"+<%=arrayD6.get("wqzgje")%>+"_"+i).val(checkFloatForJJ(ret.zgwqje));                  
			jQuery("#field"+<%=arrayD6.get("wqzgje")%>+"_"+i+"span").html(checkFloatForJJ(ret.zgwqje));       

			zcmc = ret.zcmc;
			zgje = ret.hdje;
			gysmc = ret.gysmc;
 
			setZY_ZG(zcmc,gysmc,i);
		}else{                                                                                 
			alert("�����쳣:" + urls);
		}
	});  

}

//����Ԥ������Ajax
function yfkcx(dtid,i){
	var urls = "/interface/hzjjNew/zchcgbxsqlc21/xiyf/yfkxxAjax.jsp?dtid="+dtid+"&time="+new Date().getTime();
	jQuery.getJSON(urls,function(ret){
		if(ret.status == 'succ'){ 
			jQuery("#field"+<%=arrayD5.get("yfkje")%>+"_"+i).val(checkFloatForJJ(ret.yfkje));
			jQuery("#field"+<%=arrayD5.get("yfkje")%>+"_"+i+"span").html(checkFloatForJJ(ret.yfkje));
			jQuery("#field"+<%=arrayD5.get("wqyfkje")%>+"_"+i).val(checkFloatForJJ(ret.wqyfkje));
			jQuery("#field"+<%=arrayD5.get("wqyfkje")%>+"_"+i+"span").html(checkFloatForJJ(ret.wqyfkje));
			jQuery("#field"+<%=arrayD5.get("hkr")%>+"_"+i).val(ret.hkr);
			jQuery("#field"+<%=arrayD5.get("hkr")%>+"_"+i+"span").html(ret.hkrname);
		}else{
			alert("�����쳣:" + urls);
		}
	});
}

//�ݹ�ժҪ��ֵ
// function setZY_ZG(zcmc,zgje,index) {    
// 	jQuery("#field"+ <%=arrayD6.get("zy")%> +"_"+index).val("����"+zcmc+zgje);  
// 	checkinput("field"+ <%=arrayD6.get("zy")%>+"_"+index,"field"+<%=arrayD6.get("zy")%>+"_"+index+"span"); 
// }
//Add by dingty on 20160605 /����Ҫ����ģ�ժҪ�����Ϊ������+��Ӧ��+�ʲ�����+����
function setZY_ZG(zcmc,gysmc,index) {    
	jQuery("#field"+ <%=arrayD6.get("zy")%> +"_"+index).val("����"+gysmc+zcmc+"����");  
	checkinput("field"+ <%=arrayD6.get("zy")%>+"_"+index,"field"+<%=arrayD6.get("zy")%>+"_"+index+"span"); 
}

//����ժҪ��ֵ
function setZY_BX(index) {     
	var gysmc = jQuery("#field" + <%=mMap.get("gysmc")%>).val(); 
	var bzsxspan =   jQuery("#field" + <%=arrayD1.get("bzsx")%> + "_" + index+"span a:eq(0)").html(); 
	jQuery("#field"+ <%=arrayD1.get("zy")%> +"_"+index).val("����"+gysmc+bzsxspan);  
	checkinput("field"+ <%=arrayD1.get("zy")%>+"_"+index,"field"+<%=arrayD1.get("zy")%>+"_"+index+"span"); 
}
//Ԥ����ժҪ��ֵ
function setZY_YFK(index) {    
	jQuery("#field"+ <%=arrayD5.get("zy")%> +"_"+index).val("����Ԥ����");  
	checkinput("field"+ <%=arrayD5.get("zy")%>+"_"+index,"field"+<%=arrayD5.get("zy")%>+"_"+index+"span"); 
}

var maxSize = "dialogLeft:10px;dialogTop:10px; dialogWidth:"
	+ (window.screen.availWidth - 20) + "px;" + "dialogHeight:"
	+ (window.screen.availHeight - 20) + "px";
	
function showDocView() {
	var BARCODEv = jQuery("#field" +<%=mMap.get("barcode")%> ).val(); 
	var init_json = '{"userId":<%=JSONObject.quote(init_json_userId)%>,"userName":<%=JSONObject.quote(init_json_userName)%>, '
			+ '"ecmAddr":<%=JSONObject.quote(init_json_ecmAddr)%>, "ecmUserId":<%=JSONObject.quote(init_json_ecmUserId)%>, '
			+ '"ecmPwd":<%=JSONObject.quote(init_json_ecmPwd)%>, '
			+ '"docId":"' + BARCODEv + '"}';

	var initParams = {
		"initJson" : init_json
	}; 
	window.showModalDialog("<%=showModalDialogUrl %>?&time="
			+ new Date().getTime(), initParams,
			"center:yes;resizable:yes;maximize:yes;" + maxSize);
}






//Ԥ��ƾ֤ //������ϸ2
jQuery("#indexnum1").bind("propertychange",function(){
	bindfee2(1); 
});
bindfee2(2);

function bindfee2(value){

    var indexnum1 = 0;
    if(document.getElementById("indexnum1")){
    	indexnum1 = document.getElementById("indexnum1").value * 1.0 - 1;
    }

    if(indexnum1>=0){
		if(value==1){ //��ǰ��ӵ���   
			
		}else if(value==2){//��ʼ�� 
			for(var nm2=0;nm2<=indexnum1;nm2++){  
	    		var idl2 = nm2;    
	    		jQuery("#field"+<%=arrayD2.get("fzhs")%>+"_"+idl2).hide();
	    		jQuery("#field"+<%=arrayD2.get("fzhs")%>+"_"+idl2+"span").html(jQuery("#field"+<%=arrayD2.get("fzhs")%>+"_"+idl2).val());
	    		jQuery("#field"+<%=arrayD2.get("kmbm")%>+"_"+idl2).bind("propertychange",function(){ 
					var f_name =jQuery(this).attr("name");  
					var _index = f_name.replace("field"+<%=arrayD2.get("kmbm")%> +"_",""); 
					var kmbm =  jQuery("#field"+<%=arrayD2.get("kmbm")%>+"_"+_index).val();
					var mxnum =  jQuery("#field"+<%=arrayD2.get("mxnum")%>+"_"+_index).val();  
					var dt1id =  jQuery("#field"+<%=arrayD2.get("dt1id")%>+"_"+_index).val(); 
					editYzfzhs(kmbm,<%=formid%>,mxnum,dt1id,<%=arrayD2.get("fzhs")%>,<%=requestid%>,<%=workflowid%>,_index,1,"",""); 
				});
			}
		}
    }
}

 

//����֧������   ��Ӧ����ʾ������
function zfdxChange(){
	var zfdx_val = jQuery("#field"+<%=mMap.get("zfdx")%>).val(); 
	//�Թ� 
	if(zfdx_val == 0){ 
 	   jQuery("#field"+<%=mMap.get("sfcxyfk")%>).parent().css("display","");
	   jQuery("#field"+<%=mMap.get("sfcxyfk")%>).parent().prev().css("display","");
 	   jQuery("#field"+<%=mMap.get("sfcxjk")%>).parent().css("display","none");
	   jQuery("#field"+<%=mMap.get("sfcxjk")%>).parent().prev().css("display","none"); 
      jQuery("#table4button").css("display","");  
      jQuery("#table2button").css("display","none");  
      jQuery("#field"+<%=mMap.get("sfcxjk")%>).val(1);
      jQuery("#field"+<%=mMap.get("sfcxyfk")%>).val(0);
      
	   jQuery("#field"+<%=mMap.get("gyskhm")%>).parent().css("display","");
	   jQuery("#field"+<%=mMap.get("gyskhm")%>).parent().prev().css("display","");
	   jQuery("#field"+<%=mMap.get("gyskhh")%>).parent().css("display","");
	   jQuery("#field"+<%=mMap.get("gyskhh")%>).parent().prev().css("display","");
	   jQuery("#field"+<%=mMap.get("gysyhzh")%>).parent().css("display","");
	   jQuery("#field"+<%=mMap.get("gysyhzh")%>).parent().prev().css("display","");
	   
 	   jQuery("#field"+<%=mMap.get("skrhm")%>).parent().css("display","none");
	   jQuery("#field"+<%=mMap.get("skrhm")%>).parent().prev().css("display","none"); 
 	   jQuery("#field"+<%=mMap.get("yhmc")%>).parent().css("display","none");
	   jQuery("#field"+<%=mMap.get("yhmc")%>).parent().prev().css("display","none"); 
 	   jQuery("#field"+<%=mMap.get("yhzh")%>).parent().css("display","none");
	   jQuery("#field"+<%=mMap.get("yhzh")%>).parent().prev().css("display","none"); 
	}
 if(zfdx_val == 1){//��˽   
		 jQuery("#field"+<%=mMap.get("sfcxyfk")%>).parent().css("display","none");
		 jQuery("#field"+<%=mMap.get("sfcxyfk")%>).parent().prev().css("display","none");
		 jQuery("#field"+<%=mMap.get("sfcxjk")%>).parent().css("display","");
		 jQuery("#field"+<%=mMap.get("sfcxjk")%>).parent().prev().css("display",""); 
	      jQuery("#table4button").css("display","none");  
	      jQuery("#table2button").css("display","");  
	      jQuery("#field"+<%=mMap.get("sfcxjk")%>).val(0);
	      jQuery("#field"+<%=mMap.get("sfcxyfk")%>).val(1);
	      
		   jQuery("#field"+<%=mMap.get("gyskhm")%>).parent().css("display","none");
		   jQuery("#field"+<%=mMap.get("gyskhm")%>).parent().prev().css("display","none");
		   jQuery("#field"+<%=mMap.get("gyskhh")%>).parent().css("display","none");
		   jQuery("#field"+<%=mMap.get("gyskhh")%>).parent().prev().css("display","none");
		   jQuery("#field"+<%=mMap.get("gysyhzh")%>).parent().css("display","none");
		   jQuery("#field"+<%=mMap.get("gysyhzh")%>).parent().prev().css("display","none");
		   
	 	   jQuery("#field"+<%=mMap.get("skrhm")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("skrhm")%>).parent().prev().css("display",""); 
	 	   jQuery("#field"+<%=mMap.get("yhmc")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("yhmc")%>).parent().prev().css("display",""); 
	 	   jQuery("#field"+<%=mMap.get("yhzh")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("yhzh")%>).parent().prev().css("display",""); 
	}
	 if(zfdx_val == ""){ 
		 jQuery("#field"+<%=mMap.get("sfcxyfk")%>).parent().css("display","");
		 jQuery("#field"+<%=mMap.get("sfcxyfk")%>).parent().prev().css("display","");
		 jQuery("#field"+<%=mMap.get("sfcxjk")%>).parent().css("display","");
		 jQuery("#field"+<%=mMap.get("sfcxjk")%>).parent().prev().css("display",""); 
	      jQuery("#table4button").css("display","");  
	      jQuery("#table2button").css("display","");  
	      
		   jQuery("#field"+<%=mMap.get("gyskhm")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("gyskhm")%>).parent().prev().css("display","");
		   jQuery("#field"+<%=mMap.get("gyskhh")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("gyskhh")%>).parent().prev().css("display","");
		   jQuery("#field"+<%=mMap.get("gysyhzh")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("gysyhzh")%>).parent().prev().css("display","");
		   
	 	   jQuery("#field"+<%=mMap.get("skrhm")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("skrhm")%>).parent().prev().css("display",""); 
	 	   jQuery("#field"+<%=mMap.get("yhmc")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("yhmc")%>).parent().prev().css("display",""); 
	 	   jQuery("#field"+<%=mMap.get("yhzh")%>).parent().css("display","");
		   jQuery("#field"+<%=mMap.get("yhzh")%>).parent().prev().css("display",""); 
	}
 
}

function select_show_SFZG(){
    var iszg_val=jQuery("#field"+<%=mMap.get("iszg")%>).val();
    if(iszg_val==null){
    	iszg_val=jQuery("#disfield"+<%=mMap.get("iszg")%>).val();
    }  
    if(iszg_val=='0'){
 	   jQuery("#table5button").parent().css("display","");
 	   jQuery("#table5button").parent().prev().css("display","");
        jQuery("#table5button").css("display",""); 

  	   jQuery("#table7button").parent().css("display","none");
 	   jQuery("#table7button").parent().prev().css("display","none");
        jQuery("#table7button").css("display","none");   
		   deleteRowInfo7(7);
    }
    if(iszg_val=='1'||iszg_val==''){ 
   	   jQuery("#table7button").parent().css("display","");
 	   jQuery("#table7button").parent().prev().css("display","");
        jQuery("#table7button").css("display","");   
    	
 	   jQuery("#table5button").parent().css("display","none");
 	   jQuery("#table5button").parent().prev().css("display","none");
        jQuery("#table5button").css("display","none");   

		   deleteRowInfo5(5);
    }
}

/**����Ԥ������ϸ��ʾ����**/ 
function  select_show_SFCXYFK(){ 
       var iscxyfk_val=jQuery("#field"+<%=mMap.get("sfcxyfk")%>).val();
       if(iscxyfk_val==null){
    	   iscxyfk_val=jQuery("#disfield"+<%=mMap.get("sfcxyfk")%>).val();
       }  
       if(iscxyfk_val=='0'){
    	   jQuery("#table4button").parent().css("display","");
    	   jQuery("#table4button").parent().prev().css("display","");
           jQuery("#table4button").css("display",""); 
 
       }
       if(iscxyfk_val=='1'||iscxyfk_val==''){ 
    
    	   jQuery("#table4button").parent().css("display","none");
    	   jQuery("#table4button").parent().prev().css("display","none");
           jQuery("#table4button").css("display","none");   

 		   deleteRowInfo4(4);
       }
	   
}



/**���������ϸ��ʾ����**/
function  select_show_SFCXJK(){ 
       var iscxjk_val=jQuery("#field"+<%=mMap.get("sfcxjk")%>).val();
       if(iscxjk_val==null){
    	   iscxjk_val=jQuery("#disfield"+<%=mMap.get("sfcxjk")%>).val();
       } 
       if(iscxjk_val=='0'){
    	   jQuery("#table2button").parent().css("display","");
    	   jQuery("#table2button").parent().prev().css("display","");
           jQuery("#table2button").css("display",""); 
 
       }
	 if(iscxjk_val=='1'||iscxjk_val==''){ 
    	   jQuery("#table2button").parent().css("display","none");
    	   jQuery("#table2button").parent().prev().css("display","none");
           jQuery("#table2button").css("display","none"); 
 		  deleteRowInfo2(2);
       }
	   
}

//ɾ����ϸ3 ������ϸ
function deleteRowInfo2(groupid){
	try{
var flag = true;
	//var ids = document.getElementsByName("check_node_"+groupid);
	//for(i=0; i<ids.length; i++) {
	//	if(ids[i].checked==true) {
	//		flag = true;
	//		break;
	//	}
	//} 
    if(flag) {
		var oTable=$G('detailFieldTable<%=arrayD3.get("jkdh")%>');
		var len = document.forms[0].elements.length;
		var curindex=parseInt($G("nodesnum"+groupid).value);
		var i=0;
		var rowsum1 = 0;
		var objname = "check_node_"+groupid;
		for(i=len-1; i >= 0;i--) {
			if (document.forms[0].elements[i].name==objname){
				rowsum1 += 1;
			}
		}
		for(i=len-1; i>=0; i--) {
			if(document.forms[0].elements[i].name==objname){
				//if(document.forms[0].elements[i].checked==true){
					var nodecheckObj;
						var delid;
					try{
						for(var cc=0; cc<jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children().length; cc++){
							if(jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc].tagName=="INPUT"){
								nodecheckObj = jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc];
						delid = nodecheckObj.value;
							}
						}
					}catch(e){}
					//��¼��ɾ���ľɼ�¼ id��
					if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
						if($G("deldtlid"+groupid).value!=''){
							//����ϸ
							$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
						}else{
							//����ϸ
							$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
						}
					}
					//���ύ��Ŵ���ɾ����ɾ������
					var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
					$G("submitdtlid"+groupid).value="";
					var k;
					for(k=0; k<submitdtlidArray.length; k++){
						if(submitdtlidArray[k]!=delid){
							if($G("submitdtlid"+groupid).value==''){
								$G("submitdtlid"+groupid).value = submitdtlidArray[k];
							}else{
								$G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
							}
						}
					}
					detailFieldTable<%=arrayD3.get("jkdh")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD3.get("hkr")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD3.get("jkje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD3.get("wqjkje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD3.get("bccxje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD3.get("jyje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD3.get("zy")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD3.get("lscx")%>.deleteRow(rowsum1);
					curindex--;
				//}
				rowsum1--;
			}
		}
		$G("nodesnum"+groupid).value=curindex;
			calSum(groupid); 
}else{
        alert('��ѡ����Ҫɾ��������');
		return;
    }	}catch(e){}
	try{
		var indexNum = jQuery("span[name='detailIndexSpan2']").length;
		for(var k=1; k<=indexNum; k++){
			jQuery("span[name='detailIndexSpan2']").get(k-1).innerHTML = k;
		}
	}catch(e){}
}


//ɾ����ϸ5 ����Ԥ����
function deleteRowInfo4(groupid){
	try{
var flag = true;
	//var ids = document.getElementsByName("check_node_"+groupid);
	//for(i=0; i<ids.length; i++) {
	//	if(ids[i].checked==true) {
	//		flag = true;
	//		break;
	//	}
	//} 
    if(flag) { 
		var oTable=$G('detailFieldTable<%=arrayD5.get("yfkmx")%>');
		var len = document.forms[0].elements.length;
		var curindex=parseInt($G("nodesnum"+groupid).value);
		var i=0;
		var rowsum1 = 0;
		var objname = "check_node_"+groupid;
		for(i=len-1; i >= 0;i--) {
			if (document.forms[0].elements[i].name==objname){
				rowsum1 += 1;
			}
		}
		for(i=len-1; i>=0; i--) {
			if(document.forms[0].elements[i].name==objname){
				//if(document.forms[0].elements[i].checked==true){
					var nodecheckObj;
						var delid;
					try{
						for(var cc=0; cc<jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children().length; cc++){
							if(jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc].tagName=="INPUT"){
								nodecheckObj = jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc];
						delid = nodecheckObj.value;
							}
						}
					}catch(e){}
					//��¼��ɾ���ľɼ�¼ id��
					if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
						if($G("deldtlid"+groupid).value!=''){
							//����ϸ
							$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
						}else{
							//����ϸ
							$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
						}
					}
					//���ύ��Ŵ���ɾ����ɾ������
					var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
					$G("submitdtlid"+groupid).value="";
					var k;
					for(k=0; k<submitdtlidArray.length; k++){
						if(submitdtlidArray[k]!=delid){
							if($G("submitdtlid"+groupid).value==''){
								$G("submitdtlid"+groupid).value = submitdtlidArray[k];
							}else{
								$G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
							}
						}
					}
					detailFieldTable<%=arrayD5.get("yfkmx")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD5.get("hkr")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD5.get("yfkje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD5.get("wqyfkje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD5.get("bccxje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD5.get("jyje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD5.get("zy")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD5.get("lscx")%>.deleteRow(rowsum1);
					curindex--;
				//}
				rowsum1--;
			}
		}
		$G("nodesnum"+groupid).value=curindex;
			calSum(groupid); 
}else{
        alert('��ѡ����Ҫɾ��������');
		return;
    }	}catch(e){}
	try{
		var indexNum = jQuery("span[name='detailIndexSpan4']").length;
		for(var k=1; k<=indexNum; k++){
			jQuery("span[name='detailIndexSpan4']").get(k-1).innerHTML = k;
		}
	}catch(e){}
}


//ɾ����ϸ6 �ݹ�����
function deleteRowInfo5(groupid){
	try{
var flag = true;
	//var ids = document.getElementsByName("check_node_"+groupid);
	//for(i=0; i<ids.length; i++) {
	//	if(ids[i].checked==true) {
	//		flag = true;
	//		break;
	//	}
	//} 
    if(flag) { 
		var oTable=$G('detailFieldTable<%=arrayD6.get("zgmx")%>');
		var len = document.forms[0].elements.length;
		var curindex=parseInt($G("nodesnum"+groupid).value);
		var i=0;
		var rowsum1 = 0;
		var objname = "check_node_"+groupid;
		for(i=len-1; i >= 0;i--) {
			if (document.forms[0].elements[i].name==objname){
				rowsum1 += 1;
			}
		}
		for(i=len-1; i>=0; i--) {
			if(document.forms[0].elements[i].name==objname){
				//if(document.forms[0].elements[i].checked==true){
					var nodecheckObj;
						var delid;
					try{
						for(var cc=0; cc<jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children().length; cc++){
							if(jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc].tagName=="INPUT"){
								nodecheckObj = jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc];
						delid = nodecheckObj.value;
							}
						}
					}catch(e){}
					//��¼��ɾ���ľɼ�¼ id��
					if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
						if($G("deldtlid"+groupid).value!=''){
							//����ϸ
							$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
						}else{
							//����ϸ
							$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
						}
					}
					//���ύ��Ŵ���ɾ����ɾ������
					var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
					$G("submitdtlid"+groupid).value="";
					var k;
					for(k=0; k<submitdtlidArray.length; k++){
						if(submitdtlidArray[k]!=delid){
							if($G("submitdtlid"+groupid).value==''){
								$G("submitdtlid"+groupid).value = submitdtlidArray[k];
							}else{
								$G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
							}
						}
					}
					detailFieldTable<%=arrayD6.get("zgmx")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD6.get("zgje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD6.get("wqzgje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD6.get("bccxje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD6.get("jyje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD6.get("zy")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD6.get("lscx")%>.deleteRow(rowsum1);
					curindex--;
				//}
				rowsum1--;
			}
		}
		$G("nodesnum"+groupid).value=curindex;
			calSum(groupid); 
}else{
        alert('��ѡ����Ҫɾ��������');
		return;
    }	}catch(e){}
	try{
		var indexNum = jQuery("span[name='detailIndexSpan5']").length;
		for(var k=1; k<=indexNum; k++){
			jQuery("span[name='detailIndexSpan5']").get(k-1).innerHTML = k;
		}
	}catch(e){}
}


//ɾ����ϸ8 �ʲ�
function deleteRowInfo7(groupid){
	try{
var flag = true;
	//var ids = document.getElementsByName("check_node_"+groupid);
	//for(i=0; i<ids.length; i++) {
	//	if(ids[i].checked==true) {
	//		flag = true;
	//		break;
	//	}
	//} 
    if(flag) { 
		var oTable=$G('detailFieldTable<%=arrayD8.get("kpbh")%>');
		var len = document.forms[0].elements.length;
		var curindex=parseInt($G("nodesnum"+groupid).value);
		var i=0;
		var rowsum1 = 0;
		var objname = "check_node_"+groupid;
		for(i=len-1; i >= 0;i--) {
			if (document.forms[0].elements[i].name==objname){
				rowsum1 += 1;
			}
		}
		for(i=len-1; i>=0; i--) {
			if(document.forms[0].elements[i].name==objname){
				//if(document.forms[0].elements[i].checked==true){
					var nodecheckObj;
						var delid;
					try{
						for(var cc=0; cc<jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children().length; cc++){
							if(jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc].tagName=="INPUT"){
								nodecheckObj = jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc];
						delid = nodecheckObj.value;
							}
						}
					}catch(e){}
					//��¼��ɾ���ľɼ�¼ id��
					if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
						if($G("deldtlid"+groupid).value!=''){
							//����ϸ
							$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
						}else{
							//����ϸ
							$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
						}
					}
					//���ύ��Ŵ���ɾ����ɾ������
					var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
					$G("submitdtlid"+groupid).value="";
					var k;
					for(k=0; k<submitdtlidArray.length; k++){
						if(submitdtlidArray[k]!=delid){
							if($G("submitdtlid"+groupid).value==''){
								$G("submitdtlid"+groupid).value = submitdtlidArray[k];
							}else{
								$G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
							}
						}
					}
					detailFieldTable<%=arrayD8.get("kpbh")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("zcbm")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("zcmc")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("zclb")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("zjff")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("sl")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("cgje")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("zjfs")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("kssyrq")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("jkrq")%>.deleteRow(rowsum1);
					detailFieldTable<%=arrayD8.get("zy")%>.deleteRow(rowsum1);
					curindex--;
				//}
				rowsum1--;
			}
		}
		$G("nodesnum"+groupid).value=curindex;
			calSum(groupid); 
}else{
        alert('��ѡ����Ҫɾ��������');
		return;
    }	}catch(e){}
	try{
		var indexNum = jQuery("span[name='detailIndexSpan7']").length;
		for(var k=1; k<=indexNum; k++){
			jQuery("span[name='detailIndexSpan7']").get(k-1).innerHTML = k;
		}
	}catch(e){}
}


function  openLscxmx(cxfieldid,idx,ind,detailnum){ 
	var jkdh_v= jQuery("#field"+cxfieldid+"_"+idx).val();  
	if(jkdh_v!=''){
		window.open('/interface/hzjjNew/pre/history_cxlsmx.jsp?workflowid='+<%=workflowid%>+'&cxid='+jkdh_v+'&ind='+ind+'&detailnum='+detailnum);
	}else{
		alert('��ѡ�������Ϣ��лл��');
	}
}
</script>
