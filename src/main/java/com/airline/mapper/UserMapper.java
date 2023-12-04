package com.airline.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.airline.vo.BoardDiaryVO;
import com.airline.vo.BoardEventVO;
import com.airline.vo.BoardNoticeVO;
import com.airline.vo.BoardQnaVO;
import com.airline.vo.CancelVO;
import com.airline.vo.Criteria;
import com.airline.vo.FlightResVO;
import com.airline.vo.KakaoUserVO;
import com.airline.vo.PointVO;
import com.airline.vo.UserPayVO;

@Component
public interface UserMapper {
	
	public KakaoUserVO getUser(String userId);

	public String getGrade(int gradeCode);

	public UserPayVO getPoint(String userid);

	public int getSumP(String userid);

	public List<UserPayVO> getPoint3(String userid);

	public int getSumK(String userid);

	public List<PointVO> getKakao3(String userid);
	
	public List<BoardDiaryVO> getDiary(String userid);

	public List<KakaoUserVO> getUserInfoAll();

	public List<UserPayVO> getSale();

	public List<CancelVO> reqCancel();

	public List<FlightResVO> getFlightres();

	public List<BoardNoticeVO> getNotice();

	public List<BoardEventVO> getEvent();

	public int chargePoint(@Param("userid")String userid,@Param("amount") int amount);

	public List<PointVO> getKPoint(@Param("userid")String userid,@Param("cri") Criteria cri);

	public List<UserPayVO> getMPoint(@Param("userid")String userid,@Param("cri")Criteria cri);

	public int getKTotal(@Param("userid")String userid,@Param("cri") Criteria cri);

	public int getMTotal(@Param("userid")String userid,@Param("cri") Criteria cri);

	public List<FlightResVO> getUserRes(@Param("userid")String userid,@Param("cri") Criteria cri);

	public int getCountBuy(String userid);

	public int getTotal(String userid);

	public int getFlightTotal(@Param("userid")String userid,@Param("cri")Criteria cri);

	public int cancelTicket(String data);

	public int checkin(String data);

	public List<FlightResVO> getFlight3(String userid);

	public String getUserName(String userid);

	public List<BoardQnaVO> getQna(String username);
	

}
