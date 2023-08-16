package egovframework.example.sample.board.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
	
	@RequestMapping("/AsyncBoardListData.do")
	@ResponseBody
	public ModelAndView BoardListData(HttpServletRequest request){
		int total = boardservice.getPageTotal();
		PagingVO pagingvo = getPaging(request,total);
		List<BoardVO> boardlist = boardservice.findall(pagingvo);
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		mav.addObject("boardlist",boardlist);
		mav.addObject("pages",pagingvo);
		return mav;
	}
	
	@RequestMapping("/AsyncBoardListHeartData.do")
	@ResponseBody
	public ModelAndView boardListViewByHeart(HttpServletRequest request) {
		int total = boardservice.getPageTotal();
		PagingVO pagingvo = getPaging(request,total);
		
		List<BoardVO> boardlist = boardservice.findallByHeart(pagingvo);
		
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		mav.addObject("boardlist",boardlist);
		mav.addObject("pages",pagingvo);
		return mav;
		
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
	public ModelAndView addBoard(BoardVO vo, HttpServletRequest request,MultipartFile[] uploadFile) throws Exception {
		
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
			boardservice.postFile(vo, uploadFile);
			mav.addObject("msg", "success");
			return mav;
		}
	
	}
	
	@RequestMapping("/BoardDetail.do")
	public String boardDetailView(int id,Model model) throws Exception {
		
		model.addAttribute("board",boardservice.canSelect(id));
		model.addAttribute("files",boardservice.getFiles(id));
		model.addAttribute("heart",boardservice.findAllHeart(id));
		
		
		return "sample/BoardDetail";
	}
	
	@RequestMapping("/boardupdate.do")
	public String boardUpdateView(HttpServletRequest request,BoardVO vo,MultipartFile[] uploadFile) throws Exception {
		Long board_id = new Long(Integer.parseInt(request.getParameter("board_id")));
		vo.setId(board_id);
		boardservice.canFileUpdate(vo, uploadFile);
		boardservice.canUpdate(vo);
		return "redirect:/BoardList.do?page=1";
	}
	
	@RequestMapping("/boarddelete.do")
	public String boardDeleteView(int id) {
		int board_id = id; 
		boardservice.DeleteAllFiles(board_id);
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
	
	@RequestMapping("/fileDownload.do")
	public void fileDown(@RequestParam Map<String,Object> map, HttpServletResponse response) throws Exception{
		
		Map<String,Object> resultMap = boardservice.getfileInfoForDownload(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\staticfile\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	@RequestMapping("/fileDelete.do")
	@ResponseBody
	public void fileDelete(int file_id) {
		
		boardservice.DeleteFile(file_id);
	}
	
	@RequestMapping("/plusHeart.do")
	public String plusHeart(int user_id,int board_id, Model model) {
		
		boardservice.pushHeart(user_id,board_id);
		
		return "sample/BoardDetail";
	}
	
	@RequestMapping("/heartdelete.do")
	public String heartdelete(int user_id,int board_id, Model model) {
		
		boardservice.removeHeart(user_id, board_id);
		
		return "sample/BoardDetail";
	}
	
	@RequestMapping("/checkUserHeart.do")
	@ResponseBody
	public String checkUserHeart(int user_id,int board_id) throws Exception{
		
		boolean result = boardservice.checkUserdoOrNot(user_id, board_id);
		String msg = "success";
		if(result==false) {
			msg = "fail";
		}
		else if (result == true) {
			msg = "success";
		}
		return msg;
		
	}
	
	@RequestMapping("/SearchBoard.do")
	public String SearchBoard(HttpServletRequest request,Model model,BoardVO boardvo) {
		String word = request.getParameter("word");
		int searchPage = boardservice.searchWordPage(boardvo,word);
		PagingVO pagingvo = getPaging(request,searchPage);
		List<BoardVO> boardlist = boardservice.findSearchBoard(pagingvo,word);
		if (boardlist.isEmpty()) {
			model.addAttribute("msg","nothing");
			return "sample/BoardList";
		}
		model.addAttribute("boardlist",boardlist);
		model.addAttribute("pages",pagingvo);
		
		return "sample/BoardList";
	}
	
	
	
	
	
	
	
	
	
}
