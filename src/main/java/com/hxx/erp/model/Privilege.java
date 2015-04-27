package com.hxx.erp.model;

import java.io.Serializable;

/**
 * 权限表
 * @author admin
 *
 */
public class Privilege implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int id;		//权限id
	private String name;	//权限名称
	private String value;	//权限值
	/*下面为临时变量 */
	private Integer menuPrivilegeId;	//菜单权限表id
	private boolean check;				//菜单是否拥有该权限、角色是否拥有该权限
	private String checked;
	public Privilege(){
	}

	public Privilege(String name,int id,boolean check){
		this.name = name;
		this.id = id;
		this.check = check;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getValue() {
		return value;
	}
	
	public void setValue(String value) {
		this.value = value;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public Integer getMenuPrivilegeId() {
		return menuPrivilegeId;
	}
	
	public void setMenuPrivilegeId(Integer menuPrivilegeId) {
		this.menuPrivilegeId = menuPrivilegeId;
	}

	public boolean isCheck() {
		return check;
	}

	public void setCheck(boolean check) {
		this.check = check;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

}
