package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.NoticeDTO;
import poly.persistance.mapper.NoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService")
public class NoticeService implements INoticeService{
	
	@Resource(name="NoticeMapper")
	private NoticeMapper noticeMapper;

	@Override
	public int noticeReg(NoticeDTO nDTO) throws Exception {
		System.out.println(nDTO.getTitle());
		
		return noticeMapper.noticeReg(nDTO);
	}

	@Override
	public List<NoticeDTO> getNoticeList() throws Exception {
		System.out.println("service");
		return noticeMapper.getNoticeList();
	}
	
}
