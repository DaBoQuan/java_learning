import java.io.File;  
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.BufferedReader;  
import java.io.BufferedWriter;  
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;  


public class find_return {
    public static void print(String strprint){
    	System.out.println(strprint);
    }
	public static void findstring(String originstr,String filedic){
		String s ="意识引导器";  
		int i = originstr.lastIndexOf(s);  
		if (i!=-1){
		  System.out.println("在"+filedic+"中"); 
		}
		
	}
	public static void readline(String filedic) throws Exception{
		InputStreamReader isr;
		isr = new InputStreamReader(new FileInputStream(filedic),"utf-8");
		BufferedReader   br=new   BufferedReader(isr);
		StringBuffer   sb=new  StringBuffer(4096);
		String  temp=null;
		while ((temp=br.readLine())!=null){
			findstring(temp,filedic);
		}
	}
	public static void main(String args[])throws Exception{
		String filedic="D://123//new";
		int fileindex=23;
		for (int i=0;i<=fileindex;i++){
			String s=filedic+i+".txt";
			readline(s);
		}
	}
	
}
