package db.term;

public class Sales {
	private int order_id;
	private int customer_id;
	private String status;
	private int salesman_id;
	private int order_date;

	public int getorder_id() {
		return order_id;
	}
	public void setorder_id(int order_id) {
		this.order_id = order_id;
	}
	
	public int getcustomer_id() {
		return customer_id;
	}
	public void setcustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	
	public String getstatus() {
		return status;
	}
	public void setstatus(String status) {
		this.status = status;
	}
	
	public int getsalesman_id() {
		return salesman_id;
	}
	public void setsalesman_id(int salesman_id) {
		this.salesman_id = salesman_id;
	}
	
	public String getorder_date() {
		return order_date;
	}
	public void setorder_date(String order_date) {
		this.order_date = order_date;
	}
}
