package org.ldd.ssm.crm.utils;

import java.io.IOException;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeSet;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.ldd.ssm.crm.domain.Airdiscount;
import org.ldd.ssm.crm.domain.ClassRanking;
import org.ldd.ssm.crm.domain.FlightAirline;
import org.ldd.ssm.crm.domain.TotalFly;
import org.ldd.ssm.crm.domain.Z_Airdata;
/**
 * 工具类
 * @Title:TextUtil 
 * @Description:
 * @author taimei-gds 
 * @date 2016-4-26 下午2:23:40
 */
public class TextUtil {
	/**
	 * 判断字符串是否为空
	 * @Title: isEmpty 
	 * @Description:  
	 * @param @param str
	 * @param @return    
	 * @return boolean     
	 * @throws
	 */
	public static boolean isEmpty(String str) {
		if (str == null || str.trim().length() == 0 || "".equals(str)||"null".equals(str)) {
			return true;
		}
		return false;
	}
	/**
	 * 判定是否为数字
	 * @Title: isNum 
	 * @Description:  
	 * @param @param str
	 * @param @return    
	 * @return boolean     
	 * @throws
	 */
	public static boolean isNum(String str){
		return str.matches("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
	}
	/**
	 * 得到该月的5周的日期
	 * @Title: getWeekOfMonth 
	 * @Description:  
	 * @param @param year
	 * @param @param month
	 * @param @return    
	 * @return Map<String,List<String>>     
	 * @throws
	 */
	public static Map<String, List<String>> getWeekOfMonth(int year,int month){
		Map<String, List<String>> monthMap = new HashMap<String, List<String>>();
        for (int i = 1; i <= 5 ; i++){
        	String date = countData(year,month,i) ;  
        	String [] str = date.split("-");
        	int start = Integer.parseInt(str[0]);
        	int end = Integer.parseInt(str[1]);
        	List<String> timeList = new ArrayList<String>();
        	for(int j =start ;j<=end;j++){
        		String startTime = year +"-"+ month +"-"+ j;
        		timeList.add(startTime);
        	}
        	monthMap.put(i+"", timeList);
        }
		return monthMap;
	}
	/**
	 * 根据日期转换对应的星期
	 * @Title: getWeekOfDate 
	 * @Description:  
	 * @param @param date
	 * @param @return    
	 * @return String     
	 * @throws
	 */
	public static String getWeekOfDate(Date date) {      
	    String[] weekOfDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};        
	    Calendar calendar = Calendar.getInstance();      
	    if(date != null){        
	       calendar.setTime(date);      
	    }        
	    int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;      
	    if (w < 0){        
	        w = 0;      
	    }      
	    return weekOfDays[w];    
	}
	public static String getWeekOfDate3(Date date) {      
		String[] weekOfDays = {"日", "一", "二", "三", "四", "五", "六"};        
		Calendar calendar = Calendar.getInstance();      
		if(date != null){        
			calendar.setTime(date);      
		}        
		int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;      
		if (w < 0){        
			w = 0;      
		}      
		return weekOfDays[w];    
	}
	public static String getWeekOfDate2(Date date) {      
		String[] weekOfDays = {"7", "1", "2", "3", "4", "5", "6"};        
		Calendar calendar = Calendar.getInstance();      
		if(date != null){        
			calendar.setTime(date);      
		}        
		int w = calendar.get(Calendar.DAY_OF_WEEK) - 1;      
		if (w < 0){        
			w = 0;      
		}      
		return weekOfDays[w];    
	}
	 //判断闰年
    public static boolean isLeapYear(int year){
        return (year%4 == 0 && year%100 != 0) || (year%400 == 0);
    }
    //计算日期
    public static String countData(int year,int month,int weekend){
    	 int leapYear[] = {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};   //闰年每月天数
 	    int commonYear[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}; //平年每月天数
 	    int start, end;
 	    int day, weekday, allDays=0;
         //分别表示当月天数、当月一号是星期几、1900.1.1到当前输入日期之间的天数
         day = isLeapYear(year)?leapYear[month]:commonYear[month];
         if(weekend > (day==28?4:5)){
             return null;
         }
         //计算天数
         for(int i=1900; i<year; i++){
             allDays += isLeapYear(i)?366:365;
         }
         for(int i=1; i<month; i++){
             allDays += isLeapYear(year)?leapYear[i]:commonYear[i];
         }
         //计算星期几
         weekday = 1+allDays%7;
          
         //计算第weekend周的开始和结束
         if(weekend == 1){
             start = 1;
             end = 8 - weekday;
         }
         else{
             start = (weekend-2)*7 + (9-weekday);
             end = start + 6;
             if(end > day)
                 end = day;
         }
         return start+"-"+end;
    }
    /**
     * 得到指定日期对应的月份的最大天数
     * @Title: getDayOfMonth 
     * @Description:  
     * @param @param date
     * @param @return    
     * @return int     
     * @throws
     */
    public static int getMaxDayOfMonth(String date){
		Calendar aCalendar = Calendar.getInstance(Locale.CHINA);
		String [] dates = date.split("-");
		aCalendar.set(Integer.parseInt(dates[0]),Integer.parseInt(dates[1]) - 1,1);
		int maxDay = aCalendar.getActualMaximum(Calendar.DATE);
		return maxDay;
	}
    
