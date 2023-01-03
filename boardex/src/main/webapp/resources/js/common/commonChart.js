/**
 * 작 성 자 : 최민식
 * 작 성 일 : 2021.11.11
 * 수 정 일 : --
 * 내	용 : 차트 생성 JS
 */

var chart = null;			// 차트
var chartType = '';			// 차트 종류
var prevewId = '';			// 차트가 표현될 객체ID
var dataList = [];			// 데이터 정보(x축, y축)
var colorType = '';			// 차트 색상 타입
var dataInfo = null;		// y축 이름, 색상 정보
var x = 0;
var y = 0;					// series 생성 갯수

var legendUse = false;		// 범례 사용 여부
var legendPosition = '';	// 범례 위치

var unitUse = false;		// 단위 설정 사용 여부
var unitKind = '';			// 단위 설정
var unitSetting = '';		// 단위

var topTipUse = false;		// 상단 팁 표기 여부
var scrollbar = 0;			// 스크롤 종류[0 : 사용안함, 1: 스크롤바, 2: 마우스줌]
var yValLookUse = false;	// y축 값 표기 여부
var yZeroStartUse = false;	// 값 시작을 0으로 사용할지 유무

var labelRotation = '';		// 라벨 회전 각도

// 데이터 초기화
function chartDataReset() {
	chart = null;
	chartType = '';
	prevewId = '';
	dataList = [];
	colorType = '';
	dataInfo = null;
	x = 0;
	y = 0;

	legendUse = false;
	legendPosition = '';

	unitUse = false;		// 단위 설정 사용 여부
	unitKind = '';			// 단위 설정
	unitSetting = '';		// 단위

	topTipUse = false;		// 상단 팁 표기 여부
	scrollbar = 0;			// 스크롤 종류[0 : 사용안함, 1: 스크롤바, 2: 마우스줌]
	yValLookUse = false;	// y축 값 표기 여부
	yZeroStartUse = false;	// 값 시작을 0으로 사용할지 유무
}
// 차트 데이터 정리
function cmmnChartDate(info) {
	console.log('info->'+JSON.stringify(info));
	chartDataReset();
	prevewId = info.prevewId;	// 차트가 표현될 객체ID
	chartType = info.chartType;	// 차트 종류
	legendUse = info.legendUse;	// 범례 사용 여부
	legendPosition = info.legendPosition;	// 범례 위치
	for(x = 0 ; x < info.data.length; x++) {	// x, y축 정보
		var data = {};
		data.category = info.data[x].category;	// x축 값 설정
		for(y = 0 ; y < info.data[x].val.length; y++) {	// y축 값 설정
			var tempKey = 'val'+ (y+1);
			var tempVal = info.data[x].val[y];
			data[tempKey] = tempVal;
		}
		dataList.push(data);
	}
	console.log(dataList);
	titleUse = info.titleUse;		// 제목 사용 여부
	title = info.title;			// 제목
	
	colorType = info.colorType;	// 색상 타입
	dataInfo = info.yType;	// y축 이름, 색상 정보
	
	unitUse = info.unitUse;	// 단위 설정 사용여부
	unitKind = info.unitKind;	// 단위 설정
	unitSetting = info.unitSetting;	// 단위 표기
	
	topTipUse = info.topTipUse;		// 상단 팁 표기 여부
	scrollbar = info.scrollbar;		// 스크롤 종류
	yValLookUse = info.yValLookUse;	// y 축 표기 여부
	yZeroStartUse = info.yZeroStartUse;	// 값 시작을 0으로 사용할지 유무
	
	labelRotation = info.labelRotation;
	
	cmmnCreateChart();	// 차트 생성
}

