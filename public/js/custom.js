$(".vote").click(function(){
  id = $(this).attr("id");
  vote = $(this).attr("value");
  $.ajax({
    url: "/",
    type: "POST",
    data: { id: id, vote: vote },
    success: function(data){
      $("#" + id + ".score").html(data);
      button =  $("#" + id + ".vote-" + vote);
      button.toggleClass("btn-default");
      button.toggleClass("btn-primary");
      $("#" + id + ".vote").attr("disabled", "disabled");
    }
  });
});

$(".comment-toggle").click(function(){
  id = $(this).attr("id")
  comments = $("#" + id + ".comments")
  comments.toggle();
  if (comments.is(":hidden")){
    $(".label", this).html("Show comments")
  } else {
    $(".label", this).html("Hide comments")
  }
});