package majiang;
/*Author: Shengyang gu
 *Description:模拟麻将发牌程序
 *目前功能： 打乱牌堆
 *			发牌，并将发出的牌在库中删除。
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
		while(true) {
			Scanner console = new Scanner(System.in);
			String temp;
			if ((temp=console.nextLine())!=null){
				System.out.println("current instructor "+temp);
				if (temp.equals("start")) {
					//开始发牌
					System.out.println("game start");
					Cards cards = new Cards();
					cards.showCards();
					cards.shufCards();
					cards.showCards();
					
					List<Player> p = new ArrayList<Player>();
					
				    p.add(new Player(1,"1"));
				    p.add(new Player(2,"2"));
				    p.add(new Player(3,"3"));
				    p.add(new Player(4,"4"));
				    
				    System.out.println("\n 开始发牌：");
				    
				    for (int man=0;man<4;man++) {
				    	for(int i=0; i<13;i++) {
				    		if (cards.hasNext()) {
				    			p.get(man).setHandCards(cards.getList().get(i));
				    			cards.takeNext();
				    		}
				    	}
				    }
				   
				    System.out.println("\n 展示手牌");
				    for (int man=0;man<4;man++) {
				    	p.get(man).cardCollator();
				    	System.out.println("\n Player "+man +" : ");
				    	for (int i=0;i<13;i++) {
				    	     
				    		System.out.print(p.get(man).getHandCards().get(i).getNumber()+p.get(man).getHandCards().get(i).getColor());
				     
				    	}
				    
				    }
				    
				    System.out.println("\n剩余的牌堆");
					cards.showCards();
					while(console.hasNextInt()) {
						
					}
				}
				
				else if(temp.equals("exit")) {
//					结束
					System.out.println("EXIT GAME!!");
					console.close();
					System.exit(0);				
				}
				
				else {
					System.out.println("INVALID INPUT!!");
				}
			}
		}
//			console.next();
			
		////////////////
	/*	int id=0;
		 boolean ready = true;
	        do{
	            try{
	                System.out.println("出牌：");
	                id = console.nextInt();
	                ready = true;
	            }catch(Exception e){
	                System.out.println("请输入整数类型的数字！");
	                ready = false;
	                console.nextLine();
	            }
	        }while(ready==false);
		*/

	}
	
}
