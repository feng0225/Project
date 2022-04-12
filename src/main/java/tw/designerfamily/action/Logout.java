package tw.designerfamily.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

@Controller
public class Logout {
    //當logout 清除login session 並轉址至首頁
	@RequestMapping(path = "/logout", method = RequestMethod.GET)
	public String processMainAction(SessionStatus sessionStatus,HttpSession session,HttpServletRequest req) {
		session.removeAttribute("login");
		session.removeAttribute("carts");
		return "index_admin";
	}

}
