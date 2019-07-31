package poly.dto;

public class BlockDTO {
	private String blocknumber;
	private String timestamp;
	private String blockhash;
	private String nonce;
	private String transaction;
	private String previousHash;
	private String latitude;
	private String longitude;
	private String geoAddr;
	private String chgdt;
	
	
	
	public String getChgdt() {
		return chgdt;
	}
	public void setChgdt(String chgdt) {
		this.chgdt = chgdt;
	}
	public String getGeoAddr() {
		return geoAddr;
	}
	public void setGeoAddr(String geoAddr) {
		this.geoAddr = geoAddr;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getPreviousHash() {
		return previousHash;
	}
	public void setPreviousHash(String previousHash) {
		this.previousHash = previousHash;
	}
	public String getBlocknumber() {
		return blocknumber;
	}
	public void setBlocknumber(String blocknumber) {
		this.blocknumber = blocknumber;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getBlockhash() {
		return blockhash;
	}
	public void setBlockhash(String blockhash) {
		this.blockhash = blockhash;
	}
	public String getNonce() {
		return nonce;
	}
	public void setNonce(String nonce) {
		this.nonce = nonce;
	}
	public String getTransaction() {
		return transaction;
	}
	public void setTransaction(String transaction) {
		this.transaction = transaction;
	}
	
	
}
