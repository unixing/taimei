package org.ldd.ssm.crm.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.ldd.ssm.crm.domain.Abnormal;
import org.ldd.ssm.crm.domain.AirlineDynameicGraphics;
import org.ldd.ssm.crm.domain.Yesterday_ZD;
import org.ldd.ssm.crm.mapper.AirlineDynameicMapper;
import org.ldd.ssm.crm.query.HomePageQuery;
import org.ldd.ssm.crm.query.SortQuery;
import org.ldd.ssm.crm.service.IAirlineDynameicService;
import org.ldd.ssm.crm.utils.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class AirlineDynameicServiceImpl implements IAirlineDynameicService {
	@Autowired
	private AirlineDynameicMapper airlineDynameicMapper;
	Logger log = Logger.getLogger(AirlineDynameicServiceImpl.class);
	
	@Override
	public Map<String,Object> getAirline_dynameic_list(String date) {
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			List<List<Yesterday_ZD>> list = new ArrayList<List<Yesterday_ZD>>();
			String getcompanyItia = UserContext.getcompanyItia();
			if(date==null||"".equals(date)){
				String city = UserContext.getCompanyName();
				String lastDate = airlineDynameicMapper.getNewestDate(city, "in");
				if(lastDate!=null&&!"".equals(lastDate)){
					String month = lastDate.substring(0,lastDate.length()-3);
					List<String> dates = airlineDynameicMapper.getDateList(city, month, "in");
					map.put("indates", dates);
					List<Yesterday_ZD> getAirline_dynameic_list_j = airlineDynameicMapper.getGetAirline_dynameic_list_j(getcompanyItia,lastDate);
					if(getAirline_dynameic_list_j!=null&&getAirline_dynameic_list_j.size()>0){
						for (Yesterday_ZD yesterday_ZD : getAirline_dynameic_list_j) {
							if("-0".equals(yesterday_ZD.getRemark())){
								yesterday_ZD.setRemark(null);
							}
							if(!yesterday_ZD.getState().contains("取消")&&!yesterday_ZD.getState().contains("延误")){
								String regEx = "^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$";
								Pattern p = Pattern.compile(regEx);
								boolean flag = p.matcher(yesterday_ZD.getPlan_c()).matches()&&p.matcher(yesterday_ZD.getActual_c()).matches();//验证时间格式
								if(!flag){
									yesterday_ZD.setState("正常");
									continue;
								}
								if(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "").length()>5){
									continue;
								}
								if(!p.matcher(yesterday_ZD.getPlan_q()).matches()){
									yesterday_ZD.setPlan_q("--");
								}
								if(!p.matcher(yesterday_ZD.getActual_q()).matches()){
									yesterday_ZD.setActual_q("--");
								}
								String plan_c = yesterday_ZD.getPlan_c().replaceAll("[^0-9:]", "");
								String[] split = plan_c.split(":");
								Integer valueOf0 = Integer.valueOf(split[0]);
								Integer valueOf1 = Integer.valueOf(split[1]);
								int time0 = (valueOf0*60*60*1000)+(valueOf1*60*1000);
								
								String actual_c = yesterday_ZD.getActual_c().replaceAll("[^0-9:]", "");
								String[] split2 = actual_c.split(":");
								Integer value0 = Integer.valueOf(split2[0]);
								Integer value1 = Integer.valueOf(split2[0]);
								int time1 = (value0*60*60*1000)+(value1*60*1000);
								if(value0==0 && time1<time0){
									time1 = time1+86400000;
								}
								if(time1-time0 > 1800000){//当实际到达时间比计划时间晚30分钟时，航班动态为延误
									yesterday_ZD.setState("延误");
								}else{
									yesterday_ZD.setState("正常");
								}
							}
						}
					}
					list.add(getAirline_dynameic_list_j);
				}else{
					list.add(new ArrayList<Yesterday_ZD>());
				}
				lastDate = airlineDynameicMapper.getNewestDate(city, "out");
				if(lastDate!=null&&!"".equals(lastDate)){
					String month = lastDate.substring(0,lastDate.length()-3);
					List<String> dates = airlineDynameicMapper.getDateList(city, month, "out");
					map.put("outdates", dates);
					List<Yesterday_ZD> getAirline_dynameic_list_c = airlineDynameicMapper.getGetAirline_dynameic_list_c(getcompanyItia,lastDate);
					if(getAirline_dynameic_list_c!=null&&getAirline_dynameic_list_c.size()>0){
						for (Yesterday_ZD yesterday_ZD : getAirline_dynameic_list_c) {
							if("-0".equals(yesterday_ZD.getRemark())){
								yesterday_ZD.setRemark(null);
							}
							if(!yesterday_ZD.getState().contains("取消")&&!yesterday_ZD.getState().contains("延误")){
								String regEx = "^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$";
								Pattern p = Pattern.compile(regEx);
								boolean flag = p.matcher(yesterday_ZD.getPlan_c()).matches()&&p.matcher(yesterday_ZD.getActual_c()).matches();//验证时间格式
								if(!flag){
									yesterday_ZD.setState("正常");
									continue;
								}
								if(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "").length()>5){
									continue;
								}
								if(!p.matcher(yesterday_ZD.getPlan_q()).matches()){
									yesterday_ZD.setPlan_q("--");
								}
								if(!p.matcher(yesterday_ZD.getActual_q()).matches()){
									yesterday_ZD.setActual_q("--");
								}
								String plan_c = yesterday_ZD.getPlan_c().replaceAll("[^0-9:]", "");
								String[] split = plan_c.split(":");
								Integer valueOf0 = Integer.valueOf(split[0]);
								Integer valueOf1 = Integer.valueOf(split[1]);
								int time0 = (valueOf0*60*60*1000)+(valueOf1*60*1000);
								
								String actual_c = yesterday_ZD.getActual_c().replaceAll("[^0-9:]", "");
								String[] split2 = actual_c.split(":");
								Integer value0 = Integer.valueOf(split2[0]);
								Integer value1 = Integer.valueOf(split2[0]);
								int time1 = (value0*60*60*1000)+(value1*60*1000);
								if(value0==0 && time1<time0){
									time1 = time1+86400000;
								}
								if(time1-time0 > 1800000){//当实际到达时间比计划时间晚30分钟时，航班动态为延误
									yesterday_ZD.setState("延误");
								}else{
									yesterday_ZD.setState("正常");
								}
							}
						}
					}
					list.add(getAirline_dynameic_list_c);
				}else{
					list.add(new ArrayList<Yesterday_ZD>());
				}
				map.put("list", list);
			}else{
				List<Yesterday_ZD> getAirline_dynameic_list_j = airlineDynameicMapper.getGetAirline_dynameic_list_j(getcompanyItia,date);
				if(getAirline_dynameic_list_j!=null&&getAirline_dynameic_list_j.size()>0){
					for (Yesterday_ZD yesterday_ZD : getAirline_dynameic_list_j) {
						if("-0".equals(yesterday_ZD.getRemark())){
							yesterday_ZD.setRemark(null);
						}
						if(!yesterday_ZD.getState().contains("取消")&&!yesterday_ZD.getState().contains("延误")){
							String regEx = "^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$";
							Pattern p = Pattern.compile(regEx);
							boolean flag = p.matcher(yesterday_ZD.getPlan_c()).matches()&&p.matcher(yesterday_ZD.getActual_c()).matches();//验证时间格式
							if(!flag){
								yesterday_ZD.setState("正常");
								continue;
							}
							if(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "").length()>5){
								continue;
							}
							if(!p.matcher(yesterday_ZD.getPlan_q()).matches()){
								yesterday_ZD.setPlan_q("--");
							}
							if(!p.matcher(yesterday_ZD.getActual_q()).matches()){
								yesterday_ZD.setActual_q("--");
							}
							String plan_c = yesterday_ZD.getPlan_c().replaceAll("[^0-9:]", "");
							String[] split = plan_c.split(":");
							Integer valueOf0 = Integer.valueOf(split[0]);
							Integer valueOf1 = Integer.valueOf(split[1]);
							int time0 = (valueOf0*60*60*1000)+(valueOf1*60*1000);
							
							String actual_c = yesterday_ZD.getActual_c().replaceAll("[^0-9:]", "");
							String[] split2 = actual_c.split(":");
							Integer value0 = Integer.valueOf(split2[0]);
							Integer value1 = Integer.valueOf(split2[0]);
							int time1 = (value0*60*60*1000)+(value1*60*1000);
							if(value0==0 && time1<time0){
								time1 = time1+86400000;
							}
							if(time1-time0 > 1800000){//当实际到达时间比计划时间晚30分钟时，航班动态为延误
								yesterday_ZD.setState("延误");
							}else{
								yesterday_ZD.setState("正常");
							}
						}
					}
				}
				List<Yesterday_ZD> getAirline_dynameic_list_c = airlineDynameicMapper.getGetAirline_dynameic_list_c(getcompanyItia,date);
				if(getAirline_dynameic_list_c!=null&&getAirline_dynameic_list_c.size()>0){
					for (Yesterday_ZD yesterday_ZD : getAirline_dynameic_list_c) {
						if("-0".equals(yesterday_ZD.getRemark())){
							yesterday_ZD.setRemark(null);
						}
						if(!yesterday_ZD.getState().contains("取消")&&!yesterday_ZD.getState().contains("延误")){
							String regEx = "^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$";
							Pattern p = Pattern.compile(regEx);
							boolean flag = p.matcher(yesterday_ZD.getPlan_c()).matches()&&p.matcher(yesterday_ZD.getActual_c()).matches();//验证时间格式
							if(!flag){
								yesterday_ZD.setState("正常");
								continue;
							}
							if(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "").length()>5){
								continue;
							}
							if(!p.matcher(yesterday_ZD.getPlan_q()).matches()){
								yesterday_ZD.setPlan_q("--");
							}
							if(!p.matcher(yesterday_ZD.getActual_q()).matches()){
								yesterday_ZD.setActual_q("--");
							}
							String plan_c = yesterday_ZD.getPlan_c().replaceAll("[^0-9:]", "");
							String[] split = plan_c.split(":");
							Integer valueOf0 = Integer.valueOf(split[0]);
							Integer valueOf1 = Integer.valueOf(split[1]);
							int time0 = (valueOf0*60*60*1000)+(valueOf1*60*1000);
							
							String actual_c = yesterday_ZD.getActual_c().replaceAll("[^0-9:]", "");
							String[] split2 = actual_c.split(":");
							Integer value0 = Integer.valueOf(split2[0]);
							Integer value1 = Integer.valueOf(split2[0]);
							int time1 = (value0*60*60*1000)+(value1*60*1000);
							if(value0==0 && time1<time0){
								time1 = time1+86400000;
							}
							if(time1-time0 > 1800000){//当实际到达时间比计划时间晚30分钟时，航班动态为延误
								yesterday_ZD.setState("延误");
							}else{
								yesterday_ZD.setState("正常");
							}
						}
					}
				}
				list.add(getAirline_dynameic_list_j);
				list.add(getAirline_dynameic_list_c);
				map.put("list", list);
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			e.printStackTrace();
			return map;
		}
		return map;
	}

	@Override
	public AirlineDynameicGraphics airline_dynameic_graphics(String date) {
		AirlineDynameicGraphics airlineDynameicGraphics = new AirlineDynameicGraphics();
		String getcompanyItia = UserContext.getcompanyItia();
		SortQuery query = new SortQuery();
		query.setItia(getcompanyItia);
		if(date==null||"".equals(date)){
			String city = UserContext.getCompanyName();
			date = airlineDynameicMapper.getNewestDate(city, null);
			if(date==null||"".equals(date)){
				airlineDynameicGraphics.setMonth_zd(0+"");
				airlineDynameicGraphics.setDelay_cls(0+"");
				airlineDynameicGraphics.setCancel_cls(0+"");
				airlineDynameicGraphics.setNormal_cls(0+"");
				Abnormal[] exec = {new Abnormal("天气",0),new Abnormal("航空公司",0),new Abnormal("流量",0),new Abnormal("军事活动",0),
						new Abnormal("空管",0),new Abnormal("机场",0),new Abnormal("联检",0),new Abnormal("油料",0),
						new Abnormal("离港系统",0),new Abnormal("旅客",0),new Abnormal("公共安全",0)};
				airlineDynameicGraphics.setExec(exec);
				return airlineDynameicGraphics;
			}else{
				date = date.substring(0,date.length()-3);//获取月份
				String year = date.substring(0,4);
				List<String> months = airlineDynameicMapper.getMonthList(city, year);
				airlineDynameicGraphics.setMonths(months);
			}
		}
		query.setDate(date);
		List<Yesterday_ZD> zds = airlineDynameicMapper.getGetAirline_dynameic_list_month(query);
		BigDecimal month_zd = new BigDecimal(0);
		BigDecimal delay_cls = new BigDecimal(0);
		BigDecimal cancel_cls = new BigDecimal(0);
		BigDecimal normal_cls = new BigDecimal(0);
		BigDecimal bigDecimal = new BigDecimal(1);
		BigDecimal zd_cls = new BigDecimal(1);
		for (Yesterday_ZD yesterday_ZD : zds) {
			try {
				if(yesterday_ZD.getState()!=null&&(yesterday_ZD.getState().indexOf("取消")>-1||"返航".equals(yesterday_ZD.getState()))){
					cancel_cls = cancel_cls.add(bigDecimal);
					zd_cls = zd_cls.add(bigDecimal);//
				}else if("到达".equals(yesterday_ZD.getState())){
					zd_cls = zd_cls.add(bigDecimal);//
					String regEx = "^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$";
					Pattern p = Pattern.compile(regEx);
					boolean flag = p.matcher(yesterday_ZD.getPlan_c()).matches()&&p.matcher(yesterday_ZD.getActual_c()).matches();//验证时间格式
					if(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "").length()>5||!flag){
						continue;
					}
					String regex = "^1[0-9]{2}|[1-9][0-9]\\.[0-9]{2}$";
					if(Pattern.matches(regex, yesterday_ZD.getZd_rate())){//当准点率中有多个小数点时验证不通过
						continue;
					}
					String plan_c = yesterday_ZD.getPlan_c().replaceAll("[^0-9:]", "");
					String[] split = plan_c.split(":");
					Integer valueOf0 = Integer.valueOf(split[0]);
					Integer valueOf1 = Integer.valueOf(split[1]);
					int time0 = (valueOf0*60*60*1000)+(valueOf1*60*1000);
					String actual_c = yesterday_ZD.getActual_c().replaceAll("[^0-9:]", "");
					String[] split2 = actual_c.split(":");
					Integer value0 = Integer.valueOf(split2[0]);
					Integer value1 = Integer.valueOf(split2[0]);
					int time1 = (value0*60*60*1000)+(value1*60*1000);
					if(value0==0 && time1<time0){
						time1 = time1+86400000;
					}
					if(time1-time0 > 1800000){
						delay_cls = delay_cls.add(bigDecimal);
					}else{
						normal_cls = normal_cls.add(bigDecimal);
					}
				}else{
					delay_cls = delay_cls.add(bigDecimal);
				}
				month_zd = month_zd.add(new BigDecimal(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "")));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
//		airlineDynameicGraphics.setMonth_zd((normal_cls.equals(new BigDecimal(0))?0:month_zd.divide(normal_cls,0,BigDecimal.ROUND_HALF_UP))+"");
		airlineDynameicGraphics.setMonth_zd((zd_cls.equals(new BigDecimal(0))?0:month_zd.divide(zd_cls,0,BigDecimal.ROUND_HALF_UP))+"");
		airlineDynameicGraphics.setDelay_cls(delay_cls+"");
		airlineDynameicGraphics.setCancel_cls(cancel_cls+"");
		airlineDynameicGraphics.setNormal_cls(normal_cls+"");
		
//		List<Integer> exec = new ArrayList<Integer>();
		
		//图形   5个柱形  分别是 天气原因,机器故障,航空管制,流量控制,突发事件
		String[] titles = new String[]{"天气","航空公司","流量","军事活动","空管","机场","联检","油料","离港系统","旅客","公共安全"};
		int tq = 0;
		int hkgs = 0;
		int ll = 0;
		int jshd = 0;
		int kg = 0;
		int jc = 0;
		int lj = 0;
		int yl = 0;
		int lgxt = 0;
		int lk = 0;
		int ggaq = 0;
		int[] vals = new int[]{tq,hkgs,ll,jshd,kg,jc,lj,yl,lgxt,lk,ggaq};
		for (Yesterday_ZD zd : zds) {
			if(!zd.getRemark().equals("-0")&&zd.getRemark()!=null&&!"".equals(zd.getRemark())){
				String[] split = zd.getRemark().split("\\|");
				for (String string : split) {
					for(int i=0;i<titles.length;i++){
						if(string.equals(titles[i])){
							vals[i] += 1;
						}
					}
				}
			}
		}
		Abnormal[] exec = {new Abnormal("天气",vals[0]),new Abnormal("航空公司",vals[1]),new Abnormal("流量",vals[2]),new Abnormal("军事活动",vals[3]),
				new Abnormal("空管",vals[4]),new Abnormal("机场",vals[5]),new Abnormal("联检",vals[6]),new Abnormal("油料",vals[7]),
				new Abnormal("离港系统",vals[8]),new Abnormal("旅客",vals[9]),new Abnormal("公共安全",vals[10])};
		Arrays.sort(exec,new MyComparator());
		airlineDynameicGraphics.setExec(exec);
		return airlineDynameicGraphics;
	}
	class  MyComparator implements Comparator{
		@Override
		public int compare(Object o1, Object o2) {
			Abnormal ab1 = (Abnormal) o1;
			Abnormal ab2 = (Abnormal) o2;
			if(ab1.getVal() != ab2.getVal())
	            return ab1.getVal()>ab2.getVal()? -1:1;
	        else
	            return 0;
		}
		
	}
	@Override
	public void airline_dynameic_save(String index, String sp) {
//		if(!TextUtil.isEmpty(sp)){
//			sp = sp.substring(0, sp.length()-1);
//		}else{
//			sp = "-0";
//		}
		airlineDynameicMapper.airline_dynameic_save(index,sp);
	}
	@Override
	public List<Yesterday_ZD> getAirline_dynameic_list_in(String date,
			String field,String sortType) {
		String getcompanyItia = UserContext.getcompanyItia();
		SortQuery query = new SortQuery();
		query.setItia(getcompanyItia);
		query.setDate(date);
		query.setField(field);
		query.setSortWay(sortType);
		List<Yesterday_ZD> getAirline_dynameic_list_j = airlineDynameicMapper.getGetAirline_dynameic_list_in(query);
		if(getAirline_dynameic_list_j!=null&&getAirline_dynameic_list_j.size()>0){
			for (Yesterday_ZD yesterday_ZD : getAirline_dynameic_list_j) {
				if("到达".equals(yesterday_ZD.getState())){
					String regEx = "^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$";
					Pattern p = Pattern.compile(regEx);
					boolean flag = p.matcher(yesterday_ZD.getPlan_c()).matches()&&p.matcher(yesterday_ZD.getActual_c()).matches();//验证时间格式
					if(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "").length()>5||!flag){
						continue;
					}
					if(!p.matcher(yesterday_ZD.getPlan_q()).matches()){
						yesterday_ZD.setPlan_q("--");
					}
					if(!p.matcher(yesterday_ZD.getActual_q()).matches()){
						yesterday_ZD.setActual_q("--");
					}
					String plan_c = yesterday_ZD.getPlan_c().replaceAll("[^0-9:]", "");
					String[] split = plan_c.split(":");
					Integer valueOf0 = Integer.valueOf(split[0]);
					Integer valueOf1 = Integer.valueOf(split[1]);
					int time0 = (valueOf0*60*60*1000)+(valueOf1*60*1000);
					
					String actual_c = yesterday_ZD.getActual_c().replaceAll("[^0-9:]", "");
					String[] split2 = actual_c.split(":");
					Integer value0 = Integer.valueOf(split2[0]);
					Integer value1 = Integer.valueOf(split2[0]);
					int time1 = (value0*60*60*1000)+(value1*60*1000);
					if(value0==0 && time1<time0){
						time1 = time1+86400000;
					}
					if(time1-time0 > 1800000){//当实际到达时间比计划时间晚30分钟时，航班动态为延误
						yesterday_ZD.setState("延误");
					}else{
						yesterday_ZD.setState("正常");
					}
				}
				if("-0".equals(yesterday_ZD.getRemark())){
					yesterday_ZD.setRemark(null);
				}
			}
		}
		return getAirline_dynameic_list_j;
	}

	@Override
	public List<Yesterday_ZD> getAirline_dynameic_list_out(String date,
			String field,String sortType) {
		String getcompanyItia = UserContext.getcompanyItia();
		SortQuery query = new SortQuery();
		query.setItia(getcompanyItia);
		query.setDate(date);
		query.setField(field);
		query.setSortWay(sortType);
		List<Yesterday_ZD> getAirline_dynameic_list_c = airlineDynameicMapper.getGetAirline_dynameic_list_out(query);
		if(getAirline_dynameic_list_c!=null&&getAirline_dynameic_list_c.size()>0){
			for (Yesterday_ZD yesterday_ZD : getAirline_dynameic_list_c) {
				if("到达".equals(yesterday_ZD.getState())){
					String regEx = "^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$";
					Pattern p = Pattern.compile(regEx);
					boolean flag = p.matcher(yesterday_ZD.getPlan_c()).matches()&&p.matcher(yesterday_ZD.getActual_c()).matches();//验证时间格式
					if(yesterday_ZD.getZd_rate().replaceAll("[^0-9.]", "").length()>5||!flag){
						continue;
					}
					if(!p.matcher(yesterday_ZD.getPlan_q()).matches()){
						yesterday_ZD.setPlan_q("--");
					}
					if(!p.matcher(yesterday_ZD.getActual_q()).matches()){
						yesterday_ZD.setActual_q("--");
					}
					String plan_c = yesterday_ZD.getPlan_c().replaceAll("[^0-9:]", "");
					String[] split = plan_c.split(":");
					Integer valueOf0 = Integer.valueOf(split[0]);
					Integer valueOf1 = Integer.valueOf(split[1]);
					int time0 = (valueOf0*60*60*1000)+(valueOf1*60*1000);
					
					String actual_c = yesterday_ZD.getActual_c().replaceAll("[^0-9:]", "");
					String[] split2 = actual_c.split(":");
					Integer value0 = Integer.valueOf(split2[0]);
					Integer value1 = Integer.valueOf(split2[0]);
					int time1 = (value0*60*60*1000)+(value1*60*1000);
					if(value0==0 && time1<time0){
						time1 = time1+86400000;
					}
					if(time1-time0 > 1800000){//当实际到达时间比计划时间晚30分钟时，航班动态为延误
						yesterday_ZD.setState("延误");
					}else{
						yesterday_ZD.setState("正常");
					}
				}
				if("-0".equals(yesterday_ZD.getRemark())){
					yesterday_ZD.setRemark(null);
				}
			}
		}
		return getAirline_dynameic_list_c;
	}

	@Override
	public String getAirportIthad(HomePageQuery query) {
		String ithad = "";
		try {
			ithad = airlineDynameicMapper.getAirportIthad(query);
			if(ithad==null){
				ithad = "0.00%";
			}else{
				ithad += "%";
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			return ithad;
		}
		return ithad;
	}

	@Override
	public List<String> getDateList(String city,String month,String inout) {
		List<String> list = null;
		if(city==null||"".equals(city)){
			log.debug("getDateList:city is invalid");
			return list;
		}
		try {
			if(month==null||"".equals(month)){
				String date = airlineDynameicMapper.getNewestDate(city,inout);
				month = date.substring(0,date.length()-3);
				if(month!=null&&!"".equals(month)){
					list = airlineDynameicMapper.getDateList(city,month,inout);
				}
			}else{
				list = airlineDynameicMapper.getDateList(city,month,inout);
			}
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			e.printStackTrace();
			return list;
		}
		return list;
	}

	@Override
	public List<String> getMonthList(String year) {
		List<String> months = null;
		if(year==null||"".equals(year)){
			log.debug("getMonthList:year is invalid");
			return months;
		}
		try {
			String city = UserContext.getCompanyName();
			months = airlineDynameicMapper.getMonthList(city, year);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			e.printStackTrace();
			return months;
		}
		return months;
	}
}