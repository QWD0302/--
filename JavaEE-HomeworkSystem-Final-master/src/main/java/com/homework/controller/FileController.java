package com.homework.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequestMapping(value = "/data")
@Controller

public class FileController {

    @RequestMapping(value="/studentupload" , method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> student(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        System.out.println(file);
        Map map = new HashMap<String,Object>();
        try {
            //String pre = System.getProperty("user.dir") + "/cache";
            String pre = "D:/upload/" + "/student";
            java.io.File path = new java.io.File(pre);
            if (!path.exists()) {
                path.mkdir();
            }
            java.io.File newFile = new java.io.File(pre + "/" + file.getOriginalFilename());
            newFile.createNewFile();
            file.transferTo(newFile);//采用file.transferTo 来保存上传的文件
            map.put("msg","ok");
            map.put("code",200);
        } catch (Exception e) {
            //TODO Auto-generated catch block
            map.put("msg","error");
            map.put("code",0);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value="/teacherupload" , method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> teacher(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        System.out.println(file);
        Map map = new HashMap<String, Object>();
        try {
            String pre = "D:/upload/" + "/teacher";
            java.io.File path = new java.io.File(pre);
                if (!path.exists()) {
                path.mkdir();
            }
            java.io.File newFile = new java.io.File(pre + "/" + file.getOriginalFilename());
            newFile.createNewFile();
            file.transferTo(newFile);//采用file.transferTo 来保存上传的文件
            map.put("msg","ok");
            map.put("code",200);
            System.out.println("1");
        } catch (Exception e) {
            //TODO Auto-generated catch block
            map.put("msg","error");
            map.put("code",0);
            System.out.println("2");
            e.printStackTrace();
        }
        System.out.println("3");
        return map;
    }
}