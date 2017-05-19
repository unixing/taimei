package org.ldd.ssm.crm.service.impl;


import javax.annotation.Resource;


import org.ldd.ssm.crm.domain.AirportFlight;
import org.ldd.ssm.crm.mapper.AirportFlightMapper;
import org.ldd.ssm.crm.service.AirportFlightService;
import org.springframework.stereotype.Service;

@Service
public class AirportFlightServiceImpl implements AirportFlightService{

	@Resource 
	private AirportFlightMapper airportFlightMapper;
	
	@Override
	public AirportFlight getAirportFlight(String iATA) {
		AirportFlight airportFlight=new AirportFlight();
		airportFlight.setAirportLocation(airportFlightMapper.getAirportLocation(iATA));
		airportFlight.setAirportLocationList(airportFlightMapper.getAirportLocations(iATA));
		return airportFlight;
	}

}