    //得到夏秋起始日期
  	public static Map<String,String> getXQDate(int year){
  		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  	 	Map<String,String> timeMap = new HashMap<String, String>();
  	 	String startTime = "";
  		String endTime = "";
  		Map<String, List<String>>  dateMap = TextUtil.getWeekOfMonth(year, 3);
  		List<String> dateStr = dateMap.get("5");
  		for (String date : dateStr) {
  			try {
  				String week = TextUtil.getWeekOfDate(df.parse(date));
  				if("星期日".equals(week)){
  					startTime = date;
  				}
  			} catch (ParseException e) {
  				e.printStackTrace();
  			}
  		}
  		if("".equals(startTime)){
  			List<String> dateStr2 = dateMap.get("4");
  			for (String date : dateStr2) {
  				try {
  					String week = TextUtil.getWeekOfDate(df.parse(date));
  					if("星期日".equals(week)){
  						startTime = date;
  					}
  				} catch (ParseException e) {
  					e.printStackTrace();
  				}
  			}
  		}
  		Map<String, List<String>>  dateMap2 = TextUtil.getWeekOfMonth(year, 10);
  		List<String> dateStr3 = dateMap2.get("5");
  		for (String date : dateStr3) {
  			try {
  				String week = TextUtil.getWeekOfDate(df.parse(date));
  				if("星期日".equals(week)){
  					endTime = addDateDay(date, -1);
  				}
  			} catch (ParseException e) {
  				e.printStackTrace();
  			}
  		}
  		if("".equals(endTime)){
  			List<String> dateStr4 = dateMap2.get("4");
  			for (String date : dateStr4) {
  				try {
  					String week = TextUtil.getWeekOfDate(df.parse(date));
  					if("星期日".equals(week)){
  						endTime = addDateDay(date, -1);
  					}
  				} catch (ParseException e) {
  					e.printStackTrace();
  				}
  			}
  		}
  		String [] str = endTime.split("-");
  		endTime = str[0]+"-"+str[1]+"-"+((Integer.parseInt(str[2])-1)+"");
  		timeMap.put("startTime", startTime);
  		timeMap.put("endTime", TextUtil.addDateDay(endTime, 1));
  		return timeMap;
  	}
  	//得到冬春起始数据
  	public static Map<String,String> getDCDate(int year){
  		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  		Map<String,String> timeMap = new HashMap<String, String>();
  		String startTime = "";
  		String endTime = "";
  		Map<String, List<String>>  dateMap = TextUtil.getWeekOfMonth(year, 10);
  		List<String> dateStr = dateMap.get("5");
  		for (String date : dateStr) {
  			try {
  				String week = TextUtil.getWeekOfDate(df.parse(date));
  				if("星期日".equals(week)){
  					startTime = date;
  				}
  			} catch (ParseException e) {
  				e.printStackTrace();
  			}
  		}
  		if("".equals(startTime)){
  			List<String> dateStr2 = dateMap.get("4");
  			for (String date : dateStr2) {
  				try {
  					String week = TextUtil.getWeekOfDate(df.parse(date));
  					if("星期日".equals(week)){
  						startTime = date;
  					}
  				} catch (ParseException e) {
  					e.printStackTrace();
  				}
  			}
  		}
  		Map<String, List<String>>  dateMap2 = TextUtil.getWeekOfMonth(year+1, 3);
  		List<String> dateStr3 = dateMap2.get("5");
  		for (String date : dateStr3) {
  			try {
  				String week = TextUtil.getWeekOfDate(df.parse(date));
  				if("星期日".equals(week)){
  					endTime = addDateDay(date, -1);
  				}
  			} catch (ParseException e) {
  				e.printStackTrace();
  			}
  		}
  		if("".equals(endTime)){
  			List<String> dateStr4 = dateMap2.get("4");
  			for (String date : dateStr4) {
  				try {
  					String week = TextUtil.getWeekOfDate(df.parse(date));
  					if("星期日".equals(week)){
  						endTime = addDateDay(date, -1);
  					}
  				} catch (ParseException e) {
  					e.printStackTrace();
  				}
  			}
  		}
  		String [] str = endTime.split("-");
  		endTime = str[0]+"-"+str[1]+"-"+((Integer.parseInt(str[2])-1)+"");
  		timeMap.put("startTime", startTime);
  		timeMap.put("endTime", TextUtil.addDateDay(endTime, 1));
  		return timeMap;
  	}
  	/**
  	 * 月份加多少个月
  	 * @Title: dateFormat 
  	 * @Description:  
  	 * @param @param datetime
  	 * @param @return    
  	 * @return String     
  	 * @throws
  	 */
  	 public static String addDateMonth(String datetime,int i) {  
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");  
         Date date = null;  
         try {  
             date = sdf.parse(datetime);  
         } catch (ParseException e) {  
             e.printStackTrace();  
         }  
         Calendar cl = Calendar.getInstance();  
         cl.setTime(date);  
         cl.add(Calendar.MONTH, i);  
         date = cl.getTime();  
         return sdf.format(date);  
     }  
  	 /**
  	  * 日期加多少天
  	  * @Title: dateFormat 
  	  * @Description:  
  	  * @param @param datetime
  	  * @param @return    
  	  * @return String     
  	  * @throws
  	  */
  	 public static String addDateDay(String datetime,int i) {  
  		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
  		 Date date = null;  
  		 try {  
  			 date = sdf.parse(datetime);  
  		 } catch (ParseException e) {  
  			 e.printStackTrace();  
  		 }  
  		 Calendar cl = Calendar.getInstance();  
  		 cl.setTime(date);  
  		 cl.add(Calendar.DAY_OF_MONTH, i);  
  		 date = cl.getTime();  
  		 return sdf.format(date);  
  	 }  
  	 /**
  	  * 字符串去重
  	  * @Title: removeRepeated 
  	  * @Description:  
  	  * @param @param str
  	  * @param @return    
  	  * @return String     
  	  * @throws
  	  */
  	public static String removeRepeated(String str){
  		TreeSet<String> noReapted = new TreeSet<String>();
        for (int i = 0; i < str.length(); i++){
            noReapted.add(""+str.charAt(i));
        }
        str = "";
        for(String index:noReapted){
            str += index;
        }
        return str;
    }
  	/**
  	 * 后面一个日期减去前面日期的天数
  	 * @Title: daysBetween 
  	 * @Description:  
  	 * @param @param startTime
  	 * @param @param endTime
  	 * @param @return
  	 * @return int     
  	 * @throws
  	 */
  	 public static int daysBetween(String startTime,String  endTime){    
         SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
         Date smdate = null ;
         Date bdate = null ;
		try {
			smdate=sdf.parse(startTime);  
	        bdate=sdf.parse(endTime); 
		} catch (ParseException e) {
			e.printStackTrace();
		}
         Calendar cal = Calendar.getInstance();    
         cal.setTime(smdate);    
         long time1 = cal.getTimeInMillis();                 
         cal.setTime(bdate);    
         long time2 = cal.getTimeInMillis();         
         long between_days=(time2-time1)/(1000*3600*24);  
         return Integer.parseInt(String.valueOf(between_days));           
     }  
  	/**
  	 * 是否包含异常数据
  	 * @Title: getIsIncludeExceptionData 
  	 * @Description:  
  	 * @param @param allList
  	 * @param @param isIncludeExceptionData
  	 * @param @return    
  	 * @return List<Z_Airdata>     
  	 * @throws
  	 */
  	public static List<Z_Airdata> getIsIncludeExceptionData(List<Z_Airdata> allList, String isIncludeExceptionData){
	 	//包括异常数据的所有数据
		List<Z_Airdata> zairdataListA = allList;
		//返回集合
		List<Z_Airdata> zairdataListB = new ArrayList<Z_Airdata>();
		//异常数据
		List<Z_Airdata> zairdataListC = new ArrayList<Z_Airdata>();
		//最终存放数据的list
		List<Z_Airdata> list = new ArrayList<Z_Airdata>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		list.addAll(zairdataListA);
		//找出异常数据
		for (Z_Airdata z_Airdata : zairdataListA) {
			if(z_Airdata.getCount_Set()<=0){
				String fltNum = z_Airdata.getFlt_Nbr();
				Date date = z_Airdata.getLcl_Dpt_Day();
				for (Z_Airdata z_Airdata2 : zairdataListA) {
					String fltNum2 = z_Airdata2.getFlt_Nbr();
					Date date2 = z_Airdata2.getLcl_Dpt_Day();
					if(fltNum.equals(fltNum2)&&sdf.format(date).equals(sdf.format(date2))){
						if(!zairdataListC.contains(z_Airdata2)){
							zairdataListC.add(z_Airdata2);
						}
					}
				}
			}
		}
		for (Z_Airdata z_Airdatac : zairdataListC) {
			//a就是正常数据
			zairdataListA.remove(z_Airdatac);
		}
		//判断是否包含异常数据
		if("on".equals(isIncludeExceptionData)){
			zairdataListB = list;
		}else{
			zairdataListB = zairdataListA;
		}
		return zairdataListB;
 }
  	/**
  	 * 按某个字段排序
  	 * @Title: sort 
  	 * @Description:  
  	 * @param @param targetList
  	 * @param @param sortField
  	 * @param @param sortMode    
  	 * @return void     
  	 * @throws
  	 */
  	@SuppressWarnings({ "unchecked", "rawtypes" })  
    public static List<TotalFly> sort(List<TotalFly> targetList, final String sortField, final String sortMode) {  
        Collections.sort(targetList, new Comparator() {  
            public int compare(Object obj1, Object obj2) {   
            	double retVal = 0.0;  
                try {  
                    //首字母转大写  
                    String newStr=sortField.substring(0, 1).toUpperCase()+sortField.replaceFirst("\\w","");   
                    String methodStr="get"+newStr;  
                    Method method1 = ((TotalFly)obj1).getClass().getMethod(methodStr, null);  
                    Method method2 = ((TotalFly)obj2).getClass().getMethod(methodStr, null);  
                    if (sortMode != null && "DESC".equals(sortMode)) {  
                        retVal = Double.parseDouble(method2.invoke(((TotalFly) obj2), null).toString())-(Double.parseDouble(method1.invoke(((TotalFly) obj1), null).toString())); // 倒序  
                    } else {  
                        retVal = Double.parseDouble(method2.invoke(((TotalFly) obj1), null).toString())-(Double.parseDouble(method1.invoke(((TotalFly) obj2), null).toString())); // 正序  
                    }  
                } catch (Exception e) {  
                    throw new RuntimeException();  
                }  
                return (int)retVal;  
            }  
        });  
       return  targetList;
    }  
  	@SuppressWarnings({ "unchecked", "rawtypes" })  
  	public static List<FlightAirline> sortFlightAirline(List<FlightAirline> targetList, final String sortField, final String sortMode) {  
  		Collections.sort(targetList, new Comparator() {  
  			public int compare(Object obj1, Object obj2) {   
  				double retVal = 0.0;  
  				try {  
  					//首字母转大写  
  					String newStr=sortField.substring(0, 1).toUpperCase()+sortField.replaceFirst("\\w","");   
  					String methodStr="get"+newStr;  
  					Method method1 = ((FlightAirline)obj1).getClass().getMethod(methodStr, null);  
  					Method method2 = ((FlightAirline)obj2).getClass().getMethod(methodStr, null);  
  					if (sortMode != null && "DESC".equals(sortMode)) {  
  						retVal = Double.parseDouble(method2.invoke(((FlightAirline) obj2), null).toString())-(Double.parseDouble(method1.invoke(((FlightAirline) obj1), null).toString())); // 倒序  
  					} else {  
  						retVal = Double.parseDouble(method2.invoke(((FlightAirline) obj1), null).toString())-(Double.parseDouble(method1.invoke(((FlightAirline) obj2), null).toString())); // 正序  
  					}  
  				} catch (Exception e) {  
  					throw new RuntimeException();  
  				}  
  				return (int)retVal;  
  			}  
  		});  
  		return  targetList;
  	}  
  	@SuppressWarnings({ "unchecked", "rawtypes" })  
  	public static List<ClassRanking> sortClassRanking(List<ClassRanking> targetList, final String sortField, final String sortMode) {  
  		Collections.sort(targetList, new Comparator() {  
  			public int compare(Object obj1, Object obj2) {   
  				double retVal = 0.0;  
  				try {  
  					//首字母转大写  
  					String newStr=sortField.substring(0, 1).toUpperCase()+sortField.replaceFirst("\\w","");   
  					String methodStr="get"+newStr;  
  					Method method1 = ((ClassRanking)obj1).getClass().getMethod(methodStr, null);  
  					Method method2 = ((ClassRanking)obj2).getClass().getMethod(methodStr, null);  
  					if (sortMode != null && "DESC".equals(sortMode)) {  
  						retVal = Double.parseDouble(method2.invoke(((ClassRanking) obj2), null).toString())-(Double.parseDouble(method1.invoke(((ClassRanking) obj1), null).toString())); // 倒序  
  					} else {  
  						retVal = Double.parseDouble(method2.invoke(((ClassRanking) obj1), null).toString())-(Double.parseDouble(method1.invoke(((ClassRanking) obj2), null).toString())); // 正序  
  					}  
  				} catch (Exception e) {  
  					throw new RuntimeException();  
  				}  
  				return (int)retVal;  
  			}  
  		});  
  		if(targetList.size()>10){
  			return  targetList.subList(0, 10);
  		}else{
  			return targetList;
  		}
  	}  
  	 public static List<Map<String,Object>> listSort(List<Map<String,Object>> resultList) throws Exception{  
         Collections.sort(resultList,new Comparator<Map<String,Object>>() {  
	          public int compare(Map<String, Object> o1,Map<String, Object> o2) {  
	        	  try {  
		               Integer s1 = Integer.parseInt((String)o1.get("key")) ;  
		               Integer s2 = Integer.parseInt((String)o2.get("key"));  
			           if(s1>s2) {  
			            return 1;  
			           }else if(s1==s2){
			        	  return 0;  
			           }else{  
			            return -1;  
			           }  
	        	  }catch (Exception e) {
	        		  throw new RuntimeException();  
				}
	          }  
         });  
         return resultList;
    }  
  	
