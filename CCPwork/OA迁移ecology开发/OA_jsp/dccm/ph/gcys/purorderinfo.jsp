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

<%@ page import="com.sap.conn.jco.JCoTable" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.eweaver.base.util.StringHelper" %>
<%@ page import="com.eweaver.app.configsap.SapConnector" %>
<%@ page import="com.sap.conn.jco.JCoException" %>
<%@ page import="com.sap.conn.jco.JCoFunction" %>

<%@ page import="com.eweaver.app.configsap.SapSync"%>

<%@ page import="java.text.DecimalFormat;"%>

<%
System.out.println("-----------------------------");
String requestid = StringHelper.null2String(request.getParameter("requestid"));
String purchno = StringHelper.null2String(request.getParameter("purchno"));//�ɹ�������


BaseJdbcDao baseJdbc = (BaseJdbcDao) BaseContext.getBean("baseJdbcDao");
String nodeshow=StringHelper.null2String(request.getParameter("nodeshow"));//עǰޚ֣ìӾӘؖ׎c

int no=0;

String delsql = "delete  uf_dmph_acceptancedetail   where requestid='"+requestid+"'";
baseJdbc.update(delsql);

//����SAP����		
SapConnector sapConnector = new SapConnector();
String functionName = "ZOA_MM_MSEG_READ";
JCoFunction function = null;
try {
	function = SapConnector.getRfcFunction(functionName);
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
function.getImportParameterList().setValue("P_MBLNR",purchno);//�ɹ�������
System.out.println(purchno);
function.getImportParameterList().setValue("P_WERKS","7010");

try {
		function.execute(sapConnector.getDestination(sapConnector.fdPoolName));
	} catch (JCoException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//����ֵ




//ץȡ��SAP�ķ���ֵ
			JCoTable newretTable = function.getTableParameterList().getTable("Z_PO_DOWN");
			System.out.println("--����--:"+newretTable.getNumRows());
			if(newretTable.getNumRows() >0)
			{
				for(int j = 0;j<newretTable.getNumRows();j++)
				{
					if(j == 0)
					{
						newretTable.firstRow();//��ȡ���ر�������еĵ�һ��

                        String purchno1 = newretTable.getString("EBELN");//
						String EBELP = newretTable.getString("EBELP");//�������
						String TXZ01 = newretTable.getString("TXZ01");//�������ı�
						String MATNR = newretTable.getString("MATNR");//���Ϻ�

						String BELNR = newretTable.getString("BELNR");                       //bianma
						String BUZEI = newretTable.getString("BUZEI");                      //xiangci
						String GJAHR = newretTable.getString("GJAHR");                       //niandu

						String BAMNG = newretTable.getString("BAMNG");//�빺����
						String BAMEI = newretTable.getString("BAMEI");//�빺��λ
						String MENGE = newretTable.getString("MENGE");//�ɹ�����
						String MEINS = newretTable.getString("MEINS");//�ɹ���λ
						String ERFMG = newretTable.getString("ERFMG");//������������
						String TOTAL = newretTable.getString("TOTAL");//�����ܽ��
						String PAID = newretTable.getString("PAID");//�������
						//String ZNETWR = newretTable.getString("PAID");//�Ѹ����
						System.out.println(BELNR);
						System.out.println(BUZEI);
						System.out.println(GJAHR);
					
						//�������ݿ��ж�Ӧ��������Ϣ
						no++;
						String upsql = "insert into uf_dmph_acceptancedetail    (ID, REQUESTID,purchaseorder,orderitems,ordershorttest,materialnum,applicationsnum,afpq,purchasingquantity,purchaseunit,acceptancenum,thetotalamountoforder,taohbr,amountpaid,mdnum,mdyear,mdline  )  values ((select sys_guid() from dual), '"+requestid+"','"+purchno1+"','"+EBELP+"','"+TXZ01+"','"+MATNR+"','"+BAMNG+"','"+BAMEI+"','"+MENGE+"','"+MEINS+"','"+ERFMG+"','"+TOTAL+"','"+PAID+"','"+PAID+"','"+BELNR+"','"+BUZEI+"','"+GJAHR+"')";   
						baseJdbc.update(upsql);
						System.out.println(upsql);
						}
					else
					{
						newretTable.nextRow();//��ȡ��һ������
						String purchno1 = newretTable.getString("EBELN");
						String EBELP = newretTable.getString("EBELP");//�������
						String TXZ01 = newretTable.getString("TXZ01");//�������ı�
						String MATNR = newretTable.getString("MATNR");//���Ϻ�
						String BAMNG = newretTable.getString("BAMNG");//�빺����
						String BAMEI = newretTable.getString("BAMEI");//�빺��λ
						String MENGE = newretTable.getString("MENGE");//�ɹ�����
						String MEINS = newretTable.getString("MEINS");//�ɹ���λ
						String ERFMG = newretTable.getString("ERFMG");//������������
						String TOTAL = newretTable.getString("TOTAL");//�����ܽ��
						String PAID = newretTable.getString("PAID");//�������
						//String ZNETWR = newretTable.getString("PAID");//�Ѹ����
						String BELNR = newretTable.getString("BELNR");                       //bianma
						String BUZEI = newretTable.getString("BUZEI");                      //xiangci
						String GJAHR = newretTable.getString("GJAHR");                       //niandu

				
						no++;
						String upsql = "insert into uf_dmph_acceptancedetail    (ID, REQUESTID,purchaseorder,orderitems,ordershorttest,materialnum,applicationsnum,afpq,purchasingquantity,purchaseunit,acceptancenum,thetotalamountoforder,taohbr,amountpaid,mdnum,mdyear,mdline  )  values ((select sys_guid() from dual), '"+requestid+"','"+purchno1+"','"+EBELP+"','"+TXZ01+"','"+MATNR+"','"+BAMNG+"','"+BAMEI+"','"+MENGE+"','"+MEINS+"','"+ERFMG+"','"+TOTAL+"','"+PAID+"','"+PAID+"','"+BELNR+"','"+BUZEI+"','"+GJAHR+"')"; 
						baseJdbc.update(upsql);
						System.out.println(upsql);
					}
					
				}
			}



		/*	do{
				newretTable.nextRow();//��ȡ��һ������
			    String BSART = newretTable.getString("BSART");//�ɹ�ƾ֤����
			    String TXZ01 = newretTable.getString("TXZ01");//���ı�
			    String MEINS = newretTable.getString("MEINS");//������λ
			    String MENGE = newretTable.getString("MENGE");//�ɹ�����
			    String NETWR = newretTable.getString("NETWR");//������
				String EBELP = newretTable.getString("EBELP");//���
				String ZWERT1 = newretTable.getString("ZWERT1");//��˰���
		
				no++;
				String upsql= "insert into uf_fnwkpurchinfo   (ID, REQUESTID,  no,purchorder,orderrow,text,unit,pcount,mon,cur,paycent,paymon)  values ((select sys_guid() from dual), '"+requestid+"','"+no+"','"+purchno+"','"+EBELP+"','"+TXZ01+"','"+MEINS+"','"+MENGE+"','"+ZWERT1+"','"+WAERS+"','','"+NETWR+"')";  
				baseJdbc.update(upsql);
				System.out.println(upsql);
			}while(!newretTable.isLastRow());//����������һ��*/



	JSONObject jo = new JSONObject();	
	/*jo.put("LIFNR", LIFNR);
	jo.put("NAME1", NAME1);
	jo.put("BSART", BSART);
	//jo.put("EBELN", EBELN);
	jo.put("EBELP", EBELP);
	jo.put("TXZ01", TXZ01);
	jo.put("MEINS", MEINS);
	jo.put("MENGE", MENGE);
	jo.put("WAERS", WAERS);
	jo.put("NETWR", NETWR);

*/
	response.setContentType("application/json; charset=utf-8");
	response.getWriter().write(jo.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>


