package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.model.LeaveRequest;

public interface LeaveDAO {
	//Employee
	boolean applyLeave(LeaveRequest request);
	List<LeaveRequest> viewLeaves(Integer userId);
	boolean cancelLeave(Integer leaveId);
	LeaveRequest viewLeave(Integer leaveId);
	
	//Admin
	List<LeaveRequest> viewAllRequests();
	boolean approveLeave(Integer leaveId);
	boolean rejectLeave(Integer leaveId);
	LeaveRequest searchLeaveRequest(Integer leaveId);
	List<LeaveRequest> searchByStatus(String status);
	Map<String, List<LeaveRequest>> dashBoardCount();
	
}
