package egovframework.example.sample.board.web;

import java.io.File;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.board.dao.BoardDAO;
import egovframework.example.sample.board.model.BoardFileVO;
import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.mail.model.MailVO;

@Component
public class FileUtils {
	
	@Autowired
	private BoardDAO boarddao;
	
	private static final String filePath = "C://staticfile";
	private static final String filePath2 = "C://staticfile";
		
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
	
public HashMap<String,Object> parseInsertMailFileInfo(MailVO mailvo,MultipartFile uploadFile,String category,MultipartHttpServletRequest request) throws Exception {
		
		
		// 원본 파일 이름
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		String originalFileCategory = category;
		LocalDate now = LocalDate.now();
		int year = now.getYear();
        String month = now.getMonth().toString();
		String flpth = File.separator + "new" + File.separator + "files" + File.separator + originalFileCategory + File.separator + year + File.separator + month;
		String path = request.getSession().getServletContext().getRealPath(flpth);
		File file = new File(path);
		
		// 파일 경로에 폴더가 없을 경우 생성
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		BoardFileVO fileVO = new BoardFileVO();
		originalFileName = uploadFile.getOriginalFilename();
	
		// 확장자는 '.'부터 끝까지
		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		storedFileName = getRandomString() + originalFileExtension;
	
		// 저장경로+ 저장될이름의 데이터가 담긴 file
		file = new File(path+File.separator+storedFileName);
		
		// throws exception 해야함
		// 지정한 경로에 저장될 이름으로 저장
		try { // 파일생성
			uploadFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		HashMap<String,Object> hmap = new HashMap<String,Object>();
		fileVO.setCreated(new Date());
		fileVO.setOriginalFileName(originalFileName);
		fileVO.setFileExtension(originalFileExtension);
		fileVO.setFileName(storedFileName);
		fileVO.setCategory(originalFileCategory);
		fileVO.setFileSize(uploadFile.getSize());
		
		boarddao.insertFile(fileVO);
		
		hmap.put("fileVO", fileVO);
		hmap.put("path", path);
		
		return hmap;
	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
}
