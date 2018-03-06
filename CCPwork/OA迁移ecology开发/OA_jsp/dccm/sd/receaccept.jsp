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
	String requestid = StringHelper.null2String(request.getParameter("requestid"));//requestid
	//����ջ�������ϸ
	String delsql = "delete from uf_dmph_acceptdet where requestid='"+requestid+"'";
	baseJdbc.update(delsql);
	String comcode = StringHelper.null2String(request.getParameter("comcode"));//��˾����
	String wlproof = StringHelper.null2String(request.getParameter("wlproof"));//����ƾ֤��

	//System.out.println("comcode:"+comcode);
	//System.out.println("wlproof:"+wlproof);
    //����SAP����	
	SapConnector sapConnector = new SapConnector();
	String functionName = "ZOA_MM_MSEG_READ_MY";
	JCoFunction function = null;
	try {
		function = SapConnector.getRfcFunction(functionName);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	//�����ֶ���SAP(��Ϊ��ѯ����)
	function.getImportParameterList().setValue("P_WERKS",comcode);//��˾����
	function.getImportParameterList().setValue("P_MBLNR",wlproof);//����ƾ֤��

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
	JCoTable newretTable = function.getTableParameterList().getTable("Z_PO_DOWN");
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

					String ordtype = newretTable.getString("BSART_PO");//��������
					String suppcode = newretTable.getString("LIFNR");//��Ӧ�̼���
					String suppname = newretTable.getString("NAME1") + newretTable.getString("NAME2");//��Ӧ������
					String orderno = newretTable.getString("EBELN");//�ɹ�����
					String item = newretTable.getString("EBELP");//�������
					String shorttxt = newretTable.getString("TXZ01");//�������ı�
					String wlno = newretTable.getString("MATNR");//���Ϻ�
					String qgnum = newretTable.getString("BAMNG");//�빺����
					String qgunit = newretTable.getString("BAMEI");//�빺��λ
					String cgnum = newretTable.getString("MENGE");//�ɹ�����
					String cgunit = newretTable.getString("MEINS");//�ɹ���λ
					String bcysnum = newretTable.getString("ERFMG");//������������
					String bcysunit = newretTable.getString("ERFME");//��������������λ
					String bflag = newretTable.getString("BFLAG");//�����Ƿ����
					String xncs = newretTable.getString("FLAG");//���ܲ�������
					String isxncs = "";
					if(xncs.equals("Y"))
					{
						isxncs = "YES";
					}
					else
					{
						isxncs = "NO";
					}

					String upsql = "update uf_dmph_receaccept set ordtype='"+ordtype+"',suppcode='"+suppcode+"',suppname='"+suppname+"' where requestid='"+requestid+"'";
					baseJdbc.update(upsql);

					String insql = "insert into uf_dmph_acceptdet(id,requestid,ordno,orditem,shorttxt,wlno,qgnum,qgunit,cgnum,cgunit,bcysnum,bcysunit,perfortest,ispc)values((select sys_guid() from dual),'"+requestid+"','"+orderno+"','"+item+"','"+shorttxt+"','"+wlno+"','"+qgnum+"','"+qgunit+"','"+cgnum+"','"+cgunit+"','"+bcysnum+"','"+bcysunit+"','"+isxncs+"','"+bflag+"')";
					baseJdbc.update(insql);
			}
	}


	JSONObject jo = new JSONObject();		
	jo.put("res", "true");
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
