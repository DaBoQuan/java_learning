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


<%
 	BaseJdbcDao baseJdbc=(BaseJdbcDao)BaseContext.getBean("baseJdbcDao");
	System.out.println("----------------1");
	String delsql="delete from uf_dmdb_port";
	baseJdbc.update(delsql);

    //����SAP����
	SapConnector sapConnector = new SapConnector();
	String functionName = "ZOA_SD_PORT_MY";//�����ۿ�
	JCoFunction function = null;
	try {
		function = SapConnector.getRfcFunction(functionName);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	//�����ֶ���SAP(��Ϊ��ѯ����)
	function.getImportParameterList().setValue("LAND1","");//���Ҵ���

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
	JCoTable newretTable = function.getTableParameterList().getTable("ZOA_PORT");
	//System.out.println("lenxxx:"+newretTable.getNumRows());
	if(newretTable.getNumRows() >0)
	{
			System.out.println("len:"+newretTable.getNumRows());
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
					String regexp = "\'";
					String port = newretTable.getString("INCO2");//�ۿ�
					port = port.replaceAll(regexp, "");
					String gjcode = newretTable.getString("LAND1");//���Ҵ���
					 
					String gjname = newretTable.getString("NAME1");//��������
					 
					//System.out.println("�滻��" + gjname);


					//����SAP��ȡ�������ݲ���OA
					String insql="insert into uf_dmdb_port (id,requestid,port,councode,counname)values((select sys_guid() from dual),'"+IDGernerator.getUnquieID()+"','"+port+"','"+gjcode+"','"+gjname+"')";
					baseJdbc.update(insql);

			}
	}

	System.out.println("---------------2");
	JSONObject jo = new JSONObject();		
	jo.put("res", "true");
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
