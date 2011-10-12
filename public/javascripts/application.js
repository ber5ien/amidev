$(document).ready(function() {

	// Open external links in a new window
	hostname = window.location.hostname
	$("a[href^=http]")
	  .not("a[href*='" + hostname + "']")
	  .addClass('link external')
	  .attr('target', '_blank');

});

$(document).ready(function() {
 window.setTimeout(function(){
                          $('#turnitoff').fadeOut();
 }, 5000);
});

$(document).ready(function() {
  $("#inplace").focus();
});
