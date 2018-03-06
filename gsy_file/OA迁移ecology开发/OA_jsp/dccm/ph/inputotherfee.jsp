<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.eweaver.base.BaseJdbcDao"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.eweaver.base.util.*" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="com.eweaver.base.BaseContext" %>
<%@ page import="com.eweaver.base.label.service.LabelService" %>
<%@ page import="com.eweaver.base.security.service.acegi.EweaverUser" %>
<%@ page import="com.eweaver.humres.base.model.Humres" %>
<%@ page import="com.eweaver.humres.base.service.HumresService" %>
<%@ page import="com.eweaver.base.setitem.service.SetitemService"%>
<%@ page import="com.eweaver.base.util.DateHelper"%>

<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>

<%@ page import="com.eweaver.app.configsap.SapSync"%>

<%@ page import="java.text.DecimalFormat;"%>

<%
String requestid = StringHelper.null2String(request.getParameter("requestid"));//requestid
//String supply = StringHelper.null2String(request.getParameter("supply"));//
//String imgoodsno = StringHelper.null2String(request.getParameter("imgoodsno"));//ҭեאք޸ࠚսܵҠ�?
String goodtype = StringHelper.null2String(request.getParameter("goodtype"));//��������

BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
String nodeshow=StringHelper.null2String(request.getParameter("nodeshow"));//עǰޚ֣ìӾӘؖ׎c

%>
<style type="text/css"> 


tr.tr1{     
    TEXT-INDENT: -1pt; 
    TEXT-ALIGN: left; 
    height: 22px; 
    background-color:#f8f8f0; 
} 
tr.title{ 
	font-size:12px; 
	font-weight:bold;
    TEXT-INDENT: -1pt; 
    TEXT-ALIGN: left; 
    height: 22px; 
    background-color:#f8f8f0; 
} 
tr.hj{     
    TEXT-INDENT: -1pt; 
    TEXT-ALIGN: left; 
    height: 22px; 
    background-color:#e46d0a; 
} 
td.td1{ 
    font-size:12px; 
    PADDING-RIGHT: 4px; 
    PADDING-LEFT: 4px;     
    TEXT-DECORATION: none 

} 
td.td2{ 
	height: 22px;
    font-size:12px; 
    PADDING-RIGHT: 4px; 
    PADDING-LEFT: 4px;     
    TEXT-DECORATION: none; 
    color:#000; 

} 


</style>
<script type='text/javascript' language="javascript" src='/js/main.js'>


</script>


<!--<div id="warpp" style="height:600px;overflow-y:auto">-->
<DIV id="warpp"> 
<TABLE id=oTable40285a8d4ae75b38014aeb964f391e57 class=detailtable border=1> 

<COLGROUP> 
<COL width=80> 
<COL width=140> 
<COL width=80> 
<COL width=120> 
<COL width=100> 
<COL width=80> 
<COL width=80> 
<COL width=80> 
<COL width=100> 
<COL width=100> 
<COL width=140> 
<COL width=160> 
<COL width=80> 
<COL width=60> 
<COL width=100> 
<COL width=100></COLGROUP> 
<TR class=Header> 
<TD noWrap><INPUT id=check_node_all onclick="selectAll(this,'40285a8d4ae75b38014aeb964f391e57')" value=-1 type=checkbox name=check_node_all>���</TD> 
<TD noWrap>���ڵ������</TD> 
<TD noWrap>��������</TD> 
<TD noWrap>��������</TD> 
<TD noWrap>��̯����</TD> 
<TD noWrap>����</TD> 
<TD noWrap>���ʺ�˰���</TD> 
<TD noWrap>����δ˰���</TD> 
<TD noWrap>���ʱ�λ�ҽ��</TD> 
<TD noWrap>���˿�Ŀ</TD> 
<TD noWrap>��ע</TD> 
<TD noWrap>��Ʊ����</TD> 
<TD noWrap>˰��</TD> 
<TD noWrap>˰��</TD> 
<TD noWrap>��Ʊ������</TD> 
<TD noWrap>��Ʊ�ܽ��</TD></TR> 


