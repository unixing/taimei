package org.ldd.ssm.crm.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.ldd.ssm.crm.domain.FlightSpaceNum;
import org.ldd.ssm.crm.domain.SalesDataFlightInfo;
import org.ldd.ssm.crm.domain.SegmentInfo;
import org.ldd.ssm.crm.domain.SpaceAirData;
import org.ldd.ssm.crm.domain.SpaceInfo;
import org.ldd.ssm.crm.domain.TravellerTicketInfo;
import org.ldd.ssm.crm.mapper.SalesDataMapper;
import org.ldd.ssm.crm.query.SalesDateQuery;
import org.ldd.ssm.crm.service.ISalesDataService;
import org.ldd.ssm.crm.utils.TextUtil;
import org.springframework.stereotype.Service;
/**
 * 销售数据
 * @author wxm
 *
 * @date 2017-3-8
 */
@Service
public class SalesDataServiceImpl implements ISalesDataService {
	@Resource 
	private SalesDataMapper salesDataMapper;
	
	@Override
	public List<String> findFltRteCdList(SalesDateQuery dto) {
		List<String> list=salesDataMapper.findFltRteCdList(dto);
		return list;
	}

	@Override
	public Map<String, Object> findSalesData(SalesDateQuery dto) {
		//得到另一班航班号；
		String fightNumOther="";
		if(!TextUtil.isEmpty(dto.getFlightNum())){
			String fightNumFirst=dto.getFlightNum().substring(0, 2);//前两位
			int lastTwo=Integer.parseInt(dto.getFlightNum().substring(2, 5));//中间
			int last=Integer.parseInt(dto.getFlightNum().substring(5,6));//最后一位
			//若为偶数
			String str= "";
			if(last%2==0){
				if(last==0){
					str =fightNumFirst + (lastTwo-1) + "9";
				}else{
					str = fightNumFirst +lastTwo+  (last-1);
				}
			}else{
				if(last==9){
					str =fightNumFirst + (lastTwo+1) + "0";
				}else{
					str = fightNumFirst +lastTwo+  (last+1);
				}
			}
			fightNumOther= str;
		}
		//得到另一班对应的航线 s3+s2+s1 航线不能为空
		// 经停两个以上地方 这种算法有问题
		String s1=dto.getFltRteCd().substring(0,3);
		String s2=dto.getFltRteCd().substring(3,dto.getFltRteCd().length()-3);
		String s3=dto.getFltRteCd().substring(dto.getFltRteCd().length()-3,dto.getFltRteCd().length());
		Map<String,Object> map=new HashMap<String,Object>();
		map.put(dto.getFlightNum(),findSalesFlightData(dto));
		dto.setFlightNum(fightNumOther);
		dto.setFltRteCd(s3+s2+s1);
		map.put(fightNumOther,findSalesFlightData(dto));
		return map;
	}