// 차트 생성
function cmmnCreateChart() {
	// 차트 굵기 조정(데이터 갯수에 따라 굵기 지정)
	var startLocation = 0;
	var endLocation = 1;
	if(dataList.length <= 5) {
		startLocation = 0.3;
		endLocation = 0.7;
	}
	
	/*********************************************** create bar chart ***********************************************/
	if(chartType == 'BAR_WIDTH' || chartType == 'BAR_VRTICL') {
		chart = am4core.create(prevewId, am4charts.XYChart);	// 차트 생성
		chart.data = dataList;	// 차트 데이터 추가
		console.log('var_width'+ chart.data);
		// 가로 bar
		if(chartType == 'BAR_WIDTH') {
			if(scrollbar == 1) chart.scrollbarX = new am4core.Scrollbar();		// 스크롤바
			else if(scrollbar == 2) chart.cursor = new am4charts.XYCursor();	// 마우스줌
			
			// category 정보
			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.dataFields.category = "category";
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.renderer.line.strokeOpacity = 1;
				categoryAxis.renderer.minGridDistance = 70;
				categoryAxis.renderer.grid.template.disabled = true;
				categoryAxis.renderer.cellStartLocation = startLocation;
				categoryAxis.renderer.cellEndLocation = endLocation;
				categoryAxis.renderer.labels.template.rotation = labelRotation;
			
			// val 정보
			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				if(yZeroStartUse) valueAxis.min = 0;							// 값 축 최소값 0사용 유무
				valueAxis.renderer.disabled = yValLookUse;						// 축 값 표기 여부
		// 세로 bar
		} else if(chartType == 'BAR_VRTICL') {
			if(scrollbar == 1) chart.scrollbarY = new am4core.Scrollbar();		// 스크롤
			else if(scrollbar == 2) chart.cursor = new am4charts.XYCursor();	// 마우스줌
			
			// category 정보
			var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
				categoryAxis.dataFields.category = "category";
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.renderer.line.strokeOpacity = 1;
				categoryAxis.renderer.minGridDistance = 70;
				categoryAxis.renderer.grid.template.disabled = true;
				categoryAxis.renderer.cellStartLocation = startLocation;
				categoryAxis.renderer.cellEndLocation = endLocation;
			
			// val 정보
			var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
				if(yZeroStartUse) valueAxis.min = 0;							// 값 축 최소값 0사용 유무
				valueAxis.renderer.disabled = yValLookUse;						// 축 값 표기 여부
		}
		
	/*********************************************** create bar chart ***********************************************/
	
	/*********************************************** create line chart ***********************************************/
	} else if(chartType == 'LINE' || chartType == 'LINE_AREA' || chartType == 'LINE_CURVE') {
		chart = am4core.create(prevewId, am4charts.XYChart);	// 차트 생성
		chart.data = dataList;	// 차트 데이터 추가
		if(scrollbar == 1) chart.scrollbarX = new am4core.Scrollbar();		// 스크롤바
		else if(scrollbar == 2) chart.cursor = new am4charts.XYCursor();	// 마우스줌
		
		// category 정보
		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "category";
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.renderer.minGridDistance = 50;
			categoryAxis.renderer.grid.template.disabled = true;
		
		// val 정보
		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			if(yZeroStartUse) valueAxis.min = 0;							// 값 축 최소값 0사용 유무
			valueAxis.renderer.disabled = yValLookUse;						// 축 값 표기 여부
		// 커서 사용
//		chart.cursor = new am4charts.XYCursor();
//		chart.cursor.xAxis = categoryAxis;
	/*********************************************** create line chart ***********************************************/
	
	/*********************************************** create circle chart ***********************************************/
	} else if(chartType == 'PIE' || chartType == 'DONUT') {
		chart = am4core.create(prevewId, am4charts.PieChart);	// 차트 생성
		chart.data = dataList;	// 차트 데이터 추가
		if(chartType == 'DONUT') chart.innerRadius = am4core.percent(30);	// 원 차트 가운데 구멍 뚫기
		
	/*********************************************** create circle chart ***********************************************/
	
	/*********************************************** create multi_width chart ***********************************************/
	} else if(chartType == 'MULTI_WIDTH') {
		chart = am4core.create(prevewId, am4charts.XYChart);	// 차트 생성
		chart.data = dataList;	// 차트 데이터 추가
		if(scrollbar == 1) chart.scrollbarX = new am4core.Scrollbar();		// 스크롤바
		else if(scrollbar == 2) chart.cursor = new am4charts.XYCursor();	// 마우스줌
		
		// category 정보
		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "category";
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.renderer.line.strokeOpacity = 1;
			categoryAxis.renderer.minGridDistance = 30;
			categoryAxis.renderer.grid.template.disabled = true;
			categoryAxis.renderer.cellStartLocation = 0.3;
			categoryAxis.renderer.labels.template.rotation = labelRotation;
		
		// val 정보
		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			if(yZeroStartUse) valueAxis.min = 0;							// 값 축 최소값 0사용 유무
			valueAxis.renderer.disabled = yValLookUse;						// 축 값 표기 여부
	/*********************************************** create multi_width chart ***********************************************/
	
	/*********************************************** create multi_vrticl chart ***********************************************/
	} else if(chartType == 'MULTI_VRTICL') {
		chart = am4core.create(prevewId, am4charts.XYChart);	// 차트 생성
		chart.data = dataList;	// 차트 데이터 추가
		if(scrollbar == 1) chart.scrollbarY = new am4core.Scrollbar();		// 스크롤
		else if(scrollbar == 2) chart.cursor = new am4charts.XYCursor();	// 마우스줌
		
		// category 정보
		var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "category";
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.renderer.line.strokeOpacity = 1;
			categoryAxis.renderer.minGridDistance = 30;
			categoryAxis.renderer.grid.template.disabled = true;
			categoryAxis.renderer.cellStartLocation = 0.3;
			categoryAxis.renderer.cellEndLocation = 0.7;
		
		// val 정보
		var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
			if(yZeroStartUse) valueAxis.min = 0;							// 값 축 최소값 0사용 유무
			valueAxis.renderer.disabled = yValLookUse;						// 축 값 표기 여부
	}
	/*********************************************** create multi_vrticl chart ***********************************************/
	// 제목 표기여부
	if(titleUse) {
		createTitle();	// 제목 생성
	}
	// 포맷 사용여부
	if(unitUse) {
		chartFormat();	// 데이터 포맷
	}
	
	// 시리즈 추가
	for(var i = 0; i < y; i++) {
		console.log('시리즈'+i)
		var j = i + 1;
		cmmnCreateSeries(j, i);
	}
	// 범례 추가
	if(legendUse) {
		createLegend();
	}
}

