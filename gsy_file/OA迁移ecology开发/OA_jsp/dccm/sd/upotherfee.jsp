<%@ page language="java" contentType="application/json" pageEncoding="UTF-8"%>
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
<%@ page import="com.sap.conn.jco.JCoTable" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.dccm.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>
<%@ page import="com.eweaver.app.configsap.SapSync"%>
<%@ page import="java.util.List" %>
<%@ page import="com.eweaver.base.*" %>
<%@ page import="java.util.Map" %>

<%@ page import="com.eweaver.workflow.form.model.FormBase"%>
<%@ page import="com.eweaver.workflow.form.service.FormBaseService"%>
<%@ page import="com.eweaver.base.security.util.PermissionTool"%>
<%@ page import="com.eweaver.base.util.NumberHelper"%>
<%@ page import="com.eweaver.interfaces.form.Formdata"%>
<%@ page import="com.eweaver.interfaces.form.FormdataServiceImpl"%>


<%
 	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	//����ǰ�����
	String delsql="delete from uf_dmsd_otherfeelist";
	baseJdbc.update(delsql);


    //����SAP����	
	SapConnector sapConnector = new SapConnector();
	String functionName = "ZOA_SD_OTHERFEE";
	JCoFunction function = null;
	try {
		function = SapConnector.getRfcFunction(functionName);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}


	

	try 
	{
		function.execute(sapConnector.getDestination(sapConnector.fdPoolName));
	} 
	catch (JCoException e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
	} 
	catch (Exception e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	

	
	

	//��ȡSAP�ӱ���ֵ
	JCoTable newretTable = function.getTableParameterList().getTable("ZSD_OTHERFEE");
	//System.out.println("lenxxx:"+newretTable.getNumRows());
	if(newretTable.getNumRows() >0)
	{
		//System.out.println("len:"+newretTable.getNumRows());
		for(int i= 0;i<newretTable.getNumRows();i++)
		{
			if(i == 0)
			{
				newretTable.firstRow();//��ȡ���ر�������еĵ�һ��
			}
			else
			{
				newretTable.nextRow();//��ȡ��һ������
			}

			String feetxt = newretTable.getString("FEENAME");//��������
			String feeid = "";
			String sql1 = "select requestid from uf_dmdb_feename where feename='"+feetxt+"' and imextype='40285a8d56d542730156e95e821c3061'";
			List list1 = baseJdbc.executeSqlForList(sql1);
			if(list1.size()>0)
			{
				Map map1 = (Map)list1.get(0);
				feeid = StringHelper.null2String(map1.get("requestid"));//��������id
			}
			String price = newretTable.getString("PRICE");//����
			String linertxt = newretTable.getString("LINER");//����˾����
			String sdate = newretTable.getString("ZSTARTDATE");//��ʼ����
			String curr = newretTable.getString("CURRENCY");//�ұ�
			String gx = newretTable.getString("CABINT");//����
			String gxid = "";
			String sql2 = "select requestid from uf_dmdb_cabtype where cabtype='"+gx+"'";
			List list2 = baseJdbc.executeSqlForList(sql2);
			if(list2.size()>0)
			{
				Map map2 = (Map)list2.get(0);
				gxid = StringHelper.null2String(map2.get("requestid"));//����id
			}
			String taxcode = newretTable.getString("TAX");//˰��
			String taxcodeid = "";
			String taxrate = "";
			String taxtype = "";
			String sql5 = "select requestid,rate,taxtype from uf_dmsd_taxwh where tax='"+taxcode+"'";
			List list5 = baseJdbc.executeSqlForList(sql5);
			if(list5.size()>0)
			{
				Map map5 = (Map)list5.get(0);
				taxcodeid = StringHelper.null2String(map5.get("requestid"));//˰��id
				taxrate = StringHelper.null2String(map5.get("rate"));//˰��
				taxtype = StringHelper.null2String(map5.get("taxtype"));//˰��
			}
			String remark = newretTable.getString("REMARK");//��ע
			String xdate = newretTable.getString("ZDATE");//����������
			String utime = newretTable.getString("TIME");//������ʱ��
			String imtime = xdate+" "+utime;
			
			
			
			StringBuffer buffer = new StringBuffer(512);
			buffer.append("insert into uf_dmsd_otherfeelist")
			.append("(id,requestid,feename,price,linertxt,sdate,curr,gx,taxcode,taxtype,taxrate,remark,imtime) values").append("('").append(IDGernerator.getUnquieID()).
			append("',").append("'").append("$ewrequestid$").append("',");
			buffer.append("'").append(feeid).append("',");
			buffer.append("'").append(price).append("',");
			buffer.append("'").append(linertxt).append("',");
			buffer.append("'").append(sdate).append("',");
			buffer.append("'").append(curr).append("',");
			buffer.append("'").append(gxid).append("',");
			buffer.append("'").append(taxcodeid).append("',");
			buffer.append("'").append(taxtype).append("',");
			buffer.append("'").append(taxrate).append("',");
			buffer.append("'").append(remark).append("',");
			buffer.append("'").append(imtime).append("')");
			FormBase formBase = new FormBase();
			String categoryid = "40285a8d5cf7b570015d0b99369426d5";
			//����formbase
			formBase.setCreatedate(DateHelper.getCurrentDate());
			formBase.setCreatetime(DateHelper.getCurrentTime());
			formBase.setCreator(StringHelper.null2String("40285a905b9a1d97015b9e3ed3837a00"));
			formBase.setCategoryid(categoryid);
			formBase.setIsdelete(0);
			FormBaseService formBaseService = (FormBaseService)BaseContext.getBean("formbaseService");
			formBaseService.createFormBase(formBase);
			String insertSql = buffer.toString();
			insertSql = insertSql.replace("$ewrequestid$",formBase.getId());
			baseJdbc.update(insertSql);
			PermissionTool permissionTool = new PermissionTool();
			permissionTool.addPermission(categoryid,formBase.getId(), "uf_dmsd_otherfeelist");
			
			
			//����SAP��ȡ�������ݲ���OA
			//String insql="insert into uf_dmsd_otherfeelist(id,requestid,feename,price,linertxt,sdate,curr,gx,taxcode,taxtype,taxrate,remark,imtime)values((select sys_guid() from dual),'"+IDGernerator.getUnquieID()+"','"+feeid+"','"+price+"','"+linertxt+"','"+sdate+"','"+curr+"','"+gxid+"','"+taxcodeid+"','"+taxtype+"','"+taxrate+"','"+remark+"','"+imtime+"')";
			//baseJdbc.update(insql);
		}
	}





	//System.out.println("---------------2");
	JSONObject jo = new JSONObject();		
	jo.put("res", "true");
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
