/**
 * 
 */

$("document").ready(function(){
	//console.log("공통 js 시작")
});

function changeURL(url,urlMap) {
	let newURL = url;
	
	for(let [key, val] of urlMap) {
		if(key == 'nowPage') {
			newURL += '?';
			newURL += key;
			newURL += '=';
			newURL += val;
			
		} else {
			newURL += '&';
			newURL += key;
			newURL += '=';
			newURL += val;
		}
	}
	//console.log(newURL)
	if(typeof (history.pushState) != "undefined") {
		history.pushState(null,null,newURL);
	}
	
	
}