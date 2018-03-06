package baiduOCRrecog;

import java.util.HashMap;

import org.json.JSONObject;

import com.baidu.aip.ocr.AipOcr;

public class drive {
	public void sample(AipOcr client) {
	    // �����ѡ�������ýӿ�
	    HashMap<String, String> options = new HashMap<String, String>();
	    options.put("language_type", "CHN_ENG");
	    options.put("detect_direction", "true");
	    options.put("detect_language", "true");
	    options.put("probability", "true");


	    // ����Ϊ����ͼƬ·��
	    String image = "test.jpg";
	    JSONObject res = client.basicGeneral(image, options);
	    System.out.println(res.toString(2));

	    // ����Ϊ����ͼƬ����������
	    byte[] file = readImageFile(image);
	    res = client.basicGeneral(file, options);
	    System.out.println(res.toString(2));


	    String url="";
	    
		// ͨ������ʶ��, ͼƬ����ΪԶ��urlͼƬ
	    res = client.basicGeneralUrl(url, options);
	    System.out.println(res.toString(2));

	}

	private byte[] readImageFile(String image) {
		// TODO Auto-generated method stub
		return null;
	}

	public static void main(String args[]){
		
	}
}
