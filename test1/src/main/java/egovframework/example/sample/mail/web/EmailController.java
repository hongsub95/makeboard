package egovframework.example.sample.mail.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.sample.mail.model.MailVO;
import egovframework.example.sample.mail.service.impl.mailServiceImpl;

@Controller
public class EmailController {
	
	@Autowired
	private mailServiceImpl mailServiceimpl;
	
	@RequestMapping(value="/mailform.do",method=RequestMethod.GET)
	public ModelAndView emailGetForm(ModelAndView mav) {
		mav.setViewName("sample/mail/mailForm");
		return mav;
	}
	
	@RequestMapping(value="/mailform.do",method=RequestMethod.POST)
	public ModelAndView emailPostForm(ModelAndView mv,MailVO mailvo,MultipartFile[] attchFileList1) throws Exception{
		try {
			mailServiceimpl.sendMail(mailvo,attchFileList1);
			mv.addObject("msg","success");
			mv.setViewName("jsonView");
			return mv;
		}
		 catch (Exception e) {
	            e.printStackTrace();
	            mv.addObject("msg","fail");
	            mv.setViewName("jsonView");
	            return mv;
	        } 
	}
	
}
