/**
 * 
 */
package com.hxx.erp.common;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

/**
 * @author Jon Chiang
 * @project HTU001
 * @create_date 2014-8-6 上午9:24:53
 */
public class MybatisBuilder {
	public static void main(String[] args) {
		try {
			System.setProperty("generated.source.dir","");
			List<String> warnings = new ArrayList<String>();
			boolean overwrite = true;
			File configFile = new File("build/generatorConfig.xml");
			ConfigurationParser cp = new ConfigurationParser(warnings);
			Configuration config = cp.parseConfiguration(configFile);
			DefaultShellCallback callback = new DefaultShellCallback(overwrite);
			MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
			for (String warning : warnings) {
				System.out.println(warning);
			}
			myBatisGenerator.generate(null);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
