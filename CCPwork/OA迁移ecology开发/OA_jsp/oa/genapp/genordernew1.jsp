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
String sql = StringHelper.null2String(request.getParameter("sql"));
String requestid = StringHelper.null2String(request.getParameter("requestid"));
System.out.println(sql);
BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
List sublist = baseJdbc.executeSqlForList(sql);
       if(sublist.size()>0){
	          for(int k=0,sizek=sublist.size();k<sizek;k++){
		      Map mk = (Map)sublist.get(k);
			  String goodsno=StringHelper.null2String(mk.get("goodsno"));
			  String goodsname=StringHelper.null2String(mk.get("goodsname"));
			  String applyer=StringHelper.null2String(mk.get("applyer"));
			  String applyname=StringHelper.null2String(mk.get("applyname"));
			  String deptid=StringHelper.null2String(mk.get("deptid"));
			  String deptname=StringHelper.null2String(mk.get("deptname"));
			  String comid=StringHelper.null2String(mk.get("comid"));
			  String compname=StringHelper.null2String(mk.get("compname"));
			  String goodstyle=StringHelper.null2String(mk.get("goodstyle"));
			  String stylename=StringHelper.null2String(mk.get("stylename"));
			  String specify=StringHelper.null2String(mk.get("specify"));
			  String unit=StringHelper.null2String(mk.get("unit"));
			  String price=StringHelper.null2String(mk.get("price"));
			  String num=StringHelper.null2String(mk.get("num"));
			  String spna=StringHelper.null2String(mk.get("spna"));
			  String supplyname=StringHelper.null2String(mk.get("supplyname"));
			  String scode=StringHelper.null2String(mk.get("scode"));
			  String needdate=StringHelper.null2String(mk.get("needdate"));
			  String address=StringHelper.null2String(mk.get("address"));
			  String appnumber=StringHelper.null2String(mk.get("appnumber"));
			  String no=StringHelper.null2String(mk.get("no"));
			  String subject=StringHelper.null2String(mk.get("subject"));
			  String subjectname=StringHelper.null2String(mk.get("subjectname"));
			  String innerorder=StringHelper.null2String(mk.get("innerorder"));
			  String innerid=StringHelper.null2String(mk.get("innerid"));
			  String cate=StringHelper.null2String(mk.get("cate"));
			  String catename=StringHelper.null2String(mk.get("catename"));
			  String subcate=StringHelper.null2String(mk.get("subcate"));
			  String subcatename=StringHelper.null2String(mk.get("subcatename"));
			  String appno=StringHelper.null2String(mk.get("appno"));
			  String taxcode="";
			  String taxtype="";
			  String codename="";
			  String taxtypename="";
			  String taxrate="";
			  String currency="40285a8f490d114a014917755e486996";
			  String currencycode="RMB";
			  List sublist1 =null;
			  Map mk1=null;
			if(goodstyle.equals("40285a8f489c17ce0148a6f30a642b7d"))     
			{     
				String sqltax="select a.taxcode,(select taxcode  from uf_oa_taxcode where requestid=a.taxcode) as codename,a.taxtype,(select objname from selectitem where id=a.taxtype) as taxtypename,a.taxrate,a.currency,(select currencycode from uf_oa_currencymaintain where requestid=a.currency) as currencycode from uf_oa_pricesummary  a where  a.goodscode = '"+goodsno+"' and a.specify =  '"+specify+"'  and a.unit ='"+unit+"' and a.suppliercode='"+scode+"'  and vailideflag = '40285a8f489c17ce01489c7f3d940189' and (isvalid ='40285a8f489c17ce01489c7f3d940189' or isvalid is null)";      
				sublist1 = baseJdbc.executeSqlForList(sqltax);
				if(sublist1.size()>0)
				{
					mk1 = (Map)sublist1.get(0);
					taxcode=StringHelper.null2String(mk1.get("taxcode"));
					codename=StringHelper.null2String(mk1.get("codename"));
					taxtype=StringHelper.null2String(mk1.get("taxtype"));
					taxtypename=StringHelper.null2String(mk1.get("taxtypename"));
					taxrate=StringHelper.null2String(mk1.get("taxrate"));
					currency=StringHelper.null2String(mk1.get("currency"));
					currencycode=StringHelper.null2String(mk1.get("currencycode"));
				}

			}                  
            String insql="insert into uf_oa_genorderdetailapp  (id,requestid,no,goodstyle,company,reqdept,reqname,goodsname,sepcify,unit,price,reqnum,supplier,excptdate,reqdate,address , category,subcate,genappno,genappcolumnno,ledgersubj,inorder,supplierid,taxcode,taxstyle,taxrate,currency,ordernum,remark,goods) values ((select sys_guid() from dual),'"+requestid+"',"+(k+1)+",'"+goodstyle+"','"+comid+"','"+deptid+"','"+applyer+"','"+goodsno+"','"+specify+"','"+unit+"',"+price+","+num+",'"+spna+"' , '','"+needdate+"','"+address+"','"+cate+"','"+subcate+"','"+appno+"',"+no+",'"+subject+"','"+innerid+"','"+scode+"','"+taxcode+"', '"+taxtype+"', "+taxrate+",'"+currency+"',"+num+",'','"+goodsname+"')";
			baseJdbc.update(insql);
	}
}%>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 