package majiang;

import java.math.*;
import java.util.ArrayList;
import java.util.Arrays;
public class entrance {
	
	public static void takecard(int num,int[] cardstack) {
		for (int i=0;i<num;i++) {
			int getnum=cardstack[rannum(cardstack.length)];
			
			System.out.print(check(getnum)+" " );
		}
	}
	public static int rannum(int size) {
		int num1to108 = (int)(Math.random()*size);
		return num1to108;
	}
	public static String check(int num) {
		
		if (num>=1 && num<=36) {
			
			return "wan";
		}else if (num>=37 && num<=72) {
			return num-36+"tiao";
		}else if (num >=73 && num <=108) {
			return num-36+"tong";
		}else {
			return null;
		}
	}
public static void main (String[] args) {
	    
		int cardstack[] = new int[108];
	    for (int i=0;i<108;i++) {
	    	cardstack[i]=i;
	    }
	    for (int i=0;i<3;i++)
	    {
	    	takecard(36,cardstack);
	    	System.out.println("\r\n");
	    }
	}
}
