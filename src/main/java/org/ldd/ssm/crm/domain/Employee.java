package org.ldd.ssm.crm.domain;

import java.util.List;


public class Employee {
	private Long id; //id
	private String usrNm = ""; //员工账号
	private String usrPwd = ""; //密码
	private Long departmentId; //部门
	private Integer usrSts; //状态
	private Department department;
	private String compellation;
	private String companyId = "";
	private String weixin = "";
	private String qqNbr = "";
	private String email = "";
	private String phone = "";
	private String bgPath = "";
	private String headPath = "";
	private Long roleId;
	private List<Department> parts;
	private List<RoleNew> roles;
	private String duty;
	private Long createId;
	private int firstLogin;//首次登陆状态：0-是，1-否
	public Employee() {
		super();
	}
	
	public Employee(Long id, String usrNm, String usrPwd, Long departmentId,
			Integer usrSts) {
		super();
		this.id = id;
		this.usrNm = usrNm==null?"":usrNm;
		this.usrPwd = usrPwd==null?"":usrPwd;
		this.departmentId = departmentId;
		this.usrSts = usrSts;
	}
	
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public String getUsrNm() {
		return usrNm;
	}

	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm==null?"":usrNm;
	}

	public String getUsrPwd() {
		return usrPwd;
	}

	public void setUsrPwd(String usrPwd) {
		this.usrPwd = usrPwd==null?"":usrPwd;
	}

	public Long getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Long departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getUsrSts() {
		return usrSts;
	}

	public void setUsrSts(Integer usrSts) {
		this.usrSts = usrSts;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getWeixin() {
		return weixin;
	}

	public void setWeixin(String weixin) {
		this.weixin = weixin==null?"":weixin;
	}

	public String getQqNbr() {
		return qqNbr;
	}

	public void setQqNbr(String qqNbr) {
		this.qqNbr = qqNbr==null?"":qqNbr;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email==null?"":email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone==null?"":phone;
	}

	public String getBgPath() {
		return bgPath;
	}

	public void setBgPath(String bgPath) {
		this.bgPath = bgPath==null?"":bgPath;
	}

	public String getHeadPath() {
		return headPath;
	}

	public void setHeadPath(String headPath) {
		this.headPath = headPath==null?"":headPath;
	}

	public String getCompellation() {
		return compellation;
	}

	public void setCompellation(String compellation) {
		this.compellation = compellation;
	}

	public List<Department> getParts() {
		return parts;
	}

	public void setParts(List<Department> parts) {
		this.parts = parts;
	}

	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}

	public List<RoleNew> getRoles() {
		return roles;
	}

	public void setRoles(List<RoleNew> roles) {
		this.roles = roles;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getCreateId() {
		return createId;
	}

	public void setCreateId(Long createId) {
		this.createId = createId;
	}

	public int getFirstLogin() {
		return firstLogin;
	}

	public void setFirstLogin(int firstLogin) {
		this.firstLogin = firstLogin;
	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", usrNm=" + usrNm + ", usrPwd=" + usrPwd
				+ ", departmentId=" + departmentId + ", usrSts=" + usrSts
				+ ", department=" + department + ", compellation="
				+ compellation + ", companyId=" + companyId + ", weixin="
				+ weixin + ", qqNbr=" + qqNbr + ", email=" + email + ", phone="
				+ phone + ", bgPath=" + bgPath + ", headPath=" + headPath
				+ ", roleId=" + roleId + ", parts=" + parts + ", roles="
				+ roles + ", duty=" + duty + ", createId=" + createId
				+ ", firstLogin=" + firstLogin + "]";
	}
	
}
