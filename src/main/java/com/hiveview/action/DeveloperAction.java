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
@RequestMapping("/appdeveloper")
public class DeveloperAction {

	@Autowired
	private IDeveloperService developerService;

	@RequestMapping(value="/show")
	@ResponseBody
	public String show() {
		return "aaaaaa";
	}

	@RequestMapping(value="/test")
	public ModelAndView test(HttpServletRequest request, ModelAndView mav) {
		List<AppDeveloper> a = developerService.queryMeg();
		mav.setViewName("test");
		return mav;
	}

}