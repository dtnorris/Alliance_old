# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#attendee_character_id').parent().hide()
  $('#attendee_pc').parent().hide()
  characters = $('#attendee_character_id').html()
  $('#attendee_user_id').change ->
    user = $('#attendee_user_id :selected').text()
    escaped_user = user.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(characters).filter("optgroup[label='#{escaped_user}']").html()
    if options
      $('#attendee_character_id').html(options)
      $('#attendee_character_id').parent().show()
      $('#attendee_pc').parent().show()
    else
      $('#attendee_character_id').empty()
      $('#attendee_character_id').parent().hide()
      $('#attendee_pc').parent().hide()