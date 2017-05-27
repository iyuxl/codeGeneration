package com.code.controller;

import com.code.domain.Columns;
import com.code.domain.ColumnsList;
import com.code.domain.ResultBean;
import com.code.service.ColumnsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by xiaoyaolan on 2016/9/8.
 */
@Controller
@RequestMapping("/code")
public class CodeController {

    private static  final Logger LOG = LoggerFactory.getLogger(CodeController.class);
    @Autowired
    private ColumnsService columnsService;

    @RequestMapping("/init")
    public ModelAndView init() {
        return new ModelAndView("/code/init");
    }
    @RequestMapping("/list")
    public ModelAndView list(String tableName, String tableSchema, Model model, HttpServletRequest request) {
        List<Columns> objs = columnsService.getAllColumns(tableName, tableSchema);
        model.addAttribute("objs", objs);
        model.addAttribute("table", tableName);
        return new ModelAndView("/code/list");
    }

    @RequestMapping("/save")
    public @ResponseBody Object save(ColumnsList obj, HttpServletRequest request, boolean lf) {
        ResultBean rb = new ResultBean(true, "");
        try {
            columnsService.saveCode(obj, lf);
        } catch (Exception e) {
            LOG.error("生成代码异常", e);
            rb.setFlag(false);
            rb.setMsg(e.getMessage());
        }
        return rb;
    }
}
