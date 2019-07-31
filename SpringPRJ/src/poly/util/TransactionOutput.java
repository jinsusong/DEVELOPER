package poly.util;

import java.security.*;

public class TransactionOutput {
	public String id;
	public PublicKey reciepient; //also known as the new owver of these conins.
	public float value; //the amount of onins they own
	public String parentTransactionId; //the id of the transaction this output was created in
	
	//constructor
	public TransactionOutput(PublicKey reciepient, float value, String parentTransactionId) {
		this.reciepient = reciepient;
		this.value = value;
		this.parentTransactionId = parentTransactionId;
		this.id = Sha256_v2.applySha256(Sha256_v2.getStringFromKey(reciepient)+ Float.toString(value)+parentTransactionId);
	}
	
	//check if coin belogs to you
	public boolean isMine(PublicKey publicKey) {
		return (publicKey == reciepient);
	}
}
