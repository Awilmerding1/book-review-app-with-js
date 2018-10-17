$( document ).ready(function allReviews() {
  var id = $("h2")[0]["dataset"]["id"]
   $.get("/users/" + id + ".json", function(data) {
     console.log(data)
     // data.included.forEach(function(review) {
     //   $('#allReviews').append(`<div>
     //     <h4>Rating: ${review["attributes"]["rating"]} Stars</h4>
     //     <p>${review["attributes"]["content"]}</p>
     //   </div>`)
     // })
  });
}
);
