package com.sms.service.webservice;

import java.net.URL;

public class Test {

	/**
	 * ����axis��������webservice�ͻ��˴���
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			String url = "http://localhost:8080/sms/services/sendMsg?wsdl";
			ISendMsgWebServiceServiceLocator locator = new ISendMsgWebServiceServiceLocator();
			ISendMsgWebService service;
			service = locator.getISendMsgWebServicePort(new URL(url));

			/**
			 * ����˵��
			 * account webservice�ӿ��˺�   �ýӿ��˺��ɹ���Ա�˺ţ�root���˺ŷ���http://����:�˿�/sendSmsҳ�洴��
			 * password webservice�ӿ��˺�����
			 * content ��������
			 * receiver �������ֻ�����
			 */
			System.out.print(service.sendMsg("account", "password", "content", "receiver"));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
