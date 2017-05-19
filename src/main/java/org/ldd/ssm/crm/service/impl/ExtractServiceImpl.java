package org.ldd.ssm.crm.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.ldd.ssm.crm.domain.AcquisitionTime;
import org.ldd.ssm.crm.domain.Eachflightinfo;
import org.ldd.ssm.crm.domain.LinkTypeData;
import org.ldd.ssm.crm.domain.Rule;
import org.ldd.ssm.crm.exception.RuleException;
import org.ldd.ssm.crm.mapper.PassengerdetalisinfoMapper;
import org.ldd.ssm.crm.query.ProcessTaskObject;
import org.ldd.ssm.crm.query.ProcessTaskQuery;
import org.ldd.ssm.crm.service.IExtractService;
import org.ldd.ssm.crm.utils.TextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 
 * @author zhy
 * 
 */
@Service
public class ExtractServiceImpl implements IExtractService {
	@Autowired
	private PassengerdetalisinfoMapper lisinfoMapper;
	/**
	 * 爬虫,去哪网的时刻数据
	 */
	private  Date format;
	public void extract(Rule rule) {

		// 进行对rule的必要校验
		validateRule(rule);


		LinkTypeData data = null;
		try {
			// 拿到访问地址
			String url = rule.getUrl();
			// 拿到参数集合
			String[] params = rule.getParams();
			// 拿到参数值
			String[] values = rule.getValues();
			// 对返回的HTML，第一次过滤所用的标签，请先设置type
//			String resultTagName = rule.getResultTagName();
			// 拿到返回标签类型
//			int type = rule.getType();
			// 拿到返回类型
			int requestType = rule.getRequestMoethod();
			// 连接url
			Connection conn = Jsoup.connect(url);
			// 设置查询参数

			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					conn.data(params[i], values[i]);
				}
			}

			// 设置请求类型
			Document doc = null;
			switch (requestType) {
			case Rule.GET:
				doc = conn.timeout(100000).get();
				break;
			case Rule.POST:
				doc = conn.timeout(100000).post();
				break;
			}

			
			Elements select = doc.getElementsByAttributeValue("data-defer",
					"jmpPlugin");

			Elements select2 = doc.select(".abbr");
			Elements select3 = doc.select(".time");
			Elements select4 = doc.select(".airport");
			Elements select5 = doc.select(".weeks").select("span.blue,b.t");
			Elements select6 = doc.select(".result_type");
			data = new LinkTypeData();
			if(select.text().length()>=6){
				data.setFlyNub(select.text());
			}
			data.setAirCrft_Typ(select2.text());
			data.setSummary(select3.text());
			data.setContent(select4.text());
			ArrayList<String> getfomt = getfomt(select5.text());
			data.setArrayList(getfomt);
			data.setAirText(select6.text());
			
			save(data);
			
			Elements sele = doc.select(".schedule_down");
			for (Element element : sele) {
					String attr2 = element.attr("href");
						Rule rule2 = new Rule(attr2, new String[] {}, new String[] {}, null, -1,
								Rule.GET);
						extract(rule2);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 对传入的参数进行必要的校验
	 */

	public ArrayList<String> getfomt(String str) {
		ArrayList<String> arrayList = new ArrayList<String>();
		String replace = str.replace(" ", "").replaceAll("班", "").replace("餐食", "");
		String[] split = replace.split("期");
		for (String string : split) {
			arrayList.add(string);
		}
		return arrayList;
	}

	public void validateRule(Rule rule) {
		String url = rule.getUrl();
		if (TextUtil.isEmpty(url)) {
			throw new RuleException("url不能为空！");
		}
		if (!url.startsWith("http://")) {
			throw new RuleException("url的格式不正确！");
		}

		if (rule.getParams() != null && rule.getValues() != null) {
			if (rule.getParams().length != rule.getValues().length) {
				throw new RuleException("参数的键值对个数不匹配！");
			}
		}

	}
	
	
	public String get(String name) {
		
		return lisinfoMapper.get(name);
	}

	public void testname(String str,String name,Date format) {
		this.format = format;
		String str3 = "http://flights.ctrip.com/schedule/";
		if(str!=null){
			str3 = str3+str+".";
		}
		Rule rule = new Rule(str3+".html", new String[] {}, new String[] {}, null, -1,
				Rule.GET);
		extract2(rule,name);
	}

	public void extract2(Rule rule,String name) {

		// 进行对rule的必要校验
		validateRule(rule);

		try {
			// 拿到访问地址
			String url = rule.getUrl();
			// 拿到参数集合
			String[] params = rule.getParams();
			// 拿到参数值
			String[] values = rule.getValues();
			// 拿到返回类型
			int requestType = rule.getRequestMoethod();
			// 连接url
			Connection conn = Jsoup.connect(url);
			// 设置查询参数

			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					conn.data(params[i], values[i]);
				}
			}

			// 设置请求类型
			Document doc = null;
			switch (requestType) {
			case Rule.GET:
				doc = conn.timeout(100000).get();
				break;
			case Rule.POST:
				doc = conn.timeout(100000).post();
				break;
			}
			
			
			Elements select2 = doc.select(".m");
			for (Element element : select2) {
				String text = element.select(".m").text();
				if(name.equals((text.split("-"))[0])){
					List<Node> childNodes = element.childNodes();
					for (Node node : childNodes) {
						String attr = node.attr("href");
						if(attr!=null&&attr!=""){
							Rule rule2 = new Rule(attr, new String[] {}, new String[] {}, null, -1,
									Rule.GET);
							extract(rule2);
						}
					}
				}
			}
			
			

		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	public void save(LinkTypeData data){
		String airCrft_Typ = data.getAirCrft_Typ();
		ArrayList<String> arrayList = data.getArrayList();
		if(data.getFlyNub()!=null&&data.getFlyNub()!=""){
			String[] air = airCrft_Typ.split(" +");
			String[] con = data.getContent().split(" +");
			String[] fly = data.getFlyNub().split(" +");
			String[] sum = data.getSummary().split(" +");
			String[] text = data.getAirText().split("到");
			for (int i = 1; i < air.length+1; i++) {
				Eachflightinfo each = new Eachflightinfo();
				each.setDpt_AirPt_Cd(text[0]);// 始发地
				each.setArrv_Airpt_Cd(text[1]);// 到达地
				each.setFlt_nbr(fly[i-1]);// 航班号
				each.setAirCrft_Typ(air[i-1]);// 机型
				each.setDpt_AirPt_pot(con[i*2-2]);// 出发机场
				each.setLcl_Dpt_Tm(sum[i*2-2]);// 出发时间
				each.setArrv_Airpt_pot(con[i*2-1]);// 到达机场
				each.setLcl_Arrv_Tm(sum[i*2-1]);// 到达时间
				each.setDays(arrayList.get(i));// 班期
				each.setGet_tim(format);
				lisinfoMapper.save(each); 
			}
		}
	}

	public List<String> getName() {
		return lisinfoMapper.list();
	}

	public List<String> get2(String name) {
		
		return lisinfoMapper.get2(name);
	}

	public ProcessTaskObject<Eachflightinfo> query(ProcessTaskQuery sQuery) {
		List<Eachflightinfo> eachflightinfos = lisinfoMapper.query(sQuery);
		//查询总数
		Integer queryTotal = lisinfoMapper.queryTotal(sQuery);
		//封装数据
		
		ProcessTaskObject<Eachflightinfo> permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, queryTotal);
		return permissionObject;
	}
	
