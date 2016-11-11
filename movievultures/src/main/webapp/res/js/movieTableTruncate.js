/*
 * Based on
 * http://stackoverflow.com/questions/17254379/
 * 	how-to-display-5-more-rows-of-a-table-on-the-click-on-a-button-using-jquery/
 */
//keep track of current index/row
$(document).ready(function() {
	var currFav = 0;
	var currWL = 0;
	var currRec = 0;

	// how many rows to display
	var step = 3;
	// get length of each of the following tables
	var recLength = $("#recomms td").length;
	var favLength = $("#favs td").length;
	var wlLength = $("#wl td").length;

	// The buttons
	var nextFav = $("#nextFavs");
	var prevFav = $("#prevFavs");
	var nextWL = $("#nextWL");
	var prevWL = $("#prevWL");
	var nextRec = $("#nextRec");
	var prevRec = $("#prevRec");
	
	//hide everything and only show current slices
	$("#recomms td").hide();
	$("#favs td").hide();
	$("#wl td").hide();
	$("#recomms td").slice(currRec, currRec + step).show();
	$("#favs td").slice(currFav, currFav + step).show();
	$("#wl td").slice(currWL, currWL + step).show();
	checkButtons();
	//console.log(favLength);
	
	//recomms
	nextRec.click(function(e){
		e.preventDefault();
		$("#recomms td").hide();
		currRec += step;
		$("#recomms td").slice(currRec, currRec + step).show();
		checkButtons();
	});
	
	prevRec.click(function(e){
		e.preventDefault();
		$("#recomms td").hide();
		currRec -= step;
		$("#recomms td").slice(currRec, currRec + step).show();
		checkButtons();
	});

	//favorites
	nextFav.click(function(e) {
		e.preventDefault();
		$("#favs td").hide();
		currFav += step;
		$("#favs td").slice(currFav, currFav + step).show();
		checkButtons();
	});

	prevFav.click(function(e) {
		e.preventDefault();
		$("#favs td").hide();
		currFav -= step;
		$("#favs td").slice(currFav, currFav + step).show();
		checkButtons();
	});
	
	//watchLater
	nextWL.click(function(e){
		e.preventDefault();
		$("#wl td").hide();
		currWL += step;
		$("#wl td").slice(currWL, currWL + step).show();
		checkButtons();
	});
	
	prevWL.click(function(e){
		e.preventDefault();
		$("#wl td").hide();
		currWL -= step;
		$("#wl td").slice(currWL, currWL + step).show();
		checkButtons();
	});

	function checkButtons() {
		// recomms buttons
		if( currRec + step >= recLength)
			nextRec.hide();
		else
			nextRec.show();
		
		if(currRec >= step)
			prevRec.show();
		else
			prevRec.hide();
		
		// favorite buttons
		if (currFav + step >= favLength)
			$("#nextFavs").hide();
		else
			$("#nextFavs").show();

		if (currFav >= step)
			$("#prevFavs").show();
		else
			$("#prevFavs").hide();
		
		//watchLater
		if (currWL + step >= wlLength)
			$("#nextWL").hide();
		else
			$("#nextWL").show();

		if (currWL >= step)
			$("#prevWL").show();
		else
			$("#prevWL").hide();
	}

});