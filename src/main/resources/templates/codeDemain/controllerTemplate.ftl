package ${PACKAGE_NAME}.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Lists;
import ${PACKAGE_NAME}.domain.${CLASS_NAME};
import ${PACKAGE_NAME}.exception.ServiceException;
import ${PACKAGE_NAME}.service.${CLASS_NAME}Service;
import com.xkx.domain.ResultBean;
import com.xkx.utils.CommUtil;

@Controller
@RequestMapping("/bk")
public class ${CLASS_NAME}Controller extends BaseController {
    private static final Logger LOG = LoggerFactory.getLogger(${CLASS_NAME}Controller.class);

    @Autowired
    private ${CLASS_NAME}Service ${CLASS_NAME_LINK}Service;

    @RequestMapping(value = "/${CLASS_NAME_LINK}/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
        @RequestParam(value = "page.size", defaultValue = CommUtil.PAGE_SIZE) int pageSize,
        @RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
        ServletRequest request) {
        if (LOG.isInfoEnabled()) {
            LOG.info("List Objects");
        }
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
        Page<${CLASS_NAME}> objs = ${CLASS_NAME_LINK}Service.getObjs(searchParams, pageNumber, pageSize, sortType);
        model.addAttribute("objs", objs);
        // 将搜索条件编码成字符串，用于排序，分页的URL
        model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
        model.addAttribute("pUrl", "/bk/${CLASS_NAME_LINK}/list");
        return "/bk/normal/${CLASS_NAME_LINK}/list";
    }

    @RequestMapping(value = "/${CLASS_NAME_LINK}/create", method = RequestMethod.POST)
    public @ResponseBody ResultBean create(${CLASS_NAME} obj) {
        ResultBean rb = new ResultBean(true, "");
        try {
            IBQSession bq = CommUtil.getSession(this.request);
            if(obj.getId() == null)
            {
                obj.setCreator(bq.getOp().getId().intValue());
                ${CLASS_NAME_LINK}Service.createSave(obj);
            } else {
                //TODO 设置修改人
                ${CLASS_NAME_LINK}Service.updateSave(obj);
            }
        } catch (ServiceException e) {
            rb.setFlag(false);
            rb.setMsg(e.getMessage());
            LOG.error("${CLASS_NAME}保存异常", e);
        } catch (Exception e) {
            rb.setFlag(false);
            rb.setMsg(CommUtil.GLOBAL_ERROR);
            LOG.error("${CLASS_NAME}保存异常", e);
        }
        return rb;
    }

    @RequestMapping(value = "/${CLASS_NAME_LINK}/update/{id}", method = RequestMethod.GET)
    public ModelAndView update(@PathVariable(value = "id") ${PRI} id, Model model) {
        ${CLASS_NAME} obj = ${CLASS_NAME_LINK}Service.getObj(id);
        model.addAttribute("obj", obj);
        return new ModelAndView("/bk/normal/${CLASS_NAME_LINK}/add");
     }
}