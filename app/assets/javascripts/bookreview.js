$( document ).ready(function allReviews() {
  var id = $("h2")[0]["dataset"]["id"]
   $.get("/users/" + id + ".json", function(data) {
     console.log(data["data"]["reviews"])
     data.data.reviews.forEach(function(review) {
       $('#allReviews').append(`<div>
         <h4>Rating: ${review["rating"]} Stars</h4>
         <p>${review["content"]}</p>
       </div>`)
     })
  });
}
);
