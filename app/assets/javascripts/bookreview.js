window.addEventListener("onload", allReviews);

function allReviews() {
  var id = $("h1").data("id");
   $.get("/users" + id, function(reviews) {
     if (games.data.length) {
       games.data.forEach(function(game) {
     $('#games').append(`<button id="gameid-${game.id}">${game.id}</button><br>`);
     $(`#gameid-${game.id}`).on('click', function() {reloadGame(game.id)});
     })
   }
  });
}
