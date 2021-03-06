package tw.designerfamily.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.google.gson.JsonObject;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutOneTime;
import ecpay.payment.integration.ecpayOperator.EcpayFunction;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import tw.designerfamily.model.CartItem;
import tw.designerfamily.model.IDesignerOrderService;
import tw.designerfamily.model.IDesignerProductService;
import tw.designerfamily.model.Order;
import tw.designerfamily.model.ProductBean;

@SessionAttributes("carts")
@Controller
public class OrderController {

	@Autowired
	private IDesignerOrderService service;
	
	@Autowired
	private IDesignerProductService service1;
	
	//??????post???
		@RequestMapping(path = "/showorder", method = RequestMethod.POST)
		public String processMainActionPost(Model m) {
			List<Order> list = service.selectAll();
			m.addAttribute("list", list);
			return "orderDetail";
			
		}
		//???????????????
		@RequestMapping(path = "/showorder", method = RequestMethod.GET)
		@ResponseBody
		public List<Order> processMainAction(Model m,HttpServletRequest request) {
			System.out.println("come in");
				List<Order> list = service.selectAll();
				m.addAttribute("list", list);
				return list;
			}
			
	
	@RequestMapping(path ="/deleteorder/{id}", method = RequestMethod.GET)
	@ResponseBody
	public void processAction2(@PathVariable("id") int id) {
		System.out.println("come innnnnn");
		service.selectById(id);
		service.deleteById(id);
	}
	
	@RequestMapping(path="/searchorder", method = RequestMethod.POST)
	public String processAction3(@RequestParam("keyword") String key,Model m) {
		List<Order> order = service.search(key);
		m.addAttribute("list",order);
		return "orderDetail";
	}
	
	@RequestMapping(path = "/reviseorder", method = RequestMethod.POST)
	public String processAction4(@RequestParam("orderNo") int id,Model m) {
		Order order = service.selectById(id);
		m.addAttribute("order", order);
		
		ArrayList<String> op = new ArrayList<String>();
        op.add("?????????");
        op.add("????????????");
        m.addAttribute("option", op);
        
		return "orderrevise";
	}
	
	@RequestMapping(path = "/checkO", method = RequestMethod.POST)
	public String processAction5(@RequestParam("orderNo") int id,@RequestParam("orderQty") int qty,
			@RequestParam("orderPrice") int p,@RequestParam("orderStatus") String status) {

		service.updateorder(id, qty, p, status);
		
		return "redirect:showorder";

	}
	
	@RequestMapping(path = "/buy",method = RequestMethod.POST)
	public String processAction6(Model m) {
		List<ProductBean> list = service1.selectAll();
		m.addAttribute("goods", list);
		return "BuyGoods";
	}
	
	//?????????GET
	@RequestMapping(path = "/buy",method = RequestMethod.GET)
	public String processActionR(Model m) {
		List<ProductBean> list = service1.selectAll();
		m.addAttribute("goods", list);
		
		return"BuyGoods";
	}
	
	@RequestMapping(path = "/mycart",method = RequestMethod.POST)
	public String processAction(HttpServletRequest request) {
		
		return "Cart";
	}
	
	//GET?????????
	@RequestMapping(path = "/mycart",method = RequestMethod.GET)
	public String processCart(HttpServletRequest request) {
		
			return "Cart";
		}
	
	//?????????
	@RequestMapping(path = "/cartItem",method = RequestMethod.POST,produces ="text/plain;charset=utf-8")
	public String processAction7(@RequestParam("commNo")int id,Model m,HttpServletRequest request,@RequestParam("total")int qty) {
		
			ProductBean goods = service1.selectById(id);//???????????????by id
			CartItem od = new CartItem(goods, qty, goods.getCommPrice()*qty); //new?????? CartItem,?????????????????????,??????,?????????
			if(request.getSession().getAttribute("carts")==null) {//???????????????carts??????session,???????????? new??????Arraylist??????CartItem??????
				List<CartItem> list = new ArrayList<CartItem>();
				list.add(od);
				m.addAttribute("carts", list);
			}else {//???carts session?????? null
				@SuppressWarnings("unchecked")
				List<CartItem> list = (List<CartItem>)request.getSession().getAttribute("carts");//list??????carts????????????
				boolean found = false;
				Iterator<CartItem> it = list.iterator();//????????????CartItem
				while(!found && it.hasNext()) {
					CartItem aod = it.next();
					if(aod.getProduct().getCommNo()==od.getProduct().getCommNo()) {
						aod.setQty(aod.getQty()+od.getQty());
						aod.setTotalprice(aod.getTotalprice()+od.getQty()*od.getProduct().getCommPrice());
						found = true;
					}
				}
				if(!found) {
					list.add(od);
				}
				}
				
		return "redirect:buy";
	}
	
