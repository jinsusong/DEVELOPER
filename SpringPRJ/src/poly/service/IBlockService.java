package poly.service;

import java.util.List;

import poly.dto.BlockDTO;
import poly.dto.NoticeDTO;

public interface IBlockService {

	public BlockDTO getBlockNum()throws Exception;

	public int insertFirstBlock(BlockDTO bDTO)throws Exception;

	public List<BlockDTO> getlist()throws Exception;

	public List<BlockDTO> getLocation()throws Exception;

	public List<BlockDTO> getanalysis(BlockDTO bDTO)throws Exception;

}
