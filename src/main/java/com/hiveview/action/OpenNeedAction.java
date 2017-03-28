package com.hiveview.action;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.StringUtil;
import com.google.common.collect.Maps;
import com.hiveview.entity.Member;
import com.hiveview.entity.Need;
import com.hiveview.entity.Paging;
import com.hiveview.service.IMemberService;
import com.hiveview.service.INeedService;
import utils.StatusUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

/**
 * Created by huxunqiang on 17/3/19.
 */
@Controller
@RequestMapping("/need")
public class OpenNeedAction extends BaseController{

    @Autowired
    private INeedService needService;
    @Autowired
    private IMemberService memberService;

    @RequestMapping(value="/toSearch")
    public ModelAndView toSearch(HttpServletRequest request, ModelAndView mav) {

        String keyword = request.getParameter("keyword");
        if (StringUtil.isNotEmpty(keyword)) {
            try {
                keyword = URLDecoder.decode(keyword,"UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            mav.getModel().put("keyword", keyword);
        }
        mav.setViewName("openNeed/need_list");
        return mav;
    }
    @RequestMapping(value="/page")
    public ModelAndView page(HttpServletRequest request, ModelAndView mav) {
        Paging paging = super.getPaging(request);
        Need need = new Need();
        String keyword = request.getParameter("keyword");
        if (StringUtil.isNotEmpty(keyword)) {
            need.setTitle(keyword);
        }
        String areaCode = request.getParameter("areaCode");
        if (StringUtil.isNotEmpty(areaCode)) {
            need.setAreaCode(areaCode);
        }
        String classCode = request.getParameter("classCode");
        if (StringUtil.isNotEmpty(classCode)) {
            need.setClassCode(classCode);
        }
        need.setStatus(StatusUtil.CHECK_SUCCESS.getVal());
        Page<Object> page = PageHelper.startPage(paging.getCurrentPage(), paging.getPageSize());
        List<Need> needs =  needService.getOpendNeedPage(need);
        paging.setTotalPages(page.getPages());
        mav.getModel().put("paging",paging);
        mav.getModel().put("needs",needs);
        mav.setViewName("openNeed/paging");
        return mav;
    }

    @RequestMapping(value="/detail/{needId}")
    public ModelAndView detail(ModelAndView mav,@PathVariable("needId") long needId,HttpServletRequest request) {
        String view ="openNeed/detail";
        needService.addHitsByNid(needId);
        Need need = needService.getNeedDetail(needId);
        Integer chargeType = need.getChargeType();
        if (chargeType != null && chargeType == StatusUtil.COLLECT_FEE.getVal()) {
            Long memberId =super.getMemberId(request);
            if (!needService.isViewed(memberId, needId)) {
                view ="redirect:/need/toSearch.html";
            }
        }
        mav.getModel().put("need", need);
        mav.setViewName(view);
        return mav;
    }

    @RequestMapping(value="/useViewCount/{needId}")
    public ModelAndView useViewCount(HttpServletRequest request,ModelAndView mav,@PathVariable("needId") long needId) {
        String view;
        Long memberId =super.getMemberId(request);
        Member member = memberService.getMemberById(memberId);
        Integer viewCount = member.getNeedViewCount();
        if (viewCount != null && viewCount > 0) {
            member.setNeedViewCount(viewCount - 1);
            memberService.updateMember(member);
            needService.addMemberViewNeedRecord(memberId, needId);
            view = "redirect:/need/detail/"+needId+".html";
        } else {
            view = "redirect:/need/toSearch.html";
        }
        mav.setViewName(view);
        return mav;
    }
    /**
     * 获得会员需求点击数
     * @param needId
     * @return 0可以直接观看此需求，1付费需求需要先登陆验证，2 返回会员剩余查看次数
     */
    @ResponseBody
    @RequestMapping(value="/getMemberNeedHits/{needId}")
    public Map<String,Object> getMemberNeedHits(HttpServletRequest request,
                                                @PathVariable("needId") long needId) {
        Map<String, Object> result = Maps.newHashMap();
        int flag = 0;
        Need need = needService.getNeedDetail(needId);
        if (need != null) {
            Integer chargeType = need.getChargeType();
            if (chargeType != null && chargeType == StatusUtil.COLLECT_FEE.getVal()) {
                Long memberId = super.getMemberId(request);
                if (memberId > 0) {
                    Map<String, Object> resultMap = memberService.getViewNeedCount(memberId, needId);
                    if (resultMap.get("viewId") == null) {
                        flag = 2;
                        result.put("count",resultMap.get("needViewCount"));
                    }
                } else {
                    flag = 1;
                }
            }
        }
        result.put("flag", flag);
        return result;
    }

}
