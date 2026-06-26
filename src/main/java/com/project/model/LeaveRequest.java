package com.project.model;

import java.sql.Date;

public class LeaveRequest {
	private Integer leaveId;
	private Integer userId;
	private String leaveType;
	private Date startDate;
	private Date endDate;
	private String reason;
	private String status;
	private Date appliedDate;
	
	public LeaveRequest() {
		super();
	}
	public LeaveRequest(Integer leaveId, Integer userId, String leaveType, Date startDate, Date endDate, String reason,
			String status, Date appliedDate) {
		super();
		this.leaveId = leaveId;
		this.userId = userId;
		this.leaveType = leaveType;
		this.startDate = startDate;
		this.endDate = endDate;
		this.reason = reason;
		this.status = status;
		this.appliedDate = appliedDate;
	}
	public LeaveRequest(Integer id, String leaveType,Date startDate,Date endDate,
			String reason) {
		this(null, id, leaveType, startDate, endDate, reason, null, null);
	}
	public Integer getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(Integer leaveId) {
		this.leaveId = leaveId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getLeaveType() {
		return leaveType;
	}
	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getAppliedDate() {
		return appliedDate;
	}
	public void setAppliedDate(Date appliedDate) {
		this.appliedDate = appliedDate;
	}
	@Override
	public String toString() {
		return "LeaveRequest [leaveId=" + leaveId + ", userId=" + userId + ", leaveType=" + leaveType + ", startDate="
				+ startDate + ", endDate=" + endDate + ", reason=" + reason + ", status=" + status + ", appliedDate="
				+ appliedDate + "]";
	}
}
