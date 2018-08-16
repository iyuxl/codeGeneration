package ${PACKAGE_NAME}.controller.${MK};

import com.google.common.collect.Lists;
import com.si.common.CommUtil;
import com.si.common.CommonUtil;
import com.si.common.session.IBQSession;
import com.si.common.web.Servlets;
import com.si.common.web.XkxServlets;
import com.si.controller.BaseController;
import com.si.entity.ResultBean;
import ${PACKAGE_NAME}.entity.${MK}.${CLASS_NAME};
import com.si.service.ServiceException;
import ${PACKAGE_NAME}.service.${MK}.I${CLASS_NAME}Service;
import com.vip.vjtools.vjkit.collection.ArrayUtil;
import com.vip.vjtools.vjkit.time.DateFormatUtil;
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

import javax.servlet.ServletRequest;
import java.util.List;
import java.util.Map;

/**
 *  ${CLASS_NAME}web操作相关方法
 *  @author ${author} on ${D}.
 */
@Controller
@RequestMapping("/bk")
public class ${CLASS_NAME}Controller extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(${CLASS_NAME}Controller.class);

   /**
    * 账簿服务类
    */
    @Autowired
    private I${CLASS_NAME}Service ${CLASS_NAME_LINK}Service;

    /**
     * 列表查询
     * @param pageNumber
     * @param pageSize
     * @param sortType
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/${CLASS_NAME_LINK}/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
        @RequestParam(value = "page.size", defaultValue = CommUtil.PAGE_SIZE) int pageSize,
        @RequestParam(value = "sortType", defaultValue = CommUtil.DESC) String sortType, Model model,
        ServletRequest request) {
        Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, CommUtil.SEARCH_PRE);
        Page<${CLASS_NAME}> objs = ${CLASS_NAME_LINK}Service.selectPage(searchParams, pageNumber, pageSize, sortType, SORT_PROPERTY);
        model.addAttribute("objs", objs);
        // 将搜索条件编码成字符串，用于排序，分页的URL
        model.addAttribute("searchParams", XkxServlets.encodeParameterStringWithPrefix(searchParams, CommUtil.SEARCH_PRE));
        setBaseModel(model);
        return "bk/${CLASS_NAME_LINK}/list";
    }

    /**
     * 编辑保存
     * @param obj
     * @return
     */
    @RequestMapping(value = "/${CLASS_NAME_LINK}/create", method = RequestMethod.POST)
    public @ResponseBody ResultBean create(${CLASS_NAME} obj) {
        ResultBean rb = new ResultBean(true, "");
        try {
            IBQSession bq = CommUtil.getSession(this.request);
            if(obj.getId() == null)
            {
                obj.setCreator(bq.getOp().getLogin());
                ${CLASS_NAME_LINK}Service.insert(obj);
            } else {
                //TODO 设置修改人
                obj.setUpdater(bq.getOp().getLogin());
                ${CLASS_NAME_LINK}Service.update(obj);
            }
        } catch (JpaSystemException e){
            rb.setFlag(false);
            /**
            * jpa乐观锁生效
            */
            if (e.getRootCause() instanceof StaleStateException)
            {
                rb.setMsg("该记录已被修改，请重新编辑");
            } else {
                rb.setMsg(CommUtil.GLOBAL_ERROR);
            }
        } catch (ServiceException e) {
            rb.setFlag(false);
            rb.setMsg(e.getMessage());
            logger.error("${CLASS_NAME}保存异常", e);
        } catch (Exception e) {
            rb.setFlag(false);
            rb.setMsg(CommUtil.GLOBAL_ERROR);
            logger.error("${CLASS_NAME}保存异常", e);
        }
        return rb;
    }

    /**
     * 查询编辑信息
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/${CLASS_NAME_LINK}/update/{id}", method = RequestMethod.GET)
    public ModelAndView update(@PathVariable(value = "id") ${PRI} id, Model model) {
        ${CLASS_NAME} obj = ${CLASS_NAME_LINK}Service.selectById(id);
        model.addAttribute("obj", obj);
        setBaseModel(model);
        return new ModelAndView("bk/${CLASS_NAME_LINK}/add");
     }

    /**
     * 删除信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/${CLASS_NAME_LINK}/delete/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResultBean delete(@PathVariable(value = "id") Long id) {
        ResultBean rb = new ResultBean(true, "");
        try {
            ${CLASS_NAME_LINK}Service.deleteById(id);
        } catch (ServiceException e) {
            rb.setFlag(false);
            rb.setMsg(e.getMessage());
            logger.error("${CLASS_NAME}删除异常", e);
        } catch (Exception e) {
            rb.setFlag(false);
            rb.setMsg(CommUtil.GLOBAL_ERROR);
            logger.error("${CLASS_NAME}删除异常", e);
        }
        return rb;
    }
}