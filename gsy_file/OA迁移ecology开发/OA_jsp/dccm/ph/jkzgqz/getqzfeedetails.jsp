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
String imarrid = StringHelper.null2String(request.getParameter("imgoodnos"));//�����ᵥ���(id)
String requestid = StringHelper.null2String(request.getParameter("requestid"));
//String sdate=StringHelper.null2String(request.getParameter("sdate"));//������ʼ��
//String edate=StringHelper.null2String(request.getParameter("edate"));//���ؽ�����
//String cur=StringHelper.null2String(request.getParameter("cur"));//�ݹ�����
String payto = StringHelper.null2String(request.getParameter("payobj"));//֧���������
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
<script type='text/javascript' language="javascript"></script>

<Div id="warpp" >
<Table id="oTable40285a8d5763da3c01576e3876b22e39" style="BORDER-COLLAPSE: collapse" border=1 cellSpacing=0 cellPadding=0  style="width: 100%;font-size:12" >
<COLGROUP>
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="6%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="6%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
<COL width="4%">
</COLGROUP>

<TR  class="tr1">
<TD  noWrap class="td2"><INPUT id=check_node_all onclick="selectAll(this,'40285a8d5763da3c01576e3876b22e39')" value=-1 type=checkbox name=check_node_all>Serial Number</TD>
<TD  noWrap class="td2">Order NO</TD>
<TD  noWrap class="td2">Order Item</TD>
<TD  noWrap class="td2">ImportArrange Number</TD>
<TD  noWrap class="td2">K1 Form Number</TD>
<TD  noWrap class="td2">K1 Form Date</TD>
<TD  noWrap class="td2">Fee Name</TD>
<TD  noWrap class="td2">Payment Object</TD>
<TD  noWrap class="td2">Tax Code</TD>
<TD  noWrap class="td2">Tax Rate</TD>
<TD  noWrap class="td2">Estimate Currency</TD>
<TD  noWrap class="td2">Estimate Amount</TD>
<TD  noWrap class="td2">Estimate Rate</TD>
<TD  noWrap class="td2">Estimate Amount(Local Currency)</TD>
<TD  noWrap class="td2">Clear Currency</TD>
<TD  noWrap class="td2">Clear Amount</TD>
<TD  noWrap class="td2">Clear Rate</TD>
<TD  noWrap class="td2">Clear Amount(Local Currency)</TD>
<TD  noWrap class="td2">Cost Center</TD>
<TD  noWrap class="td2">Material</TD>
<TD  noWrap class="td2">Subject</TD>
<TD  noWrap class="td2">Business Currency(Difference)</TD>
<TD  noWrap class="td2">Local Currency(Difference)</TD>
<TD  noWrap class="td2">Remark</TD>
</TR>

<%
//���ڷ����ݹ�����-������ϸ(uf_dmph_iccdetail)
//���ڷ����ݹ���ϸ-�ӱ�(uf_dmph_icechild)
String delsql = "delete uf_dmph_iccdetail where requestid = '"+requestid+"'";//ɾ����ʷ����
baseJdbc.update(delsql);
//String sql="select acode,payobj,ledgeracc,ddate,(select t.feename from uf_dmdb_feename t where t.requestid=costname)feetxt,costname,pecurrency,cclearrate,estamount,standamount,materialno,costcenter,assetno,inerordernum,purchaseorder,olitem,importblandno,importblanditem,b.id,(select requestid from  uf_dmph_importbilllad where ibolnum=b.importblandno)tdrequestid from uf_dmph_icechild b where importblandno='"+applyorder.trim()+"' and payobj='"+payto+"' and pecurrency='"+cur+"'  and not exists(select a.id from uf_dmph_iccdetail a where a.kjrequest=b.id and 0=(select isdelete from requestbase where id=a.requestid) and requestid<>'"+requestid+"')  and 0=(select isdelete from requestbase where id=b.requestid)  order by acode";//����ע��

