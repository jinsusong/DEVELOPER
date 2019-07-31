package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.DeveloperDTO;
import poly.dto.FileDTO;

@Mapper("DeveloperMapper")
public interface DeveloperMapper {
	public List<DeveloperDTO> getdeveloperList()throws Exception;
	public DeveloperDTO getdetailDev(DeveloperDTO dDTO)throws Exception;
	
	//파일 내용 DB에 저장 전에 파일 번호 가져오기
	public FileDTO getFileNo()throws Exception;
	
	//파일 번호와 합쳐진 파일 정보를 DB에 저장할꺼임
	public int insertFileInfo(FileDTO fDTO)throws Exception;
	
	//게시판 등록을 위해 파일 번호를 다시 가져옴
	public FileDTO getFileInfo(FileDTO fDTO)throws Exception;
	
	public DeveloperDTO getDevNo()throws Exception;
	public int insertDevProc(DeveloperDTO dDTO)throws Exception;
	
	
	public DeveloperDTO getTeamNo()throws Exception;
	public int insertTeamProc(DeveloperDTO teamDTO)throws Exception;
	public List<DeveloperDTO> getTeamMem(DeveloperDTO dDTO)throws Exception;
	
	
}
