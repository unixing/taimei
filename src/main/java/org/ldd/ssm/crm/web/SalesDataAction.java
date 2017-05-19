package org.ldd.ssm.crm.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ldd.ssm.crm.aop.MyMethodNote;
import org.ldd.ssm.crm.domain.TravellerTicketInfo;
import org.ldd.ssm.crm.query.SalesDateQuery;
import org.ldd.ssm.crm.service.ISalesDataService;
import org.ldd.ssm.crm.utils.TravellerTicketInfoExcelView;
import org.ldd.ssm.crm.utils.UserContext;
import org.ldd.ssm.crm.web.interceptor.MethodNote;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 销售数据
 * @author wxm
 *
 * @date 2017-3-7
 */

@Controller
@RequestMapping("/SalesData")
public class SalesDataAction {
	
	@Resource
	private ISalesDataService salesDataService;
	
	@MyMethodNote(comment="销售数据:2")
	@MethodNote(comment="销售数据:8")
	@RequestMapping("/accountCheck")
	public String getAccountCheck() {
		return "newHtml/account_check";
	}

	@RequestMapping("/findFltRteCdList")
	@MethodNote(comment="销售数据:8")
	@ResponseBody
	public List<String> findFltRteCdList(SalesDateQuery dto,HttpServletRequest request,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
		/*dto.setEndTime("2017-03-01");
		dto.setStartTime("2016-01-01");
		dto.setFlightNum("GS7620");*/
		List<String> list=new ArrayList<String>(); 
		try {
			list=salesDataService.findFltRteCdList(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  list;
	}
	
	@RequestMapping("/findSalesData")
	@MethodNote(comment="销售数据:8")
	@ResponseBody
	public Map<String,Object> findSalesData(SalesDateQuery dto,HttpServletRequest request,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
		Map<String,Object> map=new HashMap<String, Object>();
		/*dto.setEndTime("2017-03-01");
		dto.setStartTime("2016-01-01");
		dto.setFlightNum("GS7620");
		dto.setFltRteCd("HAKLZOXIY");*/
		try {
			if(!dto.getFlightNum().isEmpty()&&!dto.getFltRteCd().isEmpty()){
				Map<String, Object> findSalesData = salesDataService.findSalesData(dto);
				if(!findSalesData.isEmpty()){
					map.put("success",true);
					map.put("data",findSalesData);
				}else{
					map.put("success",false);
					map.put("data",null);
				}
			}else{
				map.put("success",false);
				map.put("data",null);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 排序 分页
	 * @param dto
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/findTicketInfo")
	@MethodNote(comment="销售数据:8")
	@ResponseBody
	public Map<String,Object> findTicketInfo(SalesDateQuery dto,HttpServletRequest request,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
		Map<String,Object> map=new HashMap<String, Object>();
		/*dto.setEndTime("2017-03-01");
		dto.setStartTime("2016-01-01");
		dto.setFlightNum("GS7620");
		dto.setFltRteCd("HAKLZOXIY");
		dto.setLeg("HAK-LZO");
		dto.setOrder("flightDate");
		dto.setSort("desc");*/
		try {
			if(!dto.getFlightNum().isEmpty()&&!dto.getFltRteCd().isEmpty()){
				List<TravellerTicketInfo> findSalesData = salesDataService.findTicketInfo(dto);
				if(!findSalesData.isEmpty()){
					map.put("success",true);
					map.put("data",findSalesData);
				}else{
					map.put("success",false);
					map.put("data",null);
				}
			}else{
				map.put("success",false);
				map.put("data",null);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping("/exportSalesdata")
	@MethodNote(comment="销售数据:8")
	public ModelAndView exportExcel(SalesDateQuery dto,HttpServletRequest request,HttpServletResponse response) {		
		response.setHeader("Access-Control-Allow-Origin", "*");
		/*dto.setEndTime("2017-03-01");
		dto.setStartTime("2016-01-01");
		dto.setFlightNum("GS7620");
		dto.setFltRteCd("HAKLZOXIY");*/
		Map<String,Object> map = new HashMap<String, Object>();
		List<String> list = new ArrayList<String>();
		list=salesDataService.findSegmentList(dto);
		if(list.isEmpty()){
			return null;
		}
		map.put("titles", list);
		Map<String,List<List<TravellerTicketInfo>>> model = new HashMap<String,List<List<TravellerTicketInfo>>>();
		List<List<TravellerTicketInfo>> travellerTicketInfo = new ArrayList<List<TravellerTicketInfo>>();
		for (int i = 0; i < list.size(); i++) {
			dto.setLeg(list.get(i));
			List<TravellerTicketInfo> findData = salesDataService.findTravellerTicketExc(dto);
			travellerTicketInfo.add(findData);
		}
		model.put("list", travellerTicketInfo);
		return new ModelAndView(new TravellerTicketInfoExcelView(map), model);
	}
	/**
	 * 返回最近有数据的时间
	 */
	@RequestMapping("/getCurrentTime")
	@MethodNote(comment="销售数据:8")
	@ResponseBody
	public Map<String,Object> getCurrentTime(SalesDateQuery dto,HttpServletRequest request,HttpServletResponse response){
		response.setHeader("Access-Control-Allow-Origin", "*");
		Map<String,Object> map=new HashMap<String, Object>();
		//dto.setFltRteCd("PEKLZO");
		try {
			if(!dto.getFlightNum().isEmpty()&&!dto.getFltRteCd().isEmpty()){
				String date= salesDataService.getCurrentTime(dto);
				if(!date.isEmpty()){
					map.put("success",true);
					map.put("data",date);
				}else{
					map.put("success",false);
					map.put("data",null);
				}
			}else{
				map.put("success",false);
				map.put("data",null);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
}
