package com.hxx.erp.model;
/**
 * 角色菜单权限表
 * @author admin
 *
 */
public class RoleMenuPrivilege {
	private static final long serialVersionUID = 1L;
	/**
	 * id
	 */
	private int id;
	
	/**
	 * 角色Id
	 */
	private int roleId;
	
	/**
	 * 菜单权限关联表id
	 */
	private int roleMenuId;
	
	/**
	 * 菜单id
	 */
	private Menu menu;
	
	/**
	 * 权限id
	 */
	private Privilege privilege;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	public Privilege getPrivilege() {
		return privilege;
	}
	public void setPrivilege(Privilege privilege) {
		this.privilege = privilege;
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
	public int getRoleMenuId() {
		return roleMenuId;
	}
	public void setRoleMenuId(int roleMenuId) {
		this.roleMenuId = roleMenuId;
	}
}
