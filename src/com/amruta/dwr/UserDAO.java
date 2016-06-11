package com.amruta.dwr;
import org.springframework.orm.hibernate3.HibernateTemplate;  

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class UserDAO {

	HibernateTemplate template;  
	public void setTemplate(HibernateTemplate template) {  
	    this.template = template;  
	}
	
	public HibernateTemplate getTemplate() {
		return template;
	}
	//method to save employee  
	public void saveUser(User u){  
	    template.save(u);  
	}  
	//method to update employee  
	public void updateUser(User u){  
	    template.update(u);  
	}  
	//method to delete employee  
	public void deleteUser(User u){  
	    template.delete(u);  
	}  
	//method to return one employee of given id  
	public User getById(int id){  
	    User u=(User)template.get(User.class,id);  
	    return u;  
	}  
	//method to return all employees  
	public List< User> getUsers(String userNameLike){  
		/*List<User> list=new ArrayList<User>();  
	    list=template.loadAll(User.class);  */
	    
		//give table name in capital
		String query="from User u where u.username like:username";
		List<User> userList = getTemplate().findByNamedParam(query, "username", '%' + userNameLike + '%');
		
		 //List<Object[]> userList = new ArrayList<Object[]>();
//	     String query = "from user";
//	     //Object[] queryParam = {userNameLike};
//	     list = template.find(query);
	     return userList;
	}

	public List getReport(int user_id, String sDate, String eDate) {
		// TODO Auto-generated method stub
		/*SimpleDateFormat format= new SimpleDateFormat("yyyy-MM-dd");
		Object  date1 = null,date2 = null;
		try {
			date1 = format.parse(sDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
		 date2 = format.parse(eDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		String order="asc";
		String order_by="name",sort_param = null;
		String query="select p.provider_id,p.provider_name,sum(s.count) from Stats s,User u,Provider p where s.provider_id=p.provider_id and s.user_id=u.user_id and u.user_id=? and s.date >=? and s.date<=? group by(p.provider_name) order by";
		if(order_by.equalsIgnoreCase("name")){
			sort_param=" p.provider_name";
			
		}else if(order_by.equalsIgnoreCase("id")){
			sort_param=" p.provider_id";
		}else if(order_by.equalsIgnoreCase("count")){
			sort_param=" s.count";
		}
		query=query+sort_param+" "+order;
		
		Object[] queryParam = {user_id,sDate,eDate};
		return getTemplate().find(query,queryParam);
		
	}  
	
	
	
	
}
