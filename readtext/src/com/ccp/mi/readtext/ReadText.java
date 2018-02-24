package com.ccp.mi.readtext;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jcifs.UniAddress;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileInputStream;
import jcifs.smb.SmbSession;

public class ReadText {
	private static final String DOMAIN_IP = JDBCUtil.pros.getProperty("domainIP");
	private static final String DOMAIN_NAME = JDBCUtil.pros.getProperty("domainName");
	private static final String USERNAME = JDBCUtil.pros.getProperty("username");
	private static final String PASSWORD = JDBCUtil.pros.getProperty("password");
	private static final String FILE_URL = JDBCUtil.pros.getProperty("fileURL");
	private static final String MATERIAL = JDBCUtil.pros.getProperty("material");
	private static final String REGEX = "TAGNAME=(Root.+?)ITEM=VALUE,VALUE=(.+?),TIMESTAMP=(.+?),QUA";
	
	//��ȡ�޶������ݼ���
	public static ArrayList<Tank> getTankList(String filestr){
		ArrayList<Tank> list = new ArrayList<Tank>();
		Matcher matcher = regexPattern().matcher(filestr);
		while(matcher.find()){
			Tank tank = new Tank();
			tank.setTagname(matcher.group(1));
			tank.setTagvalue(matcher.group(2));
			tank.setTimestamp(matcher.group(3));
			list.add(tank);
		}
		return list;
	}
	//�������򣬷���ģ��
	public static Pattern regexPattern(){
		Pattern pattern = Pattern.compile(REGEX);
		return pattern;
	}
	//ָ���ļ�·�����ı�ת���ַ�����·������db.properties�����ļ���ָ��
	public static String fileToString() {
		SmbFile file = null;
		try {
			System.setProperty("jcifs.smb.client.dfs.disabled", "true");
			UniAddress dc = UniAddress.getByName(DOMAIN_IP);
			NtlmPasswordAuthentication authentication = new NtlmPasswordAuthentication(DOMAIN_NAME, USERNAME, PASSWORD);
			SmbSession.logon(dc, authentication);
			file = new SmbFile(FILE_URL,authentication);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		StringBuilder str = new StringBuilder();
		SmbFileInputStream fr = null;
		BufferedReader bfr = null;
		try {
			if(file==null||!file.exists())return str.toString();
			fr = new SmbFileInputStream(file);
			bfr = new BufferedReader(new InputStreamReader(fr,"UTF-8"));
			String temp = null;
			while((temp=bfr.readLine())!=null){
				str.append(temp);
			}
		} catch (Exception e) {
			System.out.println("file2String�쳣ʱ��----"+new Date().toString());
			e.printStackTrace();
		} finally {
			if(bfr!=null){
				try {
					bfr.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return str.toString();
	}

	//��ȡ����������Ϣ
	public static Map<String,String> getMaterials(String filename){
		BufferedReader bfr = null;
		Map<String,String> map = new HashMap<String, String>();
		try {
			bfr = new BufferedReader(new FileReader(MATERIAL));
			String temp;
			while((temp=bfr.readLine())!=null){
				String[] strarr = temp.trim().split("[,��+]");
				map.put(strarr[0],strarr[1]);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(bfr!=null){
				try {
					bfr.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return map;
	}
}
