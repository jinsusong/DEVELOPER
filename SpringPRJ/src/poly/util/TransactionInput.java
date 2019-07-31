package poly.util;

public class TransactionInput {
	public String transactionOutputId; //reference to transactionOutputs -> transactionId
	public TransactionOutput UTXO; //contains the Unspent transactin output
	
	public TransactionInput(String transactionOutputId) {
		this.transactionOutputId = transactionOutputId;
	}
}
