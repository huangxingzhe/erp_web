package com.hxx.erp.model;
/**
 * 员工项目关系
 * @author tommy
 */
public class EmployeeProject {
	
	private int id;
	private int employeeId;
	private int projectId;
	private double cut;
	private double times;
	private String employeeName;
	private String projectName;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public double getCut() {
		return cut;
	}
	public void setCut(double cut) {
		this.cut = cut;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public double getTimes() {
		return times;
	}
	public void setTimes(double times) {
		this.times = times;
	}

	
}
