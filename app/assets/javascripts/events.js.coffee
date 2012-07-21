# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#patron_xp_character_id').parent().hide()
  $('#patron_xp_pc').parent().hide()
  characters = $('#patron_xp_character_id').html()
  $('#patron_xp_user_id').change ->
    user = $('#patron_xp_user_id :selected').text()
    escaped_user = user.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(characters).filter("optgroup[label='#{escaped_user}']").html()
    if options
      $('#patron_xp_character_id').html(options)
      $('#patron_xp_character_id').parent().show()
      $('#patron_xp_pc').parent().show()
    else
      $('#patron_xp_character_id').empty()
      $('#patron_xp_character_id').parent().hide()
      $('#patron_xp_pc').parent().hide()