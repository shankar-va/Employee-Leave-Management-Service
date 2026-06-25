package com.project.daoimpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.project.dao.LeaveDAO;
import com.project.model.LeaveRequest;
import com.project.util.DBConnection;

public class LeaveDAOImpl implements LeaveDAO{
	private static Connection connection =DBConnection.connect();

	@Override
	public boolean applyLeave(LeaveRequest request) {
		String query="INSERT INTO Leave_requests_emp "
				+ "(user_id,leave_type,start_date,end_date,reason)"
				+ " values(?,?,?,?,?)";
	    try {
			PreparedStatement pstm=connection.prepareStatement(query);
			pstm.setInt(1, request.getUserId());
			pstm.setString(2, request.getLeaveType());
			pstm.setDate(3, request.getStartDate());
			pstm.setDate(4, request.getEndDate());
			pstm.setString(5, request.getReason());
			Integer res = pstm.executeUpdate();
			if (res>0)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<LeaveRequest> viewLeaves(Integer userId) {
		String query="SELECT * FROM Leave_requests_emp"
				+ " WHERE user_Id=?";
		PreparedStatement pstm;
		ResultSet result;
		List<LeaveRequest> res=new ArrayList<LeaveRequest>();
		try {
			pstm = connection.prepareStatement(query);
			pstm.setInt(1, userId);
			result=pstm.executeQuery();
			if(!result.next())return null;
			do{
				res.add(getRequest(result));
			}while(result.next());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public boolean cancelLeave(Integer leaveId) {
		String query="UPDATE leave_requests_emp SET status='CANCELLED' where leave_Id=?";
		try {
			PreparedStatement pstm=connection.prepareStatement(query);
			pstm.setInt(1, leaveId);
			Integer res = pstm.executeUpdate();
			if (res>0)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public LeaveRequest viewLeave(Integer leaveId) {

		String query="SELECT * FROM Leave_requests_emp"
				+ " WHERE leave_Id=?";
		PreparedStatement pstm;
		ResultSet result;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setInt(1, leaveId);
			result=pstm.executeQuery();
			if(result.next())return getRequest(result);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<LeaveRequest> viewAllRequests() {
		String query="SELECT * FROM leave_requests_emp";
		PreparedStatement pstm;
		ResultSet result;
		List<LeaveRequest> res=new ArrayList<LeaveRequest>();
		try {
			pstm = connection.prepareStatement(query);
			result=pstm.executeQuery();
			if(!result.next())return null;
			do{
				res.add(getRequest(result));
			}while(result.next());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public boolean approveLeave(Integer leaveId) {
		String query="UPDATE leave_requests_emp SET status='APPROVED' where leave_Id=?";
		try {
			PreparedStatement pstm=connection.prepareStatement(query);
			pstm.setInt(1, leaveId);
			Integer res = pstm.executeUpdate();
			if (res>0)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean rejectLeave(Integer leaveId) {
		String query="UPDATE leave_requests_emp SET status='REJECTED' where leave_Id=?";
		try {
			PreparedStatement pstm=connection.prepareStatement(query);
			pstm.setInt(1, leaveId);
			Integer res = pstm.executeUpdate();
			if (res>0)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public LeaveRequest searchLeaveRequest(Integer leaveId) {
		String query="SELECT * FROM Leave_requests_emp WHERE leave_Id=?";
		PreparedStatement pstm;
		ResultSet result;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setInt(1, leaveId);
			result=pstm.executeQuery();
			if(result.next())return getRequest(result);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<LeaveRequest> searchByStatus(String status) {
		String query="SELECT * from leave_requests_emp where status=?";
		PreparedStatement pstm;
		ResultSet result;
		List<LeaveRequest> res=new ArrayList<LeaveRequest>();
		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, status);
			result=pstm.executeQuery();
			if(!result.next())return null;
			do{
				res.add(getRequest(result));
			}while(result.next());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	
	}

	@Override
	public Map<String, List<LeaveRequest>> dashBoardCount() {
		HashMap<String,List <LeaveRequest>> hash=new HashMap<String, List<LeaveRequest>>();
		hash.put("PENDING",searchByStatus("PENDING"));
		hash.put("APPROVED",searchByStatus("APPROVED"));
		hash.put("REJECTED",searchByStatus("REJECTED"));
		hash.put("CANCELLED",searchByStatus("CANCELLED"));
		return hash;
	}
	
	private static LeaveRequest getRequest(ResultSet result) {
		
		 Integer leaveId=null;
		 Integer userId=null;
		 String leaveType=null;
		 Date startDate=null;
		 Date endDate=null;
		 String reason=null;
		 String status=null;
		 Date appliedDate=null;
		try {
			 leaveId=result.getInt("leave_Id");
			 userId=result.getInt("user_Id");
			 leaveType=result.getString("leave_Type");
			 startDate=result.getDate("start_Date");
			 endDate=result.getDate("end_Date");
			 reason=result.getString("reason");
			 status=result.getString("status");
			 appliedDate=result.getDate("applied_Date");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new LeaveRequest( leaveId,  userId,  leaveType,  startDate,  endDate,  reason,
				 status,  appliedDate);
		
	}

}
