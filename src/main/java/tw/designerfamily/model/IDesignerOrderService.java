package tw.designerfamily.model;

import java.util.List;

public interface IDesignerOrderService {
	
	public void insert(Order o);
	public List<Order> selectAll();
	public Order selectById(int id);
	public void update(Order o);
	public void deleteById(int id);
	public List<Order> search(String key);
	public Order updateorder(int orderNo, int orderQty, int orderPrice, String orderStatus);
	public List<Order> detail(int key);
	public Order updateAfterPay(String id);
}
