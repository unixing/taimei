package org.ldd.ssm.crm.test;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ldd.ssm.crm.domain.Eachflightinfo;
import org.ldd.ssm.crm.domain.TableAnnotation;
import org.ldd.ssm.crm.domain.TableName;
import org.ldd.ssm.crm.mapper.PassengerdetalisinfoMapper;
import org.ldd.ssm.crm.query.ProcessTaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 生成数据库表字典
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class Test3 {
	@Autowired
	private PassengerdetalisinfoMapper passengerdetalisinfoMapper;

	@Test
	public void testLink() {
		passengerdetalisinfoMapper.databaseTableName1();
		List<TableName> list = passengerdetalisinfoMapper.databaseTableName();
		StringBuffer buffer = new StringBuffer();
		String string = UUID.randomUUID().toString();
		
		FileWriter file;
		try {
			File file2 = new File("C:\\Users\\Taimei\\Desktop\\"+string+".txt");
			if(!file2.exists()){
				file2.createNewFile();
			}
				file = new FileWriter(file2);
			for (TableName tableName : list) {
				List<TableAnnotation> list2 = passengerdetalisinfoMapper
						.databaseTableName3(tableName.getTable_name());
				buffer.append(tableName.toString()+"\r");
				for (TableAnnotation tableAnnotation : list2) {
					buffer.append(tableAnnotation.toString() + "\r");
				}

			}
			file.write(buffer.toString());
			file.flush();
			file.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	@Test
	public void testPort(){
		ProcessTaskQuery sQuery = new ProcessTaskQuery();
		sQuery.setDpt_AirPt_Cd("达县");
		 List<Eachflightinfo> queryPort = passengerdetalisinfoMapper.queryPort(sQuery);
	}
}
