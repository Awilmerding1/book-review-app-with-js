$( document ).ready(function allReviews() {

  });

$(function(){
  if($('h2').is('.userShow')){
  var id = $("h2")[0]["dataset"]["id"]
   $.get("/users/" + id + ".json", function(data) {
     data.data.forEach(function(review) {
       $('#allReviews').append(`<div>
         <h3>${review.attributes.book.title}</h3>
         <h4>Rating: ${review["attributes"]["rating"]} Stars</h4>
         <p>${review["attributes"]["content"]}</p>
       </div>`)
     })
  });
  }
});

	$(function () {
	    $(".js-next").on("click", function() {
	        var nextId = parseInt($(".js-next").attr("data-id")) + 1;
          var bookId = parseInt($(".js-book").attr("data-book-id"))
	        $.get("/books/" + bookId + "/reviews/" + nextId + ".json", function(data) {
            console.log(data)
              try {
	            $(".bookTitle").text(data.data.attributes.book.title);
	            $(".bookAuthor").text(data.included[0].attributes.author.name);
	            $(".bookReviewer").text(data.data.attributes.user.name);
              $(".bookRating").text(data.data.attributes.rating);
              $(".bookContent").text(data.data.attributes.content);
	            $(".js-next").attr("data-id", data["data"]["id"]);
              }
              catch(err) {
                alert("Review not found.")
                window.location=`/books/${bookId}`
              }
	        });
	    });
	});

  $(function () {
	   $('form').submit(function(event) {
       event.preventDefault();
       var values = $(this).serialize();
       var posting = $.post('/reviews', values);
       posting.done(function(data) {
         $("#bookReviewTitle").text(data["data"]["attributes"]["book"]["title"]);
         $("#bookReviewAuthor").text("Author: " + data.included[0].attributes.author.name);
         $("#bookReviewReviewer").text("Reviwer: " + data["data"]["attributes"]["user"]["name"]);
         $("#bookReviewRating").text("Rating: " + data["data"]["attributes"]["rating"]);
         $("#bookReviewContent").text(data["data"]["attributes"]["content"]);
       })
     })
   })
