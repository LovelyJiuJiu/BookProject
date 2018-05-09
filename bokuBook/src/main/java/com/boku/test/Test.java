package com.boku.test;

import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

public class Test {

	public static void main(String[] args) throws Exception {
		// List<String> warnings = new ArrayList<String>();
		// boolean overwrite = true;
		// InputStream is=
		// Test.class.getClassLoader().getResource("generatorConfig.xml").openStream();
		// ConfigurationParser cp = new ConfigurationParser(warnings);
		// Configuration config = cp.parseConfiguration(is);
		// is.close();
		// DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		// MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,
		// callback, warnings);
		// myBatisGenerator.generate(null);
		// System.out.println("生成代码成功，刷新项目，查看文件,然后执行TestMybatis.java");

		Double d = 538.8;
		BigDecimal a1 = new BigDecimal(Double.toString(d));
		BigDecimal b1 = new BigDecimal(Double.toString(100));
		BigDecimal result = a1.multiply(b1);// 相乘结果
		System.out.println(result.toString().indexOf('.'));
		BigDecimal one = new BigDecimal("1");
		Double a = result.divide(one, 2, BigDecimal.ROUND_HALF_UP).doubleValue();// 保留1位数
		System.out.println(a);

	}
}
