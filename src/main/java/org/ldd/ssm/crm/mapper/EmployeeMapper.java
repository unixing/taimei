package org.ldd.ssm.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ldd.ssm.crm.domain.Employee;
import org.ldd.ssm.crm.domain.Token;

public interface EmployeeMapper {
	
	int save(Employee emp);
	
	int delete(Long id);
	
	int update(Employee emp);
	
	Employee get(Long id);
	
	List<Employee> list(@Param("dptId")Long dptId);
	
	
	List<Employee> getEmployeeByUsername(@Param("usrNm")String usrNm);

	long getCompanyId(Long id);
	
	List<Employee> getEmployeeByCompanyId(@Param("companyId")Long companyId,@Param("cpyNm")String cpyNm);

	void deleteTokenByemp_id(Long id);

	void saveToken(Token token);

	Employee getToken(String parameter);
	
	int unbindMail(Long id);
	
	int updateHeadPath(Employee emp);
	
	int updateBackgroundPath(Employee emp);
	
	Employee getEmployeeByPhone(@Param("phone")String phone);
}
