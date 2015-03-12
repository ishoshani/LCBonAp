$(".vote").click(function(){
  id = $(this).attr("id");
  value = $(this).attr("value");
  $.ajax({
    url: "/",
    type: "POST",
    data: { id: id, vote: value },
    success: function(data){
      $("#" + id + ".score").html(data);
    }
  });
});