//String sql="select acode,payobj,ledgeracc,ddate,(select t.feename from uf_dmdb_feename t where t.requestid=costname)feetxt,costname,pecurrency,cclearrate,estamount,standamount,materialno,costcenter,assetno,inerordernum,purchaseorder,olitem,importblandno,importblanditem,b.id,(select requestid from  uf_dmph_importbilllad where ibolnum=b.importblandno)tdrequestid from uf_dmph_icechild b where importblandno='"+applyorder.trim()+"' and payobj='"+payto+"' and pecurrency='"+cur+"'   order by acode";


String sql = "select a.requestid,a.id,a.purchaseorder,a.olitem,d.ibolnum,d.k1form,d.cordate,(select feename from uf_dmdb_feename where requestid=a.costname)feetype,a.payobj,a.pecurrency,a.cclearrate,a.estamount,a.standamount,a.costcenter,a.taxcode,(select rate from uf_dmsd_taxwh where requestid=a.taxcode)taxrate,b.jzdate,b.rate,a.ledgeracc,a.materialno from uf_dmph_icechild a left join uf_dmph_accdetailsimc b on a.requestid=b.requestid left join uf_dmph_importbilllad d on b.arrivalno=d.requestid left join requestbase c on c.id=b.requestid left join requestbase req on req.id=d.requestid where 1=c.isfinished and 0=c.isdelete and 0=req.isdelete and req.isfinished=1 and (b.isvalid='40285a8d5763da3c0157646db1b4053a' or b.isvalid is null) and  (d.ifuseful='40285a8d5763da3c0157646db1b4053a' or d.ifuseful is null) and a.payobj='"+payto+"' and b.arrivalno ='"+imarrid+"' and not exists(select e.id from uf_dmph_iccdetail e,uf_dmph_importchargemain k where e.requestid = k.requestid and 0=(select isdelete from requestbase where id = k.requestid) and (k.isvalid ='40288098276fc2120127704884290210' or k.isvalid is null) and e.kjrequest=a.requestid ) order by d.ibolnum";
 
 
if(imarrid.equals(""))
{
	//sql="select acode,payobj,ledgeracc,ddate,costname,pecurrency,cclearrate,estamount,standamount,materialno,costcenter,assetno,inerordernum,purchaseorder,olitem,importblandno,importblanditem,b.id,(select requestid from  uf_dmph_importbilllad where ibolnum=b.importblandno)tdrequestid from uf_dmph_icechild b where payobj='"+payto+"' and pecurrency='"+cur+"'  and not exists(select a.id from uf_dmph_iccdetail a where a.kjrequest=b.id and 0=(select isdelete from requestbase where id=a.requestid) and requestid<>'"+requestid+"') order by acode";
	
	
	sql = "select a.requestid,a.id,a.purchaseorder,a.olitem,d.ibolnum,d.k1form,d.cordate,(select feename from uf_dmdb_feename where requestid=a.costname)feetype,a.payobj,a.pecurrency,a.cclearrate,a.estamount,a.standamount,a.costcenter,a.taxcode,(select rate from uf_dmsd_taxwh where requestid=a.taxcode)taxrate,b.jzdate,b.rate,a.ledgeracc,a.materialno from uf_dmph_icechild a left join uf_dmph_accdetailsimc b on a.requestid=b.requestid left join uf_dmph_importbilllad d on b.arrivalno=d.requestid left join requestbase c on c.id=b.requestid left join requestbase req on req.id=d.requestid where 1=c.isfinished and 0=c.isdelete and 0=req.isdelete and req.isfinished=1 and (b.isvalid='40285a8d5763da3c0157646db1b4053a' or b.isvalid is null) and  (d.ifuseful='40285a8d5763da3c0157646db1b4053a' or d.ifuseful is null) and a.payobj='"+payto+"' and not exists(select e.id from uf_dmph_iccdetail e,uf_dmph_importchargemain k where e.requestid = k.requestid and 0=(select isdelete from requestbase where id = k.requestid) and (k.isvalid ='40288098276fc2120127704884290210' or k.isvalid is null) and e.kjrequest=a.requestid ) order by d.ibolnum";
}

System.out.println(sql);

