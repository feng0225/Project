package tw.designerfamily.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

//web.xml的java程式組態
public class WebApplnitializeer extends AbstractAnnotationConfigDispatcherServletInitializer {
    
	//設定beans.config.xml的java程式組態
	@Override
	protected Class<?>[] getRootConfigClasses() {
		
		return new Class[] {RootAppConfig.class};
		
		//return null;
	}
	//設定mvc-servlet.xml的java程式組態
	@Override
	protected Class<?>[] getServletConfigClasses() {

		return new Class[] {WebAppConfig.class};
		
		//return null;
	}
	//設定servlet mapping的網址
	@Override
	protected String[] getServletMappings() {
		
		return new String[] {"/"};
	}
	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter cef = new CharacterEncodingFilter();
		cef.setEncoding("utf-8");
		cef.setForceEncoding(true);
		
		//CharacterEncodingFilter cef = new CharacterEncodingFilter("utf-8","true");
		
		HiddenHttpMethodFilter hiddenHttpMethodFilter = new HiddenHttpMethodFilter();
		
		return new Filter[] {cef,hiddenHttpMethodFilter};
	}
	
	//int[] data = {1,2,3,4,5} ,  int [] data = new int[5]; data[0]=1 , int[] data = new int[]{1,2,3,4,5}
	
	

}
