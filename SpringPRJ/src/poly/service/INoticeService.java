package poly.service;

import java.util.List;

import poly.dto.NoticeDTO;

public interface INoticeService {
	public int noticeReg(NoticeDTO nDTO) throws Exception;
	public List<NoticeDTO> getNoticeList()throws Exception;

}
