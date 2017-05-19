package org.ldd.ssm.crm.service;

import java.util.List;
import java.util.Map;

public interface IPortalDataService {

	public Map<String,Map<String,Object>> getPortalDataByAirports(List<String> airports);
	
}
