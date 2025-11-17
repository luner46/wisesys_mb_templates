package kr.go.hrfco.main.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;


@Controller
@RequestMapping("/floodsp/*")
public class FloodMainController {
	
	@RequestMapping(value = "main.do")
	public String main() throws Exception {
		//String wlobscd = isInteger(updateNullToString(req.getParameter("wlobscd")));
        return "flood/main";
	}
	
	@RequestMapping(value = "marker.do")
	public String marker() throws Exception {
        return "flood/marker";
	}
	
	@RequestMapping(value = "geo.do")
	public String geo() throws Exception {
        return "flood/geo";
	}
	
}
