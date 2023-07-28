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

import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.board.service.impl.BoardServiceimpl;


@Controller
public class BoardController {
	
	@Autowired
	private BoardServiceimpl boardservice;
	

	@RequestMapping("/home.do")
	public String homePage() {
		return "sample/home";
	}
	
	@RequestMapping("/BoardList.do")
	public String boardListView(Model model,HttpServletRequest request) {
		int total = boardservice.getPageTotal();
		int nowPage = Integer.parseInt(request.getParameter("page"));
		PagingVO pagingvo = new PagingVO(total,nowPage,10);
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
	public String addBoard(BoardVO vo,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("email");
		Long user_id = (Long) session.getAttribute("user_id");
		String name = (String) session.getAttribute("name");
		
		vo.setUser_id(user_id);
		vo.setUser_name(name);
		if(email == null) {
			return "sample/failedboard";
		}
		else {
			
			boardservice.canPost(vo,email);
			return "redirect:/home.do";
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
		return "redirect:/home.do";
	}
	
	@RequestMapping("/boarddelete.do")
	public String boardDeleteView(int id) {
		boardservice.canDelete(id);
		return "redirect:/home.do";
	}
}
