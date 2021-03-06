package com.ccp.service;

import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.IOUtils;

import com.ccp.dao.MnDataDao;
import com.ccp.pojo.MnData;

public class MnDataService {
	private MnDataDao dao;

	public void setDao(MnDataDao dao) {
		this.dao = dao;
	}

	public List<String> getMnDataLineList(String enterpriseName) {
		List<String> list = new ArrayList<String>();
		List<String> deviceNameList = dao
				.getDeviceNameListByEnterpriseName(enterpriseName);
		for (String deviceName : deviceNameList) {
			List<MnData> mnDatalist = dao
					.getMnDataListByEnterpriseNameAndDeviceName(enterpriseName,
							deviceName);
			list.add(generateDataLine(deviceName, mnDatalist));
		}
		return list;
	}
//	public List<String> getMnDataLineList(String enterpriseName) {
//		List<String> list = new ArrayList<String>();
//		List<String> deviceNameList = dao
//				.getDeviceNameListByEnterpriseName(enterpriseName);
//		for (String deviceName : deviceNameList) {
//			List<MnData> mnDatalist = dao
//					.getMnDataListByEnterpriseNameAndDeviceName(enterpriseName,
//							deviceName);
//			list.add(generateDataLine(deviceName, mnDatalist));
//		}
//		return list;
//	}
	public String generateDataLine(String deviceName, List<MnData> mnDatalist) {
		final String DEVICENAME1="DFR-2期焚烧炉";
		final String DEVICENAME2="DFR-1期焚烧炉";
		final String DEVICENAME3="DFR-1、2期溢散水洗塔";
		final String DEVICENAME4="DFR3期溢散水洗塔";
//		final String DEVICENAME5="DFR3期焚烧炉（西）";
//		final String DEVICENAME6="DFR3期焚烧炉（4线 东）";
		final String DEVICENAME5="DFR3期焚烧炉（3线西）";
		final String DEVICENAME6="DFR3期焚烧炉（4线东）";
		final String DEVICENAME7="厂界1";
		final String DEVICENAME8="厂界2";
		final String DEVICENAME9="厂界3";
		final String DEVICENAME10="厂界4";
		final String DEVICENAME11="BPA2（VOCs+甲硫醇）";
		final String DEVICENAME12="氧化炉（VOCs+H2S）";
		final String DEVICENAME13="PN（VOCs+甲硫醇）";
		final String DEVICECODE1="Root.CN.CCJS_ENVIRON.VOCS.DFR2_";
		final String DEVICECODE2="Root.CN.CCJS_ENVIRON.VOCS.DFR1_";
		final String DEVICECODE3="Root.CN.CCJS_ENVIRON.VOCS.DFRWT1/2_";
		final String DEVICECODE4="Root.CN.CCJS_ENVIRON.VOCS.DFRWT3/4_";
		final String DEVICECODE5="Root.CN.CCJS_ENVIRON.VOCS.DFR3W_";
		final String DEVICECODE6="Root.CN.CCJS_ENVIRON.VOCS.DFR3E_";
		final String DEVICECODE7="Root.CN.CCJS_ENVIRON.VOCS.F1_";
		final String DEVICECODE8="Root.CN.CCJS_ENVIRON.VOCS.F2_";
		final String DEVICECODE9="Root.CN.CCJS_ENVIRON.VOCS.F3_";
		final String DEVICECODE10="Root.CN.CCJS_ENVIRON.VOCS.F4_";
		final String DEVICECODE11="Root.CN.CCJS_ENVIRON.VOCS.BPA2_";
		final String DEVICECODE12="Root.CN.CCJS_ENVIRON.VOCS.UT_";
		final String DEVICECODE13="Root.CN.CCJS_ENVIRON.VOCS.PN_";

		StringBuilder sb = new StringBuilder();
		Timestamp time = null;
		for (MnData mnData : mnDatalist) {
			
			if (deviceName.equals(DEVICENAME1)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE1).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());
				}else {continue;}
			}else if (deviceName.equals(DEVICENAME2)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE2).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());
				}else {continue;}
			}else if (deviceName.equals(DEVICENAME3)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE3).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME4)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE4).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME5)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE5).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME6)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE6).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
				}else if (deviceName.equals(DEVICENAME7)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE7).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME8)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE8).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME9)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE9).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME10)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE10).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME11)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE11).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME12)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE12).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}else if (deviceName.equals(DEVICENAME13)) {
				if (getpolluCode(mnData.getPollutantName())!=null){
					sb.append("TAGNAME=").append(DEVICECODE13).append(getpolluCode(mnData.getPollutantName())).append("\r\n").append("ITEM=VALUE,").append("VALUE=").append(mnData.getRealtimeData());	
					}else {continue;}
			}
			else {
				System.out.println("error! Device name not match"+deviceName);
				break;
			}
			time=mnData.getMeasureDatetime();

			//change time output style
			
			String tsStr="";
			DateFormat sdf= new SimpleDateFormat ("MM/dd/yyyy HH:mm:ss");//月日年
			try {
				tsStr=sdf.format(time);
//				System.out.println(tsStr);
			}catch (Exception e) {
				e.printStackTrace();
			}
			sb.append(",TIMESTAMP=").append(tsStr).append(",QUALITY=192");
			sb.append("\r\n");
		}
		return sb.toString();
	}
    public String getpolluCode(String pollu) {
    	final String POLLUTION1="甲烷";
		final String POLLUTION2="非甲烷总烃";
		final String POLLUTION3="总烃";
		final String POLLUTION4="甲硫醇";
		final String POLLUTION5="硫化氢";
		final String POLLUTIONCODE1="CH4";
		final String POLLUTIONCODE2="NMHC";
		final String POLLUTIONCODE3="THC";
		final String POLLUTIONCODE4="MESH";
		final String POLLUTIONCODE5="H2S";
    	if (pollu.equals(POLLUTION1)) {
    		return POLLUTIONCODE1;
    	}else if (pollu.equals(POLLUTION2)) {
    		return POLLUTIONCODE2;
    	}else if (pollu.equals(POLLUTION3)) {
    		return POLLUTIONCODE3;
    	}
    	else if (pollu.equals(POLLUTION4)) {
    		return POLLUTIONCODE4;
    	}else if (pollu.equals(POLLUTION5)) {
    		return POLLUTIONCODE5;
    	}else {
    		return null;
    	}
    }
	//@SuppressWarnings("deprecation")
	public void mnDataToFile(List<String> mnDataLineList, OutputStream output)
			throws Exception {
		IOUtils.writeLines(mnDataLineList,"", output,"utf-8");
		IOUtils.closeQuietly(output);
	}

}
