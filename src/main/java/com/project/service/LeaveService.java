package com.project.service;
import java.util.List;
import java.util.Map;
import com.project.daoimpl.LeaveDAOImpl;
import com.project.model.LeaveRequest;


public class LeaveService {
	private final static String[] leaveType={"PERSONAL","SICK","CASUAL","EMERGENCY","VACATION"};
	private final static String[] status= {
			"PENDING","APPROVED","REJECTED","CANCELLED"
	};
	private final static LeaveDAOImpl leave=new LeaveDAOImpl();
	public static boolean applyLeave(LeaveRequest request) {
		if(request.getUserId()==null||request.getLeaveType()==null||
				request.getStartDate()==null||request.getEndDate()==null
				||request.getReason()==null)return false;
		if(request.getLeaveType().trim().isEmpty()||
				!contains(leaveType,request.getLeaveType()))return false;
		if(UserService.getById(request.getUserId())==null)return false;
		if(request.getStartDate().after(request.getEndDate()))return false;
		if (request.getStartDate().toLocalDate().isBefore(java.time.LocalDate.now())) 
		    return false;
		request.setStatus("PENDING");
		return leave.applyLeave(request);
	}
	public static List<LeaveRequest> viewLeaves(Integer userId) {
		if(userId==null || UserService.getById(userId)==null)return null;
		return leave.viewLeaves(userId);
	}
	public static LeaveRequest viewLeave(Integer leaveId) {
		if(leaveId==null)return null;
		return leave.searchLeaveRequest(leaveId);
	}
	public static List<LeaveRequest> viewAllRequests() {
		return leave.viewAllRequests();
	}
	public static boolean approveLeave(Integer leaveId) {
		return processLeave(leaveId,"approve");
	}
	public static boolean rejectLeave(Integer leaveId) {
		return processLeave(leaveId,"reject");
	}
	public static boolean cancelLeave(Integer leaveId) {
		return processLeave(leaveId,"cancel");
	}
	public static List<LeaveRequest> searchByStatus(String status) {
		if(!contains(LeaveService.status, status))return null;
		return leave.searchByStatus(status);
	}
	public static Map<String, List<LeaveRequest>> dashboard() {
		return leave.dashBoardCount();
	}
	private static boolean contains(String[] str,String target) {
		for(String s:str)if(s.equalsIgnoreCase(target))return true;
		return false;
	}
	private static boolean processLeave(Integer leaveId,String action) {
		if(leaveId==null)return false;
		LeaveRequest validate=leave.viewLeave(leaveId);
		if(validate==null||!validate.getStatus().equalsIgnoreCase("PENDING"))return false;
		if(action.toLowerCase().equals("approve")) return leave.approveLeave(leaveId);
		if(action.toLowerCase().equals("reject"))return leave.rejectLeave(leaveId);
		if(action.toLowerCase().equals("cancel"))return leave.cancelLeave(leaveId);
		return false;
	}
}
