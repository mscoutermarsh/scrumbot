//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require twitter/bootstrap

$ ->
  # fade flash message about 3 seconds
  flashCallback = ->
    $(".flash-message").fadeOut()

  setTimeout flashCallback, 3000
