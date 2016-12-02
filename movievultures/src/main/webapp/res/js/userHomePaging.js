var current_page_rev = 1;
var current_page_favs = 1;
var current_page_watch = 1;
var current_page_elo = 1;

var records_per_page = 5;

function changeEloBy(num, tableName){
	if (current_page_elo + num >= 1
			&& current_page_elo + num <= numPages('#' + tableName + ' tr')) {
		current_page_elo += num;
		changePage(current_page_elo, tableName);
	}
}

function changeRevBy(num, tableName) {
	// console.log('#' + tableName + " tr");
	if (current_page_rev + num >= 1
			&& current_page_rev + num <= numPages('#' + tableName + ' tr')) {
		current_page_rev += num;
		changePage(current_page_rev, tableName);
	}
}

function changeWatchBy(num, tableName) {
	if (current_page_watch + num >= 1
			&& current_page_watch + num <= numPages('#' + tableName + ' tr')) {
		current_page_watch += num;
		changePage(current_page_watch, tableName);
	}
}

function changeFavBy(num, tableName) {
	if (current_page_favs + num >= 1
			&& current_page_favs + num <= numPages('#' + tableName + ' tr')) {
		current_page_favs += num;
		changePage(current_page_favs, tableName);
	}
}

function changePage(page, tableName) {
	// Validate page
	if (page < 1)
		page = 1;
	if (page > numPages('#' + tableName + ' tr'))
		page = numPages('#' + tableName + ' tr');

	$("." + tableName).hide();
	$("." + tableName + "page" + page).show();
	$("#" + tableName + "pageno").html(page);
	for (var i = 1; i <= 4; i++) {
		if (page - i >= 1) {
			$("#" + tableName + "pageno-" + i).show().html(page - i);

		} else {
			$("#" + tableName + "pageno-" + i).hide();
		}
		// console.log($("#userpageno" + i));
		if (page + i <= numPages("#" + tableName + " tr")) {
			$("#" + tableName + "pageno" + i).show().html(page + i);
		} else {
			$("#" + tableName + "pageno" + i).hide();
		}
	}

	if (page == 1) {
		$("#" + tableName + "_btn_prev").hide();
	} else {
		$("#" + tableName + "_btn_prev").show();
	}

	if (page == numPages("#" + tableName + " tr")) {
		$("#" + tableName + "_btn_next").hide();
	} else {
		$("#" + tableName + "_btn_next").show();
	}

}

function numPages(tableName) {
	var count = $(tableName).length;
	return Math.ceil(count / records_per_page);
}

//function toggleFavorites() {
//	$('#favSlider').slideToggle();
//};
//
//function toggleWatch() {
//	$('#watchSlider').slideToggle();
//}
//
//function toggleReviews() {
//	$('#revSlider').slideToggle();
//}
//
//function toggleElos(){
//	$('#eloSlider').slideToggle();
//}
//
//function toggleRec(){
//	$('#recSlider').slideToggle();
//}

window.onload = function() {
	changePage(1, "rev");
	changePage(1, "watch");
	changePage(1, "fav");
	changePage(1, "elo");
	$( "#toggles" ).accordion();
};