	@Override
	public SalesDataFlightInfo findSalesFlightData(SalesDateQuery dto) {
		SalesDataFlightInfo salesDataFlightInfo=new SalesDataFlightInfo();
		//航段信息
		List<SegmentInfo> segmentInfoList=new ArrayList<SegmentInfo>();
		segmentInfoList	=salesDataMapper.findSegmentInfo(dto);
		//segmentInfoList=null; //测试
		//将舱位按航段分出来
		double avgDct=0;//平均折扣(yb运价*容量/票面和)
		double ticketPriTotal=0;//票面和（元）
		long personNum=0;//容量(人)
		List<String> segmentList=new ArrayList<String>();
		//traveller有航段信息
		if(!segmentInfoList.isEmpty()){
			//获取舱位信息
			List<SpaceInfo> spaceInfolist=salesDataMapper.findSpaceInfo(dto);
			for(SegmentInfo segmentInfo:segmentInfoList){
				List<SpaceInfo> spaceInfoLegList=new ArrayList<>();//所有的舱位信息
				String legQue=segmentInfo.getLeg().replace("-","");
				BigDecimal yB=salesDataMapper.getFareByLeg(legQue);
				//查出一部分
				//segmentInfo.setAvgDct(segmentInfo.getAvgDct().divide(yB.multiply(new BigDecimal(segmentInfo.getPersonNum())),2,RoundingMode.HALF_UP));		
				//没有查出来直接算 总价/(yb运价*人数)
				segmentInfo.setAvgDct(segmentInfo.getTicketPriTotal().multiply(new BigDecimal(100)).divide(yB.multiply(new BigDecimal(segmentInfo.getPersonNum())),2,RoundingMode.HALF_UP));
				//算总和
				avgDct +=segmentInfo.getAvgDct().floatValue();//平均折扣
				ticketPriTotal +=segmentInfo.getTicketPriTotal().floatValue();
				personNum +=segmentInfo.getPersonNum();
				//舱位信息
				if(!spaceInfolist.isEmpty()){
					for(SpaceInfo spaceInfo:spaceInfolist){
						if(segmentInfo.getLeg().equals(spaceInfo.getLeg())){//同一个航段下的舱位
							spaceInfoLegList.add(spaceInfo);
						}
					}
					segmentInfo.setSpaceInfoList(spaceInfoLegList);
				}
				//票面信息
				dto.setLeg(segmentInfo.getLeg());
				segmentInfo.setTravellerTicketInfoList(salesDataMapper.findTravellerTicket(dto));
			}
			//只算有数据的航段的平均折扣
			salesDataFlightInfo.setAvgDct(BigDecimal.valueOf(avgDct).divide(new BigDecimal(segmentInfoList.size()),2,RoundingMode.HALF_UP));
			//全部航段
			segmentList=flightSegment(dto.getFltRteCd(), segmentInfoList);
			for(String str:segmentList){
				SegmentInfo segmentInfo=new SegmentInfo();
				segmentInfo.setLeg(str);
				segmentInfo.setFlag(false);
				segmentInfoList.add(segmentInfo);
				
			}
			//三个航段的汇总
			salesDataFlightInfo.setSegmentInfoList(segmentInfoList);
			salesDataFlightInfo.setTicketPri(BigDecimal.valueOf(ticketPriTotal));
			salesDataFlightInfo.setPersonNum(personNum);
			salesDataFlightInfo.setStartTime(dto.getStartTime());
			salesDataFlightInfo.setEndTime(dto.getEndTime());
			salesDataFlightInfo.setFightNum(dto.getFlightNum());
		}else{
			//traveller无信息 从 airInfo和z_airData表中查询
			//航段信息
			segmentInfoList=salesDataMapper.findSegmentInfoByAirData(dto);
			//z_airdata 获得舱位人数 航段
			List<SpaceAirData> spaceAirDataList=salesDataMapper.findSpaceAirData(dto);
			String CpyNm=dto.getFlightNum().substring(0, 2);//航班号前两位位航司代码
			//获得每个航司折扣比例对应的舱位号
			List<FlightSpaceNum> FlightSpaceNumList=salesDataMapper.findFlightSpaceNum(CpyNm);
			List<SpaceInfo> spaceInfoList=new ArrayList<>();
			
			double dctPpt;
			//得到航舱集合
			for(SpaceAirData spaceAirData:spaceAirDataList){
				SpaceInfo spaceInfoOne=new SpaceInfo();
				spaceInfoOne.setLeg(spaceAirData.getLeg());
				spaceInfoOne.setFrtSpe("F");//CDIRJ 都用F表示
				spaceInfoOne.setPersonNum(spaceAirData.getTwoTakPpt());
				spaceInfoList.add(spaceInfoOne);
				List<Double> dctPpts=new ArrayList<>();
				for(FlightSpaceNum flightSpaceNum:FlightSpaceNumList){
					SpaceInfo spaceInfo=new SpaceInfo();
					spaceInfo.setLeg(spaceAirData.getLeg());
					spaceInfo.setFrtSpe(flightSpaceNum.getDctChr());
					dctPpt =flightSpaceNum.getDctPpt();
					//将明确折扣放入集合
					dctPpts.add(flightSpaceNum.getDctPpt());
					if(dctPpt==100){
						spaceInfo.setPersonNum(spaceAirData.getFulPcePpt());
					}else if(dctPpt==90){
						spaceInfo.setPersonNum(spaceAirData.getNneDntPpt());
					}else if(dctPpt==85){
						spaceInfo.setPersonNum(spaceAirData.getEhtFiveDntPpt());
					}else if(dctPpt==80){
						spaceInfo.setPersonNum(spaceAirData.getEhtDntPpt());
					}else if(dctPpt==75){
						spaceInfo.setPersonNum(spaceAirData.getSenFiveDntPpt());
					}else if(dctPpt==70){
						spaceInfo.setPersonNum(spaceAirData.getSenDntPpt());
					}else if(dctPpt==65){
						spaceInfo.setPersonNum(spaceAirData.getSenFiveDntPpt());
					}else if(dctPpt==60){
						spaceInfo.setPersonNum(spaceAirData.getSixDntPpt());
					}else if(dctPpt==55){
						spaceInfo.setPersonNum(spaceAirData.getFveFveDntPpt());
					}else if(dctPpt==50){
						spaceInfo.setPersonNum(spaceAirData.getFveDntPpt());
					}else if(dctPpt==45){
						spaceInfo.setPersonNum(spaceAirData.getFurFveDntPpt());
					}else if(dctPpt==40){
						spaceInfo.setPersonNum(spaceAirData.getFurDntPpt());
					}else if(dctPpt==35){
						spaceInfo.setPersonNum(spaceAirData.getThrFveDntPpt());
					}else if(dctPpt==30){
						spaceInfo.setPersonNum(spaceAirData.getThrDntPpt());
					}else if(dctPpt==25){
						spaceInfo.setPersonNum(spaceAirData.getTwoFveDntPpt());
					}else if(dctPpt==20){
						spaceInfo.setPersonNum(spaceAirData.getTwoDntPpt());
					}
					spaceInfoList.add(spaceInfo);	
				}
				int personNumSum=0;
				SpaceInfo spaceInfo=new SpaceInfo();
				spaceInfo.setLeg(spaceAirData.getLeg());
				spaceInfo.setFrtSpe("特");
				if(!dctPpts.contains(100.0)&&spaceAirData.getFulPcePpt()!=0){
					personNumSum +=spaceAirData.getFulPcePpt();
				}
				if(!dctPpts.contains(90.0)&&spaceAirData.getNneDntPpt()!=0){
					personNumSum +=spaceAirData.getNneDntPpt();
				}
				if(!dctPpts.contains(85.0)&&spaceAirData.getEhtFiveDntPpt()!=0){
					personNumSum +=spaceAirData.getEhtFiveDntPpt();
				}
				if(!dctPpts.contains(80.0)&&spaceAirData.getEhtDntPpt()!=0){
					personNumSum +=spaceAirData.getEhtDntPpt();
				}
				if(!dctPpts.contains(75.0)&&spaceAirData.getSenFiveDntPpt()!=0){
					personNumSum +=spaceAirData.getSenFiveDntPpt();
				}
				if(!dctPpts.contains(70.0)&&spaceAirData.getSenDntPpt()!=0){
					personNumSum +=spaceAirData.getSenDntPpt();
				}
				if(!dctPpts.contains(65.0)&&spaceAirData.getSixFiveDntPpt()!=0){
					personNumSum +=spaceAirData.getSixFiveDntPpt();
				}
				if(!dctPpts.contains(60.0)&&spaceAirData.getSixDntPpt()!=0){
					personNumSum +=spaceAirData.getSixDntPpt();
				}
				if(!dctPpts.contains(55.0)&&spaceAirData.getFveFveDntPpt()!=0){
					personNumSum +=spaceAirData.getFveFveDntPpt();
				}
				if(!dctPpts.contains(50.0)&&spaceAirData.getFveDntPpt()!=0){
					personNumSum +=spaceAirData.getFveDntPpt();
				}
				if(!dctPpts.contains(45.0)&&spaceAirData.getFurFveDntPpt()!=0){
					personNumSum +=spaceAirData.getFurFveDntPpt();
				}
				if(!dctPpts.contains(40.0)&&spaceAirData.getFurDntPpt()!=0){
					personNumSum +=spaceAirData.getFurDntPpt();
				}
				if(!dctPpts.contains(35.0)&&spaceAirData.getThrFveDntPpt()!=0){
					personNumSum +=spaceAirData.getThrFveDntPpt();
				}
				if(!dctPpts.contains(30.0)&&spaceAirData.getThrDntPpt()!=0){
					personNumSum +=spaceAirData.getThrDntPpt();
				}
				if(!dctPpts.contains(25.0)&&spaceAirData.getTwoFveDntPpt()!=0){
					personNumSum +=spaceAirData.getTwoFveDntPpt();
				}
				if(!dctPpts.contains(20.0)&&spaceAirData.getTwoDntPpt()!=0){
					personNumSum +=spaceAirData.getTwoDntPpt();
				}
				if(spaceAirData.getSalTakPpt()!=0){
					personNumSum +=spaceAirData.getSalTakPpt();
				}
				spaceInfo.setPersonNum(personNumSum);
				spaceInfoList.add(spaceInfo);	
			}
			if(!segmentInfoList.isEmpty()){
				//获取票面信息
				for(SegmentInfo segmentInfo:segmentInfoList){
					List<SpaceInfo> spaceInfoLegList=new ArrayList<>();
					//算总和
					avgDct +=segmentInfo.getAvgDct().floatValue();//平均折扣
					ticketPriTotal +=segmentInfo.getTicketPriTotal().floatValue();
					personNum +=segmentInfo.getPersonNum();
					//舱位信息
					if(!spaceInfoList.isEmpty()){
						for(SpaceInfo spaceInfos:spaceInfoList){
							if(segmentInfo.getLeg().equals(spaceInfos.getLeg())){
								spaceInfoLegList.add(spaceInfos);
							}
						}
						segmentInfo.setSpaceInfoList(spaceInfoLegList);
					}
				}
				//只算有数据的航段的平均折扣
				salesDataFlightInfo.setAvgDct(BigDecimal.valueOf(avgDct).divide(new BigDecimal(segmentInfoList.size()),2,RoundingMode.HALF_UP));
				segmentList=flightSegment(dto.getFltRteCd(), segmentInfoList);
				for(String str:segmentList){
					SegmentInfo segmentInfo=new SegmentInfo();
					segmentInfo.setLeg(str);
					segmentInfo.setFlag(false);
					segmentInfoList.add(segmentInfo);
					
				}
				salesDataFlightInfo.setTicketPri(BigDecimal.valueOf(ticketPriTotal));
				salesDataFlightInfo.setPersonNum(personNum);
				salesDataFlightInfo.setStartTime(dto.getStartTime());
				salesDataFlightInfo.setEndTime(dto.getEndTime());
				salesDataFlightInfo.setFightNum(dto.getFlightNum());
			}
				salesDataFlightInfo.setSegmentInfoList(segmentInfoList);//segmentInfoList为空最后也会加进去
		}
		return salesDataFlightInfo;
	}
	