  	/**
  	 * 航班号配对
  	 * @Title: getHbhLH 
  	 * @Description:  
  	 * @param @param list
  	 * @param @return    
  	 * @return List<String>     
  	 * @throws
  	 */
  	public static List<String> getHbhLH(List<String> list) {  
  		List<String> retListTemp = new ArrayList<String>();
  		List<String> retList = new ArrayList<String>();
		String tempFlyNum = "";
		for (String str : list) {
			if(str.length()==6&&TextUtil.isNum(str.substring(5, 6))){
				String firststr = str.substring(0, 2);
				int lasttwostr = Integer.parseInt(str.substring(2, 5));
				int laststr = Integer.parseInt(str.substring(5, 6));
				String pdStr = "";
				for (String str2 : list) {
					if(laststr%2==0){
						if(laststr==0){
							pdStr =firststr + (lasttwostr-1) + "9";
						}else{
							pdStr = firststr +lasttwostr+  (laststr-1);
						}
					}else{
						if(laststr==9){
							pdStr =firststr + (lasttwostr+1) + "0";
						}else{
							pdStr = firststr +lasttwostr+  (laststr+1);
						}
					}
					if(pdStr.equals(str2)){
						tempFlyNum = str + "/" + str2;
						if(!retListTemp.contains(tempFlyNum)){
							retListTemp.add(tempFlyNum);
						}
					}
				}
			}
		}
		for (String str : retListTemp) {
			if(str.length()>6&&TextUtil.isNum(str.substring(5, 6))){
				if((Integer.parseInt(str.substring(5, 6))%2)==1){
					retList.add(str);
				}
			}
		}
	  	return retList;
  	}
  	/**
  	 * 航班号字母转义
  	 * @Title: HbhCharater 
  	 * @Description:  
  	 * @param @param numnew
  	 * @param @return    
  	 * @return int     
  	 * @throws
  	 */
  	public static int HbhCharater(String numnew){
		int lastH = 0;
		if("Z".equals(numnew)){
			lastH = 0;
		}else if("Y".equals(numnew)){
			lastH = 1;
		}else if("X".equals(numnew)){
			lastH = 2;
		}else if("W".equals(numnew)){
			lastH = 3;
		}else if("V".equals(numnew)){
			lastH = 4;
		}else if("U".equals(numnew)){
			lastH = 5;
		}else if("T".equals(numnew)){
			lastH = 6;
		}else if("S".equals(numnew)){
			lastH = 7;
		}else if("R".equals(numnew)){
			lastH = 8;
		}else if("Q".equals(numnew)){
			lastH = 9;
		}else  
		lastH = Integer.parseInt(numnew);
		return lastH;
	}
  	/**
  	 * 根据航司公布的折扣,将每个舱位中的人数取出,放进集合中
  	 * @param z_Airdata
  	 * @param airdiscounts
  	 * @return
  	 */
	public static List<Airdiscount> getAirdiscounts(Z_Airdata z_Airdata,List<Airdiscount> airdiscounts) {
		List<Airdiscount> airdiscounts2 = new ArrayList<Airdiscount>();
		for (Airdiscount airdiscount : airdiscounts) {
			Airdiscount airdiscount2 = new Airdiscount();
			if(!TextUtil.isEmpty(airdiscount.getDct_Ppt())){
				Double valueOf = Double.valueOf(airdiscount.getDct_Ppt());
				if(valueOf==100){
					int ful_Pce_Ppt = z_Airdata.getFul_Pce_Ppt(); // 全价
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(ful_Pce_Ppt+"");
				}else if(valueOf==90){
					int nne_Dnt_Ppt = z_Airdata.getNne_Dnt_Ppt(); // 9折
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(nne_Dnt_Ppt+"");
				}else if(valueOf==85){
					int eht_Five_Dnt_Ppt = z_Airdata.getEht_Five_Dnt_Ppt(); // 8.5折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(eht_Five_Dnt_Ppt+"");
				}else if(valueOf==80){
					int eht_Dnt_Ppt = z_Airdata.getEht_Dnt_Ppt(); // 8折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(eht_Dnt_Ppt+"");
				}else if(valueOf==75){
					int sen_Five_Dnt_Ppt = z_Airdata.getSen_Five_Dnt_Ppt(); // 7.5折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(sen_Five_Dnt_Ppt+"");
				}else if(valueOf==70){
					int sen_Dnt_Ppt = z_Airdata.getSen_Dnt_Ppt(); // 7折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(sen_Dnt_Ppt+"");
				}else if(valueOf==65){
					int six_Five_Dnt_Ppt = z_Airdata.getSix_Five_Dnt_Ppt(); // 6.5折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(six_Five_Dnt_Ppt+"");
				}else if(valueOf==60){
					int six_Dnt_Ppt = z_Airdata.getSix_Dnt_Ppt(); // 6折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(six_Dnt_Ppt+"");
				}else if(valueOf==55){
					int fve_Fve_Dnt_Ppt = z_Airdata.getFve_Fve_Dnt_Ppt(); // 5.5折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(fve_Fve_Dnt_Ppt+"");
				}else if(valueOf==50){
					int fve_Dnt_Ppt = z_Airdata.getFve_Dnt_Ppt(); // 5折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(fve_Dnt_Ppt+"");
				}else if(valueOf==45){
					int fur_Fve_Dnt_Ppt = z_Airdata.getFur_Fve_Dnt_Ppt(); // 4.5折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(fur_Fve_Dnt_Ppt+"");
				}else if(valueOf==40){
					int fur_Dnt_Ppt = z_Airdata.getFur_Dnt_Ppt(); // 4折比例
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(fur_Dnt_Ppt+"");
				}else if(valueOf==35){
					int thr_Fve_Dnt_Ppt = z_Airdata.getThr_Fve_Dnt_Ppt(); // 35%
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(thr_Fve_Dnt_Ppt+"");
				}else if(valueOf==30){
					int thr_Dnt_Ppt = z_Airdata.getThr_Dnt_Ppt(); // 30%
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(thr_Dnt_Ppt+"");
				}else if(valueOf==25){
					int two_Fve_Dnt_Ppt = z_Airdata.getTwo_Fve_Dnt_Ppt(); // 25%
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(two_Fve_Dnt_Ppt+"");
				}else if(valueOf==20){
					int two_Dnt_Ppt = z_Airdata.getTwo_Dnt_Ppt(); // 20%         
					airdiscount2.setDct_Ppt(valueOf.intValue()+"");
					airdiscount2.setDct_Chr(airdiscount.getDct_Chr());
					airdiscount2.setDct_Pge(two_Dnt_Ppt+"");
				}
			}
			if(!TextUtil.isEmpty(airdiscount2.getDct_Chr())){
				airdiscounts2.add(airdiscount2);
			}
		}
		return airdiscounts2;
	}
	/**
	 * 得到执行班次
	 * @Title: getExecClass 
	 * @Description:  
	 * @param @param list 只能传入一个航班对或者一个航班的list
	 * @param @return    
	 * @return String     
	 * @throws
	 */
	public static double getExecClass(List<Z_Airdata> ListAll) {
		if(ListAll==null||ListAll.size()<=0){
			return 0.0;
		}
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<String> days = new ArrayList<String>();
		for (Z_Airdata z_Airdata : ListAll) {
			String day = sdf.format(z_Airdata.getLcl_Dpt_Day());
			if(!days.contains(day)){
				days.add(day);
			}
		}
		return (double)days.size();
	}
//	public static double getExecClass(List<Z_Airdata> ListAll) {
//		if(ListAll==null||ListAll.size()<=0){
//			return 0.0;
//		}
//		Map<String,List<String>>  eclassmap = new HashMap<String,List<String>>();
//		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		for (Z_Airdata z_Airdata : ListAll) {
//			String fltNbr = z_Airdata.getFlt_Nbr();
//			eclassmap.put(fltNbr,new ArrayList<String>());
//		}
//		for (Z_Airdata z_Airdata : ListAll) {
//			String fltNbr = z_Airdata.getFlt_Nbr();
//			String day = sdf.format(z_Airdata.getLcl_Dpt_Day());
//			List<String> days = eclassmap.get(fltNbr);
//			if(!days.contains(day)){
//				days.add(day);
//			}
//			eclassmap.put(fltNbr, days);
//		}
//		Set<Entry<String, List<String>>> sett =  eclassmap.entrySet();
//		int allDays = 0;
//		int index =0;
//		for (Entry<String, List<String>> entry : sett) {
//			allDays = allDays + entry.getValue().size();
//			index++;
//		}
//		return (double)allDays/(double)index;
//	}
	
	public static void main(String [] args){
		try {
			Connection connect = Jsoup.connect("http://stocks.sina.cn/sh/?code=sh603822&vt=4");
//			Connection connect = Jsoup.connect("http://stocks.sina.cn/sh/?code=sz000923&vt=4");
			Document doc = connect.timeout(100000).get();
			Element body = doc.body();
			String text = body.text();
//			System.out.println(text);
			System.out.println(text.substring(84, 90));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