	@RequestMapping(path = "/removeCart",method = RequestMethod.POST)
	public String processAction8(@RequestParam("commNo") int id,HttpServletRequest request,Model m) {
		
		@SuppressWarnings("unchecked")
		List<CartItem> list = (List<CartItem>)request.getSession().getAttribute("carts");
		Iterator<CartItem> it = list.iterator();
		while(it.hasNext()) {
			CartItem aod = it.next();
			if(aod.getProduct().getCommNo()==id) {
					it.remove();
				}
			}
		
		return "Cart";
	}
	
	@RequestMapping(path = "/checkout",method = RequestMethod.POST)
	public String processAction9(HttpServletRequest request,Model m,HttpSession session,@RequestParam("qty")int qty) {
		@SuppressWarnings("unchecked")
		List<CartItem> list = (List<CartItem>)request.getSession().getAttribute("carts");
		m.addAttribute("check", list);
		
		if(qty==0) {
			return "redirect:cartItem";
		}else {
			return "Pay";
		}
	}

	@RequestMapping(path = "/generatedorder",method = RequestMethod.POST)
	public String processAction10(HttpServletRequest request, HttpSession session,@RequestParam("price")int price,@RequestParam("qty") int qty,@RequestParam("user") String user,Model m) {
		
		UUID uuid = UUID.randomUUID();
		String key=uuid.toString().replaceAll("-", "").substring(0,20);
		
		if(request.getSession().getAttribute("login")==null) {
			
			return"redirect:login";
			
		}else {
			@SuppressWarnings("unchecked")
			List<CartItem> list = (List<CartItem>)request.getSession().getAttribute("carts");
			LinkedHashSet<CartItem> items = new LinkedHashSet<CartItem>(list);
			Timestamp time =new Timestamp(Instant.now().toEpochMilli());//??????java???????????????????????????insert???db
			String orderdate=time.toString().replaceAll("-", "/").substring(0, 19);
			
			Order order = new Order(user, qty, price, "?????????", key, items, orderdate);
			for(CartItem item:list) {
				item.setOrder(order);
			}
		    service.insert(order);
			
			AioCheckOutOneTime obj = new AioCheckOutOneTime();
			String totalprice = Integer.toString(price);
			obj.setMerchantTradeNo(key);
			obj.setMerchantTradeDate(orderdate);
			obj.setTotalAmount(totalprice);
			obj.setTradeDesc("Donling");
			String temp="";
			for(CartItem item: list) {
				String commTitle = item.getProduct().getCommTitle();
				temp+=commTitle+"#";
			}
			obj.setItemName(temp);
			obj.setReturnURL("http://211.23.128.214:5000");
			obj.setOrderResultURL("http://localhost:8080/DesignerFamily/PaySuccess");
			obj.setNeedExtraPaidInfo("N");
			obj.setRedeem("Y");
			AllInOne all = new AllInOne("");
			String form = all.aioCheckOut(obj, null);
			session.setAttribute("form", form);
			return "ECpage";
		}
			
	}
		
	
	//??????????????????by orderNo
	@RequestMapping(path = "showDetail",method = RequestMethod.POST)
	public String processAction10(@RequestParam("detailNo") int key, Model m) {
		
		List<Order> list = service.detail(key);
		m.addAttribute("detail", list);
		return"ShippingDetail";
	}
	
	
	
	@RequestMapping(path = "/PaySuccess",method = RequestMethod.POST)
	public String TestEC(HttpSession session,HttpServletRequest request,@RequestParam("MerchantID")String ID,@RequestParam("RtnCode")int RtnCode,@RequestParam("MerchantTradeNo") String No,SessionStatus sessionStatus){
		
		if(ID.equals("2000132")&&RtnCode==1) {
			
			service.updateAfterPay(No);
			session.removeAttribute("carts");
			sessionStatus.setComplete();//??????session,??????????????????,??????????????????
			
			return"successpay";
			
		}else {
			
			return"failpay";
		}

	}
}
	 
