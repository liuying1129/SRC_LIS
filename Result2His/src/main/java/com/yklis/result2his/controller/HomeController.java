package com.yklis.result2his.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSON;
import jakarta.servlet.http.HttpServletRequest;


@RestController
@RequestMapping("/")
//允许所有来源的跨域请求
@CrossOrigin(origins = "*")
public class HomeController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

/*
返回JSON格式:
{
    "success":true,
    "errorCode":-123,
    "errorMsg":"",
    "results":[
      {
        "unid":1,
        "patientname":"A",
        "sex":"男",
        "age":"45",
        "resultDetails":[
          {
            "pkcombin_id":"036",
            "combin_Name":"乙肝两对半",
            "itemid":"5501",
            "Name":"乙肝表面抗原",
            "itemvalue":"阴性",
            "Unit":""
          },
          {
            "pkcombin_id":"036",
            "combin_Name":"乙肝两对半",
            "itemid":"5502",
            "Name":"乙肝表面抗体",
            "itemvalue":"阳性",
            "Unit":""
          }
        ]
      },
      {
        "unid":2,
        "patientname":"A",
        "sex":"男",
        "age":"45",
        "resultDetails":[
          {
            "pkcombin_id":"046",
            "combin_Name":"风湿三项",
            "itemid":"9131",
            "Name":"类风湿因子",
            "itemvalue":"23",
            "Unit":"mm/h"
          },
          {
            "pkcombin_id":"046",
            "combin_Name":"风湿三项",
            "itemid":"9132",
            "Name":"血沉",
            "itemvalue":"8.2",
            "Unit":"mm/h"
          }
        ]
      }
    ]
}
 */
    @RequestMapping("queryResult")
    public String queryResult(HttpServletRequest request,
                              //如required设置为true,则地址栏中访问http://localhost:8090/queryResult时,因校验不通过,页面报错
                              @RequestParam(value = "unid",required = false) Integer unid,
                              @RequestParam(value = "his_unid",required = false) String his_unid,
                              @RequestParam(value = "barcode",required = false) String TjJianYan,
                              @RequestParam(value = "reqItemNo",required = false) String Surem1) {

        if (unid==null && (his_unid==null || "".equals(his_unid)) && (TjJianYan==null || "".equals(TjJianYan)) && (Surem1==null || "".equals(Surem1))){

            Map<String, Object> map11 = new HashMap<>();
            map11.put("success", false);
            map11.put("errorCode", -1);
            map11.put("errorMsg", "必需提供参数.注:参数unid为LIS报告单号(整数类型,否则报400),参数his_unid为HIS本次就诊号,参数barcode为条码号,参数reqItemNo为HIS申请项目号(如'0012','0013')");

            return JSON.toJSONStringWithDateFormat(map11, "yyyy-MM-dd HH:mm:ss");
        }

        String sUnid="";
        if(unid!=null) sUnid=" and unid="+unid.toString();

        String sHis_Unid="";
        if(his_unid!=null && !"".equals(his_unid)) sHis_Unid=" and His_Unid='"+his_unid+"'";

        String sTjJianYan="";
        if(TjJianYan!=null && !"".equals(TjJianYan)) sTjJianYan=" and TjJianYan='"+TjJianYan+"'";

        String sSurem1="";
        if(Surem1!=null && !"".equals(Surem1)) sSurem1=" and unid in (select pkunid from view_chk_valu_All where Surem1 in ("+Surem1+"))";

        List<Map<String, Object>> list;
        try{
            list = jdbcTemplate.queryForList("select * from view_Chk_Con_All where isnull(report_doctor,'')<>''"+sUnid+sHis_Unid+sTjJianYan+sSurem1);
        }catch(Exception e){
            Map<String, Object> map44 = new HashMap<>();
            map44.put("success", false);
            map44.put("errorCode", -1);
            map44.put("errorMsg", "sql执行出错:"+e.toString());

            return JSON.toJSONStringWithDateFormat(map44, "yyyy-MM-dd HH:mm:ss");
        }

        if (list.size() <= 0){

            Map<String, Object> map22 = new HashMap<>();
            map22.put("success", false);
            map22.put("errorCode", -1);
            map22.put("errorMsg", "未查询到数据");

            return JSON.toJSONStringWithDateFormat(map22, "yyyy-MM-dd HH:mm:ss");
        }

        for (Map<String, Object> map33 : list) {

            String sPkunid=" and pkunid="+map33.get("unid");
            List<Map<String, Object>> listDetail = jdbcTemplate.queryForList("select *,dbo.uf_ValueAlarm(itemid,Min_value,Max_value,itemvalue) as ifValueAlarm from "+ ("1".equals(map33.get("ifCompleted")) ? "chk_valu_bak" : "chk_valu") +" where issure=1 "+sPkunid);

            map33.put("resultDetails",listDetail);
        }

        Map<String, Object> map = new HashMap<>();
        map.put("success", true);
        map.put("results", list);

        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd HH:mm:ss");
    }
}