// 시리즈 생성
function cmmnCreateSeries(valIdx, typeIdx) {
	console.log(valIdx)
	console.log(typeIdx);
	var valKey = 'val' + valIdx;	// y축 val key
	var chartType = dataInfo.yChartType[typeIdx];	// chartType 설정
	
	/*********************************************** create bar series ***********************************************/
	if(chartType == 'BAR_WIDTH' || chartType == 'BAR_VRTICL') {
		var series = chart.series.push(new am4charts.ColumnSeries());
			series.name = dataInfo.yValNm[typeIdx];
		// 가로 bar 차트
		if(chartType == 'BAR_WIDTH') {
			series.dataFields.valueY = valKey;
			series.dataFields.categoryX = "category";
			series.columns.template.tooltipText = "[bold]{category}[/]\n{name}: [bold]{valueY}[/]";

			
			// 상단 팁 표기
			if(topTipUse) {
				var valueLabel = series.bullets.push(new am4charts.LabelBullet());
					valueLabel.label.text = "{valueY}";
					valueLabel.label.dy = -15;
			}
		// 세로 bar 차트
		} else if(chartType == 'BAR_VRTICL') {
			series.dataFields.valueX = valKey;
			series.dataFields.categoryY = "category";
			series.columns.template.tooltipText = "[bold]{category}[/]\n{name}: [bold]{valueX}[/]";
			
			// 상단 팁 표기
			if(topTipUse) {
				// barValue
				var valueLabel = series.bullets.push(new am4charts.LabelBullet());
				valueLabel.label.text = "{valueX}";
				valueLabel.label.horizontalCenter = "left";
				valueLabel.label.dx = 3;
				valueLabel.label.hideOversized = false;
				valueLabel.label.truncate = false;
			}
		}
		series.columns.template.strokeWidth = 0;
		series.columns.template.fillOpacity = 1;
		
		// 색상지정
		if(colorType == 'single') {
			series.columns.template.fill = am4core.color(dataInfo.yColor[typeIdx]);
		} else if(colorType == 'multi') {
			
		} else {
			series.columns.template.adapter.add("fill", function(fill, target) {
				return chart.colors.getIndex(target.dataItem.index);
			});
		}
		
	/*********************************************** create bar series ***********************************************/
	
	/*********************************************** create line series ***********************************************/
	} else if(chartType == 'LINE' || chartType == 'LINE_AREA' || chartType == 'LINE_CURVE') {
		var series = chart.series.push(new am4charts.LineSeries());
			series.name = dataInfo.yValNm[typeIdx];
			series.dataFields.valueY = valKey;
			series.dataFields.categoryX = "category";
			series.strokeWidth = 2;
			
			// 상단 팁 표기
			if(topTipUse) {
				var valueLabel = series.bullets.push(new am4charts.LabelBullet());
				valueLabel.label.text = "{valueY}";
				valueLabel.label.dy = -15;
			}
			
		// 곡선으로 만들기
		if(chartType == 'LINE_CURVE') {
			series.strokeWidth = 2;
			series.tensionX = 0.77;
		}
		
		// 라인 아래로 색 투명도
		if(chartType == 'LINE_AREA') series.fillOpacity = 0.3;
		
		var bullet = series.bullets.push(new am4charts.CircleBullet());
			bullet.circle.strokeWidth = 1;
			bullet.tooltipText = "[bold]{category}[/]\n{name}: [bold]{valueY}[/]";
		// 색상 지정
		if(colorType == 'single') {
			// 라인 아래로 색 지정
			if(chartType == 'LINE_AREA') series.fill = am4core.color(dataInfo.yColor[typeIdx]);
			
			series.stroke = am4core.color(dataInfo.yColor[typeIdx]);
			
			// 툴팁 색상
			bullet.fill = am4core.color(dataInfo.yColor[typeIdx]);
		}
	} else if (chartType == 'LINE_VRTICL' || chartType == 'LINE_VRTICL_CURVE' || chartType == 'LINE_VRTICL_AREA') {
		var series = chart.series.push(new am4charts.LineSeries());
			series.name = dataInfo.yValNm[typeIdx];
			series.dataFields.valueX = valKey;
			series.dataFields.categoryY = "category";
			series.strokeWidth = 2;
			
			// 상단 팁 표기
			if(topTipUse) {
				// barValue
				var valueLabel = series.bullets.push(new am4charts.LabelBullet());
					valueLabel.label.text = "{valueX}";
					valueLabel.label.horizontalCenter = "left";
					valueLabel.label.dx = 3;
					valueLabel.label.hideOversized = false;
					valueLabel.label.truncate = false;
			}
			
			// 곡선으로 만들기
			if(chartType == 'LINE_VRTICL_CURVE') {
				series.strokeWidth = 2;
				series.tensionX = 0.77;
			}
			// 라인 아래로 색 투명도
			if(chartType == 'LINE_VRTICL_AREA') series.fillOpacity = 0.3;
			
		var bullet = series.bullets.push(new am4charts.CircleBullet());
			bullet.circle.strokeWidth = 1;
			bullet.tooltipText = "[bold]{category}[/]\n{name}: [bold]{valueX}[/]";
			
		// 색상 지정
		if(colorType == 'single') {
			// 라인 아래로 색 지정
			if(chartType == 'LINE_VRTICL_AREA') series.fill = am4core.color(dataInfo.yColor[typeIdx]);
			
			series.stroke = am4core.color(dataInfo.yColor[typeIdx]);
			
			// 툴팁 색상
			bullet.fill = am4core.color(dataInfo.yColor[typeIdx]);
		}
	/*********************************************** create line series ***********************************************/
	
	/*********************************************** create circle series ***********************************************/
	} else if(chartType == 'PIE' || chartType == 'DONUT') {
		var series = chart.series.push(new am4charts.PieSeries());
			series.dataFields.value = valKey;
			series.dataFields.category = "category";
			series.slices.template.stroke = am4core.color("#fff");
			series.slices.template.tooltipText= "{category}: [bold]{value}";
			series.labels.template.text = "{category}";
			
			// 툴팁 사용여부
			if(!topTipUse) series.labels.template.disabled = true;
			
			series.slices.template.propertyFields.fill = "color";
	}
	/*********************************************** create circle series ***********************************************/
}

// 범례 생성
function createLegend() {
	chart.legend = new am4charts.Legend();
	chart.legend.maxHeight = 200;
	chart.legend.maxWidth = 300;
	chart.legend.scrollable = true;
	chart.legend.position = legendPosition;
}

// 숫자 포맷
function chartFormat() {
	var s = {"number": unitKind, "suffix": unitSetting }
	var formatList = [];
		formatList.push(s);
	chart.numberFormatter.bigNumberPrefixes = formatList;
	chart.numberFormatter.numberFormat = "#,##a";
}

// 제목
function createTitle() {
	var chartTitle = chart.titles.create();
		chartTitle.text = title;
		chartTitle.fontSize = 18;
		chartTitle.marginBottom = 10;
}
