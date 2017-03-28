package com.hiveview.action;

import com.google.common.collect.Maps;
import com.hiveview.entity.Attribute;
import com.hiveview.entity.Category;
import com.hiveview.service.ICategoryService;
import utils.log.LogMgr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member/category")
public class CategoryAction {

    @Autowired
    private ICategoryService categoryService;

    @ResponseBody
    @RequestMapping(value="/getSonCategory")
    public Map<String,Object> getSonCategory(HttpServletRequest request) {
        Map<String, Object> result = Maps.newHashMap();
        Boolean flag = true;
        String parentId = request.getParameter("parentId");
        try {
            List<Category> categorys= categoryService.getSonCategory(Long.parseLong(parentId));
            result.put("categorys",categorys);
        } catch (Exception e) {
            LogMgr.writeErrorLog(e);
            flag = false;
        }
        result.put("flag",flag);
        return result;
    }

    @ResponseBody
    @RequestMapping(value="/getAttribute")
    public List<Attribute> getAttribute(HttpServletRequest request) {
        String categoryId = request.getParameter("categoryId");
        List<Attribute> attributes = null;
        try {
             attributes= categoryService.getCategoryAttribute(Long.parseLong(categoryId));
        } catch (Exception e) {
            LogMgr.writeErrorLog(e);
        }
        return attributes;
    }


}
