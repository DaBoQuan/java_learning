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

<%
String requestid = StringHelper.null2String(request.getParameter("requestid"));

BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
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
<script type='text/javascript' language="javascript" src='/js/main.js'></script>


<!--<div id="warpp" style="height:600px;overflow-y:auto">-->

 <DIV id="warpp">


<TABLE id=oTable40285a904a8073af014a84a526e03023 class=detailtable border=1 ><!--isUseJQGrid=true-->
<CAPTION>对帐通知装卸暂估明细<SPAN id=div40285a904a8073af014a84a526e03023button name="div40285a904a8073af014a84a526e03023button">
&nbsp;<A href="javascript:delmx('');"><IMG title=Delete border=0 src="/images/minus.gif" width=11 height=11></A>&nbsp;<A href="javascript:addrowbyexcel('40285a904a8073af014a84a526e03023');"><IMG title=Excel border=0 src="/images/excel.gif" width=11 height=11></A></SPAN></CAPTION>
<COLGROUP>
<COL width="12%">
<COL width="11%">
<COL width="11%">
<COL width="11%">
<COL width="11%">
<COL width="11%">
<COL width="11%">
<COL width="10%">
<COL width="10%">
<COL width="12%"></COLGROUP>
<TBODY>
<TR class=Header>
<TD noWrap><INPUT id=check_node_all onclick="selectAll(this,'40285a904a8073af014a84a526e03023')" value=-1 type=checkbox name=check_node_all>装卸计划编号</TD>
<TD noWrap>
<P align=center>进出口单号</P></TD>
<TD noWrap>
<P align=center>暂估单号</P></TD>
<TD noWrap>
<P align=center>合并开票原则</P></TD>
<TD noWrap>
<P align=center>暂估金额</P></TD>
<TD noWrap>
<P align=center>未税金额</P></TD>
<TD noWrap>
<P align=center>费用类型</P></TD>
<TD noWrap>
<P align=center>暂估凭证号</P></TD>
<TD noWrap>
<P align=center>装卸日期</P></TD>
<TD noWrap>
<P align=center>&nbsp;主线路名称</P></TD>
<TD style="DISPLAY: none" noWrap>同暂估单标识</TD>
<TD style="DISPLAY: none" noWrap>公司</TD></TR>


