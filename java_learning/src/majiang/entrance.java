package majiang;
/*Author: Shengyang gu
 *Description:ģ���齫���Ƴ���
 *Ŀǰ���ܣ� �����ƶ�
 *			���ƣ��������������ڿ���ɾ����
 *			
 *

*/

import java.math.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;


public class entrance {
	

	public static void main (String[] args) {
		Scanner console = new Scanner(System.in);
		Cards cards = new Cards();
		cards.showCards();
		cards.shufCards();
		cards.showCards();
		
		List<Player> p = new ArrayList<Player>();
		
	    p.add(new Player(1,"1"));
	    p.add(new Player(2,"2"));
	    p.add(new Player(3,"3"));
	    p.add(new Player(4,"4"));
	    
	    System.out.println("\n ��ʼ���ƣ�");
	    
	    for (int man=0;man<4;man++) {
	    	for(int i=0; i<13;i++) {
	    		if (cards.hasNext()) {
	    			p.get(man).setHandCards(cards.getList().get(i));
	    			cards.takeNext();
	    		}
	    	}
	    }
	   
	    System.out.println("\n չʾ����");
	    for (int man=0;man<4;man++) {
	    	p.get(man).cardCollator();
	    	System.out.println("\n Player "+man +" : ");
	    	for (int i=0;i<13;i++) {
	    	     
	    		System.out.print(p.get(man).getHandCards().get(i).getNumber()+p.get(man).getHandCards().get(i).getColor());
	     
	    	}
	    
	    }
	    
	    System.out.println("\nʣ����ƶ�");
		cards.showCards();
		////////////////
	/*	int id=0;
		 boolean ready = true;
	        do{
	            try{
	                System.out.println("���ƣ�");
	                id = console.nextInt();
	                ready = true;
	            }catch(Exception e){
	                System.out.println("�������������͵����֣�");
	                ready = false;
	                console.nextLine();
	            }
	        }while(ready==false);
		*/

	}
	
}