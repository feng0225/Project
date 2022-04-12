package tw.designerfamily.action;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.designerfamily.model.Member;
import tw.designerfamily.model.MemberService;

@Controller
@SessionAttributes("status")
public class Login {


	@RequestMapping(path = "/login", method = RequestMethod.GET)
	public String processMainAction(HttpServletRequest request,Model m) {
		
		if(request.getSession().getAttribute("login")==null) {
			m.addAttribute("status", "登出");
			return "login";
		}else {
			m.addAttribute("status", "登入");
			return "redirect:logout";
		}
	}
	
//	@RequestMapping(path = "/buylogin", method = RequestMethod.GET)
//	public String processMainAction2(HttpServletRequest request,Model m) {
//		
//			return "redirect:checkout";
//
//	}

}
