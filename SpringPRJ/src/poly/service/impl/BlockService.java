package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.BlockDTO;
import poly.dto.NoticeDTO;
import poly.persistance.mapper.BlockMapper;
import poly.persistance.mapper.NoticeMapper;
import poly.service.IBlockService;
import poly.service.INoticeService;

@Service("BlockService")
public class BlockService implements IBlockService{
	
	@Resource(name="BlockMapper")
	private BlockMapper blockMapper;

	@Override
	public BlockDTO getBlockNum() throws Exception {
		// TODO Auto-generated method stub
		System.out.println("getblocknum service start !!");
		return blockMapper.getBlockNum();
	}

	@Override
	public int insertFirstBlock(BlockDTO bDTO) throws Exception {
		return blockMapper.insertFirstBlock(bDTO);
	}

	@Override
	public List<BlockDTO> getlist() throws Exception {
		// TODO Auto-generated method stub
		return blockMapper.getlist();
	}

	@Override
	public List<BlockDTO> getLocation() throws Exception {
		// TODO Auto-generated method stub
		return blockMapper.getLocation();
	}

	@Override
	public List<BlockDTO> getanalysis(BlockDTO bDTO) throws Exception {
		System.out.println("service bDTO get " + bDTO.getGeoAddr());
		return blockMapper.getanalysis(bDTO);
	}
	
}
