package com.yklis.result2his;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/*
运行JDBC操作时报错:
javax.net.ssl.SSLHandshakeException: No appropriate protocol (protocol is disabled or cipher suites are inappropriate)
处理方式:
jdk-17\conf\security\java.security,找到【TLSv1, TLSv1.1,】,删除并保存
https://blog.csdn.net/weixin_41649773/article/details/134245045
 */

@SpringBootApplication
public class Result2hisApplication {

	public static void main(String[] args) {
		SpringApplication.run(Result2hisApplication.class, args);
	}

}
