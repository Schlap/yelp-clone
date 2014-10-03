// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){

  $('.endorsement-links').on('click', '.endorse', function(event){
    var endorsementCount = $(this).parent().siblings('.endorsements-count');
    event.preventDefault();
    $.post(this.href, function(response){
      endorsementCount.text(response.new_endorsements_count);
      $('.notice').text(response.notice);
      $('.endorsement-links').html(response.replacement_link);
    });
  })

  $('.endorsement-links').on('click', '.unendorse', function(event){
    var endorsementCount = $(this).parent().siblings('.endorsements-count');
    event.preventDefault();
    $.ajax({
      url: this.href,
      type: 'DELETE',
      success: function(response) {
        endorsementCount.text(response.new_endorsements_count);
        $('.notice').text(response.notice);
        $('.endorsement-links').html(response.replacement_link);
      }
    })
  })
})