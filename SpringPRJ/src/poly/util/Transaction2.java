package poly.util;

import java.security.*;
import java.util.ArrayList;

public class Transaction2 {

	public String transactionId; //this is also the hash of the transaction.
	public PublicKey sender; //senders address/public key.
	public PublicKey reciepient; //recipients address/public key.
	public float value;
	public byte[] signature;//this is to prevent anybody else from spending funds in our wallet.
	
	public ArrayList<TransactionInput> inputs = new ArrayList<TransactionInput>();
	public ArrayList<TransactionOutput> outputs = new ArrayList<TransactionOutput>();
	
	private static int sequence = 0; //a rough count of how many transactions have been generate
	
	//Constructor:
	public Transaction2(PublicKey from, PublicKey to, float value, ArrayList<TransactionInput> inputs) {
		this.sender = from;
		this.reciepient = to;
		this.value = value;
		this.inputs = inputs;
		
	}
	//this calculates the transcation hash(which will be used as its Id)
	public String calculateHash() {
		sequence++; //increase the sequence to avoid 2 identical transactoins having the 
		return Sha256_v2.applySha256(
				Sha256_v2.getStringFromKey(sender)+
				Sha256_v2.getStringFromKey(reciepient)+
				Float.toString(value) + sequence
				);
	}
	
	//Signs all the data we don't wish to be tampered with.
	public void generateSignature(PrivateKey privateKey) {
		String data = Sha256_v2.getStringFromKey(sender) + Sha256_v2.getStringFromKey(reciepient) + Float.toString(value);
		signature = Sha256_v2.applyECDSASig(privateKey, data);
	}
	
	//Verifles the data we signed hasnt been tampered with
	public boolean veriflySignature() {
		String data = Sha256_v2.getStringFromKey(sender) + Sha256_v2.getStringFromKey(reciepient) + Float.toString(value);
		return Sha256_v2.verifyECDSASig(sender, data, signature);
	}
	
	//returns true if new transaction could be created.
	public boolean processTransaction() {
		if(veriflySignature() == false) {
			System.out.println("#Transaction signature failed to verify");
			return false;
			
		}
		//gather transaction inputs(Make sure they are unspent):
		for(TransactionInput i : inputs) {
			i.UTXO = NoobChain.UTXOs.get(i.transactionOutputId);
			
		}
		
		//check if transaction is valid:
		if(getInputsValue() < NoobChain.minimumTransaction) {
			System.out.println("#Transaction inputs to small : " + getInputsValue());
			return false;
		}
		
		//generate transaction outpus:
		float leftOver = getInputsValue() -value; //get value of inputs then the left over change:
		transactionId = calculateHash();
		outputs.add(new TransactionOutput(this.reciepient, value, transactionId)); //send value to recipient
		outputs.add(new TransactionOutput(this.sender,leftOver, transactionId)); //send the left over 'change' back to sender
		
		//add outputs to Unspent list
		for(TransactionOutput o : outputs) {
			NoobChain.UTXOs.put(o.id, o);
		}
		
		//remove transaction inputs from UTXO lists as spent:
		for(TransactionInput i : inputs) {
			if(i.UTXO == null) continue; // if transaction can't be found skip it
			NoobChain.UTXOs.remove(i.UTXO.id);
		}
		return true;
	}
	//returns sum of inputs(utxos) values
	public float getInputsValue() {
		float total = 0;
		for(TransactionInput i : inputs) {
			if(i.UTXO == null) continue; //if transaction can't be found skip it
			total += i.UTXO.value;
		}
		return total;
	}
	
	//returns sum of outputs:
	public float getOutputsValue() {
		float total = 0;
		for(TransactionOutput o : outputs) {
			total += o.value;
		}
		return total;
	}
	
	
	
}
