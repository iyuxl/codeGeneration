package com.code.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by xiaoyaolan on 2017/5/24.
 */
@Controller
public class HomeController {
    @RequestMapping("/")
    public String index() {
        return "redirect:/code/init";
    }
}
