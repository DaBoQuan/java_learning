package weaver.interfaces.tw.xiyf.sap.twytcc.action;
 

import java.util.ArrayList;
import java.util.List;
 
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
 * @ClassName: YTCLFBXExecuteBapi 
 * @Description: ӯͨ��·�ѱ�������sap��
 * @author xiyufei
 * @date 2014-6-18 ����11:23:51 
 *
 */
public class YTCLFBXExecuteBapi {

	
	private JCoRecordFieldIterator JCoRecordFieldIterator = null;
	private JCoField JCoField = null;
	private static JCoDestination destination = SAPConn.getJCoDestination();

/**
 * 
 * @Title: YtfkReturnSap 
 * @Description:  ӯͨ����(fk) ����sap
 * @param @param workflowId
 * @param @param requestId
 * @param @param status
 * @param @return    �趨�ļ� 
 * @return String    �������� 
 * @throws
 */
	public static String YtclfReturnSap(List list,String status){
		BaseBean bb = new BaseBean();
		String result = "";
		try {
			JCoFunction function = destination.getRepository().getFunction("ZFI_OA2SAP_BXD_YT");
 
			
				//if(SAPConstant.S_STATU_L.equals(status)){//statusΪLʱ���غ�ͬ��Ϣ
					JCoTable  JCoTable  = null;
//					RecordSet rs = new RecordSet();
//					rs.execute("select tablename from workflow_base a,workflow_bill b where a.formid=b.id and a.id="+workflowId);
//					rs.next();
//					String maintable = Util.null2String(rs.getString("tablename"));
//					rs.execute("select a.* from "+ maintable+" a,workflow_requestbase b where a.requestid=b.requestid and b.workflowid="+workflowId+" and a.requestid="+requestId+"");
//					rs.next();IT_OA_BXD  ZSOA_EXP_TRANSFER
	
					JCoTable  = function.getTableParameterList().getTable("IT_OA_BXD");
					for (int i = 0; i < list.size(); i++) {
						CLFBean CLFBean = (CLFBean) list.get(i);
						JCoTable.appendRow();
						JCoTable.setRow(i);     
						JCoTable.setValue("BUKRS",  Util.null2String(CLFBean.getGsdm()));
						JCoTable.setValue("GJAHR",  Util.null2String(CLFBean.getNf()));
						JCoTable.setValue("ERDAT",  Util.null2String(CLFBean.getZdrq()));
						JCoTable.setValue("ZOABXD",  Util.null2String(CLFBean.getBxdh()));  
						JCoTable.setValue("ZJHLX",  Util.null2String(CLFBean.getJhlx()));  
						JCoTable.setValue("ZFJZS",  Util.null2String(CLFBean.getFjzs()));
						JCoTable.setValue("ZUSR_CREATE",Util.null2String(CLFBean.getFycsr()));
						JCoTable.setValue("WAERS",  Util.null2String(CLFBean.getBzdm()));
						JCoTable.setValue("ZCHKSTAT",  Util.null2String(CLFBean.getShhzt())); 
						JCoTable.setValue("ZUSR_LINKUAN",  Util.null2String(CLFBean.getLkr())); 
						JCoTable.setValue("ZEXPCLAIM",  Util.null2String(CLFBean.getJehj()));  
						JCoTable.setValue("ZDJLX",  Util.null2String(CLFBean.getDjlx())); 
						JCoTable.setValue("ZYSBM", Util.null2String(CLFBean.getBmdm()));
						JCoTable.setValue("ZFYYSXM",  Util.null2String(CLFBean.getXmdm()));
						JCoTable.setValue("SGTXT1",  Util.null2String(CLFBean.getXm()));
						JCoTable.setValue("ZWRBTR",  Util.null2String(CLFBean.getJe()));
						JCoTable.setValue("BKTXT",  Util.null2String(CLFBean.getCcsy()));

						JCoTable.setValue("ZUSR_CREATE_ITEM",  Util.null2String(CLFBean.getBxr()));
						//
						bb.writeLog("������˾����:"+Util.null2String(CLFBean.getGsdm()));
						bb.writeLog("���:"+Util.null2String(CLFBean.getNf()));
						bb.writeLog("��������:"+Util.null2String(CLFBean.getZdrq()));
						bb.writeLog("OA��������:"+Util.null2String(CLFBean.getBxdh()));  
						bb.writeLog("�ƻ�����:"+Util.null2String(CLFBean.getJhlx()));  
						bb.writeLog("��������:"+Util.null2String(CLFBean.getFjzs()));  
						bb.writeLog("���ò����ˣ�����ˣ�:"+Util.null2String(CLFBean.getFycsr()));
						bb.writeLog("���ִ���:"+Util.null2String(CLFBean.getBzdm()));
						bb.writeLog("���״̬:"+Util.null2String(CLFBean.getShhzt())); 
						bb.writeLog("�����:"+Util.null2String(CLFBean.getLkr()));
						bb.writeLog("���ϼ�:"+Util.null2String(CLFBean.getJehj()));
						bb.writeLog("��������:"+Util.null2String(CLFBean.getDjlx()));
						bb.writeLog("�������Ŵ���:"+Util.null2String(CLFBean.getBmdm()));
						bb.writeLog("���ñ���������:"+Util.null2String(CLFBean.getXmdm()));
						bb.writeLog("�ش���������:"+Util.null2String(CLFBean.getDjlx()));
						bb.writeLog("��Ŀ:"+Util.null2String(CLFBean.getXm()));
						bb.writeLog("���:"+Util.null2String(CLFBean.getJe()));
						bb.writeLog("������:"+Util.null2String(CLFBean.getBxr()));
						bb.writeLog("̧ͷ:"+Util.null2String(CLFBean.getCcsy()));
					}
				 
					function.execute(destination);
					result =  function.getExportParameterList().getValue("EV_STATUS").toString(); 
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
			List.add(new CLFBean());
			YtclfReturnSap(List, "");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
