package org.ldd.ssm.crm.test;

import java.math.BigDecimal;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ldd.ssm.crm.domain.AirPort;
import org.ldd.ssm.crm.domain.Passengerdetalisinfo;
import org.ldd.ssm.crm.domain.Traveler;
import org.ldd.ssm.crm.mapper.AirPortMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class CityTest {
	@Autowired
	private AirPortMapper airPortMapper;

	@Test
	public void testname() throws Exception {
		AirPort airPort = new AirPort();
		Date date = new Date();
//		String uuid = UUID.randomUUID().toString();
		BigDecimal bigDecimal = new BigDecimal(1000);
		airPort.setLcl_Dpt_Day(date);
		airPort.setDpt_AirPt_Cd("海口机场");
		airPort.setArrv_Airpt_Cd("六盘水机场");
		airPort.setYb_Pri(bigDecimal);
		airPort.setFlt_nbr("YB0000");
		airPort.setAirCrft_Typ("测试机型");
		airPort.setCls_Cpn_Qty("W3C7B3Y105");
		airPort.setAirCrft_Reg_Nbr("测试的飞机号0000");
		airPort.setAirln_cd("GB");
		airPort.setLcl_Dpt_Tm(date);
		airPort.setLcl_Arrv_Tm(date);
		airPort.setSeats(104);
		airPort.setGosh_Ind(8);
		airPort.setNosh_Ind(10);
		airPort.setChile_Pax_Qty(9);
		airPort.setInft_Qty(1);
		airPort.setUuid("3d78da68-49d6-49e2-88bf-dd6ffdc70f5f");
		airPort.setDat_Gat_Tme(date);
		airPort.setDat_Gat_Acc_Nbr("8100");
		airPort.setDat_Gat_Ist("fbl");
		
		Traveler traveler = new Traveler();
		traveler.setPax_Id_Nbr("123456789123456123");
		traveler.setTit_Pre(bigDecimal);
		traveler.setFrt_Spe("Y");
		traveler.setGrp_Ind("1L");
		traveler.setBk_Ofc_Cd("ffkkll");
		traveler.setRsp_Ofc_Cd("ff1133");
		traveler.setPen_Tye(1);
		traveler.setTKT_No("ff1133");
		traveler.setUuid("3d78da68-49d6-49e2-88bf-dd6ffdc70f5f");
		
		Passengerdetalisinfo passengerdetalisinfo = new Passengerdetalisinfo();
		passengerdetalisinfo.setPax_Chn_Nm("张三");
		passengerdetalisinfo.setPax_Id_Nbr("123456789123456123");
		passengerdetalisinfo.setPax_Enh_Nm("yingggsghsgs");
		passengerdetalisinfo.setPax_Bdy(date);
		passengerdetalisinfo.setPax_Sex(1);
		passengerdetalisinfo.setPax_Eml("24196775@qq.com");
		passengerdetalisinfo.setPax_Pho("13102222222");
		passengerdetalisinfo.setPax_ads("天津市北京市南京市山东省山东市");
		passengerdetalisinfo.setPax_Qq("12111222212");
		passengerdetalisinfo.setVip_Ind("111s2s1|asdasdsad|13123123|12312312");
		passengerdetalisinfo.setPax_Pat_No("dsa123123123");
		passengerdetalisinfo.setPax_Diy_Hat("咖啡面食");
		passengerdetalisinfo.setCountry("中国");
		for (int i = 0; i < 150000; i++) {
			
//			airPortMapper.save(airPort);
			airPortMapper.save2(traveler);
			airPortMapper.save3(passengerdetalisinfo);
		}
		 
	}

	@Test
	public void testname2() throws Exception {
	}
	
}
