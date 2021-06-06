package db.term;

public class Customer {
	private int customer_id;
	private String name;
	private String address;
	private String website;
	private String credit_limt;
	
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getCredit_limt() {
		return credit_limt;
	}
	public void setCredit_limt(String credit_limt) {
		this.credit_limt = credit_limt;
	}

}
