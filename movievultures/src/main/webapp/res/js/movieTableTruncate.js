
/*
* Based on
* http://stackoverflow.com/questions/17254379/
* 	how-to-display-5-more-rows-of-a-table-on-the-click-on-a-button-using-jquery/
*/
//keep track of current index/row
var currFav = 0;
var currWL = 0;
var currRec = 0;

//how many rows to display
var step = 3;
//get length of each of the following tables
var recLength = $("#recomms tr").length();
var favLength = $("#favs tr").length();
var wlLength = $("#wl tr").length();

//The buttons
var nextFav = $("#nextFavs");
var prevFav = $("#prevFavs");
var nextWL = $("#nextWL");
var prevWL = $("#prevWL");
var nextRec = $("#nextRec");
var prevRec = $("#prevRec");

$("#favs tr").hide();
$("#favs tr").slice(currFav, currFav + step).show();
checkButtons();

nextFav.click(function(e){
	e.preventDefault();
	$("#favs tr").hide();
	currFav += step;
	$("#favs tr").slice(currFav, currFav + step).show();
    checkButtons();
});

prevFav.click(function(e){
	e.preventDefault();
	curFav -= step;
	$("#favs tr").slice(currFav, currFav + step).show();
	checkButtons();
});

function checkButtons(){
	//favorite buttons
	if(currFav + step >= favLength)
		$("#nextFavs").hide();
	else
		$("#nextFavs").show();
	
	if(currFav >= step)
		$("#prevFavs").show();
	else
		$("#prevFavs").hide();
	
}