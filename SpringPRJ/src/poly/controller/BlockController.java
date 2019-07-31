package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.GsonBuilder;

import poly.dto.BlockDTO;
import poly.service.IBlockService;
import poly.service.IDeveloperService;
import poly.util.Block;
import poly.util.CmmUtil;
import poly.util.FileUtil;

@Controller
public class BlockController {
	private Logger log = Logger.getLogger(this.getClass());
	
	
	  @Resource(name = "BlockService") private IBlockService blockService;
	 
	@RequestMapping(value="block/blockRegView", method=RequestMethod.GET)
	public String NoticeList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + ".blockRegView start!");
		log.info(this.getClass().getName() + ".developerList end!");
		return "block/blockRegView";
	}

	
	public static ArrayList<Block> blockchain = new ArrayList<Block>();
	public static int difficulty = 5;
	
	//블록 생성
	@RequestMapping(value="block/blockRegProc", method=RequestMethod.POST)
	public String blockRegProc(HttpServletRequest request, Model model) throws Exception{
		log.info(this.getClass().getName() + " .blockRegProc start !!!!");
		
		String title = CmmUtil.nvl(request.getParameter("title"));
		log.info("title : " + title);
		String contents = CmmUtil.nvl(request.getParameter("contents"));
		log.info("content : " + contents);
		String latitude = CmmUtil.nvl(request.getParameter("latitude"));
		log.info("latitude : " + latitude);
		String longitude = CmmUtil.nvl(request.getParameter("longitude"));
		log.info("longitude : " + longitude);
		String geoAddr = CmmUtil.nvl(request.getParameter("geoAddr"));
		log.info("geoAddr : " + geoAddr);
		
		
		
		BlockDTO bDTOgetNo = blockService.getBlockNum();
		log.info("block bDTO : " + bDTOgetNo);
		if(bDTOgetNo == null) {
			bDTOgetNo = new BlockDTO();
		}
		log.info("block number : " +bDTOgetNo.getBlocknumber());

		//add our blocks to the blockchain ArrayList:
		BlockDTO bDTO = new BlockDTO();
		String url = "";
		String msg = "";
		int res;

		if(bDTOgetNo.getBlocknumber().equals("1")) {
			log.info("if getBlock number 1 start");
			//DB에 1번 블록 등록
			blockchain.add(new Block("Hi im the first block", "0"));
			System.out.println("Trying to Mine block 1 ...");
			blockchain.get(0).mineBlock(difficulty);

			blockchain.add(new Block("title : "+title+"\ncontent : "+contents, blockchain.get(blockchain.size()-1).hash));
			System.out.println("Trying to Mine block 2 ...");
			blockchain.get(1).mineBlock(difficulty);
			
			bDTO.setBlocknumber(bDTOgetNo.getBlocknumber());
			bDTO.setBlockhash(blockchain.get(1).hash);
			bDTO.setTimestamp(String.valueOf(blockchain.get(1).timeStamp));
			bDTO.setNonce(String.valueOf(blockchain.get(1).nonce));
			bDTO.setTransaction(" ");
			bDTO.setPreviousHash(blockchain.get(1).previousHash);
			
			res = blockService.insertFirstBlock(bDTO);
			log.info("res : " + res);
			
			
			
		}else {
			//1.DB에서 존재하는 블록 불러와서 
			//2.리스트( blockchain ) 담고
			//3.그 다음 블록 추가하기
			log.info("else getBlock number 1 start");
			List<BlockDTO> bList = blockService.getlist();
			System.out.println("blist size : " + bList.size());
			
			
			System.out.println("\nbList : ");
			System.out.println(bList.get(0).getBlocknumber());
			System.out.println(bList.get(0).getTimestamp());
			System.out.println(bList.get(0).getBlockhash());
			System.out.println(bList.get(0).getNonce());
			System.out.println(bList.get(0).getTransaction());
			
			blockchain.add(new Block("title : "+title+"\ncontent : "+contents, bList.get(0).getBlockhash()));
			System.out.println("Trying to Mine block "+ (blockchain.size()-1) +" ...");
			blockchain.get(blockchain.size()-1).mineBlock(difficulty);
			
			bDTO.setBlocknumber(bDTOgetNo.getBlocknumber());
			bDTO.setBlockhash(blockchain.get(blockchain.size()-1).hash);
			bDTO.setTimestamp(String.valueOf(blockchain.get(blockchain.size()-1).timeStamp));
			bDTO.setNonce(String.valueOf(blockchain.get(blockchain.size()-1).nonce));
			bDTO.setTransaction(" ");
			bDTO.setPreviousHash(blockchain.get(blockchain.size()-1).previousHash);
			bDTO.setLatitude(latitude);
			bDTO.setLongitude(longitude);
			bDTO.setGeoAddr(geoAddr);
			
			
			res = blockService.insertFirstBlock(bDTO);
			log.info("res : " + res);
			
		}
		
		if(res == 1) {
			url ="/main.do";
			msg ="저작권 보호를 위해 블록이 생성되었습니다.";
		}else {
			url ="/main.do";
			msg ="저작권 등록 실패!\n다시 시도해주세요.";
		}
		
		System.out.println("\nBlockchain is Valid : " + isChainValid());
		
		String blockchainJson = new GsonBuilder().setPrettyPrinting().create().toJson(blockchain);
		System.out.println("\nThe block chain : ");
		System.out.println(blockchainJson);
		
		model.addAttribute("url",url);
		model.addAttribute("msg",msg);
		
		url = null;
		msg = null;

		log.info(this.getClass().getName() + " .blockRegProc end !!!!");
		return "/alert";
	}
	//블록 보안 검사
	public static Boolean isChainValid() {
		Block currentBlock;
		Block previousBlock;
		String hashTarget = new String(new char[difficulty]).replace('\0', '0');
		
		//loop through blockchain to check hashes:
		for(int i=1; i < blockchain.size(); i++) {
			currentBlock = blockchain.get(i);
			previousBlock = blockchain.get(i-1);
			//compare registered hash and calculated hash:
			if(!currentBlock.hash.contentEquals(currentBlock.calculateHash())) {
				System.out.println("Current Hashes not equal : 현재 해쉬가 동일하지 않음");
				return false;
			}
			//compare previous hash and registered previous hash
			if(!previousBlock.hash.equals(currentBlock.previousHash)) {
				System.out.println("Previous Hashes not equal : 이전 해쉬가 같지 않음");
				return false;
			}
			//check if hash is solved
			if(!currentBlock.hash.substring(0,difficulty).contentEquals(hashTarget)) {
				System.out.println("This block hasn't been mined : 이 블록은 채굴되지 않았다.");
				return false;
			}
			
		}
		return true; 
	}
	//블록 모니터링 화면
	@RequestMapping(value="/block/blockMonitoring", method=RequestMethod.GET)
	public String blockMonitoring(Model model) throws Exception{
		log.info(this.getClass().getName() + " .blockMonitoring start !!");
		
		List<BlockDTO> bList = blockService.getlist();
		for(int i =0; i < bList.size(); i++) {
			log.info("bList :");
			log.info(bList.get(i).getBlockhash()+"\n");
		}

		model.addAttribute("bList",bList);
		
		bList = null;
		log.info(this.getClass().getName() + " .blockMonitoring end !!");
		//return "/block/blockMonitoring";
		return "/block/blockMonitor";
	}
	
	@RequestMapping(value="blockAdd",method=RequestMethod.POST)
	public String blockAdd (Model model) throws Exception{
		log.info(this.getClass().getName() + " .blockAdd start !!");
		
		System.out.println("\nBlockchain is Valid : " + isChainValid());
		
		
		//해쉬값 강제로 선언해서 블록생성하면 블록검사할때 블록체인에 오류가 있음을 확인할 수 있음.
		blockchain.add(new Block("errorTest", "hashError"));
		System.out.println("Trying to Mine block "+ (blockchain.size()-1) +" ...");
		blockchain.get(blockchain.size()-1).mineBlock(difficulty);
		
		//블록체인에 연결된 블록 검사
		System.out.println("\nBlockchain is Valid : " + isChainValid());
		if(!isChainValid()) {
			System.out.println("!isChainValid() start ");
			model.addAttribute("blockchainError",blockchain);
			
			String blockchainJson = new GsonBuilder().setPrettyPrinting().create().toJson(blockchain);
			System.out.println("\nThe block chain Error : ");
			System.out.println(blockchainJson);
		}
		
		log.info(this.getClass().getName() + " .blockAdd end !!");
		
		return "/block/blockUpdate";
	}
	@RequestMapping(value="blockDel", method=RequestMethod.GET)
	public String blockDel() throws Exception{
		log.info(this.getClass().getName()+"blockDel start !!!");
		
		blockchain.remove(blockchain.size()-1);
		
		System.out.println("\nBlockchain is Valid : " + isChainValid());
		
		String blockchainJson = new GsonBuilder().setPrettyPrinting().create().toJson(blockchain);
		System.out.println("\nThe block chain : ");
		System.out.println(blockchainJson);
		
		log.info(this.getClass().getName()+"blockDel end !!!");
		return "redirect:/main.do";
	}
	@RequestMapping(value="ajaxPage", method=RequestMethod.GET)
	public String ajaxPage(Model model)throws Exception{
		
		log.info(this.getClass().getName() + " .ajaxPage start !!");
		
		List<BlockDTO> bList = blockService.getlist();
		for(int i =0; i < bList.size(); i++) {
			log.info("bList :");
			log.info(bList.get(i).getBlockhash()+"\n");
		}

		model.addAttribute("bList",bList);
		
		bList = null;
		log.info(this.getClass().getName() + " .ajaxPage start !!");
		
		return "/block/blockMonitorList";
	}
	@RequestMapping(value="blockLocation", method=RequestMethod.GET)
	public String blockLocation(Model model)throws Exception{
		log.info(this.getClass().getName() + " .blockLocation start!!!");
		
		List<BlockDTO> bList = blockService.getLocation();
		
		for(int i=0; i<bList.size()-1; i++) {
			log.info("bList location : " + bList.get(i).getBlocknumber());
			log.info("bList location : " + bList.get(i).getLatitude());
			log.info("bList location : " + bList.get(i).getLongitude());
		}
		
		model.addAttribute("bList",bList);
		
		BlockDTO bDTO2 = new BlockDTO();
		bDTO2.setGeoAddr("종로구");
		
		log.info(bDTO2.getGeoAddr());
		
		List<BlockDTO> bList2 = blockService.getanalysis(bDTO2);
		
		System.out.println("bList2 length : " + bList2.size());
		log.info("bList2 get : " + bList2.get(0).getChgdt());
		
		String hour;
		String minute; 
		for(int i=0; i< bList2.size()-1; i++) {
			hour = bList2.get(i).getChgdt().substring(11, 13);
			minute = bList2.get(i).getChgdt().substring(14, 16);
			
		}
		/*
		 * String chgdt = "2019-01-01 01:48:44"; 
		 * String[] time = chgdt.split(" ");
		 * System.out.println(time[1]);
		 * 
		 * String[] timeSplit = time[1].split(":"); 
		 * System.out.println(timeSplit[0]);
		 * System.out.println(timeSplit[1]);
		 */
		
		model.addAttribute("bList2",bList2);
		
		bList = null;
		bList2 = null;
		
		log.info(this.getClass().getName() + " .blockLocation end!!!");
		return "/block/blockLocation";
	}
	
	@RequestMapping(value="/locationAjax.do", method=RequestMethod.GET)
	public String locationAjax (HttpServletRequest request, Model model) throws Exception{
		log.info("locationAjax start");
		String name = CmmUtil.nvl(request.getParameter("name"));
		log.info("name : " + name);
		
		BlockDTO bDTO = new BlockDTO();
		bDTO.setGeoAddr(name);
		
		log.info(bDTO.getGeoAddr());
		
		List<BlockDTO> bList = blockService.getanalysis(bDTO);
		
		System.out.println("bList length : " + bList.size());
		log.info("bList get : " + bList.get(0).getGeoAddr());
		
		model.addAttribute("bList2",bList);
		
		bList = null;

		log.info("locationAjax end");
		return "/block/blockAnalysis";
	}
	
	
}
