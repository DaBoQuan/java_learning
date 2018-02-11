package weaver.interfaces.tw.xiyf.sap.twytzch.action;

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
import weaver.interfaces.tw.xiyf.sap.SAPConstant; 
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Row;

public class ZCHAction implements Action{
	private Log log = LogFactory.getLog(ZCHAction.class.getName());

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
		YTZCHExecuteBapi ytfybxExecuteBapi = new YTZCHExecuteBapi();
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
		String ssgsmc  = Util.null2String((String) mainTableDataMap.get("ssgsmc"));//�ʲ�������˾����
		String ssgsdm = Util.null2String((String) mainTableDataMap.get("ssgsdm"));//��˾����
		String ssbmdm = Util.null2String((String) mainTableDataMap.get("ssbmdm"));//���벿�Ŵ���
		String jbr = Util.null2String((String) mainTableDataMap.get("jbr"));//������
		String zdrq = Util.null2String((String) mainTableDataMap.get("zdrq"));//�Ƶ�����
		String djbh = Util.null2String((String) mainTableDataMap.get("djbh"));//���ݱ�� 
		String zclbdm = Util.null2String((String) mainTableDataMap.get("zclbdm"));//�ʲ�������
		//zclbdm = "A5000";

		
		String result = "";
 
		DetailTable dtltable =  request.getDetailTableInfo().getDetailTable(0);// ��ȡ����ϸ�ֶ���Ϣ
		Row[] rows = dtltable.getRow();
		List sublist = new ArrayList();
		for(int i = 0; i<rows.length; i++){
			Row row = rows[i];
			Map onerow = new HashMap();
			sublist.add(onerow);
			Cell[] cells = row.getCell();
			for(int j=0; j<cells.length; j++){
				Cell cell = cells[j];
				onerow.put(cell.getName().toLowerCase(), Util.null2String(cell.getValue()));
			}
			
			String sblx = Util.null2String((String) onerow.get("sblx"));//�豸����
			String sbmcjxh = Util.null2String((String) onerow.get("sbmcjxh"));//�豸���Ƽ��ͺ�
			String pzyt = Util.null2String((String) onerow.get("pzyt"));//���ü���;����
			String dj = Util.null2String((String) onerow.get("dj")).replace(",", "");//����
			String ysfy = Util.null2String((String) onerow.get("ysfy")).replace(",", "");//Ԥ�����  
			
			 
			ZCHBean ZCHBean = new ZCHBean();
			ZCHBean.setZclbdm(zclbdm);
			ZCHBean.setSsgsdm(ssgsdm);
			ZCHBean.setSsbmdm(ssbmdm); 
			ZCHBean.setDjbh(djbh);
			
			ZCHBean.setSblx(sblx);
			ZCHBean.setSbmcjxh(sbmcjxh);
			ZCHBean.setPzyt(pzyt);
			list.add(ZCHBean); 
		} 
		
		 
		result  = ytfybxExecuteBapi.YtzchReturnSap(list, "");
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
