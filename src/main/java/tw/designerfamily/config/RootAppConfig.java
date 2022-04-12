package tw.designerfamily.config;

import java.util.Properties;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;


//相當於beans.config.xml的java程式組態
@Configuration
@ComponentScan(basePackages = "tw.designerfamily")
@EnableTransactionManagement
public class RootAppConfig {
	
	@Bean
	public DataSource dataSource() throws IllegalArgumentException, NamingException {
		JndiObjectFactoryBean jnidBean = new JndiObjectFactoryBean();
		jnidBean.setJndiName("java:comp/env/jdbc/Designer");//設定為專題jndi mapping
		jnidBean.afterPropertiesSet();
		DataSource ds = (DataSource) jnidBean.getObject();
		
		return ds;
	}
	
	@Bean
	public LocalSessionFactoryBean sessionFactory() throws IllegalArgumentException, NamingException {
		LocalSessionFactoryBean factory = new LocalSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setPackagesToScan("tw.designerfamily");
		factory.setHibernateProperties(addProperties());
		
		return factory;
	}

	private Properties addProperties() {
		Properties prop = new Properties();
		prop.put("hibernate.dialect", org.hibernate.dialect.SQLServerDialect.class);
		prop.put("hibernate.show_sql",Boolean.TRUE);
		prop.put("hibernate.format_sql", Boolean.TRUE);
		//prop.put("hibernate.current_session_context_class", "thread");
		
		//用來提供在Spring @Transactional中透過Session進行修改update()與刪除delete()方法
		prop.put("hibernate.allow_update_outside_transaction",Boolean.TRUE);
		
		return prop;
	}
	
	//sessionfactory必須的
	@Bean
	@Autowired
	public TransactionManager transactionManager(SessionFactory sessionFactory) {
		HibernateTransactionManager txMgr = new HibernateTransactionManager();
		txMgr.setSessionFactory(sessionFactory);
		return txMgr;
	}

}
