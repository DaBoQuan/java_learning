package com.service;

public class Test {

	/**
	 * ����java��wsimport��������webservice�ͻ��˴���
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ISendMsgWebService is =new ISendMsgWebServiceService().getISendMsgWebServicePort();
		/**
		 * ����˵��
		 * account webservice�ӿ��˺�   �ýӿ��˺��ɹ���Ա�˺ţ�root���˺ŷ���http://����:�˿�/sendSmsҳ�洴��
		 * password webservice�ӿ��˺�����
		 * content ��������
		 * receiver �������ֻ�����
		 */
		String resultString = is.sendMsg("account", "password", "content", "receiver");
		System.out.print("�ӿڵ��ý����"+resultString);
		
	}

}
