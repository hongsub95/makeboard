package egovframework.example.sample.admin.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.admin.dao.AdminDAO;
import egovframework.example.sample.admin.service.AdminService;

@Service
public class AdminServiceimpl implements AdminService{
	
	@Autowired
	private AdminDAO admindao;
 	
	public void AdmindeleteBoard(Long id, String reason) {
		Map<String,Object> newMap = new HashMap<String,Object>();
		newMap.put("id", id);
		newMap.put("deleteReason",reason);
		admindao.deleteBoardReason(newMap);
	}
}