	public ProcessTaskObject<Eachflightinfo> queryByIata(ProcessTaskQuery sQuery) {
		ProcessTaskObject<Eachflightinfo> permissionObject = null;
		try {
			List<Eachflightinfo> eachflightinfos = lisinfoMapper.queryByIata(sQuery);
			//查询总数
			Integer queryTotal = lisinfoMapper.queryTotalByIata(sQuery);
			//封装数据
			
			permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, queryTotal);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return permissionObject;
	}

	public ProcessTaskObject<Eachflightinfo> queryPort(ProcessTaskQuery sQuery) {
		List<Eachflightinfo> eachflightinfos = lisinfoMapper.queryPort(sQuery);
		ProcessTaskObject<Eachflightinfo> permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, null);
		return permissionObject;
	}

	public List<AcquisitionTime> getAll() {
		List<AcquisitionTime> all = lisinfoMapper.getAll();
		List<AcquisitionTime> newAll =new ArrayList<AcquisitionTime>();
		for (int i = 1; i <= all.size(); i++) {
			AcquisitionTime acquisitionTime = all.get(all.size()-i);
			newAll.add(acquisitionTime);
		}
		return newAll;
	}

	public ProcessTaskObject<Eachflightinfo> queryAll(ProcessTaskQuery sQuery) {
		List<Eachflightinfo> eachflightinfos = lisinfoMapper.queryAll(sQuery);
		//查询总数
		Integer queryTotal = lisinfoMapper.queryTotalAll(sQuery);
//		//封装数据
		
		ProcessTaskObject<Eachflightinfo> permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, queryTotal);
		return permissionObject;
	}
	
	public ProcessTaskObject<Eachflightinfo> queryAllByIata(ProcessTaskQuery sQuery) {
		List<Eachflightinfo> eachflightinfos = lisinfoMapper.queryAllByIata(sQuery);
		//查询总数
		Integer queryTotal = lisinfoMapper.queryTotalAllByIata(sQuery);
		//封装数据
		
		ProcessTaskObject<Eachflightinfo> permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, queryTotal);
		return permissionObject;
	}

	public ProcessTaskObject<Eachflightinfo> queryToRoRreturn(
			ProcessTaskQuery sQuery) {
		List<Eachflightinfo> eachflightinfos = lisinfoMapper.queryToRoRreturn(sQuery);
		//查询总数
		Integer queryTotal = lisinfoMapper.queryTotalToRoRreturn(sQuery);
		//封装数据
		
		ProcessTaskObject<Eachflightinfo> permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, queryTotal);
		return permissionObject;
	}
	
	public ProcessTaskObject<Eachflightinfo> queryToRoRreturnByIata(
			ProcessTaskQuery sQuery) {
		List<Eachflightinfo> eachflightinfos = null;
		Integer queryTotal = 0;
		try {
			eachflightinfos = lisinfoMapper.queryToRoRreturnByIata(sQuery);
			//查询总数
			queryTotal = lisinfoMapper.queryTotalToRoRreturnByIata(sQuery);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//封装数据
		
		ProcessTaskObject<Eachflightinfo> permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, queryTotal);
		return permissionObject;
	}

	@Override
	public List<String> getNewEstCollectDate(ProcessTaskQuery sQuery) {
		List<String> list = new ArrayList<String>();
		list = lisinfoMapper.getNewEstCollectDate(sQuery);
		return list;
	}

	@Override
	public ProcessTaskObject<Eachflightinfo> queryPortReturn(
			ProcessTaskQuery sQuery) {
		List<Eachflightinfo> eachflightinfos = lisinfoMapper.queryPortReturn(sQuery);
		ProcessTaskObject<Eachflightinfo> permissionObject = new ProcessTaskObject<Eachflightinfo>(eachflightinfos, null);
		return permissionObject;
	}
}
