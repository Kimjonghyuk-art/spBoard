<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>readPage</h1>
    
    
    <form id="fileForm" method="POST" enctype="multipart/form-data">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    	<input type="file" name="file">
	    	<button type="button" id="excelBtn">제출</button>
    </form>
    
    
    <table id="excel-table" class="table">
    	<thead>
    	</thead>
    	
    	<tbody>
    	</tbody>
    	
    </table>
    
    
<script>

$("document").ready(function(){
	
})

$("#excelBtn").click(function() {
		
		let form = $("#fileForm")[0];
		let formData = new FormData(form);
		formData.append("file", $("input[name=file]")[0].files[0]);					
		$.ajax({
			url : '/admin/json/read.ajax',
			contentType : false,
			processData : false,
			type : 'POST',
			data : formData,
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
		    },
			success : function(data) {
				alert('등록 완료');
				for (obj of data){
					makeRow(obj);			
				}
			},
			error : function(e) {
				console.log(e);
				alert('에러');
			},

		});
	})

		
function makeRow(obj) {
	console.log(obj.column1);
 	let node = "<tr>";
	node += "<td>"+obj.column1+"</td>";
	node += "<td>"+obj.column2+"</td>";
	node += "<td>"+obj.column3+"</td>";
	node += "<td>"+obj.column4+"</td>";
	node += "<td>"+obj.column5+"</td>";
	node += "<td>"+obj.column6+"</td>";
	node += "</tr>"; 
	
	$("#excel-table tbody").append(node);
	
	
}


</script>