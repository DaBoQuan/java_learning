package majiang;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.swing.plaf.synth.SynthStyle;

public class Cards {

	private List<Card> list = new ArrayList<Card>();
	
	//�����ƶ�
	public Cards() {
		System.out.println("-----��ʼ�����ƶ�-----");
		String Color[]= {"��","��","Ͱ"};
		String Colorhua[] = {"��"};
		String Colorhua2[] = {"��","��","��","��","��","��"};
		int nohua=12;
		int nofeng=4;
		String index[] = {"1","2","3","4","5","6","7","8","9"};
		String indexhua[] = {"1","2","3","4","5","6","7","8"};
		String indexhua2[]= {"1","2","3","4"};
		//��Ͱ��
		for (int i = 0; i<Color.length;i++) {
			for (int j = 0; j<index.length;j++) {
				for (int k=0;k<4;k++) {
					list.add(new Card(Color[i],index[j]));
				}
			}
		}
		for (int i=1; i<nohua+1;i++) {
			list.add(new Card(Colorhua[0],Integer.toString(i)));
		}
		for (int i=0;i<Colorhua2.length;i++) {
			for (int j=1;j<nofeng+1;j++) {
				list.add(new Card(Colorhua2[i],Integer.toString(j)));
				
			}
		}
	}
	
	public List<Card> getList() {
		return list;
	}
	
	public void shufCards() {
		System.out.print("start shuffling");
		Collections.shuffle(list);
		System.out.println();
		System.out.print("end shuffling");
		System.out.println();
	}
	
	public void showCards() {
		System.out.print("�˿���Ϊ:");
		System.out.print("<<");
		for (int i=0; i < list.size();i++) {
			System.out.print(list.get(i).getNumber()+list.get(i).getColor());
		}
		System.out.print(">>");
		System.out.println();
	}
    public boolean hasNext() {
    	return !list.isEmpty();
    }
	public void takeNext() {
		//System.out.println("��һ����: ");
	    System.out.print(list.get(0).getNumber()+list.get(0).getColor());
	    list.remove(0);
	}
	
	public void cardCollator() {
		System.out.println("��ʼ����");
		String Color[]= {"��","��","Ͱ","��","��","��","��","��","��","��"};
		String index[] = {"1","2","3","4","5","6","7","8","9"};
		/*Collections.sort(list, new SortByNumber());
		Collections.sort(list, new SortByColor());*/
		
		/*for (int i=0; i<list.size();i++) {
			
			list.get(i).getColor();
			
			list.get(i).getNumber();
			//�����ƽ�������
			
		}*/
	}
	
	
	
}
	

