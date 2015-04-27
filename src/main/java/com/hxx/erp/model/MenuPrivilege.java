package com.hxx.erp.model;


/**
 * 菜单权限实体类
 */
public class MenuPrivilege {
	private int id;			//id
	private int menuId;		//菜单id
	private int priId;		//权限id
	
	public MenuPrivilege(){
		
	}
	
	public MenuPrivilege(int menuId,int priId){
		this.menuId = menuId;
		this.priId = priId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getPriId() {
		return priId;
	}

	public void setPriId(int priId) {
		this.priId = priId;
	}
	
	
}
