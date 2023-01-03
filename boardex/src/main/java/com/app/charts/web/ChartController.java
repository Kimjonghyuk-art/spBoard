package com.app.charts.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/charts")
public class ChartController {

	@RequestMapping("/chartEx.do")
	public String moveChartPage() {
		
		return "charts/chartEx.tiles";
	}
	
	@RequestMapping("/cmmChartEx.do")
	public String moveCmmChartEx() {
		return "charts/cmmChartEx.tiles";
	}
	
}
