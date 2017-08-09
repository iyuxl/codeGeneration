package com.code.controller;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

/**
 * Created by xiaoyaolan on 2017/8/9.
 */
public class BaseController {
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // 设置List的最大长度
        binder.setAutoGrowCollectionLimit(1000);
    }
}
