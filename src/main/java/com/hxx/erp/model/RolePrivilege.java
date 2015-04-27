package com.hxx.erp.model;
/**
 * 角色权限表
 * @author admin
 *
 */
public class RolePrivilege {
	private static final long serialVersionUID = 1L;
	/**
	 * id
	 */
	private int id;
	/**
	 * 角色id
	 */
	private Role role;
	/**
	 * 权限id
	 */
	private RoleMenuPrivilege roleMenuPrivilege;
	
	/**
	 * 角色Id
	 */
	private String roleId;
	
	/**
	 * 菜单权限关联表id
	 */
	private int menuPriId;
	
	
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
	
	public RoleMenuPrivilege getRoleMenuPrivilege() {
		return roleMenuPrivilege;
	}
	
	public void setRoleMenuPrivilege(RoleMenuPrivilege roleMenuPrivilege) {
		this.roleMenuPrivilege = roleMenuPrivilege;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public int getMenuPriId() {
		return menuPriId;
	}

	public void setMenuPriId(int menuPriId) {
		this.menuPriId = menuPriId;
	}
}
