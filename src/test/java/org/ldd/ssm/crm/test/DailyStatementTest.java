package org.ldd.ssm.crm.test;

import java.math.BigDecimal;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ldd.ssm.crm.domain.DailyStatement;
import org.ldd.ssm.crm.mapper.DailyStatementMapper;
import org.ldd.ssm.crm.utils.MyMathUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class DailyStatementTest {
	@Autowired
//	private IDailyStatementService dailyStatementService;
	private DailyStatementMapper dailyStatementMapper;
	@Test
	public void testLink() throws Exception {
		DailyStatement dailyStatement = new DailyStatement();
		dailyStatement.setFlightDate(new Date());
		dailyStatement.setLeg("六盘水贵阳");
		dailyStatement.setyPrice(new BigDecimal(700));
		dailyStatement.setPriceTeam(new BigDecimal(0));
		dailyStatement.setX(1);
		dailyStatement.setU(3);
//		dailyStatement.setE(4);
		dailyStatement.setT(8);
		dailyStatement.setZ(1);
		Integer sumPerson = MyMathUtils.getSumPerson(dailyStatement.getF(),dailyStatement.getY(),dailyStatement.getB(),dailyStatement.getH(),dailyStatement.getK(),
				dailyStatement.getL(),dailyStatement.getM(),dailyStatement.getQ(),dailyStatement.getX(),dailyStatement.getU(),dailyStatement.getE(),
				dailyStatement.getT(),dailyStatement.getZ(),dailyStatement.getG(),dailyStatement.getO(),dailyStatement.getS(),dailyStatement.getV(),
				dailyStatement.getyElse()
				);
		dailyStatement.setCombinedGroup(sumPerson);
		
		Integer totalNumber = MyMathUtils.getTotalNumber(dailyStatement.getCombinedGroup(),dailyStatement.getG());
		dailyStatement.setTotalNumber(totalNumber);
		
		double individualIncome = MyMathUtils.getIndividualIncome(dailyStatement.getyPrice().intValue(),dailyStatement.getF(),dailyStatement.getY(),dailyStatement.getB(),dailyStatement.getH(),dailyStatement.getK(),
				dailyStatement.getL(),dailyStatement.getM(),dailyStatement.getQ(),dailyStatement.getX(),dailyStatement.getU(),dailyStatement.getE(),
				dailyStatement.getT(),dailyStatement.getZ(),dailyStatement.getG(),dailyStatement.getO(),dailyStatement.getS(),dailyStatement.getV(),
				dailyStatement.getyElse());
		dailyStatement.setIndividualIncome(new BigDecimal(individualIncome));
		
		Integer teamTotalRevenue = MyMathUtils.getTeamTotalRevenue(dailyStatement.getG().intValue(),dailyStatement.getPriceTeam().intValue());
		dailyStatement.setTeamTotalRevenue(new BigDecimal(teamTotalRevenue));
		
		BigDecimal kilometerIncome = MyMathUtils.getKilometerIncome(dailyStatement.getIndividualIncome().intValue(),dailyStatement.getTeamTotalRevenue().intValue(), 105, 156);
		dailyStatement.setKilometerIncome(kilometerIncome.setScale(2,BigDecimal.ROUND_HALF_UP));
		
		BigDecimal averageDiscount = MyMathUtils.getAverageDiscount(dailyStatement.getCombinedGroup().intValue(), dailyStatement.getIndividualIncome().intValue(), dailyStatement.getTeamTotalRevenue().intValue(), dailyStatement.getyPrice().intValue());
		dailyStatement.setAverageDiscount(averageDiscount.setScale(2,BigDecimal.ROUND_HALF_UP));
		dailyStatementMapper.save(dailyStatement);
		
//		dailyStatementMapper.saveCount(new DailyStatementTotal());
	}
	
}
