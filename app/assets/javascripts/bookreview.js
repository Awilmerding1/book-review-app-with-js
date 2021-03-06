$( document ).ready(function allReviews() {

  $(function () {
     $('#update_form').submit(function(event) {
       event.preventDefault();
       var book_id = $("h1")[1]["dataset"]["id"]
       var values = $(this).serialize();
       var posting = $.post('/books/' + book_id, values);
       posting.done(function(data) {
         var updateBook = data.data.attributes.genres
         var bookGenres = updateBook.map(x => `<li>${x.name}</li>`)
          $("#genreList").empty()
          $("#genreList").append(bookGenres)
       })
     })
   })

   $(function () {
      $('#update_title_author').submit(function(event) {
        event.preventDefault();
        var book_id = $("h1")[1]["dataset"]["id"]
        var values = $(this).serialize();
        var posting = $.post('/books/' + book_id, values);
        posting.done(function(data) {
          var updateAuthor = data.data.attributes.author.name
          var updateTitle = data.data.attributes.title
          console.log(updateAuthor)
          console.log(updateTitle)
           $("#bookTitleEdit").empty()
           $("#bookTitleEdit").append(updateTitle)
           $("#bookAuthorEdit").empty()
           $("#bookAuthorEdit").append("Author: "+ updateAuthor)
        })
      })
    })


  $(function () {
     $('#review_form').submit(function(event) {
       event.preventDefault();
       var values = $(this).serialize();
       var posting = $.post('/reviews', values);
       posting.done(function(data) {
         var newReview = new Review(data["data"]["attributes"]["book"]["title"], data.included[0].attributes.author.name, data["data"]["attributes"]["user"]["name"], data["data"]["attributes"]["rating"], data["data"]["attributes"]["content"])
         $("#reviewResult").append(newReview.format())
       })
     })
   })

   $(function () {
      $('#filter_form').submit(function(event) {
        event.preventDefault();
        var title = $('#filter_title').val()
        var t
        var a
        var g
        var author = $('#filter_author').val()
        var genres = $('#filter_genre').val()
        var id = $("h2")[0]["dataset"]["id"]
        $.get("/users/" + id + ".json", function(data) {
          $('#allReviews').empty()
          $('#filterType').text("Review(s) of ")
          data.data.forEach(function(review) {
            var appending = `<div>
              <h3>${review.attributes.book.title}</h3>
              <h4>Rating: ${review["attributes"]["rating"]} Stars</h4>
              <p>${review["attributes"]["content"]}</p>
            </div>`
            if (title && review.attributes.book.id == title) {
               t = `${document.getElementById("filter_title").options[document.getElementById("filter_title").selectedIndex].text} `
              $('#allReviews').append(appending)
          } if (author && review.attributes.book.author_id == author) {
             a = `Books By ${document.getElementById("filter_author").options[document.getElementById("filter_author").selectedIndex].text} `
             if ($(`div:contains("${review.attributes.book.title}")`).length == 0) {
                $('#allReviews').append(appending)
              }
            }
             if (genres && review.attributes.genres.some(g => g["id"] == genres)) {
               g = `${document.getElementById("filter_genre").options[document.getElementById("filter_genre").selectedIndex].text} Books`
               if ($(`div:contains("${review.attributes.book.title}")`).length == 0) {
                $('#allReviews').append(appending)
              }
            }
            })
             if (t && a && g) {
              $('#filterType').append(t, "and ", a, "and ", g)
            }  else if (t && a) {
                $('#filterType').append(t, "and ", a)
              } else if (t && g) {
                $('#filterType').append(t, "and ", g)
              } else if (a && g) {
                $('#filterType').append(a, "and ", g)
              } else if (t){
                  $('#filterType').append(t)
                } else if (a){
                  $('#filterType').append(a)
                } else if (g) {
                  $('#filterType').append(g)
                }
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

$(function(){
  if($('h1').is('.bookShow')){
  var id = $("h1")[1]["dataset"]["id"]
   $.get("/books/" + id + ".json", function(data) {
     data.data.attributes.genres.forEach(function(genre) {
       $('#genreList').append(`<li>${genre.name}</li>`)
     })
  });
  }
});

	$(function () {
	    $(".js-next").on("click", function() {
	        var currentReviewId = parseInt($(".js-next").attr("data-id"));
          var bookId = parseInt($(".js-book").attr("data-book-id"))
          $.get("/books/" + bookId + ".json", function(data) {
            if (data.data.attributes.reviews.length > 0) {
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
            }
          })

	    });
	});
