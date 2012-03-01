// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery(function($) {
  // create a convenient toggleLoading function
  // var toggleLoading = function() { $("#loading").toggle() };
  // $("#task_form input#new_task_description").val('sample');
  $("#task_form")
    .bind("ajax:success", function(evt, data, status, xhr) {
      $('#tasks tr:first').after(data);
      $('#tasks tr:nth-child(2)').animate({'backgroundColor' : '#CC99CC'}, 1000).delay(500).animate({'backgroundColor' : '#DDE'}, 1000);
      $('#task_form')[0].reset();
        
      $('#tasks tr.row:odd').animate({'backgroundColor' : '#DDE'}, 500);
      $('#tasks tr.row:even').animate({'backgroundColor' : '#EEF'}, 500);
    });
});