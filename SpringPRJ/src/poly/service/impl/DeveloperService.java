package poly.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.DeveloperDTO;
import poly.dto.FileDTO;
import poly.dto.NoticeDTO;
import poly.persistance.mapper.DeveloperMapper;
import poly.service.IDeveloperService;
import poly.util.CmmUtil;

@Service("DeveloperService")
public class DeveloperService implements IDeveloperService{
	
	@Resource(name = "DeveloperMapper")
	private DeveloperMapper developerMapper;
	 
	@Override
	public List<DeveloperDTO> getdeveloperList() throws Exception {
		return developerMapper.getdeveloperList();
	}

	@Override
	public DeveloperDTO getdetailDev(DeveloperDTO dDTO) throws Exception {
		return developerMapper.getdetailDev(dDTO);
	}

	//파일 내용 DB 저장
	@Override
	public int insertFileDTO(FileDTO fDTO) throws Exception {
		//파일 번호를 가져온다.
		FileDTO fDTO2 = developerMapper.getFileNo();
		
		//파일번호 못가져왔을때 에러 대비용으로 메모리 올리기
		if (fDTO2==null) {
			fDTO2 = new FileDTO();
		}
		System.out.println("fDTO2 get fileno : " +fDTO2.getFileNo());
		
		String fileNo = CmmUtil.nvl(fDTO2.getFileNo());
		
		//fDTO2로 가져온 파일번호를 기존에 가지고 있던 File 정보 fDTO에 fileNO를 저장시켜줌
		fDTO.setFileNo(fileNo);
		
		return developerMapper.insertFileInfo(fDTO);
	}

	@Override
	public FileDTO getFileInfo(FileDTO fDTO) throws Exception {
		// TODO Auto-generated method stub
		return developerMapper.getFileInfo(fDTO);
	}

	@Override
	public int insertDevProc(DeveloperDTO dDTO) throws Exception {
		//게시글번호 가져오기
		DeveloperDTO mDTO = developerMapper.getDevNo();
						
		//게시글번호 못가져왔을때 에러 대비용으로 메모리 올리기
		if (mDTO==null) {
			mDTO = new DeveloperDTO();
		}
						
		//게시글번호를 commuNo 변수에 저장하기
		String devNo = CmmUtil.nvl(mDTO.getNo());
						
		dDTO.setNo(devNo);
		dDTO.setTeamId(devNo);
		DeveloperDTO teamDTO = developerMapper.getTeamNo();;

		System.out.println("teamDTO get no : " + teamDTO.getNo());
		teamDTO.setUserName(dDTO.getUserName());
		teamDTO.setTeamId(dDTO.getTeamId());
		System.out.println(teamDTO.getTeamId());
		
		int res = developerMapper.insertTeamProc(teamDTO);
		System.out.println("res : " + res);
		
		return developerMapper.insertDevProc(dDTO);
	}

	@Override
	public List<DeveloperDTO> getTeamMem(DeveloperDTO dDTO2) throws Exception {
		return developerMapper.getTeamMem(dDTO2);
	}

	@Override
	public int insertJoinUs(DeveloperDTO dDTO) throws Exception {
		// TODO Auto-generated method stub
		return developerMapper.insertTeamProc(dDTO);
	}
	
}
