package test2;
//final version!!!
//show first line in sysout terminal and then delete it and save rest file 
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

public class testread {  
	public static void deleterow(int row, String filedic) throws Exception{
		int   lineDel=row;
		String file=filedic;//file directory
		InputStreamReader isr;
		isr = new InputStreamReader(new FileInputStream(file),"utf-8");
		BufferedReader   br=new   BufferedReader(isr);
		StringBuffer   sb=new  StringBuffer(4096);
		String  temp=null;
		int line=0;
		while((temp = br.readLine())!=null){
	        
		    line++;
	        
	        if(line==lineDel) {
	        	
	        	String s= temp.replace(" ","").replace("\r\n", "");
	        	if(s.length()>18) {
	        		String s1=s.substring(0,15);
	        		String s2=s.substring(15);
	        		System.out.print(s1);
	        		sb.append(s2).append("\r\n");
	        		
	        	}
	        	else {
	        		System.out.print(s);
	        		
	        	}
	        	continue;
	        }
	       sb.append(temp);
		}
		
		/*while((temp = br.readLine())!=null){
		        
			    line++;
		        
		        if(line==lineDel) {
		        		
		        	String s= temp.replace(" ","");
		        	//if(s.length()>1000)
		        	//System.out.println(s.length());
		        	System.out.print(s);
		        	ksdjfllkjsdlfk、
		        	continue;
		        	}
		        sb.append(temp).append( "\r\n");
		}*/
		br.close();
		OutputStreamWriter osr = new OutputStreamWriter(new FileOutputStream(file),"utf-8");
		BufferedWriter  bw=new   BufferedWriter(osr);
		bw.write(sb.toString());
		bw.close();
	}
	public static void deletefile(String file){
		 File f = new File(file);
		 if(f.exists())
		 f.delete();
		 
	}
	public static void main(String args[]) throws Exception {
		String filedirectory="D://123//new14.txt";
		//String delfiledir="D://123//new9.txt";
		int n=1;
		for (int i=0;i<n;i++){
		  deleterow(1,filedirectory);
		}
		//deletefile(filedirectory);
    }
    /* 
       String ponos = request.getParameter("ponos");
    String path = request.getParameter("");
    JCO.Client sapconnection = null;
    try {
        
        RecordSet rs = new RecordSet();
        RecordSet rs1 = new RecordSet();
        RecordSet rs2 = new RecordSet();
        String sources = "";
        jfsdoiufn654alksdj
        what fuck the fucking bloody job
        String outcall = "";
       

       
        rs1.writeLog("20180330_______________创建SAP连接");
    
         adfs

        rs1.writeLog(outcall);
        out.write("20180330________________suceess：" + outcall);
    } catch (Exception e) {
        // TODO: handle exception
        out.write("20180330_______________fail" + e);
        e.printStackTrace();
        kjjnhasfkj】 

    }
	*/
} 