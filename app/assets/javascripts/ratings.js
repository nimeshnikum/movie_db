// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("turbolinks:load", function() {
  $('.rateit').rateit();
  $('.rateit').bind('rated', function () {
    callbackOnRated($(this))
  });
});

function callbackOnRated(el) {
  var previousValue = el.attr('data-rateit-value');
  var value = el.rateit('value');
  var movieID = el.data('movieid')

  $.ajax({
    url: '/movies/' + movieID + '/ratings',
    data: { rating: value },
    type: 'POST',
    success: function (data) {
      bindAndUpdateElement('tr.movie_' + movieID, data)
    },
    error: function (response) {
      bindAndUpdateElement('tr.movie_' + movieID, response.responseText)
    }
   });
}

function bindAndUpdateElement(elem, data) {
  $(elem).html(data)
  $(elem).find('.rateit').rateit();
  $(elem).find('.rateit').bind('rated', function () {
    callbackOnRated($(this))
  });
}
