$(document).ready(function(){
	
	var rows_display = 4;
	var curRev = 4;
	var curWatch = 4;
	var curFav = 4;
	var curRec = 4;
	
	var recLength = $("#rec tr").length;
	var favLength = $("#fav tr").length;
	var watchLength = $("#watch tr").length;
	var revLength = $("#rev tr").length;
	//buttons
	var moreRec = $("#moreRec");
	var lessRec = $("#lessRec");
	var moreFav = $("#moreFav");
	var lessFav = $("#lessFav");
	var moreWatch = $('#moreWatch');
	var lessWatch = $("#lessWatch");
	var moreRev = $("#moreRev");
	var lessRev = $("#lessRev");
	
	//on start only show first rows
	checkButtons();
	$("#rec tr").hide();
	$("#fav tr").hide();
	$("#watch tr").hide();
	$("#rev tr").hide();
	$("#rev tr").slice(0, rows_display).show();
	$("#fav tr").slice(0, rows_display).show();
	$("#rec tr").slice(0, rows_display).show();
	$("#watch tr").slice(0, rows_display).show();
	
	//slide demo
	$('#revHeader').click(function(e){
	    $('#slideRev').slideToggle();
	});
	
	//button clicks
	moreRev.click(function(){
		$("#rev tr").slice(curRev, curRev + rows_display).show();
		curRev += rows_display;
		checkButtons();
	});
	
	lessRev.click(function(){
		$("#rev tr").slice(curRev - rows_display, curRev).hide();
		curRev -= rows_display;
		checkButtons();
	});
	
	moreRec.click(function(){
		$("#rec tr").slice(curRec, curRec + rows_display).show();
		curRec += rows_display;
		checkButtons();
	});

	lessRec.click(function(){
		$("#rec tr").slice(curRec - rows_display, curRec).hide();
		curRec -= rows_display;
		checkButtons();
	});
	
	moreWatch.click(function(){
		$("#watch tr").slice(curWatch, curWatch + rows_display).show();
		curWatch += rows_display;
		checkButtons();
	});
	
	lessWatch.click(function() {
		$("#watch tr").slice(curWatch - rows_display, curWatch).hide();
		curWatch -= rows_display;
		checkButtons();
	});
	
	function checkButtons(){
		//Reviews
		if(curRev < revLength)
			moreRev.show();
		else
			moreRev.hide();
		
		if(curRev <= rows_display)
			lessRev.hide();
		else
			lessRev.show();
		//WatchList
		if(curWatch < watchLength)
			moreWatch.show();
		else
			moreWatch.hide();
		if(curWatch <= rows_display)
			lessWatch.hide();
		else
			lessWatch.show();
		//Recommendations
		if(curRec < recLength)
			moreRec.show();
		else
			moreRec.hide();
		if(curRec <= rows_display)
			lessRec.hide();
		else
			lessRec.show();
		//Favorites
		if(curFav < favLength)
			moreFav.show();
		else
			moreFav.hide();
		if(curFav <= rows_display)
			lessFav.hide();
		else
			lessFav.show();
	}
	
});