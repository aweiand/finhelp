// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery-ui
//= require turbolinks
//= require js-routes
//= require bootstrap-sprockets
//= require_tree .

function remove_fields(link) {
        $(link).prev("input[type=hidden]").val("1");
        $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
        var new_id = new Date().getTime();
        var regexp = new RegExp("new_" + association, "g");
        $(link).append(content.replace(regexp, new_id));
}

function valida_cpf(cpf) {
    var sum;
    var rest;
    sum = 0;
	if (cpf == "00000000000") return false;
    
	for (i=1; i<=9; i++)
		sum = sum + parseInt(cpf.substring(i-1, i)) * (11 - i);
	rest = (sum * 10) % 11;
	
    if ((rest == 10) || (rest == 11))
    	rest = 0;

    if (rest != parseInt(cpf.substring(9, 10)) )
    	return false;
	
	sum = 0;
    for (i = 1; i <= 10; i++) 
    	sum = sum + parseInt(cpf.substring(i-1, i)) * (12 - i);
    rest = (sum * 10) % 11;
	
    if ((rest == 10) || (rest == 11))
    	rest = 0;

    if (rest != parseInt(cpf.substring(10, 11) ) ) 
    	return false;

    return true;
}