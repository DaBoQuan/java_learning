package weaver.interfaces.tw.xiyf.sap.twytcc.action;

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
import weaver.interfaces.tw.xiyf.sap.twytfybx.action.FYBXBean;
import weaver.interfaces.workflow.action.Action;  
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo; 
import weaver.soa.workflow.request.Row;
/**
 * ���÷�action �����sap
 * @ClassName: CLFBXAction 
 * @Description: TODO
 * @author xiyufei
 * @date 2014-12-1 ����4:57:04 
 *
 */
public class CLFBXAction implements Action{
	private Log log = LogFactory.getLog(CLFBXAction.class.getName());

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
		YTCLFBXExecuteBapi ytjkExecuteBapi = new YTCLFBXExecuteBapi();
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
		String  gsdm = Util.null2String((String) mainTableDataMap.get("gsdm"));//���ڹ�˾����
		String nf = Util.null2String((String) mainTableDataMap.get("zdrq")).substring(0,4);//���
		String zdrq = Util.null2String((String) mainTableDataMap.get("zdrq"));//�Ƶ�����
		String bxdh = Util.null2String((String) mainTableDataMap.get("bxdh"));//��������  
		String jhlx = Util.null2String((String) mainTableDataMap.get("jhlx"));//�ƻ�����  
		String fjzs = Util.null2String((String) mainTableDataMap.get("fjzs"));
		String ccsy = Util.null2String((String) mainTableDataMap.get("ccsy"));//��������
		String fycsr = "";
		String lkr = "";
		try {
			ResourceComInfo resourceComInfo = new ResourceComInfo();
			fycsr =resourceComInfo.getLoginID(Util.null2String((String) mainTableDataMap.get("fycsr")));
			lkr = resourceComInfo.getLoginID(Util.null2String((String) mainTableDataMap.get("lkr")));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String bzdm = Util.null2String((String) mainTableDataMap.get("bzdm"));//���ִ���
		String shhzt = "L"; 
		

		
		String jehj = Util.null2String((String) mainTableDataMap.get("jehj")).replace(",", "");  //�����ϼ�
		
		String bmdm = Util.null2String((String) mainTableDataMap.get("bmdm"));  //�������Ŵ���
		
		String tzzsfzb  = Util.null2String((String) mainTableDataMap.get("tzzsfzb")).replace(",", "");  //;�г�����
		String sncfzb  = Util.null2String((String) mainTableDataMap.get("sncfzb")).replace(",", "");  //���ڳ���
		String zsfzb  = Util.null2String((String) mainTableDataMap.get("zsfzb")).replace(",", "");  //ס�޷�
		String bgfzb  = Util.null2String((String) mainTableDataMap.get("bgfzb")).replace(",", "");  //�칫��
		String qtzb  = Util.null2String((String) mainTableDataMap.get("qtzb")).replace(",", "");  //����
		String wwpbzhj  = Util.null2String((String) mainTableDataMap.get("wwpbzhj")).replace(",", "");  //�����̲����ϼ�
		String hsbzhj  = Util.null2String((String) mainTableDataMap.get("hsbzhj")).replace(",", "");  //��ʳ�����ϼ�
		String clfhj  = Util.null2String((String) mainTableDataMap.get("clfhj")).replace(",", "");  //���÷Ѻϼ�
		String clbuzhj  = Util.null2String((String) mainTableDataMap.get("clfhj")).replace(",", "");  //���÷Ѻϼ�
		
		String djlx_sap="";
		djlx_sap="2";
		//���÷�
		if(!"".equals(sncfzb)){
			CLFBean CLFBean = new CLFBean();
			CLFBean.setGsdm(gsdm);
			CLFBean.setNf(nf);
			CLFBean.setZdrq(zdrq);
			CLFBean.setBxdh(bxdh);
			CLFBean.setFjzs(fjzs);
			CLFBean.setJhlx(jhlx);
			CLFBean.setFycsr(fycsr);
			CLFBean.setBzdm(bzdm);
			CLFBean.setShhzt(shhzt);
			CLFBean.setLkr(lkr);
			CLFBean.setJehj(jehj);
			CLFBean.setDjlx(djlx_sap);
		
			CLFBean.setBmdm(bmdm); 
			CLFBean.setXmdm("20000401");
			CLFBean.setXm("���ڳ���");
			CLFBean.setJe(clfhj);
			CLFBean.setBxr(fycsr);
			CLFBean.setCcsy(ccsy);
			list.add(CLFBean);
		}
		
		//���ò���
		if(!"".equals(sncfzb)){
			CLFBean CLFBean = new CLFBean();
			CLFBean.setGsdm(gsdm);
			CLFBean.setNf(nf);
			CLFBean.setZdrq(zdrq);
			CLFBean.setBxdh(bxdh);
			CLFBean.setFjzs(fjzs);
			CLFBean.setJhlx(jhlx);
			CLFBean.setFycsr(fycsr);
			CLFBean.setBzdm(bzdm);
			CLFBean.setShhzt(shhzt);
			CLFBean.setLkr(lkr);
			CLFBean.setJehj(jehj);
			CLFBean.setDjlx(djlx_sap);
		
			CLFBean.setBmdm(bmdm); 
			CLFBean.setXmdm("20000401");
			CLFBean.setXm("���ڳ���");
			CLFBean.setJe(clbuzhj);
			CLFBean.setBxr(fycsr);
			CLFBean.setCcsy(ccsy);
			list.add(CLFBean);
		}
		
		//;�г�����
//		if(!"".equals(tzzsfzb)){
//			CLFBean CLFBean = new CLFBean();
//			CLFBean.setGsdm(gsdm);
//			CLFBean.setNf(nf);
//			CLFBean.setZdrq(zdrq);
//			CLFBean.setBxdh(bxdh);
//			CLFBean.setFjzs(fjzs);
//			CLFBean.setJhlx(jhlx);
//			CLFBean.setFycsr(fycsr);
//			CLFBean.setBzdm(bzdm);
//			CLFBean.setShhzt(shhzt);
//			CLFBean.setLkr(lkr);
//			CLFBean.setJehj(jehj);
//			CLFBean.setDjlx(djlx_sap);
//		
//			CLFBean.setBmdm(bmdm); 
//			CLFBean.setXmdm("20000401");
//			CLFBean.setXm(";�г�����");
//			CLFBean.setJe(tzzsfzb);
//			CLFBean.setBxr(fycsr);
//			CLFBean.setCcsy(ccsy);
//			list.add(CLFBean);
//		}
		//���ڳ���
		if(!"".equals(sncfzb)){
			CLFBean CLFBean = new CLFBean();
			CLFBean.setGsdm(gsdm);
			CLFBean.setNf(nf);
			CLFBean.setZdrq(zdrq);
			CLFBean.setBxdh(bxdh);
			CLFBean.setFjzs(fjzs);
			CLFBean.setJhlx(jhlx);
			CLFBean.setFycsr(fycsr);
			CLFBean.setBzdm(bzdm);
			CLFBean.setShhzt(shhzt);
			CLFBean.setLkr(lkr);
			CLFBean.setJehj(jehj);
			CLFBean.setDjlx(djlx_sap);
		
			CLFBean.setBmdm(bmdm); 
			CLFBean.setXmdm("20000401");
			CLFBean.setXm("���ڳ���");
			CLFBean.setJe(sncfzb);
			CLFBean.setBxr(fycsr);
			CLFBean.setCcsy(ccsy);
			list.add(CLFBean);
		}
		//ס�޷�
//		if(!"".equals(zsfzb)){
//			CLFBean CLFBean = new CLFBean();
//			CLFBean.setGsdm(gsdm);
//			CLFBean.setNf(nf);
//			CLFBean.setZdrq(zdrq);
//			CLFBean.setBxdh(bxdh);
//			CLFBean.setFjzs(fjzs);
//			CLFBean.setJhlx(jhlx);
//			CLFBean.setFycsr(fycsr);
//			CLFBean.setBzdm(bzdm);
//			CLFBean.setShhzt(shhzt);
//			CLFBean.setLkr(lkr);
//			CLFBean.setJehj(jehj);
//			CLFBean.setDjlx(djlx_sap);
//		
//			CLFBean.setBmdm(bmdm); 
//			CLFBean.setXmdm("20000401");
//			CLFBean.setXm("ס�޷�");
//			CLFBean.setJe(zsfzb);
//			CLFBean.setBxr(fycsr);
//			CLFBean.setCcsy(ccsy);
//			list.add(CLFBean);
//		}
		
		//�칫��
		if(!"".equals(bgfzb)){
			CLFBean CLFBean = new CLFBean();
			CLFBean.setGsdm(gsdm);
			CLFBean.setNf(nf);
			CLFBean.setZdrq(zdrq);
			CLFBean.setBxdh(bxdh);
			CLFBean.setFjzs(fjzs);
			CLFBean.setJhlx(jhlx);
			CLFBean.setFycsr(fycsr);
			CLFBean.setBzdm(bzdm);
			CLFBean.setShhzt(shhzt);
			CLFBean.setLkr(lkr);
			CLFBean.setJehj(jehj);
			CLFBean.setDjlx(djlx_sap);
		
			CLFBean.setBmdm(bmdm); 
			CLFBean.setXmdm("20000401");
			CLFBean.setXm("�칫��");
			CLFBean.setJe(bgfzb);
			CLFBean.setBxr(fycsr);
			CLFBean.setCcsy(ccsy);
			list.add(CLFBean);
		}
		
		//����
//				if(!"".equals(qtzb)){
//					CLFBean CLFBean = new CLFBean();
//					CLFBean.setGsdm(gsdm);
//					CLFBean.setNf(nf);
//					CLFBean.setZdrq(zdrq);
//					CLFBean.setBxdh(bxdh);
//					CLFBean.setFjzs(fjzs);
//					CLFBean.setJhlx(jhlx);
//					CLFBean.setFycsr(fycsr);
//					CLFBean.setBzdm(bzdm);
//					CLFBean.setShhzt(shhzt);
//					CLFBean.setLkr(lkr);
//					CLFBean.setJehj(jehj);
//					CLFBean.setDjlx(djlx_sap);
//				
//					CLFBean.setBmdm(bmdm); 
//					CLFBean.setXmdm("20000401");
//					CLFBean.setXm("����");
//					CLFBean.setJe(qtzb);
//					CLFBean.setBxr(fycsr);
//					CLFBean.setCcsy(ccsy);
//					list.add(CLFBean);
//				}
		
				//�����̲���
//				if(!"".equals(wwpbzhj)){
//					CLFBean CLFBean = new CLFBean();
//					CLFBean.setGsdm(gsdm);
//					CLFBean.setNf(nf);
//					CLFBean.setZdrq(zdrq);
//					CLFBean.setBxdh(bxdh);
//					CLFBean.setFjzs(fjzs);
//					CLFBean.setJhlx(jhlx);
//					CLFBean.setFycsr(fycsr);
//					CLFBean.setBzdm(bzdm);
//					CLFBean.setShhzt(shhzt);
//					CLFBean.setLkr(lkr);
//					CLFBean.setJehj(jehj);
//					CLFBean.setDjlx(djlx_sap);
//				
//					CLFBean.setBmdm(bmdm); 
//					CLFBean.setXmdm("20000401");
//					CLFBean.setXm("�����̲���");
//					CLFBean.setJe(wwpbzhj);
//					CLFBean.setBxr(fycsr);
//					CLFBean.setCcsy(ccsy);
//					list.add(CLFBean);
//				}
//				//��ʳ����
//				if(!"".equals(hsbzhj)){
//					CLFBean CLFBean = new CLFBean();
//					CLFBean.setGsdm(gsdm);
//					CLFBean.setNf(nf);
//					CLFBean.setZdrq(zdrq);
//					CLFBean.setBxdh(bxdh);
//					CLFBean.setFjzs(fjzs);
//					CLFBean.setJhlx(jhlx);
//					CLFBean.setFycsr(fycsr);
//					CLFBean.setBzdm(bzdm);
//					CLFBean.setShhzt(shhzt);
//					CLFBean.setLkr(lkr);
//					CLFBean.setJehj(jehj);
//					CLFBean.setDjlx(djlx_sap);
//				
//					CLFBean.setBmdm(bmdm); 
//					CLFBean.setXmdm("20000402");
//					CLFBean.setXm("��ʳ����");
//					CLFBean.setJe(hsbzhj);
//					CLFBean.setBxr(fycsr);
//					CLFBean.setCcsy(ccsy);
//					list.add(CLFBean);
//				}
		String result = "";   

		result = YTCLFBXExecuteBapi.YtclfReturnSap(list, "");
		String act_rtn ="1";
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
