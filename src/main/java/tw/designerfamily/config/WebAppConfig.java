package tw.designerfamily.config;

import java.util.ArrayList;
import java.util.List;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.fasterxml.jackson.annotation.JsonView;

//相當於mvc-servlet.xml的java程式組態設定
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "tw.designerfamily")
public class WebAppConfig implements WebMvcConfigurer {

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		
		configurer.enable();
	
	}
	
	@Bean
	public InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver irvr = new InternalResourceViewResolver();
		irvr.setPrefix("/WEB-INF/pages/");
		irvr.setSuffix(".jsp");
		irvr.setOrder(6);
		
		return irvr;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/src/**").addResourceLocations("/WEB-INF/resources/src/");
		registry.addResourceHandler("/vendors/**").addResourceLocations("/WEB-INF/resources/vendors/");
		//registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/resources/images/");
		//registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/resources/css/");
		//registry.addResourceHandler("/js/**").addResourceLocations("WEB-INF/resources/js");
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addRedirectViewController("/", "/login");
//		registry.addViewController("/resourcesAction").setViewName("staticResources");
		
	}

	//上傳檔案
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver cmr = new CommonsMultipartResolver();
		cmr.setDefaultEncoding("utf-8");
		return cmr;
	}
	
//	@Bean //解析json格式
//	public MappingJackson2JsonView mJackson2JsonView() {
//		MappingJackson2JsonView mjv = new MappingJackson2JsonView();
//		mjv.setPrettyPrint(true);
//		return mjv;
//	}
//	
//	@Bean
//	public Jaxb2Marshaller jaxb2Marshaller() {
//		 Jaxb2Marshaller jaxb2 = new Jaxb2Marshaller();
//		 jaxb2.setPackagesToScan("tw.designerfamily");
//		 return jaxb2;
//		 
//	}
	
//	@Bean
//	public ContentNegotiatingViewResolver cResolver() {
//		ContentNegotiatingViewResolver cnvr = new ContentNegotiatingViewResolver();
//		ArrayList<ViewResolver> resolver = new ArrayList<ViewResolver>();
//		cnvr.setViewResolvers(resolver);
//		
//		List<View> defaultview = new ArrayList<View>();
//		defaultview.add(new MappingJackson2JsonView());
//		cnvr.setDefaultViews(defaultview);
//		
//		return cnvr;
//	}
//	
	

}
