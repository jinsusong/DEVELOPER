package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.BlockDTO;

@Mapper("BlockMapper")
public interface BlockMapper {

	public BlockDTO getBlockNum()throws Exception;

	public int insertFirstBlock(BlockDTO bDTO)throws Exception;

	public List<BlockDTO> getlist()throws Exception;

	public List<BlockDTO> getLocation()throws Exception;

	public List<BlockDTO> getanalysis()throws Exception;

	public List<BlockDTO> getanalysis(BlockDTO bDTO)throws Exception;
	
}
