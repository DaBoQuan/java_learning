package weaver.interfaces.tw.xiyf.sap.twytjk.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
 
import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.hrm.resource.ResourceComInfo;
import weaver.interfaces.tjwc.vyf.log.action.WriteLog;
import weaver.interfaces.tjwc.vyf.log.bean.ActionLog; 
import weaver.interfaces.workflow.action.Action;  
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo; 

/**
 * 
 * @ClassName:���action�ӿ� �����sap 
 * @Description: TODO
 * @author xiyufei
 * @date 2014-12-1 ����4:55:53 
 *
 */
public class JKAction implements Action{
	private Log log = LogFactory.getLog(JKAction.class.getName());

	public Log getLog() {
		return this.log;
	}

	public void setLog(Log log) {
		this.log = log;
	}
	
	
	public String execute(RequestInfo request) {
		String requestId = request.getRequestid();
		String workflowId = request.getWorkflowid();
		RecordSet rs = new RecordSet();
		List list = new ArrayList();
		YTJKExecuteBapi ytjkExecuteBapi = new YTJKExecuteBapi();
		rs.execute("select currentnodeid from workflow_requestbase where requestid='"+requestId+"'");
		rs.next();
		String nodeid = Util.null2o(rs.getString("currentnodeid"));
		String executor = request.getLastoperator();
		String dscription = request.getDescription();
		Property[] properties = request.getMainTableInfo().getProperty();// ��ȡ�����ֶ���Ϣ
		// �����ֶ�
		Map mainTableDataMap = new HashMap();
		Property[] props = request.getMainTableInfo().getProperty();
		for (int i = 0; i < props.length; i++) {
			String fieldname = props[i].getName().toLowerCase();
			String fieldval = Util.null2String(props[i].getValue());
			mainTableDataMap.put(fieldname, fieldval);
		}
		String  jkrgsdm = Util.null2String((String) mainTableDataMap.get("jkrgsdm"));//���ڹ�˾����
		String nf = Util.null2String((String) mainTableDataMap.get("zdrq")).substring(0,4);//���
		String zdrq = Util.null2String((String) mainTableDataMap.get("zdrq"));//�Ƶ�����
		String jkdh = Util.null2String((String) mainTableDataMap.get("jkdh"));//����  
		String jksy =  Util.null2String((String) mainTableDataMap.get("jksy"));//�������
		String jkr = "";
		try {
			ResourceComInfo resourceComInfo = new ResourceComInfo();
			 jkr =resourceComInfo.getLoginID(Util.null2String((String) mainTableDataMap.get("jkr")));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String bzdm = Util.null2String((String) mainTableDataMap.get("jkbzdm"));//���ִ���
		String shhzt = "L"; 
		

		
		String jkje = Util.null2String((String) mainTableDataMap.get("jkje")).replace(",", "");  //�����
		
		String jkbmdm = Util.null2String((String) mainTableDataMap.get("jkbmdm"));  //���ò���
		String  fkfsdm  = Util.null2String((String) mainTableDataMap.get("fkfsdm")); //���ʽ
		
		String djlx_sap="";
		djlx_sap="0";
		
		String result = "";  
			JKBean JKBean = new JKBean();
			JKBean.setJkrgsdm(jkrgsdm);
			JKBean.setNf(nf);
			JKBean.setZdrq(zdrq);
			JKBean.setJkdh(jkdh);
			JKBean.setJkr(jkr);
			JKBean.setBzdm(bzdm);
			JKBean.setShhzt(shhzt); 
			JKBean.setJkje(jkje);
			JKBean.setDjlx(djlx_sap); 
			JKBean.setBxrbm(jkbmdm);
			JKBean.setFkfsdm(fkfsdm);
			JKBean.setBz(""); 
			JKBean.setJksy(jksy);
		list.add(JKBean);
		result = ytjkExecuteBapi.YtjkReturnSap(list, "");
		String act_rtn = "1";
		if("F".equals(result)){
			act_rtn="0";
			request.getRequestManager().setMessage("111121");
			request.getRequestManager().setMessagecontent("����SAPʧ��");
		}
		//action ������־
		ActionLog actionLog = new ActionLog();
		actionLog.setWorkflowid(workflowId);
		actionLog.setRequestid(requestId);
		actionLog.setNodeid(nodeid);
		actionLog.setExecutor(executor);
		actionLog.setDescription(dscription);
		actionLog.setResult(result);
		WriteLog WriteLog = new WriteLog();
		WriteLog.writeActionLog(actionLog);
		return act_rtn;
	}
}
