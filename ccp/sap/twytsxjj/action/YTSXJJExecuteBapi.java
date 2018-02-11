package weaver.interfaces.tw.xiyf.sap.twytsxjj.action;
 

import java.util.ArrayList;
import java.util.List;
 
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util; 
import weaver.interfaces.tw.xiyf.sap.SAPConn;  
 

import com.sap.conn.jco.JCoDestination; 
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoField;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoRecordFieldIterator; 
import com.sap.conn.jco.JCoTable;
/**
 * 
 * @ClassName: YTFKExecuteBapi 
 * @Description: ӯͨ���ñ�������sap��
 * @author xiyufei
 * @date 2014-6-18 ����11:23:51 
 *
 */
public class YTSXJJExecuteBapi {

	
	private JCoRecordFieldIterator JCoRecordFieldIterator = null;
	private JCoField JCoField = null;
	private static JCoDestination destination = SAPConn.getJCoDestination();


/**
 * 
 * @Title: YtsxjjReturnSap 
 * @Description: ���ԼӼ�
 * @param @param list
 * @param @param creator
 * @param @param status
 * @param @return    �趨�ļ� 
 * @return String    �������� 
 * @throws
 */
	public static String YtsxjjReturnSap(List list,String creator,String status){
		BaseBean bb = new BaseBean();
		String result = "";
		try {
			JCoFunction function = destination.getRepository().getFunction("ZYW_CREATE_PRICE_FOR_VA00");
 
			
				//if(SAPConstant.S_STATU_L.equals(status)){//statusΪLʱ���غ�ͬ��Ϣ
					JCoTable  JCoTable  = null;
//					RecordSet rs = new RecordSet();
//					rs.execute("select tablename from workflow_base a,workflow_bill b where a.formid=b.id and a.id="+workflowId);
//					rs.next();
//					String maintable = Util.null2String(rs.getString("tablename"));
//					rs.execute("select a.* from "+ maintable+" a,workflow_requestbase b where a.requestid=b.requestid and b.workflowid="+workflowId+" and a.requestid="+requestId+"");
//					rs.next(); 
	
					function.getImportParameterList().setValue("S_FLAG","E");
					function.getImportParameterList().setValue("S_UNAME",creator);
					JCoTable  = function.getTableParameterList().getTable("T_ZSVA00");
					for (int i = 0; i < list.size(); i++) {
						SXJJBean SXJJBean = (SXJJBean) list.get(i);
						JCoTable.appendRow();
						JCoTable.setRow(i);     
						JCoTable.setValue("VKORG",  Util.null2String(SXJJBean.getVKORG()));
						JCoTable.setValue("MATNR",  Util.null2String(SXJJBean.getMATNR()));
						JCoTable.setValue("VARCOND",  Util.null2String(SXJJBean.getVARCOND()));
						JCoTable.setValue("KBETR",  Util.null2String(SXJJBean.getKBETR()));
						JCoTable.setValue("KONWA",  Util.null2String(SXJJBean.getKONWA()));
						JCoTable.setValue("KPEIN",  Util.null2String(SXJJBean.getKPEIN()));
						JCoTable.setValue("KMEIN",  Util.null2String(SXJJBean.getKMEIN()));
						JCoTable.setValue("DATAB",  Util.null2String(SXJJBean.getDATAB()));
						JCoTable.setValue("DATBI",  Util.null2String(SXJJBean.getDATBI()));
//						JCoTable.setValue("S_FLAG","E");
//						JCoTable.setValue("S_UNAME",creator);
						
						bb.writeLog("�û���:"+creator); 
						bb.writeLog("������֯:"+Util.null2String(SXJJBean.getVKORG())); 
						bb.writeLog("���Ϻ�:"+Util.null2String(SXJJBean.getMATNR())); 
						bb.writeLog("��ʽ����:"+Util.null2String(SXJJBean.getVARCOND())); 
						bb.writeLog("�۸�:"+Util.null2String(SXJJBean.getKBETR())); 
						bb.writeLog("���ʵ�λ:"+Util.null2String(SXJJBean.getKONWA())); 
						bb.writeLog("�������۵�λ:"+Util.null2String(SXJJBean.getKPEIN())); 
						bb.writeLog("������λ:"+Util.null2String(SXJJBean.getKMEIN())); 
						bb.writeLog("��ʼ��Ч����:"+Util.null2String(SXJJBean.getDATAB())); 
						bb.writeLog("��Ч��������:"+Util.null2String(SXJJBean.getDATBI())); 
					}
					
					function.execute(destination);
					result =  function.getExportParameterList().getValue("S_RETURN").toString(); 
					System.out.println("result="+result);
		} catch (JCoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // ZRFC_GET_CUSTDATA
		return result;
		
	}

	 

	public static void main(String[] a) {
		try{
			List  List = new ArrayList(); 
			YTSXJJExecuteBapi.YtsxjjReturnSap(List, "","");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
