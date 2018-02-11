package weaver.interfaces.tw.xiyf.sap;

import java.math.BigDecimal;

/**
 * 
 * @ClassName: BigDecimalCalculate 
 * @Description: �Ӽ��˳�����
 * @author xiyufei
 * @date 2013-10-25 ����2:14:43 
 *
 */
public class BigDecimalCalculate {
	// float�������
	public static String floatAdd(String a, String b) {
		BigDecimal bg1 = new BigDecimal(a);
		BigDecimal bg2 = new BigDecimal(b);

		BigDecimal bd = bg1.add(bg2);

		return bd.toString();
	}

	// float�������
	public static String floatSubtract(String a, String b) {
		BigDecimal bg1 = new BigDecimal(a);
		BigDecimal bg2 = new BigDecimal(b);
		BigDecimal bd = bg1.subtract(bg2);
		return bd.toString();
	}
	//��������2λС��
	public static String floatDivide(String a,String b)
    {
    	BigDecimal bg1=new BigDecimal(a);  
		BigDecimal bg2=new BigDecimal(b);

		BigDecimal bd = bg1.divide(bg2,2,BigDecimal.ROUND_HALF_UP);
		return  bd.toString();
    }
	
	//�˷�
	public static String floatMultiply(String a,String b)
    {
    	BigDecimal bg1=new BigDecimal(a);  
		BigDecimal bg2=new BigDecimal(b);

		BigDecimal bd = bg1.multiply(bg2).setScale(2, BigDecimal.ROUND_HALF_UP);
		return  bd.toString();
    }
	
	// ��С�Ƚ� -1 0 1
	public static int floatCompare(String a, String b) {
		BigDecimal bg1 = new BigDecimal(a);
		BigDecimal bg2 = new BigDecimal(b);
		
		return bg1.compareTo(bg2);
	}
}
