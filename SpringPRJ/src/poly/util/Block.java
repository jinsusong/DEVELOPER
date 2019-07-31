package poly.util;

import java.util.ArrayList;
import java.util.Date;

public class Block {
	public String hash;
	public String previousHash;
	
	private String data; //our data will be a simple message.
	public long timeStamp; //as number of milliseconds since 1/1/1970.
	public int nonce;
	
	//Block Constructor.
	public Block(String data, String previousHash) {
		this.data = data;
		this.previousHash = previousHash;
		this.timeStamp = new Date().getTime();
		this.hash = calculateHash();//Makeing sure we do this after we set the other values.
	}
	
	public String calculateHash() {
		String calculatedhash = StringUtil.applySha256(
				previousHash + 
				Long.toString(timeStamp) + 
				Integer.toString(nonce) +
				data
				);
		return calculatedhash;
	} 
	
	public void mineBlock(int difficulty) { 
		String target = new String(new char[difficulty]).replace('\0', '0');//create a string with difficulty *
		while(!hash.substring(0, difficulty).equals(target)) { 
			nonce++; 
			hash = calculateHash(); 
		} 
		System.out.println("Block Mined!!! : " + hash); }
	
	//Add transactions to this block
	/*
	 * public boolean addTransaction(Transaction2 transaction) { //process
	 * transaction and check if valid, unless block is genesis block then ignore.
	 * if(transaction == null) return false; if((previousHash != "0")) {
	 * if((transaction.processTransaction() != true)) {
	 * System.out.println("Transaction failed to process. Discarded."); return
	 * false; } } transactions.add(transaction);
	 * System.out.println("transaction successfully added to block"); return true; }
	 */
}
