<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.graph_box {
	display: flex;
    align-items: center;
}

.h6 {
	position: relative;
	color: #222;
	font-size: 18px;
	font-weight: 600;
	padding: 8px 20px 0px 20px;
    /* border-bottom: 1px solid #dddddd; */
	transform: rotate(-0.03deg);
}
.graphUnit {
	margin-left: 2%;
}
</style>
    <h1>차트페이지</h1>
    
<div id="info">
    <div class="flex_box"> 
		<div class="box">
			<div>
				<h6>
					파이차트 <span class="chul">출처 : 률류</span><span class="chul graphUnit">단위(%)</span>
						<div class="utilBox">
							<button class="cbtn_chart" v-on:click="viewChart('chart_1', 'tb_1')">차트보이기</button>
							<button class="cbtn_table" v-on:click="viewTable('tb_1', 'chart_1')">그래프보이기</button>
							<button class="cbtn_down"  v-on:click="excelDown('chart_1', '세입예산')">엑셀</button>
						</div>
				</h6>			
			</div>
			<div class="graph"> 
    			<div id="pieChart" style="width: 700px; height: 500px;"></div>
    			<div id="pieTable"></div>
    		</div>
    	</div>
    </div>
    
    <div class="flex_box">
    	<div class="box">
    		<h6>
    			xy차트<span class="chul">출처 : 룰루</span><span>단위 </span>
    		</h6>
    	
    	</div>
    	
    	<div class="graph">
    		<div id="xyChart" style="width: 700px; height: 500px;"></div>
    	</div>
    </div>
    
    
</div>
    
    
<script>
var vm = new Vue({
	el:"#info",
	data : {
		data : [
			{
				  "country": "Lithuania",
				  "litres": 501.9
				}, {
				  "country": "Czech Republic",
				  "litres": 301.9
				}, {
				  "country": "Ireland",
				  "litres": 201.1
				}, {
				  "country": "Germany",
				  "litres": 165.8
				}, {
				  "country": "Australia",
				  "litres": 139.9
				}, {
				  "country": "Austria",
				  "litres": 128.3
				}, {
				  "country": "UK",
				  "litres": 99
				}, {
				  "country": "Belgium",
				  "litres": 60
				}, {
				  "country": "The Netherlands",
				  "litres": 50
				}
		],
		
	xyData : [
		{
			  "country": "Lithuania",
			  "litres": 501.9,
			  "units": 250
			}, {
			  "country": "Czech Republic",
			  "litres": 301.9,
			  "units": 222
			}, {
			  "country": "Ireland",
			  "litres": 201.1,
			  "units": 170
			}, {
			  "country": "Germany",
			  "litres": 165.8,
			  "units": 122
			}, {
			  "country": "Australia",
			  "litres": 139.9,
			  "units": 99
			}, {
			  "country": "Austria",
			  "litres": 128.3,
			  "units": 85
			}, {
			  "country": "UK",
			  "litres": 99,
			  "units": 93
			}, {
			  "country": "Belgium",
			  "litres": 60,
			  "units": 50
			}, {
			  "country": "The Netherlands",
			  "litres": 50,
			  "units": 42
			}
	],
	},
	methods: {
		createPieChart : function(id,data) {
			var chart = am4core.create(id, am4charts.PieChart);
			
			var series = chart.series.push(new am4charts.PieSeries());
			series.dataFields.value = "litres";
			series.dataFields.category = "country";
			series.labels.template.text = ""; // 차트 주위 선 뻗은 라벨 없애기
			chart.data = data;
			// And, for a good measure, let's add a legend
			chart.legend = new am4charts.Legend();
			/*amchart 로고 제거*/
	        $("g[aria-labelledby^='id-']g[aria-labelledby$='-title']").css("display", "none");
		},
		createXyChart(id,data) {
			// Create chart instance
			var chart = am4core.create(id, am4charts.XYChart); //차트 생성
			chart.scrollbarX = new am4core.Scrollbar(); // 스크롤바 생성
			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis()); 
			categoryAxis.dataFields.category = "country";
			
			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			var valueAxis2 = chart.yAxes.push(new am4charts.ValueAxis());
			//valueAxis2.title.text = "Units sold";
			valueAxis2.renderer.opposite = true;
			
			var series = chart.series.push(new am4charts.ColumnSeries());
			series.name = "Sales";
			series.columns.template.tooltipText = "Series: {name}\nCategory: {categoryX}\nValue: {valueY}";
			//series.columns.template.fill = am4core.color("#104547"); // fill
			series.dataFields.valueY = "litres";
			series.dataFields.categoryX = "country";
			
			chart.data = data;
			
			 $("g[aria-labelledby^='id-']g[aria-labelledby$='-title']").css("display", "none");
			 
			 var series2 = chart.series.push(new am4charts.LineSeries());
			 series2.name = "Units";
			 series2.stroke = am4core.color("#CDA2AB");
			 series2.strokeWidth = 3;
			 series2.dataFields.valueY = "units";
			 series2.dataFields.categoryX = "country";
			 series2.smoothing = "monotoneX";
			 
			  var bullet = series2.bullets.push(new am4charts.CircleBullet());
			  bullet.circle.stroke = am4core.color("#fff");
			  bullet.circle.strokeWidth = 2;
			  
			  series2.yAxis = valueAxis2;
			 
			  chart.cursor = new am4charts.XYCursor();
			  
		},
		
	},
	mounted : function () {
		this.createPieChart('pieChart',this.data);
		this.createXyChart('xyChart',this.xyData);
		
	},
	
		
});    	
    
</script>  