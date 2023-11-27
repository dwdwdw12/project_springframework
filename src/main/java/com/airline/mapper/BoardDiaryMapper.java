package com.airline.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.airline.vo.BoardDiaryVO;
import com.airline.vo.Criteria;

public interface BoardDiaryMapper {

	public List<BoardDiaryVO> getList();

	public List<BoardDiaryVO> getListwithPaging(Criteria cri);

	public BoardDiaryVO get(int boardNum);

	public int insert(BoardDiaryVO vo);
	
	public int delete(int boardNum);
	
	public int update(BoardDiaryVO vo);
	
	public int getTotalCount(Criteria cri);

	public void updateReplyCnt(@Param("boardNum") int boardNum, @Param("amount") int amount); 
	
}