package egovframework.example.sample.board.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.board.model.BoardVO;

@Component
public class FileUtils {
	
	private static final String filePath = "C:\\staticfile";
	
	public List<Map<String,Object>> parseInsertFileInfo(BoardVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		
		//업로드된 파일 이름목록을 제공하는 생성자
		Iterator<String> iterator = mpRequest.getFileNames();
		
		
		//나중에 db넣을 변수
		
		MultipartFile multipartFile = null;
		// 원본 파일 이름
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> listMap = null;
		
		Long board_id = vo.getId();
		
		File file = new File(filePath);
		
		// 파일 경로에 폴더가 없을 경우 생성
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		// 다음 데이터의 유무 확인
		while(iterator.hasNext()) {
			
			// 다음 데이터 반환
			multipartFile = mpRequest.getFile(iterator.next());
			
			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				// 확장자는 '.'부터 끝까지
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				
				// 저장경로+ 저장될이름의 데이터가 담긴 file
				file = new File(filePath + storedFileName);
				
				// throws exception 해야함
				// 지정한 경로에 저장될 이름으로 저장
				multipartFile.transferTo(file);
				
				listMap = new HashMap<String,Object>();
				listMap.put("board_id",board_id);
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
				
			}
		}
		return list;
	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
}