<%

		String sql="select id,requestid,jckdh,loadplanno,invoiceno,principle,get_namebyid(a.principle,0)  printname,amount,notaxamount,feetype,voucherno,createdate,linecode,flagid,company from uf_lo_checkzxzgdetail a where a.requestid='"+requestid+"' order by a.jckdh asc";
		//System.out.println(sql);
       List sublist = baseJdbc.executeSqlForList(sql);
	   int no1=0;
       if(sublist.size()>0){
	          for(int k=0,sizek=sublist.size();k<sizek;k++){
		      Map mk = (Map)sublist.get(k);
			  
			  String id=StringHelper.null2String(mk.get("id"));
			  String jckdh=StringHelper.null2String(mk.get("jckdh"));
			  String loadplanno=StringHelper.null2String(mk.get("loadplanno"));
			  String invoiceno=StringHelper.null2String(mk.get("invoiceno"));
			  String principle=StringHelper.null2String(mk.get("principle"));
			  String printname=StringHelper.null2String(mk.get("printname"));
			  String amount=StringHelper.null2String(mk.get("amount"));
			  String notaxamount=StringHelper.null2String(mk.get("notaxamount"));
			  String feetype=StringHelper.null2String(mk.get("feetype"));
			  String voucherno=StringHelper.null2String(mk.get("voucherno"));
			  String createdate=StringHelper.null2String(mk.get("createdate"));
			  String linecode=StringHelper.null2String(mk.get("linecode"));
			  String company=StringHelper.null2String(mk.get("company"));
			  String flagid=StringHelper.null2String(mk.get("flagid"));
			 
		                
                     
		%>
<TR id=oTR40285a904a8073af014a84a526e03023 class=DataLight><!-- 明细表ID，请勿删除。-->
<TD noWrap>
<P align=center><span ><input type="checkbox" name="check_node_40285a904a8073af014a84a526e03023" value="<%=id%>"><input type=hidden name=<%="detailid_40285a904a8073af014a84a526e03023_"+k%> value="<%=id%>"></span><input type="hidden" id=<%="field_40285a904a8073af014a84bb187b30f4_"+k%> name=<%="field_40285a904a8073af014a84bb187b30f4_"+k%>  value="<%=loadplanno%>"  ><span style='width: 80%' id=<%="field_40285a904a8073af014a84bb187b30f4_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb187b30f4_"+k+"span"%> ><%=loadplanno%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a8d525ca49e01526726c9a3634a_"+k%> name=<%="field_40285a8d525ca49e01526726c9a3634a_"+k%>  value="<%=jckdh%>"  ><span style='width: 100%' id=<%="field_40285a8d525ca49e01526726c9a3634a_"+k+"span"%> name=<%="field_40285a8d525ca49e01526726c9a3634a_"+k+"span"%> ><%=jckdh%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb189e30f6_"+k%> name=<%="field_40285a904a8073af014a84bb189e30f6_"+k%> value="<%=invoiceno%>" ><span   style='width: 80%' id=<%="field_40285a904a8073af014a84bb189e30f6_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb189e30f6_"+k+"span"%> ><%=invoiceno%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb18be30f8_"+k%> name=<%="field_40285a904a8073af014a84bb18be30f8_"+k%> value="<%=principle%>" ><span style='width: 80%' id=<%="field_40285a904a8073af014a84bb18be30f8_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb18be30f8_"+k+"span"%> ><%=printname%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb18da30fa_"+k%> name=<%="field_40285a904a8073af014a84bb18da30fa_"+k%>  value="<%=amount%>"><span style='width: 80%' id=<%="field_40285a904a8073af014a84bb18da30fa_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb18da30fa_"+k+"span"%> ><%=amount%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb18f530fc_"+k%> name=<%="field_40285a904a8073af014a84bb18f530fc_"+k%>  value="<%=notaxamount%>"   ><span style='width: 80%' id=<%="field_40285a904a8073af014a84bb18f530fc_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb18f530fc_"+k+"span"%> ><%=notaxamount%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb191530fe_"+k%> name=<%="field_40285a904a8073af014a84bb191530fe_"+k%>  value="<%=feetype%>"  ><span style='width: 80%' id=<%="field_40285a904a8073af014a84bb191530fe_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb191530fe_"+k+"span"%> ><%=feetype%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb19313100_"+k%> name=<%="field_40285a904a8073af014a84bb19313100_"+k%>  value="<%=voucherno%>"  ><span style='width: 80%' id=<%="field_40285a904a8073af014a84bb19313100_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb19313100_"+k+"span"%> ><%=voucherno%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb19513102_"+k%> name=<%="field_40285a904a8073af014a84bb19513102_"+k%> value="<%=createdate%>"  style='width: 80%'  ><span id=<%="field_40285a904a8073af014a84bb19513102_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb19513102_"+k+"span"%> ><%=createdate%></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id=<%="field_40285a904a8073af014a84bb19763104_"+k%> name=<%="field_40285a904a8073af014a84bb19763104_"+k%> value="<%=linecode%>" ><span   style='width: 80%' id=<%="field_40285a904a8073af014a84bb19763104_"+k+"span"%> name=<%="field_40285a904a8073af014a84bb19763104_"+k+"span"%> ><%=linecode%></span></P></TD>
<TD style="DISPLAY: none" noWrap><input type="text" class="InputStyle2" MAXLENGTH=256 name=<%="field_40285a904b772dda014c0e2364a6532a_"+k%>  id=<%="field_40285a904b772dda014c0e2364a6532a_"+k%> style='width: 80%' value="<%=flagid%>" onblur="while(value.replace(/[^\x00-\xff]/g,'**').length>maxLength)value=value.slice(0,-1);fieldcheck(this,'','同暂估单标识')" ></TD>
<TD style="DISPLAY: none" noWrap><button type=button  class=Browser  id=<%="button_402881f34b23e292014b25655a1003bf_"+k%> name=<%="button_402881f34b23e292014b25655a1003bf_"+k%> onclick="javascript:getrefobj('field_402881f34b23e292014b25655a1003bf_0','field_402881f34b23e292014b25655a1003bf_0span','40285a8f489c17ce0148a260b3001cd3','','','0');"></button><input type="hidden" id=<%="field_402881f34b23e292014b25655a1003bf_"+k%> name=<%="field_402881f34b23e292014b25655a1003bf_"+k%> value="<%=company%>"  style='width: 80%'><span id=<%="field_402881f34b23e292014b25655a1003bf_"+k+"span"%> name=<%="field_402881f34b23e292014b25655a1003bf_"+k+"span"%> ><%=company%></span></TD></TR>
		<%	

	}
}else{%> 
<TR id=oTR40285a904a8073af014a84a526e03023 class=DataLight><!-- 明细表ID，请勿删除。-->
<TD noWrap>
<P align=center><span ><input type="checkbox" name="check_node_40285a904a8073af014a84a526e03023" value="0"><input type=hidden name="detailid_40285a904a8073af014a84a526e03023_0" value=""></span><input type="hidden" id="field_40285a904a8073af014a84bb187b30f4_0" name="field_40285a904a8073af014a84bb187b30f4_0"  value=""  ><span style='width: 80%' id="field_40285a904a8073af014a84bb187b30f4_0span" name="field_40285a904a8073af014a84bb187b30f4_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a8d525ca49e01526726c9a3634a_0" name="field_40285a8d525ca49e01526726c9a3634a_0"  value=""  ><span style='width: 100%' id="field_40285a8d525ca49e01526726c9a3634a_0span" name="field_40285a8d525ca49e01526726c9a3634a_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb189e30f6_0" name="field_40285a904a8073af014a84bb189e30f6_0" value="" ><span   style='width: 80%' id="field_40285a904a8073af014a84bb189e30f6_0span" name="field_40285a904a8073af014a84bb189e30f6_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb18be30f8_0" name="field_40285a904a8073af014a84bb18be30f8_0" value="" ><span style='width: 80%' id="field_40285a904a8073af014a84bb18be30f8_0span" name="field_40285a904a8073af014a84bb18be30f8_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb18da30fa_0" name="field_40285a904a8073af014a84bb18da30fa_0"  value=""   ><span style='width: 80%' id="field_40285a904a8073af014a84bb18da30fa_0span" name="field_40285a904a8073af014a84bb18da30fa_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb18f530fc_0" name="field_40285a904a8073af014a84bb18f530fc_0"  value=""   ><span style='width: 80%' id="field_40285a904a8073af014a84bb18f530fc_0span" name="field_40285a904a8073af014a84bb18f530fc_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb191530fe_0" name="field_40285a904a8073af014a84bb191530fe_0"  value=""  ><span style='width: 80%' id="field_40285a904a8073af014a84bb191530fe_0span" name="field_40285a904a8073af014a84bb191530fe_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb19313100_0" name="field_40285a904a8073af014a84bb19313100_0"  value=""  ><span style='width: 80%' id="field_40285a904a8073af014a84bb19313100_0span" name="field_40285a904a8073af014a84bb19313100_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb19513102_0" name="field_40285a904a8073af014a84bb19513102_0" value=""  style='width: 80%'  ><span id="field_40285a904a8073af014a84bb19513102_0span" name="field_40285a904a8073af014a84bb19513102_0span" ></span></P></TD>
<TD noWrap>
<P align=center><input type="hidden" id="field_40285a904a8073af014a84bb19763104_0" name="field_40285a904a8073af014a84bb19763104_0" value="" ><span   style='width: 80%' id="field_40285a904a8073af014a84bb19763104_0span" name="field_40285a904a8073af014a84bb19763104_0span" ></span></P></TD>
<TD style="DISPLAY: none" noWrap><input type="text" class="InputStyle2" MAXLENGTH=256 name="field_40285a904b772dda014c0e2364a6532a_0"  id="field_40285a904b772dda014c0e2364a6532a_0" style='width: 80%' value="" onblur="while(value.replace(/[^\x00-\xff]/g,'**').length>maxLength)value=value.slice(0,-1);fieldcheck(this,'','同暂估单标识')" ></TD>
<TD style="DISPLAY: none" noWrap><button type=button  class=Browser  id="button_402881f34b23e292014b25655a1003bf_0" name="button_402881f34b23e292014b25655a1003bf_0" onclick="javascript:getrefobj('field_402881f34b23e292014b25655a1003bf_0','field_402881f34b23e292014b25655a1003bf_0span','40285a8f489c17ce0148a260b3001cd3','','','0');"></button><input type="hidden" id="field_402881f34b23e292014b25655a1003bf_0" name="field_402881f34b23e292014b25655a1003bf_0" value=""  style='width: 80%'  ><span id="field_402881f34b23e292014b25655a1003bf_0span" name="field_402881f34b23e292014b25655a1003bf_0span" ></span></TD></TR>
<%} %>
</TBODY>
</table>
</div>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                