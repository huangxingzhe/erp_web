package com.hxx.erp.model;
/**
 * 角色权限表
 * @author admin
 *
 */
public class RolePrivilege {
	private static final long serialVersionUID = 1L;
	private int id;
	private Role role;
	private int roleId;
	private int menuPriId;
	public RolePrivilege(){
	}

	public RolePrivilege(int roleId,int menuPriId){
		this.roleId = roleId;
		this.menuPriId = menuPriId;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public Role getRole() {
		return role;
	}
	
	public void setRole(Role role) {
		this.role = role;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public int getMenuPriId() {
		return menuPriId;
	}

	public void setMenuPriId(int menuPriId) {
		this.menuPriId = menuPriId;
	}
}
