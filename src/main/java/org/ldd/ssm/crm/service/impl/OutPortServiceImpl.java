package org.ldd.ssm.crm.service.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ldd.ssm.crm.domain.ClassRanking;
import org.ldd.ssm.crm.domain.DOW;
import org.ldd.ssm.crm.domain.EvenPort;
import org.ldd.ssm.crm.domain.OutPort;
import org.ldd.ssm.crm.domain.Z_Airdata;
import org.ldd.ssm.crm.mapper.DOWMapper;
import org.ldd.ssm.crm.mapper.OutPortMapper;
import org.ldd.ssm.crm.query.DOWObject;
import org.ldd.ssm.crm.query.DOWQuery;
import org.ldd.ssm.crm.service.IOutPortService;
import org.ldd.ssm.crm.utils.DOWDataUtils;
import org.ldd.ssm.crm.utils.TextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class OutPortServiceImpl implements IOutPortService  {
	@Autowired
	private DOWMapper dowMapper;
	@Autowired
	private OutPortMapper outPortMapper;
	/**
	 * 拿到全年的所有的月份统计数据
	 */
	public DOWObject<OutPort> getMethod(DOWQuery dta_Sce) {
		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		dta_Sce.setDpt_AirPt_Cd(airCode);
		//1,先查询当前年下的所有月份
		List<OutPort> rows = new ArrayList<OutPort>();
		dta_Sce.setLcl_Dpt_Day(dta_Sce.getLcl_Dpt_Day());
		//拿到有数据的月份
		List<DOW> method = dowMapper.getMethod(dta_Sce);
		//拿到条件查询的航距
		int airDistacne = outPortMapper.getAirDistacne(dta_Sce.getDpt_AirPt_Cd()+dta_Sce.getArrv_Airpt_Cd());
		//2,根据当前月查询数据每个月数据,统计每个月的数据
		for (DOW dow : method) {
			dta_Sce.setMonth(dow.getMethod());
			OutPort date = outPortMapper.getMonthDate(dta_Sce);
			date.setMonth(dow.getMethod());
			date.setFlt_Ser_Ine(new BigDecimal(date.getFlt_Ser_Ine()/airDistacne).setScale(0, BigDecimal.ROUND_HALF_UP).intValue());
			date.setAvg_Dct(new BigDecimal(date.getAvg_Dct()*100).setScale(3, BigDecimal.ROUND_HALF_UP).intValue());
			date.setIdd_Dct(new BigDecimal(date.getIdd_Dct()*100).setScale(3, BigDecimal.ROUND_HALF_UP).intValue());
			date.setGrp_Dct(new BigDecimal(date.getGrp_Dct()*100).setScale(3,BigDecimal.ROUND_HALF_UP).intValue());
			rows.add(date);
		}
		return new DOWObject<OutPort>(rows, rows.size());
	}
	/**
	 * 拿到图表所需要统计数据
	 */
	public List<OutPort> getOutPort(DOWQuery dta_Sce) {
//		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		String airCode = dta_Sce.getDpt_AirPt_Cd();
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<OutPort> rows = new ArrayList<OutPort>();
		//拿到有数据的月份
		List<DOW> method = dowMapper.getMethod(dta_Sce);
		if(method.isEmpty()){
			return null;
		}
		//2,根据当前月查询数据每个月数据,统计每个月的数据
		for (DOW dow : method) {
			dta_Sce.setMonth(dow.getMethod());
			OutPort date = outPortMapper.getMonthDate(dta_Sce);
			//这里判断的拿到的不是空数据
			if(date.getCla_Nbr()!=0&&date.getTal_Nbr_Set()!=0&&date.getIdd_moh()!=0){
				date.setMonth(dow.getMethod());
				rows.add(date);
			}
		}
		return rows;
	}
	/**
	 * 拿到年数据的所有月份的均班统计数据
	 */
	public DOWObject<EvenPort> getEvenPort(DOWQuery dta_Sce) {
		String airCode = dta_Sce.getDpt_AirPt_Cd();
//		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<EvenPort> rows = new ArrayList<EvenPort>();
		List<DOW> method = dowMapper.getMethod(dta_Sce);
		if(method.isEmpty()){
			return null;
		}
		for (DOW dow : method) {
			dta_Sce.setMonth(dow.getMethod());
			EvenPort data = outPortMapper.getEvenPort(dta_Sce);
			data.setMonth(dow.getMethod()+"月");
			data.setTme_Nbr(DOWDataUtils.getNumbertime(dta_Sce.getLcl_Dpt_Day(),dow.getMethod()));
			data.setIdd_Dct(new BigDecimal(data.getIdd_Dct()/1000).setScale(0, BigDecimal.ROUND_HALF_UP).intValue());
			data.setLod_For(new BigDecimal(data.getLod_For()*100).setScale(0, BigDecimal.ROUND_HALF_UP).intValue());
			data.setFlt_Ser_Ine((new BigDecimal(data.getFlt_Ser_Ine()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue())/100);
			rows.add(data);
		}
		
		return new DOWObject<EvenPort>(rows, rows.size());
	}
	public List<ClassRanking> getClassRanking(DOWQuery dta_Sce) {
		String airCode = dta_Sce.getDpt_AirPt_Cd();
//		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<ClassRanking> set_Ktr_Ine = outPortMapper.getClassRanking(dta_Sce);
		for (ClassRanking classRanking : set_Ktr_Ine) {
			classRanking.setDpt_AirPt_Cd(outPortMapper.getNameByCode(classRanking.getDpt_AirPt_Cd()));
			classRanking.setArrv_Airpt_Cd(outPortMapper.getNameByCode(classRanking.getArrv_Airpt_Cd()));
		}
		return set_Ktr_Ine;
	}
	public List<ClassRanking> getSet_Ktr_Ine(DOWQuery dta_Sce) {
		String airCode = dta_Sce.getDpt_AirPt_Cd();
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<ClassRanking> set_Ktr_Ine = outPortMapper.getSet_Ktr_Ine(dta_Sce);
		for (ClassRanking classRanking : set_Ktr_Ine) {
			classRanking.setCount(new BigDecimal(classRanking.getCount()).setScale(2,BigDecimal.ROUND_HALF_UP).abs().toString());
		}
		return set_Ktr_Ine;
	}
	/**
	 * 历史运营各个指标计算
	 * @Title: airportHistroy 
	 * @Description:  
	 * @param @param zairdataListAllList
	 * @param @return    
	 * @return Map<String,List<Object>>     
	 * @throws
	 */
	public Map<String,Map<String,Map<String,String>>> airportHistroy(DOWQuery dta_Sce){
		List<Z_Airdata> zairdataListAllList = outPortMapper.getSet_Ktr_IneNew(dta_Sce);
		Map<String,Map<String,Map<String,String>>> retMap = new HashMap<String,Map<String,Map<String,String>>>();
		//按月份流量走势
		SimpleDateFormat  sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<String> months = new ArrayList<String>();
		List<String> codes = new ArrayList<String>();
		List<String> hss = new ArrayList<String>();
		//计算出所有月份
		for (Z_Airdata z_airdata : zairdataListAllList) {
			String dptCode = z_airdata.getDpt_AirPt_Cd();
			String arrCode = z_airdata.getArrv_Airpt_Cd();
			String hs = z_airdata.getCpy_Nm();
			String day = sdf.format(z_airdata.getLcl_Dpt_Day());
			String [] str = day.split("-");
			if(!months.contains(str[1])){
				months.add(str[1]);
			}
			if(!codes.contains(dptCode+arrCode)){
				codes.add(dptCode+arrCode);
			}
			if(!hss.contains(hs)){
				hss.add(hs);
			}
		}
		Map<String,Map<String,String>> monthllMap = new HashMap<String,Map<String,String>>();
		Map<String,Map<String,String>> monthjbllMap = new HashMap<String,Map<String,String>>();
		DecimalFormat df = new DecimalFormat("0.00");
		for (String month : months) {
			double monthBc = 0.00;
			double monthPerson = 0.00;
			double monthSet = 0.00;
			double monthSr = 0.00;
			double monthTd = 0.00;
			double monthTdsr = 0.00;
			Map<String,String> llMap = new HashMap<String,String>();
			Map<String,String> jbllMap = new HashMap<String,String>();
			for (Z_Airdata z_airdata : zairdataListAllList) {
				String day = sdf.format(z_airdata.getLcl_Dpt_Day());
				String [] str = day.split("-");
				if(str[1].equals(month)){
					monthBc ++;
					monthPerson = monthPerson + z_airdata.getPgs_Per_Cls();
					monthSet = monthSet + z_airdata.getTal_Nbr_Set();
					monthSr = monthSr + z_airdata.getTotalNumber();
					monthTd = monthTd + z_airdata.getGrp_Nbr();
					monthTdsr = monthTdsr + z_airdata.getGrp_Ine().doubleValue();
				}
			}
			//月流量
			llMap.put("label",month+"月");
			llMap.put("idd_moh",df.format(monthPerson)+"");
			llMap.put("Cla_Nbr",df.format(monthBc)+"");
			llMap.put("Tal_Nbr_Set",df.format(monthSet)+"");
			llMap.put("Grp_moh",df.format(monthTd)+"");
			llMap.put("Grp_Ine",df.format(monthTdsr));
			llMap.put("Tol_Ine",monthSr+"");
			monthllMap.put(month, llMap);
			//均班流量
			jbllMap.put("label",month+"月");
			jbllMap.put("cla_Set", df.format(monthSet/monthBc));
			jbllMap.put("cla_Per", df.format(monthPerson/monthBc));
			jbllMap.put("cla_Grp",df.format(monthTd/monthBc));
			jbllMap.put("flt_Ser_Ine", df.format(monthTdsr/monthBc/100));
			jbllMap.put("lod_For",df.format((monthPerson/monthBc)/(monthSet/monthBc)*100));
			jbllMap.put("idd_Dct",df.format(monthSr/monthBc/1000));
			monthjbllMap.put(month, jbllMap);
		}
		retMap.put("monthll", monthllMap);
		retMap.put("monthjbll", monthjbllMap);
		Map<String,Map<String,String>> codebcMap = new HashMap<String,Map<String,String>>();
		Map<String,Map<String,String>> codezsMap = new HashMap<String,Map<String,String>>();
		Map<String,Map<String,String>> codelkMap = new HashMap<String,Map<String,String>>();
		Map<String,Map<String,String>> codejblkMap = new HashMap<String,Map<String,String>>();
		for (String code : codes) {
			double codeBc = 0.0;
			double codePerson = 0.0;
			double codeSet = 0.0;
			double codeSr = 0.0;
			double codeIne = 0.0;
			double monthTd = 0.0;
			Map<String,String> bcMap = new HashMap<String,String>();
			Map<String,String> zsMap = new HashMap<String,String>();
			Map<String,String> lkMap = new HashMap<String,String>();
			Map<String,String> jbklMap = new HashMap<String,String>();
			for (Z_Airdata z_airdata : zairdataListAllList) {
				String dptCode = z_airdata.getDpt_AirPt_Cd();
				String arrCode = z_airdata.getArrv_Airpt_Cd();
				if(code.equals(dptCode+arrCode)){
					codeBc ++;
					codePerson = codePerson + z_airdata.getPgs_Per_Cls();
					codeSet = codeSet + z_airdata.getTal_Nbr_Set();
					codeSr = codeSr + z_airdata.getTotalNumber();
					monthTd = monthTd + z_airdata.getGrp_Nbr();
					if(z_airdata.getSailingDistance()>0&&z_airdata.getTal_Nbr_Set()>0){
						codeIne = codeIne + (double)z_airdata.getTotalNumber()/(double)z_airdata.getSailingDistance()/(double)z_airdata.getTal_Nbr_Set();
					}
				}
			}
			//班次排行
			bcMap.put("count", df.format(codeBc)+"");
			bcMap.put("dpt_AirPt_Cd",code.substring(0, 3));
			bcMap.put("arrv_Airpt_Cd", code.substring(3, 6));
			codebcMap.put(code, bcMap);
			//坐收排行
			zsMap.put("set_Ktr_Ine",df.format(codeSr/codeBc/1000));
			zsMap.put("count", df.format((codeIne/codeBc)*100));
			zsMap.put("dpt_AirPt_Cd",code.substring(0, 3));
			zsMap.put("arrv_Airpt_Cd", code.substring(3, 6));
			codezsMap.put(code, zsMap);
			//旅客排行
			lkMap.put("value", df.format(codePerson)+"");
			lkMap.put("dpt_AirPt_Cd",code.substring(0, 3));
			lkMap.put("arrv_Airpt_Cd", code.substring(3, 6));
			codelkMap.put(code, lkMap);
			//均班客量排行
			jbklMap.put("count", df.format(codeSet/codeBc)+"");
			jbklMap.put("set_Ktr_Ine", df.format(codePerson/codeBc)+"");
			jbklMap.put("guestamount", df.format(monthTd/codeBc)+"");
			jbklMap.put("dpt_AirPt_Cd",code.substring(0, 3));
			jbklMap.put("arrv_Airpt_Cd", code.substring(3, 6));
			codejblkMap.put(code, jbklMap);
		}
		
		retMap.put("codebcMap", codebcMap);
		retMap.put("codezsMap", codezsMap);
		retMap.put("codelkMap", codelkMap);
		retMap.put("codejblkMap", codejblkMap);
		Map<String,Map<String,String>> hsbcMap = new HashMap<String,Map<String,String>>();
		Map<String,Map<String,String>> hsklMap = new HashMap<String,Map<String,String>>();
		for (String hs : hss) {
			double hsBc = 0.0;
			double hsPerson = 0.0;
			Map<String,String> bcMap = new HashMap<String,String>();
			Map<String,String> klMap = new HashMap<String,String>();
			for (Z_Airdata z_airdata : zairdataListAllList) {
				String hstemp = z_airdata.getCpy_Nm();
				if(hs.equals(hstemp)){
					hsBc++;
					hsPerson = hsPerson + z_airdata.getPgs_Per_Cls();
				}
			}
			//航司班次排行
			bcMap.put("count", df.format(hsBc));
			bcMap.put("cpy_Nm", hs);
			hsbcMap.put(hs, bcMap);
			//航司客量排行
			klMap.put("value", df.format(hsPerson));
			klMap.put("cpy_Nm", hs);
			hsklMap.put(hs, klMap);
		}
		retMap.put("hsbcMap", hsbcMap);
		retMap.put("hsklMap", hsklMap);
		return retMap;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public List<ClassRanking> getGuestamount(DOWQuery dta_Sce) {
		String airCode = dta_Sce.getDpt_AirPt_Cd();
//		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<ClassRanking> set_Ktr_Ine = outPortMapper.getGuestamount(dta_Sce);
		for (ClassRanking classRanking : set_Ktr_Ine) {
			classRanking.setCount(new BigDecimal(classRanking.getCount()).setScale(2,BigDecimal.ROUND_HALF_UP).abs().toString());
//			classRanking.setDpt_AirPt_Cd(outPortMapper.getNameByCode(classRanking.getDpt_AirPt_Cd()));
//			classRanking.setArrv_Airpt_Cd(outPortMapper.getNameByCode(classRanking.getArrv_Airpt_Cd()));
		}
		return set_Ktr_Ine;
	}
	public List<ClassRanking> getAmountRanking(DOWQuery dta_Sce) {
		String airCode = dta_Sce.getDpt_AirPt_Cd();
//		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<ClassRanking> rankings = outPortMapper.getAmountRanking(dta_Sce);
//		for (ClassRanking classRanking : rankings) {
//			classRanking.setDpt_AirPt_Cd(outPortMapper.getNameByCode(classRanking.getDpt_AirPt_Cd()));
//			classRanking.setArrv_Airpt_Cd(outPortMapper.getNameByCode(classRanking.getArrv_Airpt_Cd()));
//		}
		return rankings;
	}
	/**
	 * 航司班次排行
	 */
	@Override
	public List<ClassRanking> getCpy_ClassRanking(DOWQuery dta_Sce) {
		String airCode = dta_Sce.getDpt_AirPt_Cd();
//		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<ClassRanking> set_Ktr_Ine = outPortMapper.getCpy_ClassRanking(dta_Sce);
		return set_Ktr_Ine;
	}
	@Override
	public List<ClassRanking> getCpy_AmountRanking(DOWQuery dta_Sce) {
		String airCode = dta_Sce.getDpt_AirPt_Cd();
//		String airCode = outPortMapper.getAirCodeByName(dta_Sce.getDpt_AirPt_Cd());
		if(TextUtil.isEmpty(airCode)){
			return null;
		}
		if ("1".equals(dta_Sce.getState())) {
			dta_Sce.setDpt_AirPt_Cd(airCode);
			dta_Sce.setArrv_Airpt_Cd(null);
		}else if("0".equals(dta_Sce.getState())){
			dta_Sce.setDpt_AirPt_Cd(null);
			dta_Sce.setArrv_Airpt_Cd(airCode);
		}
		List<ClassRanking> rankings = outPortMapper.getCpy_AmountRanking(dta_Sce);
		return rankings;
	}
	@Override
	public List<String> getYears(String itia) {
		if(itia==null||"".equals(itia)){
			return null;
		}
		List<String> years = null;
		try {
			years = outPortMapper.getYearList(itia);
		} catch (Exception e) {
			e.printStackTrace();
			return years;
		}
		return years;
	}
}
