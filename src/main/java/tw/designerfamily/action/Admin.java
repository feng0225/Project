package tw.designerfamily.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("status")
public class Admin {

	@RequestMapping(path = "/admin", method = RequestMethod.GET)
	public String index(HttpServletRequest request,Model m) {

			return "index_admin";
		
	}

}
