package poly.util;

import java.security.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.security.Provider;

import com.google.gson.GsonBuilder;

public class NoobChain {

	public static ArrayList<Block2> blockchain = new ArrayList<Block2>();
	public static HashMap<String, TransactionOutput> UTXOs = new HashMap<String,TransactionOutput>(); //list of all unspent transactions.
	
	public static int difficulty =3;
	public static float minimumTransaction = 0.1f;
	public static Wallet walletA;
	public static Wallet walletB;
	public static Transaction2 genesisTransaction;
	
	public static void main(String[] args) {
		
		//setup bouncey castle as a Security Provider
		Security.addProvider(new org.bouncycastle .jce.provider.BouncyCastleProvider() );
		
		//create the new wallets
		walletA = new Wallet();
		walletB = new Wallet();
		Wallet coinbase = new Wallet();
		
		//create genesis transaction, which sends 100 NoobCoin to walletA;
		genesisTransaction = new Transaction2(coinbase.publicKey	,walletA.publicKey, 100f,null);
		genesisTransaction.generateSignature(coinbase.privateKey); //manually sign the genesis transaction
		genesisTransaction.transactionId = "0"; //manually set the transaction id
		genesisTransaction.outputs.add(new TransactionOutput(genesisTransaction.reciepient, genesisTransaction.value, genesisTransaction.transactionId));
		UTXOs.put(genesisTransaction.outputs.get(0).id, genesisTransaction.outputs.get(0)); //its important to store our first transaction
		
		System.out.println("Creating and Mining Genesis block...");
		Block2 genesis = new Block2("0");
		genesis.addTransaction(genesisTransaction);
		addBlock(genesis);
		
		//testing
		Block2 block1 = new Block2(genesis.hash);
		System.out.println("\nWalletA's balance is : " + walletA.getBalance());
		
		System.out.println("\nWalletA is Attempting to send funds(40) to WalletB...");
		block1.addTransaction(walletA.sendFunds(walletB.publicKey, 40f));
		addBlock(block1);
		System.out.println("\nWalletA's balance is : " + walletA.getBalance());
		System.out.println("WalletB's balance is : " + walletB.getBalance());
		
		Block2 block2 = new Block2(block1.hash);
		System.out.println("\nWalletA Attempting to send more funds (1000) than it has ...");
		block2.addTransaction(walletA.sendFunds(walletB.publicKey, 1000f));
		addBlock(block2);
		System.out.println("\nWalletA's balance is : " + walletA.getBalance());
		System.out.println("WalletB's balance is :" +walletB.getBalance());
		
		Block2 block3 = new Block2(block2.hash);
		System.out.println("\nWalletB is Attempting to send funds(20) to WalletA..");
		block3.addTransaction(walletB.sendFunds(walletA.publicKey, 20));
		System.out.println("\nWalletA's balance is : " + walletA.getBalance());
		System.out.println("WalletB's balance is :" +walletB.getBalance());
		
		isChainValid();
		
		
		
		//test public and private keys
		/*
		 * System.out.println("private and public keys: ");
		 * System.out.println(Sha256.getStringFromKey(walletA.privateKey));
		 * System.out.println(Sha256.getStringFromKey(walletA.publicKey));
		 * 
		 * //create a test transaction from walletA to walletB Transaction transaction =
		 * new Transaction(walletA.publicKey, walletB.publicKey, 5, null);
		 * transaction.generateSignature(walletA.privateKey); //verify the signature
		 * works and verify it from the public key
		 * System.out.println("is signature verified");
		 * System.out.println(transaction.veriflySignature());
		 */		
		/*
		 * 각각의 블록은 전자 시그니쳐를 가지는데 그 블록의 정보와 이전 블록의 시그니쳐에 기반을 둔다. 블록체인의 형태를 이루기 위해 이 블록들을
		 * ArrayList에 집어 넣는다. 그리고 json 형태로 보기 위해 임포트하도록 한다.
		 
		
		blockchain.add(new Block("Hi im the first block","0"));
		System.out.println("Trying to Mine block 1...");
		blockchain.get(0).mineBlock(difficulty);
		
		
		blockchain.add(new Block("Yo im the second block", blockchain.get(blockchain.size()-1).hash));
		System.out.println("Trying to Mine block 2...");
		blockchain.get(1).mineBlock(difficulty);
		
		
		blockchain.add(new Block("Hey im the third block", blockchain.get(blockchain.size()-1).hash));
		System.out.println("Trying to Mine block 3...");
		blockchain.get(2).mineBlock(difficulty);
		
		System.out.println("\nBlockchain is Valid: " + isChainValid());
		
		String blockchainJson = new GsonBuilder().setPrettyPrinting().create().toJson(blockchain);
		System.out.println("\nBlockchain chain : ");
		System.out.println(blockchainJson);
		*/
		
	}
	
