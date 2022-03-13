package com.example.web.restcontroller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.annotation.LoginedUser;
import com.example.dto.PointStatDto;
import com.example.dto.ResponseDto;
import com.example.dto.ReviewDto;
import com.example.exception.ErrorException;
import com.example.exception.ReviewErrorException;
import com.example.pagination.Pagination;
import com.example.service.ReviewService;
import com.example.vo.Customer;
import com.example.vo.Review;
import com.example.vo.ReviewPoint;
import com.example.web.form.Criteria;
import com.example.web.form.ReviewEditForm;
import com.example.web.form.ReviewInsertForm;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest")
public class ReviewRestController {
	
	@Autowired
	private ReviewService reviewService;
				
	@GetMapping("/review")
	public ResponseDto<Map<String, Object>> reviews(Criteria criteria) {
		if (criteria.getPage() < 1) {
			criteria.setPage(1);
		}
		
		int totalRecords = reviewService.getTotalRecords(criteria.getMovieNo());
		Pagination pagination = new Pagination(criteria.getPage(), totalRecords);
		
		criteria.setBeginIndex(pagination.getBegin());
		criteria.setEndIndex(pagination.getEnd());
		String option = criteria.getOption();
		
		ResponseDto<Map<String, Object>> response = new ResponseDto<>();
		List<ReviewDto> reviews = reviewService.getAllReviewsByMovie(criteria);
		int totalReviews = reviewService.getAllReviewsByMovie(criteria).size();
		
		log.info("조건:"+criteria);
		
		response.setStatus(true);
		response.setItems(Map.of("pagination", pagination, "reviews", reviews, "totalReviews", totalReviews, "option", option));
		
		return response;
	}
	
	@PostMapping("/review")
	public ResponseDto<Map<String, Object>> save(@LoginedUser Customer customer, ReviewInsertForm form) {
		
		if (customer == null) {
			throw new ErrorException("로그인이 필요한 서비스입니다.");
		}
		
		ResponseDto<Map<String, Object>> response = new ResponseDto<>();
		
		Review review = new Review();
		BeanUtils.copyProperties(form, review);
		review.setCustomerNo(customer.getNo());
		
		List<ReviewPoint> reviewPoints = new ArrayList<>();
		List<Integer> points = form.getPointNo();
		setReviewPoints(review, reviewPoints, points);
		
		Review savedReview = reviewService.addReview(review, reviewPoints);
		
		response.setStatus(true);
		response.setItems(Map.of("review", savedReview, "points", reviewPoints));
		
		return response;
	}
	
	@GetMapping("/myReview")
	public ResponseDto<Map<String, Object>> myReview(@LoginedUser Customer customer, int movieNo) {
		
		ResponseDto<Map<String, Object>> response = new ResponseDto<>();
		ReviewDto dto = reviewService.getMyReviewByMovieNo(customer.getNo(), movieNo);

		response.setStatus(true);
		response.setItems(Map.of("review", dto, "movieNo", movieNo));
		
		return response;
	}
	
	@PostMapping("/updatedReview")
	public ResponseDto<Map<String, Object>> update(@LoginedUser Customer customer, ReviewEditForm form) {

		if (customer == null) {
			throw new ErrorException("로그인이 필요한 서비스입니다.");
		}
		
		Review review = new Review();
		BeanUtils.copyProperties(form, review);
		
		List<ReviewPoint> reviewPoints = new ArrayList<>();
		List<Integer> points = form.getPointNo();
		setReviewPoints(review, reviewPoints, points);
		
		ResponseDto<Map<String, Object>> response = new ResponseDto<>();
		Review updatedReview = reviewService.updateReview(review, reviewPoints);
		
		response.setStatus(true);
		response.setItems(Map.of("review", updatedReview, "points", reviewPoints));
		
		return response;
	}

	@DeleteMapping("/review")
	public Review delete(@LoginedUser Customer customer, long reviewNo) {
		
		Review review = reviewService.deleteReview(reviewNo);
		return review;
	}
	
	@GetMapping("/pointCounts")
	public ResponseDto<List<PointStatDto>> pointCounts(int movieNo) {
		 
		ResponseDto<List<PointStatDto>> response = new ResponseDto<>();
		List<PointStatDto> pointCounts = reviewService.getReviewCount(movieNo);

		response.setStatus(true);
		response.setItems(pointCounts);
		
		return response;
	}
	
	@GetMapping("/movieScore")
	public String movieScore(int movieNo) {
		return reviewService.getMovieScore(movieNo);
	}
	
	@GetMapping("/check")
	public ResponseDto<Map<String, Object>> checkQualification(@LoginedUser Customer customer, int movieNo) {
		
		ResponseDto<Map<String, Object>> response = new ResponseDto<>();
		boolean isPossibleToWrite = reviewService.getQualification(customer.getNo(), movieNo);
		
		if (isPossibleToWrite) {
			response.setStatus(true);
			response.setItems(Map.of("review", "작성 가능"));
		}
		
		return response;
	}
	
	private void setReviewPoints(Review review, List<ReviewPoint> reviewPoints, List<Integer> points) {
		for (Integer point : points) {
			ReviewPoint reviewPoint = new ReviewPoint();
			reviewPoint.setNo(review.getNo());
			reviewPoint.setPointNo(point);
			
			reviewPoints.add(reviewPoint);
		}
	}
}
