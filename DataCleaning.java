import java.io.*;
import java.util.*;

public class DataCleaning{
	public static void main(String args[]) throws Exception{
		preprocess(args[0],args[1],1024000);
		
	}
	
	/**
	*	read from inFile, write the result into outFile seperated by newline
	*	it reads bufferSize chars in and process it 
	*	it could happend that the record at the end is cut off, those that are cut off are ignored
	*/
	public static void preprocess(String inFile, String outFile, int bufferSize) throws Exception{
		//initialize reader and writer
		BufferedReader in = new BufferedReader(new FileReader(inFile));
		BufferedWriter out= new BufferedWriter(new FileWriter(outFile));
		char[] buffer=new char[bufferSize];
		int len=0;
		
		while((len=in.read(buffer,0,bufferSize))!=-1){
		//read the chars in to buffer repeatedly and pass it to clean for cleaning
		String s=new String(buffer,0,len);
		List<String> result=clean(s);
		//for the results returned, write them back to the outFile writer
		for(String tmp : result)
			out.write(tmp+"\n\n");
		}
		
		//close the reader and writers
		out.flush();
		in.close();
		out.close();
	}

	public static List<String> clean(String s){
		int idx=0;
		List<String> list=new ArrayList<String>();
		//replace all the connected ""
		s=s.replaceAll("\\\"\\\""," ");
		//test if the string starts with "[0-9]+"
		if(s.indexOf("\"")==0){
			idx=s.indexOf("\"",1);
			String tmp=s.substring(1,idx);
			if(tmp.matches("[0-9]+"))
				idx=0;
			else idx=1;
		}else
			idx=1;
		String[] str=s.split("\\\"[0-9]+\\\"");
		//repeatedly:
		for(;idx<str.length;idx++){
			//get the title and body
			String[] ss=str[idx].split("\\\"");
			if(ss.length!=7)
				continue;
			String result=ss[1]+ss[3];
			//clean the title and body
			result=result.replaceAll("\n"," ");
			result=result.replaceAll("<code>.*?</code>"," ");
			result=result.replaceAll("<.*?>"," ");
			result=result.replaceAll("[^a-zA-Z0-9]"," ");
			result=result.replaceAll("\\s+"," ");
			result=result.toLowerCase();
			list.add(result);
		}
		return list;
	}

}
