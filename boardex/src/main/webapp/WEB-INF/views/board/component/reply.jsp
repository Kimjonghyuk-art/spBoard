<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <template id="replyForm">
		<span>댓글작성</span>
		<textarea id="replyContent" name="replyContent" v-model="replyContent"
		rows="5" cols="130"></textarea>
		<button type="button" class="btn btn-primary" @click="insert">등록</button>
		<hr>
    	
    
    </template>
    
  
<script>
	/* 	Vue.component('reply', {
		template: "#replyForm",
		props: {
			
		},
		data() {
		/* 	return {
				replyContent: "",
			}; */
		},
		methods: {
			/* insert: function() {
				console.log("들어오님")
				this.$emit('insertReply',this.replyContent); 
			}, */
		},
		
		
	});
	 */
	
</script>