var current_page_users = 1;
var records_per_page = 10;

function changePageBy(num) {
	if(num == -1000){
		current_page_users = 1;
		changePageUsers(current_page_users);
	}
	if(num == -99){
		current_page_users = numPagesUsers();
		changePageUsers(current_page_users);
	}
	if (current_page_users + num >= 1
			&& current_page_users + num <= numPagesUsers()) {
		current_page_users += num;
		changePageUsers(current_page_users);
	}
}

function changePageUsers(page) {
	// Validate page
	if (page < 1)
		page = 1;
	if (page > numPagesUsers())
		page = numPagesUsers();

	$(".user").filter(":not(." + current_page_users + ")").hide();
	$(".userpage" + page).show();
	$("#userpageno").html(page);
	for (var i = 1; i <= 4; i++) {
		if (page - i >= 1) {
			$("#userpageno-" + i).show().html(page - i);

		} else {
			$("#userpageno-" + i).hide();
		}
		console.log($("#userpageno" + i));
		if (page + i <= numPagesUsers()) {
			$("#userpageno" + i).show().html(page + i);
		} else {
			$("#userpageno" + i).hide();
		}
	}

	if (page == 1) {
		$("#user_btn_prev").hide();
	} else {
		$("#user_btn_prev").show();
	}

	if (page == numPagesUsers()) {
		$("#user_btn_next").hide();
	} else {
		$("#user_btn_next").show();
	}
	
	//start and finish buttons for large result sets
	if(page < (numPagesUsers() - 4)){
		$('#user_btn_last').show();
	}else{
		$('#user_btn_last').hide();
	}
	
	if(page > 4){
		$('#user_btn_first').show();
	}else{
		$('#user_btn_first').hide();
	}
}

function numPagesUsers() {
	var count = $('#usersT tr').length - 1;
	return Math.ceil(count / records_per_page);
}

window.onload = function() {
	changePageUsers(1);
};