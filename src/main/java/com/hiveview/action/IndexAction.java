package com.hiveview.action;

import com.hiveview.entity.AppDeveloper;
import com.hiveview.service.IDeveloperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/")
public class IndexAction {

	@RequestMapping(value="/test")
	public ModelAndView test(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("test");
		return mav;
	}

	@RequestMapping(value="/login")
	public ModelAndView login(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("login");
		return mav;
	}

	@RequestMapping(value="/pass_find")
	public ModelAndView passFind(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("password_find");
		return mav;
	}

	@RequestMapping(value="/pass_update")
	public ModelAndView passUpdate(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("password_update");
		return mav;
	}

	@RequestMapping(value="/need/list")
	public ModelAndView need(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("need/list");
		return mav;
	}

	@RequestMapping(value="/introduce")
	public ModelAndView introduce(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("introduce");
		return mav;
	}
	@RequestMapping(value="/reg")
	public ModelAndView reg(HttpServletRequest request, ModelAndView mav) {
		mav.setViewName("reg");
		return mav;
	}


}
