package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn; // connection:db에접근하게 해주는 객체
	private ResultSet rs;

	public BbsDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함

		try {
			String dbURL = "jdbc:mysql://localhost:3305/BBS?characterEncoding=UTF-8&serverTimezone=UTC"; // localhost:3306 포트는 컴퓨터설치된 mysql주소
			//jdbc:mysql://localhost:3305/BBS?characterEncoding=UTF-8&serverTimezone=UTC"
			//jdbc:mysql://localhost:3306/dongouck?characterEncoding=UTF-8&serverTimezone=UTC
			String dbID = "root";//root
			String dbPassword = "root";//root
			Class.forName("com.mysql.cj.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace(); // 오류가 무엇인지 출력
		}
	}
	public String getDate(){
		String SQL="SELECT NOW()";//현재의 시간을 가져와주는 MYSQL문장
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()){
				return rs.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";//데이터베이스 오류
	}
	public int getNext(){
		String SQL="SELECT bbsID FROM BBS ORDER BY bbsID DESC";//현재의 시간을 가져와주는 MYSQL문장
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1;
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	public int write(String bbsTitle, String userID, String bbsContent){
		String SQL="INSERT INTO BBS VALUES(?,?,?,?,?,?)";//현재의 시간을 가져와주는 MYSQL문장
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL="SELECT bbsID,bbsTitle, userID, bbsDate, bbsContent, bbsAvailable,  (SELECT COUNT(*) FROM BBSR WHERE bbsID=b.bbsID and bbsrAvailable=1) replyCount FROM BBS b WHERE bbsID <? AND bbsAvailable =1 ORDER BY bbsID DESC limit 10";
		ArrayList<Bbs> list =new ArrayList<Bbs>();
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			//System.out.println(getNext() - (pageNumber - 1)*10);
			//System.out.println("aaa"+getNext()); 똑같이 숫자 값
			rs=pstmt.executeQuery();
			while(rs.next()){
				Bbs bbs= new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2)); 
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setReplyCount(rs.getInt(7));
				list.add(bbs);
			} 
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	public boolean nextPage(int pageNumber){
		String SQL="SELECT *FROM BBS WHERE bbsID <? AND bbsAvailable =1";
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				return true;
			} 
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
		
	}
	public Bbs getBbs(int bbsID){
		String SQL="SELECT *FROM BBS WHERE bbsID = ?";
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()){
				Bbs bbs= new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2)); 
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			} 
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
		
	}
	public int update(int bbsID,String bbsTitle, String bbsContent) {
		String SQL="UPDATE BBS SET bbsTitle=?, bbsContent =? WHERE bbsID =?";//현재의 시간을 가져와주는 MYSQL문장
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	public int delete(int bbsID){
		String SQL="UPDATE BBS SET bbsAvailable = 0 WHERE bbsID =?";//현재의 시간을 가져와주는 MYSQL문장
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
		
	}
	public int writeReply(int bbsID, String reply, String userID){
		String SQL="INSERT INTO BBSR VALUES(?,?,?,?,?,?)";//
		
		try{
			
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, getReplyNext());
			pstmt.setString(3, userID);
			pstmt.setString(4, reply);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	public ArrayList<Bbsr> getReplyList(int bbsID){
		String SQL="SELECT * FROM BBSR WHERE bbsID =? AND bbsrAvailable=1 ORDER BY bbsID DESC";
		ArrayList<Bbsr> listReply =new ArrayList<Bbsr>();
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			//System.out.println("aaa"+getReplyNext());
			rs=pstmt.executeQuery();
			//for(int i=0; i<rs.end();)
			while(rs.next()){
				Bbsr bbsr= new Bbsr();
				bbsr.setBbsID(rs.getInt("bbsID"));
				//System.out.println();
				//아래부터 작동 X
				bbsr.setBbsrID(rs.getInt("bbsrID"));
				bbsr.setUserID(rs.getString("userID"));
				bbsr.setReply(rs.getString("reply"));
				bbsr.setBbsrDate(rs.getString("bbsrDate"));
				bbsr.setBbsrAvailable(rs.getInt("bbsrAvailable"));
				
				listReply.add(bbsr);
				
				//System.out.println("for : "+listReply.toString());
			} 
		}catch(Exception e){
			e.printStackTrace();
		}
		return listReply;
	}
	public Bbsr getBbsr(int bbsID){
		String SQL="SELECT *FROM BBSR WHERE bbsID = ?";
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()){
				Bbsr bbsr= new Bbsr();
				bbsr.setBbsID(rs.getInt(1));
				bbsr.setBbsrID(rs.getInt(2)); 
				bbsr.setUserID(rs.getString(3)); 
				bbsr.setReply(rs.getString(4));
				bbsr.setBbsrDate(rs.getString(5));
				bbsr.setBbsrAvailable(rs.getInt(6));
				return bbsr;
			} 
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
		
	}
	public int getReplyNext(){
		String SQL="SELECT bbsrID FROM BBSR ORDER BY bbsrID DESC";//현재의 시간을 가져와주는 MYSQL문장
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				return rs.getInt(1)+1;
			}
			return 1;
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int deleteReply(int bbsrID){
		String SQL="UPDATE BBSR SET bbsrAvailable = 0 WHERE bbsrID =?";//현재의 시간을 가져와주는 MYSQL문장
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsrID);
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
		
	}
	/*업데이트 예정*/
	public int rewriteReply(int bbsrID, String reply) {
		String SQL="UPDATE bbsr SET reply=? WHERE bbsrID =?";
		try{
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, reply);
			pstmt.setString(2, getDate());
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
}
