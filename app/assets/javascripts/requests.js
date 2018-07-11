$(document).on("turbolinks:load",function(){
  $('#check_in').hide()
  $('#check_out').hide()
  $('#request_requests_type_id').change(function(){
    if ($(this).val() == "1"){
      $('#check_out').show();
      $('#check_in').hide();
    } else if($(this).val() == "2") {
      $('#check_out').hide();
      $('#check_in').show();
    }else {
      $('#check_out').hide();
      $('#check_in').hide();
    }
  });
});
