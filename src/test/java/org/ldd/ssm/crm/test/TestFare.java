package org.ldd.ssm.crm.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ldd.ssm.crm.domain.Fare;
import org.ldd.ssm.crm.domain.Z_Airdata;
import org.ldd.ssm.crm.mapper.FareMapper;
import org.ldd.ssm.crm.mapper.UpdataMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


/**
 * 将txt文件的运价写入数据库
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestFare {
	@Autowired
	private FareMapper fareMapper;
	@Autowired
	private UpdataMapper mapper;
	@Test
	public void testLink() {
		try {
			String encoding = "GBK";
			List<Fare> fares = new ArrayList<Fare>();
			File file = new File("C:\\Users\\Taimei\\Desktop\\dd.txt");
			if (file.isFile() && file.exists()) { // 判断文件是否存在
				InputStreamReader read = new InputStreamReader(
						new FileInputStream(file), encoding);// 考虑到编码格式
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				while ((lineTxt = bufferedReader.readLine()) != null) {
					String[] split = lineTxt.split(" +|\\t");
					Fare fare = new Fare();
					fare.setVoyageCode(split[0].replaceAll("\\s*|\t|\r|\n","").replaceAll("-", ""));
					fare.setVoyageName(split[1].replaceAll("\\s*|\t|\r|\n",""));
					fare.setyBFare(Integer.valueOf((split[2].replaceAll("\\s*|\t|\r|\n",""))));
					fare.setSailingDistance(Integer.valueOf((split[3].replaceAll("\\s*|\t|\r|\n",""))));
					fares.add(fare);
				}
				read.close();
			} else {
			}
			for (Fare fare : fares) {
				fareMapper.save(fare);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	@Test
	public void testGetInt(){
		double i = fareMapper.get("XICHGH");
	}
	@Test
	public void testsave(){
		Z_Airdata airdata = new Z_Airdata();
		airdata.setLcl_Dpt_Day(new Date());
		mapper.save(airdata);
	}
	@Test
	public void testData(){
	}
	
}
