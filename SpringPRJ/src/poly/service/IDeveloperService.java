package poly.service;

import java.util.List;

import poly.dto.DeveloperDTO;
import poly.dto.FileDTO;

public interface IDeveloperService {

	public List<DeveloperDTO> getdeveloperList()throws Exception;

	public DeveloperDTO getdetailDev(DeveloperDTO dDTO)throws Exception;

	public int insertFileDTO(FileDTO fDTO)throws Exception;

	//게시판에 파일 번호 똑같이 등록하기 위해 파일 번호 다시 select
	public FileDTO getFileInfo(FileDTO fDTO)throws Exception;

	public int insertDevProc(DeveloperDTO dDTO)throws Exception;

	public List<DeveloperDTO> getTeamMem(DeveloperDTO dDTO2)throws Exception;

	public int insertJoinUs(DeveloperDTO dDTO)throws Exception;


}
