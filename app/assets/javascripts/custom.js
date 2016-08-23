$(function() {
  if (typeof gon !== 'undefined') {
    return braintree.setup(gon.client_token, 'dropin', {
      container: 'dropin'
    });
  }
});

$(".alert-dismissable").fadeTo(2000, 500).slideUp(500, function(){
    $(".alert-dismissable").alert('close');
});