package egovframework.example.sample.board.web;

import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.board.service.impl.BoardServiceimpl;


@Controller
public class BoardController {
	
	@Autowired
	private BoardServiceimpl boardservice;
	
	private PagingVO getPaging(HttpServletRequest request,int total) {
		int nowPage = Integer.parseInt(request.getParameter("page"));
		PagingVO pagingvo = new PagingVO(total,nowPage,10);
		return pagingvo;
	}
	

	@RequestMapping("/home.do")
	public String homePage() {
		return "sample/home";
	}
	
	@RequestMapping("/BoardList.do")
	public String boardListView(Model model,HttpServletRequest request) {
		int total = boardservice.getPageTotal();
		PagingVO pagingvo = getPaging(request,total);
		List<BoardVO> boardlist = boardservice.findall(pagingvo);
		
		model.addAttribute("boardlist",boardlist);
		model.addAttribute("pages", pagingvo);
		return "sample/BoardList";
	}
	
	@GetMapping("/BoardForm.do")
	public String addBoardView(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if(session == null) {
			return "sample/failedboard";
		}
		return "sample/BoardForm";
	}
	
	@PostMapping("/BoardForm.do")
	public ModelAndView addBoard(BoardVO vo,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("email");
		Long user_id = (Long) session.getAttribute("user_id");
		String name = (String) session.getAttribute("name");
		String title = vo.getTitle();
		String content = vo.getContent();
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		vo.setUser_id(user_id);
		vo.setUser_name(name);
		if(email == null) {
			mav.addObject("msg","sessionExpired");
			return mav;
		}

		else if (title.length()<5) {
			mav.addObject("msg","shortTitle");
			return mav;
		}
		else if (content.length()<5) {
			mav.addObject("msg","shortContent");
			return mav;
		}
		else {
			
			boardservice.canPost(vo,email);
			mav.addObject("msg", "success");
			return mav;
		}
	
	}
	
	@RequestMapping("/BoardDetail.do")
	public String boardDetailView(int id,Model model) {
		model.addAttribute("board",boardservice.canSelect(id));
		return "sample/BoardDetail";
	}
	
	@RequestMapping("/boardupdate.do")
	public String boardUpdateView(BoardVO vo) {
		
		boardservice.canUpdate(vo);
		return "redirect:/BoardList.do?page=1";
	}
	
	@RequestMapping("/boarddelete.do")
	public String boardDeleteView(int id) {
		boardservice.canDelete(id);
		return "redirect:/BoardList.do?page=1";
	}
	
	@RequestMapping("/myPostBoard.do")
	public String MyBoardView(Long user_id,Model model,HttpServletRequest request) {
		int total = boardservice.getPagemyTotal(user_id);
		PagingVO pagingvo = getPaging(request,total);
		
		model.addAttribute("myboard",boardservice.canMyBoardSelect(user_id,pagingvo));
		model.addAttribute("pages", pagingvo);
		return "sample/myPostBoard";
	}
	
	@RequestMapping("/postFile.do")
	public void WriteFile(BoardVO vo,MultipartHttpServletRequest mpRequest) throws Exception{
		
		boardservice.postFile(vo, mpRequest);
	}
	
	
}