	//获得无数据航段  
	public List<String> flightSegment(String fltRteCd,List<SegmentInfo> segmentInfoList){
		List<String> listOne=new ArrayList<String>();
		List<String> listTwo=new ArrayList<String>();
		if(!segmentInfoList.isEmpty()){
			for(SegmentInfo segmentInfo:segmentInfoList){
				listTwo.add(segmentInfo.getLeg());//获得已有航段
			}
		}
		if(fltRteCd.length()==9&&segmentInfoList.size()!=3){
			String s1=fltRteCd.substring(0,3);
			String s2=fltRteCd.substring(3,fltRteCd.length()-3);
			String s3=fltRteCd.substring(fltRteCd.length()-3,fltRteCd.length());
			listOne.add(s1+"-"+s2);
			listOne.add(s1+"-"+s3);
			listOne.add(s2+"-"+s3);
			listOne.removeAll(listTwo);//需要添加的没有数据的航线
		}
		if(fltRteCd.length()==6&&segmentInfoList.size()!=1){
			String s1=fltRteCd.substring(0,3);
			String s2=fltRteCd.substring(fltRteCd.length()-3,fltRteCd.length());
			listOne.add(s1+"-"+s2);
			listOne.removeAll(listTwo);//需要添加的没有数据的航线
		}
		return listOne;
	}
	
	@Override
	public List<String> findSegmentList(SalesDateQuery dto) {
		return salesDataMapper.findSegmentList(dto);
	}

	@Override
	public List<TravellerTicketInfo> findTravellerTicketExc(SalesDateQuery dto) {
		return salesDataMapper.findTravellerTicketExc(dto);
	}

	@Override
	public List<TravellerTicketInfo> findTicketInfo(SalesDateQuery dto) {
		return salesDataMapper.findTicketInfo(dto);
	}

	@Override
	public String getCurrentTime(SalesDateQuery dto) {
		String s1=dto.getFltRteCd().substring(0,3);
		String s2=dto.getFltRteCd().substring(3,dto.getFltRteCd().length()-3);
		String s3=dto.getFltRteCd().substring(dto.getFltRteCd().length()-3,dto.getFltRteCd().length());
		dto.setFltRteCdOther(s3+s2+s1);
		return salesDataMapper.getCurrentTime(dto);
	}

}
