package com.hxx.erp.model;

import java.io.Serializable;
import java.util.List;

public class Menu implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String url;
	private int pid;
	private int position;
	private int level;
	private int status;
	private List<Menu> childs;
	private List<Privilege> pris;
	private String checked;
	
	public Menu(){}
	
	public Menu(int id,String name,String url) {
		this.id = id;
		this.name = name;
		this.url = url;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public List<Menu> getChilds() {
		return childs;
	}

	public void setChilds(List<Menu> childs) {
		this.childs = childs;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public List<Privilege> getPris() {
		return pris;
	}

	public void setPris(List<Privilege> pris) {
		this.pris = pris;
	}


}
