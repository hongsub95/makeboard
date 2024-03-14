package egovframework.example.sample.file.upload;

import java.io.File;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.board.model.BoardFileVO;
import lombok.Getter;
import lombok.Setter;

public class SFileUpload {
	
	public HashMap<String,Object> upload(MultipartFile uploadFile,String category,String realPath) throws Exception{
		
		String originalFileName;
		String fileExtension;
		String storedFileName;
		long fileSize = uploadFile.getSize();
		HashMap<String,Object> hmap = new HashMap<String,Object>();
		
		if (fileSize > 30000000) {
			hmap.put("msg", "fail");
			return hmap;
		}
		
		LocalDate now = LocalDate.now();
		int year = now.getYear();
        String month = now.getMonth().toString();
		String flpth = File.separator + "new"+ File.separator + category + File.separator + year + File.separator + month;
		String path = realPath + flpth;
		File file = new File(path);
		
		// 파일 경로에 폴더가 없을 경우 생성
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		originalFileName = uploadFile.getOriginalFilename();
	
		// 확장자는 '.'부터 끝까지
		fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		storedFileName = getRandomString() + fileExtension;
	
		// 저장경로+ 저장될이름의 데이터가 담긴 file
		file = new File(path+File.separator+storedFileName);
		
		// throws exception 해야함
		// 지정한 경로에 저장될 이름으로 저장
		try { // 파일생성
			uploadFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		hmap.put("msg","success");
		hmap.put("path", path);
		
		return hmap;
	}
	
	private String getRandomString() throws Exception{
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
		
}
