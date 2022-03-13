package com.example.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.PointStatDto;
import com.example.dto.ReviewDto;
import com.example.exception.ErrorException;
import com.example.exception.ReviewErrorException;
import com.example.mapper.ReviewMapper;
import com.example.vo.Review;
import com.example.vo.ReviewPoint;
import com.example.vo.ReviewPointType;
import com.example.web.form.Criteria;

@Service
@Transactional
public class ReviewService {
	
	static final Logger logger = LogManager.getLogger(ReviewService.class);

	@Autowired
	private ReviewMapper reviewMapper;
	
	/**
	 * 관람평 작성 시 필요한 관람 포인트를 반환한다.
	 * @return 관람포인트
	 */
	public List<ReviewPointType> getAllPointTypes() {
		return reviewMapper.getAllPointTypes();
	}
	
	/**
	 * 리뷰를 등록한다.
	 * @param review
	 * @param points
	 * @return 작성 리뷰
	 */
	public Review addReview(Review review, List<ReviewPoint> points) {
		try {
			reviewMapper.insertReview(review);
			setReviewPoints(review, points); 
		
		} catch (DataAccessException e) {
			throw new ReviewErrorException("이미 작성한 관람평이 있습니다."); 
		}
		
		return reviewMapper.getReviewByNo(review.getNo());
	}

	/**
	 * 영화에 해당하는 리뷰 개수를 반환한다.
	 * @param movieNo
	 * @return
	 */
	public int getTotalRecords(int movieNo) {
		return reviewMapper.getTotalReviewsByMovieNo(movieNo);
	}
	
	/**
	 * 모든 리뷰를 출력한다.
	 * @param criteria
	 * @return
	 */
	public List<ReviewDto> getAllReviewsByMovie(Criteria criteria) {
		
		List<ReviewDto> reviews = reviewMapper.getAllReviewsByMovieNo(criteria);
		
		for (ReviewDto review: reviews) {
			List<ReviewPointType> pointTypes = reviewMapper.getPointNamesByReviewNo(review.getReviewNo());
			
			List<ReviewPointType> points = new ArrayList<>();
			for (ReviewPointType point : pointTypes) {
				points.add(point);
			}
			
			review.setReviewPoints(points);
		}
		
		return reviews;
	}

	/**
	 * 고객번호와 영화번호에 해당하는 리뷰 정보를 반환한다.
	 * @param customerNo
	 * @param movieNo
	 * @return
	 */
	public ReviewDto getMyReviewByMovieNo(int customerNo, int movieNo) {
		
		ReviewDto dto = new ReviewDto();
		
		Review review = reviewMapper.getMyReviewByMovieNo(customerNo, movieNo);
		List<ReviewPointType> pointTypes = reviewMapper.getPointNamesByReviewNo(review.getNo());
		
		dto.setCustomerId("비공개");
		dto.setReviewNo(review.getNo());
		dto.setReviewContent(review.getReviewContent());
		dto.setReviewScore(review.getReviewScore());
		dto.setReviewPoints(pointTypes);
		
		return dto;
	}
	
	/**
	 * 리뷰를 수정한다.
	 * @param review
	 * @param points
	 * @return
	 */
	public Review updateReview(Review review, List<ReviewPoint> points) {
		
		Review savedReview = reviewMapper.getReviewByNo(review.getNo());
		savedReview.setReviewScore(review.getReviewScore());
		savedReview.setReviewContent(review.getReviewContent());

		reviewMapper.updateReview(savedReview);
		
		// 기존 리뷰 포인트 삭제 후 insert
		reviewMapper.deleteReviewPoints(review.getNo());
		setReviewPoints(review, points); 
		
		return savedReview;
	}
	
	/**
	 * 리뷰를 삭제한다.
	 * @param reviewNo
	 * @return
	 */
	public Review deleteReview(long reviewNo) {
		
		Review savedReview = reviewMapper.getReviewByNo(reviewNo);
		
		reviewMapper.deleteReviewPoints(reviewNo);
		reviewMapper.deleteReview(reviewNo);
		
		return savedReview;
	}
	
	/**
	 * 리뷰 관람 포인트에 대한 통계를 반환한다.
	 * @param movieNo
	 * @return
	 */
	public List<PointStatDto> getReviewCount(int movieNo) {
		
		List<PointStatDto> pointCounts = new ArrayList<>();
		int reviewCount = reviewMapper.getTotalReviewsByMovieNo(movieNo);
		
		for (int pointNo = 1; pointNo <= 5; pointNo++) {
			
			PointStatDto pointStat = new PointStatDto();
			int pointCount = reviewMapper.getReviewPointCount(movieNo, pointNo);
			String pointName = reviewMapper.getPointNameByPointNo(pointNo);
			
			int stat = pointCount * 100 / reviewCount;
			
			pointStat.setPointName(pointName);
			pointStat.setPointNo(pointNo);
			pointStat.setStat(stat);
			
			pointCounts.add(pointStat);
		}
		
		return pointCounts;
	}
	
	/**
	 * 해당 영화에 대한 관람 평점을 반환한다.
	 * @param movieNo
	 * @return
	 */
	public String getMovieScore(int movieNo) {
		
		int totalScore = reviewMapper.getReviewScore(movieNo);
		int reviewCount = reviewMapper.getTotalReviewsByMovieNo(movieNo);
		
		String averageScore = String.format("%.1f", (double) totalScore / (double) reviewCount);
		
		return averageScore;
	}
	
	public boolean getQualification(int customerNo, int movieNo) {
		List<String> isReserved = reviewMapper.getQualification(customerNo, movieNo);
		Review review = reviewMapper.getMyReviewByMovieNo(customerNo, movieNo);
		
		if (isReserved.isEmpty()) {
			throw new ReviewErrorException("관람평은 실관람 이후 작성 가능합니다.");
		}
		
		if (review != null) {
			throw new ReviewErrorException("이미 작성한 관람평이 있습니다.");
		}
		
		return true;
	}

	private void setReviewPoints(Review review, List<ReviewPoint> points) {
		for (ReviewPoint point : points) {
			point.setNo(review.getNo());
			point.setPointNo(point.getPointNo());
			reviewMapper.insertReviewPoint(point); 
		}
	}
}