<%
	//��ѯ���ݲ���ʾ
	String selsql = "select sno,a.imgoodsid,(select ibolnum from uf_dmph_importbilllad  where requestid = a.imgoodsid) as imgoodflow,(select objname from selectitem where id = imgoodstype) as typename,imgoodstype,(select expensename from uf_dmph_maintenance  where requestid=feetype) as feename,feetype,(select objname from selectitem where id=allobase) as ftjs,allobase,currency,cleartaxmoney,clearnotaxmoney,clearcurrmoney,ledgersubject,remarks,(select objname from selectitem where id=taxtype) as taxtypename,taxtype,taxrate,invoicetotal,invoiceamount from uf_tr_feeothersub a where requestid = '"+requestid+"' order by sno asc";
	//System.out.println(selsql);
	List sublist4 = baseJdbc.executeSqlForList(selsql);
	//System.out.println("��ѯ��������Ϊ��"+sublist4.size());
	if(sublist4.size() >0)
	{
		for(int j = 0;j<sublist4.size();j++)
		{
			Map m4 = (Map)sublist4.get(j);
			String sno = StringHelper.null2String(m4.get("sno"));//���
			String imgoodsid = StringHelper.null2String(m4.get("imgoodsid"));//���ڵ������id
			String imgoodflow = StringHelper.null2String(m4.get("imgoodflow"));//���ڵ������
			//System.out.println(imgoodflow);
			//String typename = StringHelper.null2String(m4.get("typename"));//���ڻ������
			//String imgoodstype = StringHelper.null2String(m4.get("imgoodstype"));//���ڻ������id
			String feename = StringHelper.null2String(m4.get("feename"));//��������
			String feetype = StringHelper.null2String(m4.get("feetype"));//��������id
			
			String ftjs = StringHelper.null2String(m4.get("ftjs"));//��̯����
			String allobase = StringHelper.null2String(m4.get("allobase"));//��̯����id

			String currency = StringHelper.null2String(m4.get("currency"));//����
			String cleartaxmoney = StringHelper.null2String(m4.get("cleartaxmoney"));//���ʺ�˰���
			String clearnotaxmoney = StringHelper.null2String(m4.get("clearnotaxmoney"));//����δ˰���
			String clearcurrmoney = StringHelper.null2String(m4.get("clearcurrmoney"));//���ʱ�λ�ҽ��
			String ledgersubject = StringHelper.null2String(m4.get("ledgersubject"));//���˿�Ŀ
			String remarks = StringHelper.null2String(m4.get("remarks"));//��ע

			//String invoicename = StringHelper.null2String(m4.get("invoicename"));//��Ʊ����
			//String invoicetype = StringHelper.null2String(m4.get("invoicetype"));//��Ʊ����id

			String taxtypename = StringHelper.null2String(m4.get("taxtypename"));//˰��
			String taxtype = StringHelper.null2String(m4.get("taxtype"));//˰��id
			String taxrate = StringHelper.null2String(m4.get("taxrate"));//˰��
			String invoicetotal = StringHelper.null2String(m4.get("invoicetotal"));//��Ʊ������
			String invoiceamount = StringHelper.null2String(m4.get("invoiceamount"));//��Ʊ�ܽ��

%>
	<TR id=oTR40285a8d4ae75b38014aeb964f391e57 class=DataLight><!-- ��ϸ��ID������ɾ����--> 
	<TD noWrap><span ><input type="checkbox" name="check_node_40285a8d4ae75b38014aeb964f391e57" value="<%=j%>"><input type=hidden name="<%="detailid_40285a8d4ae75b38014aeb964f391e57_"+j%>" value="40285a8d4fbaabf8014fd932d6030410"></span><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d32121e8c_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d32121e8c_"+j%>" value="<%=sno%>" maxlength=24  ><span style='width: 40%' id="<%="field_40285a8d4ae75b38014aeb9d32121e8c_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d32121e8c_"+j+"span"%>" ><%=sno%></span></TD> 
	<TD noWrap><button type=button  class=Browser id="<%="button_40285a8d4ae75b38014aeb9d32361e8e_"+j%>" name="<%="button_40285a8d4ae75b38014aeb9d32361e8e_"+j%>" onclick="javascript:getrefobj('<%="field_40285a8d4ae75b38014aeb9d32361e8e_"+j%>','<%="field_40285a8d4ae75b38014aeb9d32361e8e_"+j+"span"%>','40285a8d4acccf8c014ad18dd52175ff','sqlwhere=instr((select wm_concat(distinct(imgoodsid)) from uf_tr_feeclearsub where requestid =%27$40285a8d4f024188014f15a158e37571$%27),imgoodsid)>0','','1');getallmon();"></button><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d32361e8e_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d32361e8e_"+j%>" value="<%=imgoodsid%>"  style='width: 80%'   ><span id="<%="field_40285a8d4ae75b38014aeb9d32361e8e_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d32361e8e_"+j+"span"%>" ><img src="/images/base/checkinput.gif" align=absMiddle><%=imgoodflow%></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d325b1e90_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d325b1e90_"+j%>" value="<%=imgoodstype%>" ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d325b1e90_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d325b1e90_"+j+"span"%>" ><%=typename%></span></TD> 
	<TD noWrap><button type=button  class=Browser id="<%="button_40285a8d4ae75b38014aeb9d327c1e92_"+j%>" name="<%="button_40285a8d4ae75b38014aeb9d327c1e92_"+j%>" onclick="javascript:getrefobj('<%="field_40285a8d4ae75b38014aeb9d327c1e92_"+j%>','<%="field_40285a8d4ae75b38014aeb9d327c1e92_"+j+"span"%>','40285a90497a8f7801497dbf14870370','sqlwhere=factype=%27$40285a8d4ae75b38014aeb8686061bd8$%27 and importandexport = %2740285a90497a8f7801497d7b4cbd0031%27','','1');getsubjectbyname();"></button><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d327c1e92_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d327c1e92_"+j%>" value="<%=feetype%>"  style='width: 80%'   ><span id="<%="field_40285a8d4ae75b38014aeb9d327c1e92_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d327c1e92_"+j+"span"%>" ><%=feename%></span></TD> 
<%
	if(ftjs.equals("��Ʊ����"))
	{%>
		<TD noWrap><input type="hidden" name="field_40285a8d4ae75b38014aeb9d32a01e94_fieldcheck" value="" ><select class="InputStyle6"  name="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>"   id="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>" style='width: 80%'   onChange="fillotherselect(this,'40285a8d4ae75b38014aeb9d32a01e94',0);checkInput('<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>','<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>');"  ><option value="<%=allobase%>"  ></option><option value="40285a90497a8f7801497d967012006a" selected   >��Ʊ����</option><option value="40285a90497a8f7801497d9670120069"  >��Ʊ���</option></select><span id="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>" ></span></TD> 
	<%}else if(ftjs.equals("��Ʊ���"))
	{%>
		<TD noWrap><input type="hidden" name="field_40285a8d4ae75b38014aeb9d32a01e94_fieldcheck" value="" ><select class="InputStyle6"  name="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>"   id="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>" style='width: 80%'   onChange="fillotherselect(this,'40285a8d4ae75b38014aeb9d32a01e94',0);checkInput('<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>','<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>');"  ><option value="<%=allobase%>"  ></option><option value="40285a90497a8f7801497d967012006a"  >��Ʊ����</option><option value="40285a90497a8f7801497d9670120069" selected   >��Ʊ���</option></select><span id="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>" ></span></TD> 
	<%}else{%>
		<TD noWrap><input type="hidden" name="field_40285a8d4ae75b38014aeb9d32a01e94_fieldcheck" value="" ><select class="InputStyle6"  name="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>"   id="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>" style='width: 80%'   onChange="fillotherselect(this,'40285a8d4ae75b38014aeb9d32a01e94',0);checkInput('<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j%>','<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>');"  ><option value="" ></option><option value="40285a90497a8f7801497d967012006a"  >��Ʊ����</option><option value="40285a90497a8f7801497d9670120069" >��Ʊ���</option></select><span id="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d32a01e94_"+j+"span"%>" ></span></TD> 
	<%}
	%>

	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d32c51e96_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d32c51e96_"+j%>"  value="<%=currency%>"  ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d32c51e96_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d32c51e96_"+j+"span"%>" ><%=currency%></span></TD> 
	<TD noWrap><input type="text" class="InputStyle2" name="<%="field_40285a8d4ae75b38014aeb9d32e81e98_"+j%>"  id="<%="field_40285a8d4ae75b38014aeb9d32e81e98_"+j%>" value="<%=cleartaxmoney%>"  style='width: 80%'  onKeyup="updatemonvalue()"onblur="fieldcheck(this,'^(-?[\\d+]{1,20})(\\.[\\d+]{1,4})?$','���ʺ�˰���')"  onChange="fieldcheck(this,'^(-?[\\d+]{1,20})(\\.[\\d+]{1,4})?$','���ʺ�˰���');checkInput('<%="field_40285a8d4ae75b38014aeb9d32e81e98_"+j%>','<%="field_40285a8d4ae75b38014aeb9d32e81e98_"+j+"span"%>');" ><span id="<%="field_40285a8d4ae75b38014aeb9d32e81e98_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d32e81e98_"+j+"span"%>" ><img src="/images/base/checkinput.gif" align=absMiddle></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d33191e9a_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d33191e9a_"+j%>"  value="<%=clearnotaxmoney%>"   ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d33191e9a_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d33191e9a_"+j+"span"%>" ><%=clearnotaxmoney%></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d33411e9c_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d33411e9c_"+j%>"  value="<%=clearcurrmoney%>"   ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d33411e9c_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d33411e9c_"+j+"span"%>" ><%=clearcurrmoney%></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d33681e9e_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d33681e9e_"+j%>"  value="<%=ledgersubject%>"  ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d33681e9e_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d33681e9e_"+j+"span"%>" ><%=ledgersubject%></span></TD> 
	<TD noWrap><input type="text" class="InputStyle2" MAXLENGTH=256 name="<%="field_40285a8d4ae75b38014aeb9d338d1ea0_"+j%>"  id="<%="field_40285a8d4ae75b38014aeb9d338d1ea0_"+j%>" style='width: 80%' value="<%=remarks%>" onblur="while(value.replace(/[^\x00-\xff]/g,'**').length>maxLength)value=value.slice(0,-1);fieldcheck(this,'','��ע')" ></TD> 
	<TD noWrap><button type=button  class=Browser id="<%="button_40285a8d4ae75b38014aeb9d33b81ea2_"+j%>" name="<%="button_40285a8d4ae75b38014aeb9d33b81ea2_"+j%>" onclick="javascript:getrefobj('<%="field_40285a8d4ae75b38014aeb9d33b81ea2_"+j%>','<%="field_40285a8d4ae75b38014aeb9d33b81ea2_"+j+"span"%>','40285a904975c288014979410ee916b8','','','1');updatemonvalue();"></button><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d33b81ea2_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d33b81ea2_"+j%>" value="<%=invoicetype%>"  style='width: 80%'  ><span id="<%="field_40285a8d4ae75b38014aeb9d33b81ea2_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d33b81ea2_"+j+"span"%>" ><%=invoicename%><img src="/images/base/checkinput.gif" align=absMiddle></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d33e71ea4_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d33e71ea4_"+j%>" value="<%=taxtype%>" ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d33e71ea4_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d33e71ea4_"+j+"span"%>" ><%=taxtypename%></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d340e1ea6_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d340e1ea6_"+j%>"  value="<%=taxrate%>"  ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d340e1ea6_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d340e1ea6_"+j+"span"%>" ><%=taxrate%></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d34361ea8_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d34361ea8_"+j%>"  value="<%=invoicetotal%>"   ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d34361ea8_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d34361ea8_"+j+"span"%>" ><%=invoicetotal%></span></TD> 
	<TD noWrap><input type="hidden" id="<%="field_40285a8d4ae75b38014aeb9d345f1eaa_"+j%>" name="<%="field_40285a8d4ae75b38014aeb9d345f1eaa_"+j%>"  value="<%=invoiceamount%>"   ><span style='width: 80%' id="<%="field_40285a8d4ae75b38014aeb9d345f1eaa_"+j+"span"%>" name="<%="field_40285a8d4ae75b38014aeb9d345f1eaa_"+j+"span"%>" ><%=invoiceamount%></span></TD></TR>
	<%
	}
}else{%> 
<%} %>
</table>
</div>
