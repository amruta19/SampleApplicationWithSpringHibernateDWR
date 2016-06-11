package com.amruta.dwr;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.BeanFactory;  
import org.springframework.beans.factory.xml.XmlBeanFactory;  
import org.springframework.core.io.ClassPathResource;  
import org.springframework.core.io.Resource;  
  

public class MainApplication{
 
	public static void main(String[] args) {  
	      
		  Resource r=new ClassPathResource("resources/applicationContext.xml");  
		    BeanFactory factory=new XmlBeanFactory(r);  
		      
		    UserDAO dao=(UserDAO)factory.getBean("d");  
		      
		   
		    
	      
	}  
	
	 public List<User> getUsers(String name) {
		  
	
         System.out.println("sayHello from insertest : "+name);
                
		  Resource r=new ClassPathResource("resources/applicationContext.xml");  
		  BeanFactory factory=new XmlBeanFactory(r);  
		      
		  UserDAO dao=(UserDAO)factory.getBean("d");  
		  List<User> list = new ArrayList<User>();
		  list= dao.getUsers(name);
		 
		  return list;
       
	      
	  }    
	 
	 
	 public List getReport(int user_id,String sDate,String eDate) {
		  
			
         System.out.println("user_id : "+user_id+"");
         System.out.println("start_date : "+sDate+"");
         System.out.println("end_date : "+eDate+"");
                
		  Resource r=new ClassPathResource("resources/applicationContext.xml");  
		  BeanFactory factory=new XmlBeanFactory(r);  
		      
		  UserDAO dao=(UserDAO)factory.getBean("d");  
		  List list = new ArrayList<Report>();
		  list= dao.getReport(user_id,sDate,eDate);
		  
		  return list;
		 
       
	      
	  }    
	 
	 
}  
