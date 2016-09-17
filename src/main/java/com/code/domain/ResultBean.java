package com.code.domain;

import java.io.Serializable;

public class ResultBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7050928273862020550L;
	
	public ResultBean(boolean flag, String msg) {
		this.flag = flag;
		this.msg = msg;
	}
	
	private boolean flag;
	private String msg;
	private Object data;
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
}
