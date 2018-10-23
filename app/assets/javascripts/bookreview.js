$( document ).ready(function allReviews() {

  $(function () {
     $('#review_form').submit(function(event) {
       event.preventDefault();
       var values = $(this).serialize();
       var posting = $.post('/reviews', values);
       posting.done(function(data) {
         var newReview = new Review(data["data"]["attributes"]["book"]["title"], data.included[0].attributes.author.name, data["data"]["attributes"]["user"]["name"], data["data"]["attributes"]["rating"], data["data"]["attributes"]["content"])
         $("#reviewResult").append(newReview.format())
         // $("#bookReviewTitle").text(data["data"]["attributes"]["book"]["title"]);
         // $("#bookReviewAuthor").text("Author: " + data.included[0].attributes.author.name);
         // $("#bookReviewReviewer").text("Reviwer: " + data["data"]["attributes"]["user"]["name"]);
         // $("#bookReviewRating").text("Rating: " + data["data"]["attributes"]["rating"]);
         // $("#bookReviewContent").text(data["data"]["attributes"]["content"]);
       })
     })
   })

   $(function () {
      $('#filter_form').submit(function(event) {
        event.preventDefault();
        var title = $('#filter_title').val()
        var author = $('#filter_author').val()
        var genres = $('#filter_genre').val()
        var id = $("h2")[0]["dataset"]["id"]
        $.get("/users/" + id + ".json", function(data) {
          $('#allReviews').empty()
          data.data.forEach(function(review) {
            var appending = `<div>
              <h3>${review.attributes.book.title}</h3>
              <h4>Rating: ${review["attributes"]["rating"]} Stars</h4>
              <p>${review["attributes"]["content"]}</p>
            </div>`
            if (title && review.attributes.book.id == title) {
              $('#filterType').text(`Reviews of ${document.getElementById("filter_title").options[document.getElementById("filter_title").selectedIndex].text}`)
              $('#allReviews').append(appending)
          } else if (author && review.attributes.book.author_id == author) {
            $('#filterType').text(`Reviews of Books By ${document.getElementById("filter_author").options[document.getElementById("filter_author").selectedIndex].text}`)
              $('#allReviews').append(appending)
          }
            else if (genres && review.attributes.genres.some(g => g["id"] == genres)) {
              $('#filterType').text(`Reviews of ${document.getElementById("filter_genre").options[document.getElementById("filter_genre").selectedIndex].text} Books`)
              $('#allReviews').append(appending)
          }
            })
          })
        });
      })

  function Review(title, author, reviewer, rating, content) {
    this.rating = rating;
    this.content = content;
    this.title = title;
    this.author = author;
    this.reviewer = reviewer;
  }

  Review.prototype.format = function() {
    return `<div>
      <h3>${this.title}</h3>
      <h4>Author: ${this.author}</h4>
      <h4>Reviewer: ${this.reviewer}</h4>
      <h4>Rating: ${this.rating} Stars</h4>
      <p>${this.content}</p>
    </div>`
  };



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
	        var currentReviewId = parseInt($(".js-next").attr("data-id"));
          var bookId = parseInt($(".js-book").attr("data-book-id"))
          $.get("/books/" + bookId + ".json", function(data) {
            var thisId = data.data.attributes.reviews.map(x => x["id"] == currentReviewId).indexOf(true)
            $(".bookTitle").text(data.data.attributes.title);
            $(".bookAuthor").text(data.data.attributes.author.name);
            try {
            $(".bookReviewer").text(data.data.attributes.users[thisId +1].name);
            $(".bookRating").text(data.data.attributes.reviews[thisId +1].rating);
            $(".bookContent").text(data.data.attributes.reviews[thisId +1].content);
            $(".js-next").attr("data-id", data.data.attributes.reviews[thisId +1].id);
            }
            catch(err) {
              thisId = 0
              $(".bookReviewer").text(data.data.attributes.users[thisId].name);
              $(".bookRating").text(data.data.attributes.reviews[thisId].rating);
              $(".bookContent").text(data.data.attributes.reviews[thisId].content);
              $(".js-next").attr("data-id", data.data.attributes.reviews[thisId].id);
            }
          })

	        // $.get("/books/" + bookId + "/reviews/" + nextId + ".json", function(data) {
          //   console.log(data)
          //     try {
	        //     $(".bookTitle").text(data.data.attributes.book.title);
	        //     $(".bookAuthor").text(data.included[0].attributes.author.name);
	        //     $(".bookReviewer").text(data.data.attributes.user.name);
          //     $(".bookRating").text(data.data.attributes.rating);
          //     $(".bookContent").text(data.data.attributes.content);
	        //     $(".js-next").attr("data-id", data["data"]["id"]);
          //     }
          //     catch(err) {
          //       alert("Review not found.")
          //       window.location=`/books/${bookId}`
          //     }
	        // });
	    });
	});
