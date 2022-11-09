<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <template id="pagination">
 	<div class="pagenation">
 	<%-- 	<a href="#" v-if="dataSearch.nowPage != 1" @click="paginationfn(1)">&Lt;</a>
		<a href="#" v-if="dataSearch.nowPage != 1" @click="paginationfn(dataSearch.nowPage - 1)">&lt;</a>
	 	<a href="#" 
	 		v-for="i in pageNum" @click="paginationfn(i)"> {{i}} </a>
	 	<a href="#" v-if="dataSearch.nowPage < dataSearch.endPage" @click="paginationfn(dataSearch.nowPage + 1)">&gt;</a>
		<a href="#" v-if="dataSearch.nowPage < dataSearch.endPage" @click="paginationfn(dataSearch.endPage)">&Gt;</a> --%>
		
		<nav>
		  <ul class="pagination" style="justify-content: center;">
		    <li class="page-item">
		      <a class="page-link" href="#"  v-if="dataSearch.nowPage != 1" @click="paginationfn(1)">
		        <span aria-hidden="true">&Lt;</span>
		      </a>
		    </li>
		    
		    <li class="page-item">
		    	<a class="page-link" href="#" v-if="dataSearch.nowPage != 1" @click="paginationfn(dataSearch.nowPage - 1)">
		    		<span aria-hidden="true">&lt;</span>
		    	</a>
		    </li>
		    <li class="page-item" v-for="i in pageNum"><a href="#" class="page-link" @click="paginationfn(i)">{{i}}</a></li>

		    <li class="page-item">
		      <a class="page-link" href="#" v-if="dataSearch.nowPage < dataSearch.endPage" @click="paginationfn(dataSearch.nowPage + 1)">
		        <span aria-hidden="true">&gt;</span>
		      </a>
		    </li>
		    
		     <li class="page-item">
		      <a class="page-link" href="#" v-if="dataSearch.nowPage < dataSearch.endPage" @click="paginationfn(dataSearch.endPage)">
		        <span aria-hidden="true">&Gt;</span>
		      </a>
		    </li>
		    
		  </ul>
		</nav>

 	</div>

 </template>
 
 <script>
 //'page' 는 다른 jsp페이지에서 <page> 태그로 사용
 Vue.component('page', {
	template : '#pagination', //템플릿 적용 시킬 태그 id
	props : ['dataSearch'], //상위 페이지에서 :data-search로 사용한 데이터
	methods : {
			
		paginationfn: function(i) {
			this.dataSearch.nowPage = i;
			//console.log("클릭 " + i);
			this.$emit('pagingfn', i); //하위 컴포넌트에서 상위 컴포넌트로 이벤트 위임
		}
	},
	computed : { //vue data 내부의 변수의 값이 바뀔때 감지 function을 통해 로직 처리 가능 (리턴값 필요)
		//페이지 번호 
		pageNum: function() {
			let range = [];
			
			for(let i = this.dataSearch.firstPage; i <= this.dataSearch.lastPage; i++) {
				range.push(i);
			}
			//console.log(range);
			return range;
		}
	}
 });
 
 </script>