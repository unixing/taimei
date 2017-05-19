package org.ldd.ssm.crm.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.runner.RunWith;
import org.ldd.ssm.crm.exception.RuleException;
import org.ldd.ssm.crm.utils.DOWDataUtils;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestThreadDemo {
	public static void main(String[] args) throws ParseException {
		try {
//			Calendar c = Calendar.getInstance();
//			//遍历集合中的数据,判断是星期几,如果是按照星期按照星期给添加数量
//			c.setTime(new Date());
			
//			boolean contains = ValidationDataUtils.isContains("CTUXIC", "XIU");
//			double j = 100;
//			BigDecimal b1 = new BigDecimal(100.0);
//			BigDecimal b2 = new BigDecimal(30);
//			BigDecimal divide3 = b1.divide(b2);
			//use getInstance() method to get object of java Calendar class 
			Calendar cal = Calendar.getInstance(); 
			//use getTime() method of Calendar class to get date and time 
			cal.setTime(new Date());
			int actualMaximum = cal.getActualMaximum(Calendar.DATE);
			int numbertime = DOWDataUtils.getNumbertime("2015", "08");
			
			System.exit(0);
		} catch (Exception e) {
		}
	}
	public static void testParttern(){
		//表达式的功能：验证必须为数字（整数或小数）
		String pattern = "[0-9]+(.[0-9]+)?";
		//对()的用法总结：将()中的表达式作为一个整体进行处理，必须满足他的整体结构才可以。
		//(.[0-9]+)? ：表示()中的整体出现一次或一次也不出现
		Pattern p = Pattern.compile(pattern);
		Matcher m = p.matcher("-2.22");
		boolean b = m.matches();
		if(b){
		}
	}
	public static int isNumber(String str) throws Exception{
		try {
			if(str.isEmpty()){
				return 0;
			}
			return Integer.parseInt(str);
		} catch (Exception e) {
			throw new RuleException("数值验证错误");
		}
		
	}
	
	public static boolean validationVoyageLength(String str)
			throws Exception {
		// 去除特殊字符
		String replaceAll = str.replaceAll("\\s*|\t|\r|\n", "");
		if (replaceAll.length() != 6) {
			throw new Exception("航程长度异常");
		}
			return true;
	}
	
	
	public static boolean isDate(String date) throws Exception {
		// 指定日期格式为四位年/两位月份/两位日期，注意yyyy/MM/dd区分大小写；
			if (date.contains("/")) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
				// 设置lenient为false.
				// 否则SimpleDateFormat会比较宽松地验证日期，比如2007/02/29会被接受，并转换成2007/03/01
				format.setLenient(false);
				Date parse = format.parse(date);
				if(parse instanceof Date){
					return true;
				}
			} else if (date.contains("-")) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				// 设置lenient为false.
				// 否则SimpleDateFormat会比较宽松地验证日期，比如2007-02-29会被接受，并转换成2007/03/01
				format.setLenient(false);
				Date parse = format.parse(date);
				if(parse instanceof Date){
					return true;
				}
			}
		return false;
	}
}