int sno = 0;//���
String ordno = "";//�ɹ�������
String orditem = "";//�������
String imarrno = "";//�����ᵥ���
String bgno = "";//���ص���
String bgdate = "";//��������
String feename = "";//��������
String payobj = "";//֧������
String zgcurr = "";//�ݹ�����
String zgrate = "";//�ݹ�����
String zgamount = "";//�ݹ����
String zgbwb = "";//�ݹ���λ��
String costcenter = "";//�ɱ�����
String material = "";//���Ϻ�
String subject = "";//���˿�Ŀ
String busdiff = "0";//ҵ����Ҳ��(Ĭ��Ϊ0)
String bwbdiff = "0";//��λ�Ҳ��(Ĭ��Ϊ0)
String remark = "";//��ע(Ĭ��Ϊ��)
//˰��Ĭ��IS(��Ӧ˰��Ϊ0);
String taxid = "40285a8c5e08c702015e11d1b85a061b";//˰��id
String taxtxt = "IS";
String taxrate = "0";//˰��
String imgoodsid = "";//�����ᵥ���(����ƴ������̧ͷ�Ľ����ᵥ)
String kjrequest = "";//��Ӧ�����ϸrequestid(����ƴ������̧ͷ�Ľ����ᵥ)




List sublist = baseJdbc.executeSqlForList(sql);
if(sublist.size()>0)
{
	for(int k=0,sizek=sublist.size();k<sizek;k++)
	{
		Map mk = (Map)sublist.get(k);
		sno = k+1;//���
		ordno = StringHelper.null2String(mk.get("purchaseorder"));//�ɹ�������
		orditem = StringHelper.null2String(mk.get("olitem"));//�ɹ������
		imarrno = StringHelper.null2String(mk.get("ibolnum"));//�����ᵥ��
		bgno = StringHelper.null2String(mk.get("k1form"));//K1 Form Number
		bgdate = StringHelper.null2String(mk.get("cordate"));//K1 Form Date
		feename = StringHelper.null2String(mk.get("feetype"));//��������
		payobj = StringHelper.null2String(mk.get("payobj"));//֧������
		zgcurr = StringHelper.null2String(mk.get("pecurrency"));//�ݹ�����
		zgrate = StringHelper.null2String(mk.get("cclearrate"));//�ݹ�����
		zgamount = StringHelper.null2String(mk.get("estamount"));//�ݹ����
		zgbwb = StringHelper.null2String(mk.get("standamount"));//�ݹ���λ��
		costcenter = StringHelper.null2String(mk.get("costcenter"));//�ɱ�����
		material = StringHelper.null2String(mk.get("materialno"));//���Ϻ�
		subject = StringHelper.null2String(mk.get("ledgeracc"));//���˿�Ŀ
		//����ƴ������̧ͷ�Ľ����ᵥ
		imgoodsid = StringHelper.null2String(mk.get("ibolnum"));//�����ᵥ���
		kjrequest = StringHelper.null2String(mk.get("requestid"));//��Ӧ�����ϸrequestid
		

		//String insql = "insert into uf_dmph_iccdetail  (id,requestid,sno,imgoodsid,imgoodsitem,feetype,payobject,estcurrency,estmoney,estrate,estamount,clearmoney,clearamount,buscurrencydiff,currencydiff,materialid,costcenter,assetid,innerorderid,ledgersubject,purorderid,purorderitem,kjrequest,ddate,imgoodsreq)values(";
		//insql = insql +"'"+IDGernerator.getUnquieID()+"','"+requestid+"','"+no+"','"+imgoodsid+"','"+imgoodsitem+"','"+feetypes+"','"+paycode+"','"+cur+"','"+amount+"','"+rate+"','"+df.format(rmbamount)+"',";
		//insql = insql +"'"+IDGernerator.getUnquieID()+"','"+requestid+"',"+(k+1)+",'"+importblandno+"','"+importblanditem+"','"+costname+"','"+payobj+"','"+pecurrency+"','"+estamount+"','"+cclearrate+"','"+standamount+"',";
	
		//insql = insql +"'"+standamount+"','','','','"+materialno+"','"+costcenter+"','','','"+ledgeracc+"','"+purchaseorder+"','"+olitem+"','"+id+"','"+ddate+"','"+imgoodsreq+"')";
		
		
		//ҵ����Ҳ��Ĭ��Ϊ0;��λ�Ҳ��Ĭ��Ϊ0;RemarkĬ��Ϊ��;
		//���ʱ���Ĭ���ݹ�����;���ʽ��Ĭ���ݹ����;���ʻ���Ĭ���ݹ�����;���ʱ�λ��Ĭ���ݹ���λ��;
		String insql = "insert into uf_dmph_iccdetail(id,requestid,sno,purorderid,purorderitem,imarrno,k1number,ddate,feetype,payobject,qzsm,qzsl,estcurrency,estmoney,estrate,estamount,qzcurr,clearmoney,qzrate,clearamount,costcenter,materialid,ledgersubject,buscurrencydiff,currencydiff,remark,imgoodsid,kjrequest)values('"+IDGernerator.getUnquieID()+"','"+requestid+"',"+(k+1)+",'"+ordno+"','"+orditem+"','"+imarrno+"','"+bgno+"','"+bgdate+"','"+feename+"','"+payobj+"','"+taxid+"','"+taxrate+"','"+zgcurr+"','"+zgamount+"','"+zgrate+"','"+zgbwb+"','"+zgcurr+"','"+zgamount+"','"+zgrate+"','"+zgbwb+"','"+costcenter+"','"+material+"','"+subject+"','"+busdiff+"','"+bwbdiff+"','"+remark+"','"+imgoodsid+"','"+kjrequest+"')";
		baseJdbc.update(insql);
		//System.out.println(insql);

%>



<TR id=oTR40285a8d5763da3c01576e3876b22e39 class=DataLight><!-- ��ϸ��ID������ɾ����-->
<!--Serial Number-->
<TD noWrap><span ><input type="checkbox" name="check_node_40285a8d5763da3c01576e3876b22e39" value="<%=k%>"><input type=hidden name="detailid_40285a8d5763da3c01576e3876b22e39_0" value="<%=k%>"></span><input type="hidden" id=<%="field_40285a8d5763da3c01576e3876f92e3a_"+k%> name=<%="field_40285a8d5763da3c01576e3876f92e3a_"+k%> value="<%=sno%>" maxlength=24  ><span style='width: 60%' id=<%="field_40285a8d5763da3c01576e3876f92e3a_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3876f92e3a_"+k+"span"%> ><%=(k+1)%></span></TD>
<!--Order NO-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e38793d2e5e_"+k%> name=<%="field_40285a8d5763da3c01576e38793d2e5e_"+k%>  value="<%=ordno%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e38793d2e5e_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e38793d2e5e_"+k+"span"%> ><%=ordno%></span></TD>
<!--Order Item-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3879652e60_"+k%> name=<%="field_40285a8d5763da3c01576e3879652e60_"+k%>  value="<%=orditem%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3879652e60_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3879652e60_"+k+"span"%> ><%=orditem%></span></TD>
<!--ImportArrange Number-->
<TD noWrap><input type="hidden" id=<%="field_40285a8c60b5859d0160bae743351ad8_"+k%> name=<%="field_40285a8c60b5859d0160bae743351ad8_"+k%>  value="<%=imarrno%>"  ><span style='width: 80%' id=<%="field_40285a8c60b5859d0160bae743351ad8_"+k+"span"%> name=<%="field_40285a8c60b5859d0160bae743351ad8_"+k+"span"%> ><%=imarrno%></span></TD>
<!--K1 Form Number-->
<TD noWrap><input type="hidden" id=<%="field_40285a8c60b5859d0160bae743741ada_"+k%> name=<%="field_40285a8c60b5859d0160bae743741ada_"+k%>  value="<%=bgno%>"  ><span style='width: 80%' id=<%="field_40285a8c60b5859d0160bae743741ada_"+k+"span"%> name=<%="field_40285a8c60b5859d0160bae743741ada_"+k+"span"%> ><%=bgno%></span></TD>
<!--K1 Form Date-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5ac62b7f015ac692b2d60476_"+k%> name=<%="field_40285a8d5ac62b7f015ac692b2d60476_"+k%>  value="<%=bgdate%>"  ><span style='width: 80%' id=<%="field_40285a8d5ac62b7f015ac692b2d60476_"+k+"span"%> name=<%="field_40285a8d5ac62b7f015ac692b2d60476_"+k+"span"%> ><%=bgdate%></span></TD>
<!--Fee Name-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3877602e40_"+k%> name=<%="field_40285a8d5763da3c01576e3877602e40_"+k%>  value="<%=feename%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3877602e40_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3877602e40_"+k+"span"%> ><%=feename%></span></TD>
<!--Payment Object-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3877842e42_"+k%> name=<%="field_40285a8d5763da3c01576e3877842e42_"+k%>  value="<%=payobj%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3877842e42_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3877842e42_"+k+"span"%> ><%=payobj%></span></TD>

<!--Tax Code-->
<TD noWrap><button type=button  class=Browser id="button_title" name="button_title" onclick="javascript:getrefobj('<%="field_40285a8c60b5859d0160baebd0901ae0_"+k%>','<%="field_40285a8c60b5859d0160baebd0901ae0_" +k+"span"%>','40285a8d56d542730156e997518f3381','','','1');UpTaxCode('<%=k%>')"></button>
<input type="hidden" id=<%="field_40285a8c60b5859d0160baebd0901ae0_"+k%> name=<%="field_40285a8c60b5859d0160baebd0901ae0_"+k%>  value="<%=taxid%>"  ><span style='width: 80%' id=<%="field_40285a8c60b5859d0160baebd0901ae0_"+k+"span"%> name=<%="field_40285a8c60b5859d0160baebd0901ae0_"+k+"span"%> ><%=taxtxt%><img src="/images/base/checkinput.gif" align=absMiddle></span></TD>

<!--Tax Rate-->
<TD noWrap><input type="hidden" id=<%="field_40285a8c60b5859d0160baebd0ce1ae2_"+k%> name=<%="field_40285a8c60b5859d0160baebd0ce1ae2_"+k%>  value="<%=taxrate%>"  ><span style='width: 60%' id=<%="field_40285a8c60b5859d0160baebd0ce1ae2_"+k+"span"%> name=<%="field_40285a8c60b5859d0160baebd0ce1ae2_"+k+"span"%> ><%=taxrate%></span></TD>

<!--Estimate Currency-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3877a72e44_"+k%> name=<%="field_40285a8d5763da3c01576e3877a72e44_"+k%>  value="<%=zgcurr%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3877a72e44_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3877a72e44_"+k+"span"%> ><%=zgcurr%></span></TD>

<!--Estimate Amount-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3877cc2e46_"+k%> name=<%="field_40285a8d5763da3c01576e3877cc2e46_"+k%>  value="<%=zgamount%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3877cc2e46_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3877cc2e46_"+k+"span"%> ><%=zgamount%></span></TD>

<!--Estimate Rate-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3877f02e48_"+k%> name=<%="field_40285a8d5763da3c01576e3877f02e48_"+k%>  value="<%=zgrate%>"  ><span style='width: 60%' id=<%="field_40285a8d5763da3c01576e3877f02e48_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3877f02e48_"+k+"span"%> ><%=zgrate%></span></TD>

<!--Estimate Amount(Local Currency)-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3878142e4a_"+k%> name=<%="field_40285a8d5763da3c01576e3878142e4a_"+k%>  value="<%=zgbwb%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3878142e4a_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3878142e4a_"+k+"span"%> ><%=zgbwb%></span></TD>

<!--Clear Currency-->
<TD noWrap>
<button type=button  class=Browser id="button_curr" name="button_curr" onclick="javascript:getrefobj('<%="field_40285a8c60b5859d0160c8db485325ad_"+k%>','<%="field_40285a8c60b5859d0160c8db485325ad_" +k+"span"%>','40285a8d56d542730156e4f80abc256a','','','1');UpCurrency('<%=k%>')"></button>
<input type="hidden" id=<%="field_40285a8c60b5859d0160c8db485325ad_"+k%> name=<%="field_40285a8c60b5859d0160c8db485325ad_"+k%>  value="<%=zgcurr%>"  ><span style='width: 80%' id=<%="field_40285a8c60b5859d0160c8db485325ad_"+k+"span"%> name=<%="field_40285a8c60b5859d0160c8db485325ad_"+k+"span"%> ><%=zgcurr%><img src="/images/base/checkinput.gif" align=absMiddle></span></TD>

<!--Clear Amount-->
<TD noWrap><input type="text" id=<%="field_40285a8d5763da3c01576e3878392e4c_"+k%> name=<%="field_40285a8d5763da3c01576e3878392e4c_"+k%>  value="<%=zgamount%>" onblur="changeqzje('<%=sno%>','<%=k%>')"><span style='width: 40%' id=<%="field_40285a8d5763da3c01576e3878392e4c_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3878392e4c_"+k+"span"%> ><img src="/images/base/checkinput.gif" align=absMiddle></span></TD>

<!--Clear Rate-->
<TD noWrap><input type="text" id=<%="field_40285a8c60b5859d0160bb0962901b56_"+k%> name=<%="field_40285a8c60b5859d0160bb0962901b56_"+k%>  value="<%=zgrate%>" onblur="changeqzhl('<%=sno%>','<%=k%>')"><span style='width: 40%' id=<%="field_40285a8c60b5859d0160bb0962901b56_"+k+"span"%> name=<%="field_40285a8c60b5859d0160bb0962901b56_"+k+"span"%> ><img src="/images/base/checkinput.gif" align=absMiddle></span></TD>

<!--Clear Amount(Local Currency)-->
<TD noWrap><input type="text" id=<%="field_40285a8d5763da3c01576e3878612e4e_"+k%> name=<%="field_40285a8d5763da3c01576e3878612e4e_"+k%>  value="<%=zgbwb%>" onblur="changeqzbwb('<%=sno%>','<%=k%>')"><span style='width: 40%' id=<%="field_40285a8d5763da3c01576e3878612e4e_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3878612e4e_"+k+"span"%> ><img src="/images/base/checkinput.gif" align=absMiddle></span></TD>

<!--Cost Center-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3878ee2e56_"+k%> name=<%="field_40285a8d5763da3c01576e3878ee2e56_"+k%>  value="<%=costcenter%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3878ee2e56_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3878ee2e56_"+k+"span"%> ><%=costcenter%></span></TD>

<!--Material-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3878d72e54_"+k%> name=<%="field_40285a8d5763da3c01576e3878d72e54_"+k%>  value="<%=material%>"  ><span style='width: 60%' id=<%="field_40285a8d5763da3c01576e3878d72e54_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3878d72e54_"+k+"span"%> ><%=material%></span></TD>

<!--Subject-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3879282e5c_"+k%> name=<%="field_40285a8d5763da3c01576e3879282e5c_"+k%>  value="<%=subject%>"  ><span style='width: 60%' id=<%="field_40285a8d5763da3c01576e3879282e5c_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3879282e5c_"+k+"span"%> ><%=subject%></span></TD>

<!--Business Currency(Difference)-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3878882e50_"+k%> name=<%="field_40285a8d5763da3c01576e3878882e50_"+k%>  value="<%=busdiff%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3878882e50_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3878882e50_"+k+"span"%> ><%=busdiff%></span></TD>

<!--Local Currency(Difference)-->
<TD noWrap><input type="hidden" id=<%="field_40285a8d5763da3c01576e3878af2e52_"+k%> name=<%="field_40285a8d5763da3c01576e3878af2e52_"+k%>  value="<%=bwbdiff%>"  ><span style='width: 80%' id=<%="field_40285a8d5763da3c01576e3878af2e52_"+k+"span"%> name=<%="field_40285a8d5763da3c01576e3878af2e52_"+k+"span"%> ><%=bwbdiff%></span></TD>

<!--Remark-->
<TD noWrap><input type="text" id=<%="field_40285a8c60b5859d0160baee2b591ae6_"+k%> name=<%="field_40285a8c60b5859d0160baee2b591ae6_"+k%>  value="<%=remark%>" onblur="changeremark('<%=sno%>','<%=k%>')"><span style='width: 80%' id=<%="field_40285a8c60b5859d0160baee2b591ae6_"+k+"span"%> name=<%="field_40285a8c60b5859d0160baee2b591ae6_"+k+"span"%> ></span></TD>
</TR>
<%		
	}
}else{%> 
	<TR class="tr1">
	<TD class="td2" colspan="14">NO Message!</TD>
	</TR>
<%} 
%>
</table>
</div>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                