	public static Boolean isChainValid() {
		
		//체인 안에 속해있는 모든 블록들을 루프돌며 해쉬값을 비교 
		//해쉬 변수가 실제로 계산된 해쉬값과 같은지 그리고 이전 블록의 해쉬값이 이전 해쉬의 변수와 같은지를 확인하는 것입니다.
		//블록체인의 블록들에 어떠한 변화라도 생기게 된다면 이 메소드는 false 값을 리턴함
		Block2 currentBlock;
		Block2 previousBlock;
		String hashTarget = new String(new char[difficulty]).replace('\0', '0');
		HashMap<String, TransactionOutput> tempUTXOs = new HashMap<String,TransactionOutput>(); //a temporary working list of unspen
		tempUTXOs.put(genesisTransaction.outputs.get(0).id, genesisTransaction.outputs.get(0));
		
		//loop through blockchain to check hashes:
		for(int i=1; i<blockchain.size(); i++) {
			
			currentBlock = blockchain.get(i);
			previousBlock = blockchain.get(i-1);
			
			//compare registered hash and calculated hash;
			if(!currentBlock.hash.contentEquals(currentBlock.calculateHash()) ) {
				System.out.println("Current Hashes not equal");
				return false;
			}
			
			//compare previous hash and registered previous hash
			if(!previousBlock.hash.equals(currentBlock.previousHash)) {
				System.out.println("Previous Hashes not equal");
				return false;
			}
			
			//check if hash is solved
			if(!currentBlock.hash.substring(0,difficulty).equals(hashTarget)) {
				System.out.println("This block hasn't been mined");
				return false;
			}
			
			//loop thru blockchains transactions:
			TransactionOutput tempOutput;
			for(int t=0; t < currentBlock.transactions.size(); t++) {
				Transaction2 curenTransaction = currentBlock.transactions.get(t);
				
				if(!curenTransaction.veriflySignature()) {
					System.out.println("#Signature on Transaction(" + t + ")is Invalid");
					return false;
				}
				
				if(curenTransaction.getInputsValue() != curenTransaction.getOutputsValue()) {
					System.out.println("#Inputs are note equal to outputs on Transaction(" + t + ")");
					return false;
				}
				for(TransactionInput input : curenTransaction.inputs) {
					tempOutput = tempUTXOs.get(input.transactionOutputId);
					
					if(tempOutput == null) {
						System.out.println("#Referenced input on Transaction(" + t + ") is Missing");
						return false;
					}
					if(input.UTXO.value != tempOutput.value) {
						System.out.println("#Referenced input Transaction("  + t + ") vlaue is Invalid");
						return false;
					}
					tempUTXOs.remove(input.transactionOutputId);
				}
				for(TransactionOutput output : curenTransaction.outputs) {
					tempUTXOs.put(output.id, output);
				}
				if(curenTransaction.outputs.get(0).reciepient != curenTransaction.reciepient) {
					System.out.println("#Transaction(" + t + ") output reciepient is not who is should be");
					return false;
				}
				if(curenTransaction.outputs.get(1).reciepient != curenTransaction.sender) {
					System.out.println("#Transaction(" + t + ") output 'change' is not sender.");
					return false;
				}
			}
		}
		System.out.println("Blockchain is valid");
		return true;
	}
	
	public static void addBlock(Block2 newBlock) {
		newBlock.mineBlock(difficulty);
		blockchain.add(newBlock);
	}

}
