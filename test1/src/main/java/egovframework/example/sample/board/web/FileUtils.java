package egovframework.example.sample.board.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.board.model.BoardFileVO;
import egovframework.example.sample.board.model.BoardVO;

@Component
public class FileUtils {
	
	private static final String filePath = "C://staticfile";
	
	public BoardFileVO parseInsertFileInfo(BoardVO vo,MultipartFile uploadFile,String category) throws Exception {
		
		
		// 원본 파일 이름
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		String originalFileCategory = category;
		
		
		
		File file = new File(filePath);
		
		// 파일 경로에 폴더가 없을 경우 생성
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		/*for(MultipartFile multipartFile : uploadFile) {
			
			
			// 다음 데이터 반환
			
			BoardFileVO fileVO = new BoardFileVO();
			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				
				// 확장자는 '.'부터 끝까지
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				
				// 저장경로+ 저장될이름의 데이터가 담긴 file
				file = new File(filePath,storedFileName);
				
				// throws exception 해야함
				// 지정한 경로에 저장될 이름으로 저장
				multipartFile.transferTo(file);
				
				fileVO.setCreated(new Date());
				fileVO.setOriginalFileName(originalFileName);
				fileVO.setFileExtension(originalFileExtension);
				fileVO.setFileName(storedFileName);
				fileVO.setFileSize(multipartFile.getSize());
				fileVO.setBoard_id(vo.getId());
				
				list.add(fileVO);
				
			}
		}*/
		BoardFileVO fileVO = new BoardFileVO();
		originalFileName = uploadFile.getOriginalFilename();
	
		// 확장자는 '.'부터 끝까지
		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		storedFileName = getRandomString() + originalFileExtension;
	
		// 저장경로+ 저장될이름의 데이터가 담긴 file
		file = new File(filePath,storedFileName);
		
		// throws exception 해야함
		// 지정한 경로에 저장될 이름으로 저장
		try { // 파일생성
			uploadFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		fileVO.setCreated(new Date());
		fileVO.setOriginalFileName(originalFileName);
		fileVO.setFileExtension(originalFileExtension);
		fileVO.setFileName(storedFileName);
		fileVO.setCategory(originalFileCategory);
		fileVO.setFileSize(uploadFile.getSize());
		fileVO.setBoard_id(vo.getId());
	
		
		
		return fileVO;
	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
}
