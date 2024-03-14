package egovframework.example.sample.file.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class FileVO {
	private String created;
	private String originFileName;
	private String storedFileName;
	private String fileExtension;
	private String fileSize;
	private String filePath;
	private String fileId;
}
