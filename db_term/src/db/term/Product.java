package db.term;

public class Product {
	private int product_id;
	private String product_name;
	private String description;
	private int standard_cost;
	private int list_price;
	private int category_id;
	private int quantity;
	

	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getStandard_cost() {
		return standard_cost;
	}
	public void setStandard_cost(int standard_cost) {
		this.standard_cost = standard_cost;
	}
	public int getList_price() {
		return list_price;
	}
	public void setList_price(int list_price) {
		this.list_price = list_price;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	
	
	
}
