package majiang2;

import java.util.ArrayList;

public class entrance {
	public static void main (String[] args) {
		ArrayList<String> cardList = createArrayList(
				"1wan","1wan","1wan","1wan",
				"2wan","2wan","2wan","2wan",
				"3wan","3wan","3wan","3wan",
				"4wan","4wan","4wan","4wan",
				"5wan","5wan","5wan","5wan",
				"6wan","6wan","6wan","6wan",
				"7wan","7wan","7wan","7wan",
				"8wan","8wan","8wan","8wan",
				"9wan","9wan","9wan","9wan",
				"1tiao","1tiao","1tiao","1tiao",
				"2tiao","2tiao","2tiao","2tiao",
				"3tiao","3tiao","3tiao","3tiao",
				"4tiao","4tiao","4tiao","4tiao",
				"5tiao","5tiao","5tiao","5tiao",
				"6tiao","6tiao","6tiao","6tiao",
				"7tiao","7tiao","7tiao","7tiao",
				"8tiao","8tiao","8tiao","8tiao",
				"9tiao","9tiao","9tiao","9tiao",
				"1tong","1tong","1tong","1tong",
				"2tong","2tong","2tong","2tong",
				"3tong","3tong","3tong","3tong",
				"4tong","4tong","4tong","4tong",
				"5tong","5tong","5tong","5tong",
				"6tong","6tong","6tong","6tong",
				"7tong","7tong","7tong","7tong",
				"8tong","8tong","8tong","8tong",
				"9tong","9tong","9tong","9tong"
				); 
		int cardpos[]= new int[108];
		for (int i=0;i<108;i++) {
			cardpos[i]=i;
		}//��ʼ��
		//generate rand number
		for (int k=0;k<4;k++) {
			for (int i=0;i<13;i++) {
				int j=0;
				j=rannum(108);
				if (!(cardpos[j]>=200)) {
					String currentcard=cardList.get(j);
					System.out.print(currentcard);
				    cardpos[j]=999;
				}else{
					i--;
					continue;
				}
			}
			System.out.println("\r\n");
		}
	}
	public static int rannum(int size) {
		int num1to108 = (int)(Math.random()*size);
		return num1to108;
	}
	public static ArrayList<String> createArrayList(String ... elements) {
		  ArrayList<String> list = new ArrayList<String>(); 
		  for (String element : elements) {
		    list.add(element);
		  }
		  return list;
		}
}