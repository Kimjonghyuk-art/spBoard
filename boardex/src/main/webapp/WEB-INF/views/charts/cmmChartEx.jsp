<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="content">
	<h1>cmmChartEx 페이지</h1>
	
	<div id="chart1" style="width: 700px; height: 500px;">
	
	</div>
	
	<div id='chart2' style="width: 700px; height: 500px;">
	
	</div>
	
</div>



<script>
	var vm = new Vue({
		el : "#content",
		data : {
			data : [
				{
					category : 'Lithuania',
					val : [501.9],
					
				},
				{
					category : 'test',
					val : [400],
				},
				{
					category : 'test2',
					val : [250],
				},
			],
			info : {
				chartType : 'BAR_WIDTH',
				prevewId : '',
				legendUse : false,
				legendPosition : '',
				topTipUse : false,
				scrollbar : 0,
				data :[
						{
		               	category : '',
		               	val : [],
		            	},
					],
			 	 yType : { yValNm : ['가', '나', '다'],
			               yColor : ['#f00', '#00f', '#0f0'],
			               yChartType : ['BAR_WIDTH', 'BAR_WIDTH', 'BAR_WIDTH']
				       },
				
			},
			
			
		},
		methods : {
			createChart : function(id,data) {
				var vm = this;
				vm.info.legendUse = true;
				vm.info.chartType = "DONUT"
				vm.info.prevewId = id;
				vm.info.data = data;
				vm.info.yType.yChartType[0] = 'DONUT';
				cmmnChartDate(vm.info);
				
				$("g[aria-labelledby^='id-']g[aria-labelledby$='-title']").css("display", "none");
			},
			createChart2 : function(id,data) {
				var vm = this;
				vm.info.legendUse = true;
				vm.info.chartType = "MULTI_WIDTH";
				vm.info.prevewId = id;
				vm.info.scrollbar = 2;
				vm.info.data = data;
				cmmnChartDate(vm.info);
			}
		},
		mounted : function() {
			var vm = this;
			this.createChart('chart1',vm.data);
			this.createChart2('chart2',vm.data);
			
		}
		
	});

</script>