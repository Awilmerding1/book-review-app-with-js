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
              // if (data.data.attributes.book) {
              try {
	            $(".bookTitle").text(data.data.attributes.book.title);
	            $(".bookAuthor").text(data.included[0].attributes.author.name);
	            $(".bookReviewer").text(data.data.attributes.user.name);
              $(".bookRating").text(data.data.attributes.rating);
              $(".bookContent").text(data.data.attributes.content);
	            // re-set the id to current on the link
	            $(".js-next").attr("data-id", data["data"]["id"]);
              }
              catch(err) {
                console.log(err)
              }
              finally {
                 window.location=`/books/${bookId}`
              }
            // } else {
            //
            // }
	        });
	    });
	});
