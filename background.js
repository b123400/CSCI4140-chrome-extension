chrome.storage.local.set({"name":"CSCI4140","message":"tywong sosad"},
	function(e){
		alert('Loaded Successfully!');
	});

chrome.storage.local.get(null,function(e){
	alert(e.name + ":" + e.message);
});