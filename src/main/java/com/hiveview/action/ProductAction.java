package com.hiveview.action;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.hiveview.entity.Category;
import com.hiveview.entity.Paging;
import com.hiveview.entity.Product;
import com.hiveview.service.ICategoryService;
import com.hiveview.service.IProductService;
import com.hiveview.util.LevelUtil;
import com.hiveview.util.StatusUtil;
import com.hiveview.util.log.LogMgr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/member/product")
public class ProductAction extends BaseController{

	@Autowired
	private ICategoryService categoryService;

	@Autowired
	private IProductService productService;



	@RequestMapping(value="/list")
	public String list() {
		return "product/product_list";
	}
	@RequestMapping(value="/page")
	public ModelAndView page(HttpServletRequest request, ModelAndView mav) {
		Paging paging = super.getPaging(request);
		Product product = new Product();
		product.setMemberId(super.getMemberId(request));
//		product.setStatus(StatusUtil.VALID.getVal());
		Page<Object> page = PageHelper.startPage(paging.getCurrentPage(), paging.getPageSize());
		List<Product> products =  productService.getProductPage(product);
		paging.setTotalPages(page.getPages());
		mav.getModel().put("paging",paging);
		mav.getModel().put("products",products);
		mav.setViewName("product/paging");
		return mav;
	}

	@ResponseBody
	@RequestMapping(value="/operation")
	public Boolean operation(HttpServletRequest request,Product product) {
		Boolean flag = false;
		long memberId = super.getMemberId(request);
		if (memberId > 0  && product.getStatus() != null) {
			try {
				product.setMemberId(memberId);
				productService.updateProduct(product);
				flag = true;
			} catch (Exception e) {
				LogMgr.writeErrorLog(e);
			}
		}
		return flag;
	}


	@RequestMapping(value="/toAdd/{productId}")
	public ModelAndView add(ModelAndView mav, @PathVariable("productId") Long productId) {
		Category category = new Category();
		category.setLevel(LevelUtil.ONE_LEVEL.getVal());
		List<Category> oneLevelCategories = categoryService.getCategory(category);
		if (productId > 0 ) {
			Product product= productService.getProductById(productId);
			Category selectClass = categoryService.getCategoryById(product.getClassId());
			category.setOneLevel(selectClass.getOneLevel());
			category.setLevel(LevelUtil.TWO_LEVEL.getVal());
			List<Category> twoLevelCategories = categoryService.getCategory(category);
			category.setLevel(LevelUtil.THREE_LEVEL.getVal());
			category.setTwoLevel(selectClass.getTwoLevel());
			List<Category> threeLevelCategories = categoryService.getCategory(category);
			mav.getModel().put("selectClass", selectClass);
			mav.getModel().put("product", product);
			mav.getModel().put("twoLevelCategories", twoLevelCategories);
			mav.getModel().put("threeLevelCategories", threeLevelCategories);
		}
		mav.getModel().put("oneLevelCategories", oneLevelCategories);
		mav.setViewName("product/product_add");
		return mav;
	}

	@ResponseBody
	@RequestMapping(value="/add")
	public Boolean addOrUpdate(HttpServletRequest request,Product product) {
		Boolean flag = false;
		long memberId = super.getMemberId(request);
		if (memberId > 0 ) {
			try {
				product.setMemberId(memberId);
				long companyId = super.getCompanyId(request);
				if (companyId > 0) {
					product.setCompanyId(companyId);
				}
				if (product.getId() != null) {
                    product.setStatus(StatusUtil.CHECKING.getVal());
					product.setUpdateTime(new Date());
					productService.updateProduct(product);
				} else {
					product.setAddTime(new Date());
					productService.saveProduct(product);
				}
				flag = true;
			} catch (Exception e) {
				LogMgr.writeErrorLog(e);
			}
		}
		return flag;
	}


	@RequestMapping(value="/update")
	public String update(HttpServletRequest request) {
		request.setAttribute("nav","myshop");
		return "product/product_update";
	}

	@RequestMapping(value="/toSuccess")
	public String toSuccess() {
		return "product/success";
	}


}
