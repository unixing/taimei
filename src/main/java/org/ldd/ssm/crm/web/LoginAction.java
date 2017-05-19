package org.ldd.ssm.crm.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.ldd.ssm.crm.aop.MyMethodNote;
import org.ldd.ssm.crm.domain.AirportData;
import org.ldd.ssm.crm.domain.Company;
import org.ldd.ssm.crm.domain.EmailValidStr;
import org.ldd.ssm.crm.domain.Employee;
import org.ldd.ssm.crm.domain.FlightRoute;
import org.ldd.ssm.crm.domain.MapperData;
import org.ldd.ssm.crm.domain.MenuNew;
import org.ldd.ssm.crm.domain.Resource;
import org.ldd.ssm.crm.domain.Token;
import org.ldd.ssm.crm.exception.LogicException;
import org.ldd.ssm.crm.service.BasicDataService;
import org.ldd.ssm.crm.service.DituMapperService;
import org.ldd.ssm.crm.service.FlightRouteService;
import org.ldd.ssm.crm.service.HomePageService;
import org.ldd.ssm.crm.service.ICompanyService;
import org.ldd.ssm.crm.service.IEmailValidStrService;
import org.ldd.ssm.crm.service.IEmployeeRoleService;
import org.ldd.ssm.crm.service.IEmployeeService;
import org.ldd.ssm.crm.service.IMenuNewService;
import org.ldd.ssm.crm.service.IPortalDataService;
import org.ldd.ssm.crm.service.IResourceNewService;
import org.ldd.ssm.crm.service.IRoleMenuNewService;
import org.ldd.ssm.crm.service.impl.DatasupplierServiceImpl;
import org.ldd.ssm.crm.utils.UploadImage;
import org.ldd.ssm.crm.utils.UserContext;
import org.ldd.ssm.crm.web.interceptor.MethodNote;
import org.ldd.ssm.crm.web.interceptor.SendSmsAliyun;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
@Controller
public class LoginAction {
	@Autowired
	private IPortalDataService portalDataService;
	@Autowired
	 private IEmployeeService employeeService;
	@Autowired
	private ICompanyService companyService;
	@Autowired
	private BasicDataService basicDataService;
	@Autowired
	private DituMapperService dituMapperService;
	@Autowired
	private FlightRouteService flightRouteService;
	@Autowired
	private IEmployeeRoleService employeeRoleService;
	@Autowired
	private IRoleMenuNewService roleMenuNewService;
	@Autowired
	private IEmailValidStrService iEmailValidStrService;
	@Autowired
	private IMenuNewService menuNewService;
	@Autowired
	private IResourceNewService resourceNewService;
	@Autowired
	private HomePageService homePageService;
	Logger logger = Logger.getLogger(LoginAction.class);
//	//验证登录
//	@RequestMapping("/checkLogin")
//	public String checkLogin(HttpSession session,String username,String password){
//		try{
//			// 检查登陆
//			Employee emp = employeeService.checkLogin(username, password);
//			Digitt	digit = basicDataService.get();
//			// 注册session
//			UserContext.setUser(emp);
//			UserContext.setDigitt(digit);
//			//设置公司ID为全局.
//			UserContext.setCompanyId("1");
//			return "/index/index";
//		}catch(LogicException e){
//			return "redirect:/login.jsp";
//		}
//	}
	//验证登录
	@MyMethodNote(comment="用户登录:1")
	@RequestMapping("/checkLogin")
	@MethodNote(comment="默认:16")
	@ResponseBody
	public Map<String, Object> checkLogin(HttpSession session,String username,String password,String token){
		Map<String,Object> map = new HashMap<String,Object>();
		try{
			// 检查登陆
			Employee emp = employeeService.checkLogin(username, password);
			int status = emp.getUsrSts();
			if(status==99){
				//管理员登陆放行
			}else if(status==-1){
				//账号禁用或者被删除状态，
				map.put("opResult", "-1");
				return map;
			}else if(status==1){
				//账号正常登陆放行
			}else if(status==0){
				//第一次，需要完善个人信息
				map.put("opResult", "0");
				map.put("emp", emp);
				return map;
			}
			//登陆成功，判断用户状态
			//判断后台系统用户首次
			if(emp.getPhone()==null||"".equals(emp.getPhone())){
				map.put("opResult", "4");//后台系统首次登陆，后台没有绑定手机号
				UserContext.setUser(emp);
				return map;
			}
			map = loginOption(session, emp, token);
		}catch(LogicException e){
			map.put("success", false);
			map.put("msg", "登陆失败，"+e.getMessage()+"！！");
			map.put("errorCode", e.getErrorCode());
		} catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	@MyMethodNote(comment="用户退出:1")
	@RequestMapping("/outLogin")
	@MethodNote(comment="默认:16")
	public String outLogin(){
			// 注销session
//			UserContext.rmoveUser();
		UserContext.getRequest().getSession().invalidate();
			return "redirect:/login.jsp";
	}
	@MyMethodNote(comment="清除缓存:1")
	@RequestMapping("/cleranHistroy")
	@MethodNote(comment="默认:16")
	public String cleranHistroy(){
		// 注销session
		return "newHtml/cleranHistroy";
	}
	@RequestMapping(value = "/restful/versionExchange")
	@MethodNote(comment="默认:16")
	@ResponseBody
	public Map<String, String> versionExchange(){
		Map<String,String> map = new HashMap<String,String>();
		//改文件名
		Date dd = new Date();
		String strtime = dd.getTime()+"";
		File newFile = new File(UserContext.getRequest().getSession().getServletContext().getRealPath("/")+"css");
		File [] files =newFile.listFiles();
		String name1 = UserContext.getRequest().getSession().getServletContext().getRealPath("/")+"css/css"+strtime;
		File ff1 = files[0];
		boolean b = ff1.renameTo(new File(name1)); 
	    File newFile1 = new File(UserContext.getRequest().getSession().getServletContext().getRealPath("/")+"js");
	    File [] files1 =newFile1.listFiles();
	    File ff2 = files1[0];
	    String name2 = UserContext.getRequest().getSession().getServletContext().getRealPath("/")+"js/js"+strtime;
	    boolean c = ff2.renameTo(new File(name2)); 
	    UserContext.setVersionn(strtime);
		return map ;
	}
	@RequestMapping("/IoSOutLogin")
	@ResponseBody
	public Map<String, String> IoSOutLogin(String token){
		Map<String,String> map = new HashMap<String, String>();
		if(token == null){
			map.put("states", "o");
		}else{
			Employee token2 = employeeService.getToken(token);
			if(token2==null){
				map.put("states", "o");
			}else{
				employeeService.deleteTokenByemp_id(token2.getId());
				map.put("states", "1");
			}
		}
		return map;
	}
	
	public String validMail(String validStr,Long id){
		String resultStr = "1";
		try {
			long currentTime = new Date().getTime();
			EmailValidStr emailValidStr = iEmailValidStrService.load(id);
			if(emailValidStr==null){
//				map.put("opResult", "3");//验证过期
				return "newHtml/fail";
			}else{
				long validMailTime = emailValidStr.getCreateTime().longValue();
				if(currentTime-validMailTime>30*60*1000){//30分钟验证过期
					resultStr = "3";
				}else{
					Employee emp = new Employee();
					emp.setId(UserContext.getUser().getId());
					emp.setEmail(emailValidStr.getEmail());
					boolean result= employeeService.update(emp);
					if(result){
						UserContext.getUser().setEmail(emailValidStr.getEmail());
						resultStr = "0";
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultStr = "2";
			return resultStr;
		}
		return resultStr;
	}
	
	@RequestMapping("/validPhone")
	@MethodNote(comment="默认:16")
	@ResponseBody
	public Map<String,Object> validPhone(String mobile){
		Map<String,Object> map=new HashMap<String,Object>();
		if(mobile==null||"".equals(mobile)){
			map.put("opResult", "3");
			return map;
		}
		try {
			Employee emp = employeeService.getEmployeeByPhone(mobile);
			if(emp==null){
				map.put("opResult", "0");
			}else{
				map.put("opResult","1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("opResult", "2");
			return map;
		}
		return map;
	}
	
	@RequestMapping("/bindPhoneOrValidCode")
	@MethodNote(comment="默认:16")
	@ResponseBody
	public Map<String,Object> bindMobile(String mobile,String validCode){
		Map<String,Object> map = new HashMap<String,Object>();
		if(mobile==null||"".equals(mobile)||validCode==null||"".equals(validCode)){
			map.put("opResult", "3");
			return map;
		}
		try {
			HttpSession session = UserContext.getRequest().getSession();
			String code = (int)session.getAttribute(mobile)+"";
			if(validCode.equals(code)){
				Employee emp = UserContext.getUser();
				if(emp==null){//普通用户手机号首次登陆
					emp = employeeService.getEmployeeByPhone(mobile);
					UserContext.setUser(emp);
					map.put("opResult", "0");
					return map;
				}else{
					emp.setPhone(mobile);//管理员首次登陆绑定手机号
					boolean result = employeeService.update(emp);
					if(!result){
						map.put("opResult", "1");//绑定失败
						return map;
					}
					map.put("opResult", "0");
				}
			}else{
				map.put("opResult", "1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("opResult", "2");
			return map;
		}
		return map;
	}
	
	@RequestMapping("/createNamdAndPwd")
	@MethodNote(comment="默认:16")
	@ResponseBody
	public Map<String,Object> createUserNameAndPassword(String userName,String password){
		Map<String,Object> map=new HashMap<String,Object>();
		if(userName==null||"".equals(userName)||password==null||"".equals(password)){
			map.put("opResult", "3");
			return map;
		}
		try {
			Employee emp = UserContext.getUser();
			emp.setUsrNm(userName);
			emp.setUsrPwd(password);
			boolean result = employeeService.update(emp);
			if(result){
				UserContext.setUser(emp);
				map = loginOption(UserContext.getRequest().getSession(), emp, null);
			}else{
				map.put("opResult", "1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("opResult", "2");
			return map;
		}
		return map;
	}
	
	@RequestMapping("/getLoginSmCode")
	@MethodNote(comment="默认:16")
	@ResponseBody
	public Map<String,Object> getLoginSmCode(String mobile){
		Map<String,Object> map=new HashMap<String,Object>();
		if(mobile==null||"".equals(map)){
			map.put("opResult", "3");
			return map;
		}
		try {
			Employee emp = employeeService.getEmployeeByPhone(mobile);
			if(emp==null){
				map.put("opResult", "5");//手机号未绑定账户
				return map;
			}
			boolean flag = SendSmsAliyun.sample(mobile);
			if(flag){
//				UserContext.getRequest().getSession().setAttribute("getCodePhone", mobile);
				map.put("opResult", "0");
			}else{
				map.put("opResult", "1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("opResult", "2");
			return map;
		}
		return map;
	}
	
	@RequestMapping("/getPortalData")
	@MethodNote(comment="默认:16")
	@ResponseBody
	public Map<String,Object> getPortalData(){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//获取当前用户可以查看机场
			Map<String,Map<String,Object>> lists = portalDataService.getPortalDataByAirports(UserContext.getItiaList());
			if(lists!=null){
				map.put("opResult", "0");
				map.put("list", lists);
				map.put("groupName", UserContext.getCompanyName());
				Map<String, AirportData> airportDataMap = homePageService.getAirportInfoMap();
				//取出机场三字码和四字码
//				List<AirportData> icaoList = homePageService.getIcaoIataList();
//				Map<String,AirportData> icaoMap = new HashMap<String,AirportData>();
//				for (AirportData airportData : icaoList) {
//					icaoMap.put(airportData.getIata(), airportData);
//				}
//				map.put("icaoMap", icaoMap);
				map.put("airportInfoMap", airportDataMap);
			}else{
				map.put("opResult", "1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("opResult", "2");
			return map;
		}
		return map;
	}
	
	public Map<String,Object> loginOption(HttpSession session,Employee emp,String token){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			// 注册session
			UserContext.setUser(emp);
			//获取服务器ip地址，并判断是否为测试服务器
			boolean ipness=getAddress();
			UserContext.setIpNess(ipness);
			//本地测试模拟航线
//			UserContext.setIpNess(true);
			//设置公司ID为全局.
			Long companyId=employeeService.getCompanyId(emp.getId());
			UserContext.setCompanyId(companyId+"");
//			Company  company = companyService.load(companyId);
//			if(company!=null){
//				UserContext.setCompanyName(company.getCpyAds());
//				UserContext.setcompanyItia(company.getCpyItia());
//			}else{
//				UserContext.setCompanyName("海口");
//				UserContext.setcompanyItia(null);
//			}
			//设置黑名单为全局变量
			List<MapperData> mapperDataList = dituMapperService.getDataMapperList();
			UserContext.setMapperList(mapperDataList);
			//设置能操作的航班航线为全局变量
			List<FlightRoute> fltNbrList = flightRouteService.selectByEmployee(emp.getId(),UserContext.getcompanyItia());
			UserContext.setFlyNumList(fltNbrList);
			// 如果登录成功,创建ios需要的token信息------------------------------------------------------
			String randomUUID = UUID.randomUUID().toString();
			if(token!=null){
				Token newToken = new Token();
				newToken.setUuid(randomUUID);
				newToken.setEmployee_id(emp.getId());
				employeeService.deleteTokenByemp_id(emp.getId());
				employeeService.saveToken(newToken);
			}
			//将头像复制到指定路径
			if(!"".equals(emp.getHeadPath())){
				String fileName = UUID.randomUUID().toString()+".jpg";
				File newFile = new File(UserContext.getRequest().getSession().getServletContext().getRealPath("/")+"uploadimage/"+emp.getId()+"/");
				if(!newFile.isDirectory()){
					newFile.mkdirs();
				}
				newFile = new File(UserContext.getRequest().getSession().getServletContext().getRealPath("/")+"uploadimage/"+emp.getId()+"/"+fileName);
				File oldFile = new File(emp.getHeadPath());
				boolean result = UploadImage.copyTheFile(oldFile, newFile);
				if(result==true){
					UserContext.getUser().setHeadPath("/uploadimage/"+emp.getId()+"/"+fileName);
				}
			}
			//封装菜单列表存入session
//			if(emp.getUsrSts()!=99){
//				Long roleId = employeeRoleService.load(company.getCpyItia(), emp.getId());
//				if(roleId!=null){
//					UserContext.getUser().setRoleId(roleId);
//					List<String> urls = roleMenuNewService.getCurrentEmployeeResource(roleId);
////					List<MenuNew> menus = roleMenuNewService.selectMenuList(roleId);
//					UserContext.setUrlList(urls);
////					UserContext.setMenuNewList(menus);
//				}
//			}else{//超级管理员
//				List<String> urls = resourceNewService.getAllResourceUrls();
////				List<MenuNew> menus = menuNewService.getAllMenu();
//				UserContext.setUrlList(urls);
////				UserContext.setMenuNewList(menus);
//			}
			// 封装响应信息
			String validStr = (String)session.getAttribute("validStr");
			Long id = session.getAttribute("id")==null?0l:Long.valueOf((String)session.getAttribute("id"));
			if(validStr==null||"".equals(validStr)||id==null||id.longValue()<=0){
				map.put("success", true);
				map.put("msg", "登陆成功！！");
				map.put("token",randomUUID);
			}else{
				//清空id和验证字符
				session.removeAttribute("id");
				session.removeAttribute("validStr");
				String opResult = validMail(validStr, id);
				map.put("success", true);
				map.put("opResult", opResult);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("opRestult", "2");
			return map;
		}
		return map;
	}
	protected boolean getAddress() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest(); 
		String serverIP = request.getLocalAddr();
//		InetAddress address;
//		try {
//			address = InetAddress.getLocalHost();
//			String hostAddress = address.getHostAddress();
			if("192.168.22.8".equals(serverIP)){
				return true;
			}else{
				return false;
			}
//			
//		} catch (UnknownHostException e) {
//			e.printStackTrace();
//		}
//		return false;
		
//		boolean result=false;
//        try {
//            for (Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces(); interfaces.hasMoreElements();) {
//                NetworkInterface networkInterface = interfaces.nextElement();
//                if (networkInterface.isLoopback() || networkInterface.isVirtual() || !networkInterface.isUp()) {
//                    continue;
//                }
//                Enumeration<InetAddress> addresses = networkInterface.getInetAddresses();
//                if (addresses.hasMoreElements()) {
//                	if("192.168.22.8".equals(addresses.nextElement().getHostAddress())){
//                		result=true;
//                		break;
//                	}
//                }
//            }
//        } catch (SocketException e) {
//            logger.debug("Error when getting host ip address: <{}>.", e);
//            return result;
//        }
//        return result;
    }
}