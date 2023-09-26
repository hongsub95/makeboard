package egovframework.example.sample.board.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
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

import egovframework.example.sample.board.model.BoardFileVO;
import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.board.service.impl.BoardServiceimpl;


@Controller
public class BoardController {
	
	@Autowired
	private BoardServiceimpl boardservice;
	
	@Autowired
	private FileUtils fileutils;
	
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
		
		return "sample/board/BoardList";
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
			return "sample/message/failedboard";
		}
		return "sample/board/BoardForm";
	}
	
	@PostMapping("/BoardFile.do")
	@ResponseBody
	public ModelAndView BoardFile(@RequestParam("board_id") String board_id,BoardVO vo, HttpServletRequest request,MultipartFile uploadFile,HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		response.setContentType("text/html;charset=utf-8");
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		System.out.println(uploadFile);
		String email = (String) session.getAttribute("email");
		Long user_id = (Long) session.getAttribute("user_id");
		String name = (String) session.getAttribute("name");
		String category = request.getParameter("type");
		vo.setUser_id(user_id);
		vo.setUser_name(name);
		// 파일이 처음 들어왔을 경우
		if (board_id.equals("undefined")){
			boardservice.canPost(vo, email);
		}
		// 파일이 두번째 이상 들어왔을 경우
		else {
			vo.setId(new Long(Integer.parseInt(board_id)));
		}
		BoardFileVO filevo = boardservice.postFile(vo, uploadFile,category);
		String storedFileName = filevo.getFileName();
		mav.addObject("file","/staticfile/"+storedFileName);
		mav.addObject("file_name",storedFileName);
		mav.addObject("board_id",vo.getId());
		mav.addObject("file_id",filevo.getFile_id());
		return mav;
		
		
		
	}
	
	@RequestMapping("/selectFileId.do")
	@ResponseBody
	public ModelAndView selectFileId(@RequestParam("savedName") String SavedFileName) {
		String file_id = boardservice.findFileId(SavedFileName);
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		mav.addObject("file_id",file_id);
		return mav;
	}
	
	
	
	@PostMapping("/BoardForm.do")
	public ModelAndView addBoard(BoardVO vo, HttpServletRequest request,@RequestParam HashMap<String, Object> param) throws Exception {
		/*String newFileJson = (String) param.get("newFileList");
		String[] newFileList = newFileJson.substring(1,newFileJson.length()-1).split(",");*/
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
			vo.setIsCompleted(true);
			boardservice.canPost(vo,email);
			/*boardservice.findnoExistFileId(newFileList);*/
			mav.addObject("msg", "success");
			return mav;
			}
			
		}
	
	
	
	@RequestMapping("/BoardDetail.do")
	public String boardDetailView(int id,Model model) throws Exception {
		
		model.addAttribute("board",boardservice.canSelect(id));
		model.addAttribute("files",boardservice.getFiles(id));
		model.addAttribute("heart",boardservice.findAllHeart(id));
		
		
		return "sample/board/BoardDetail";
	}
	
	@RequestMapping("/boardupdate.do")
	public String boardUpdateView(HttpServletRequest request,BoardVO vo,MultipartFile uploadFile) throws Exception {
		Long board_id = new Long(Integer.parseInt(request.getParameter("board_id")));
		String category = request.getParameter("type");
		vo.setId(board_id);
		boardservice.canFileUpdate(vo, uploadFile,category);
		boardservice.canUpdate(vo);
		return "redirect:/BoardList.do?page=1";
	}
	
	@RequestMapping("/boardsoftdelete.do")
	@ResponseBody
	public String boardSoftDeleteView(HttpServletRequest request,BoardVO vo) {
		/*int board_id = id
		boardservice.DeleteAllFiles(board_id);
		boardservice.canDelete(id);*/
		
		Long board_id = new Long(Integer.parseInt(request.getParameter("id")));
		vo.setId(board_id);
		System.out.println(board_id);
		boardservice.DeleteAllFiles(board_id);
		boardservice.boardSoftdelete(vo);
		
		return "redirect:/BoardList.do?page=1";
	}
	
	
	
	@RequestMapping("/myPostBoard.do")
	public String MyBoardView(Long user_id,Model model,HttpServletRequest request) {
		int total = boardservice.getPagemyTotal(user_id);
		PagingVO pagingvo = getPaging(request,total);
		
		model.addAttribute("myboard",boardservice.canMyBoardSelect(user_id,pagingvo));
		model.addAttribute("pages", pagingvo);
		return "sample/board/myPostBoard";
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
	
	@RequestMapping("/goOutBoard.do")
	@ResponseBody
	public void goOutBoard(@RequestParam("board_id") String board_id) {
		Long boardId = new Long(Integer.parseInt(board_id));
		boardservice.DeleteAllFiles(boardId);
		boardservice.canDelete(Integer.parseInt(board_id));
	}
	
	@RequestMapping("/fileDelete.do")
	@ResponseBody
	public void fileDelete(int file_id) {
		
		boardservice.DeleteFile(file_id);
	}
	
	
	@RequestMapping("/plusHeart.do")
	public String plusHeart(int user_id,int board_id, Model model) {
		
		boardservice.pushHeart(user_id,board_id);
		
		return "sample/board/BoardDetail";
	}
	
	@RequestMapping("/heartdelete.do")
	public String heartdelete(int user_id,int board_id, Model model) {
		
		boardservice.removeHeart(user_id, board_id);
		
		return "sample/board/BoardDetail";
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
			return "sample/board/BoardList";
		}
		model.addAttribute("boardlist",boardlist);
		model.addAttribute("pages",pagingvo);
		
		return "sample/board/BoardList";
	}
	
	
	
	
	
	
	
	
	
}
