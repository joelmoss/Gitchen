# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap


$ ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()


# Fetch repos on loading page
# -----------------------------------------------------------------------------

$ ->
  if $('#loading').size() > 0
    fetch_repos = ->
      $.getJSON '/repos', (data)->
        if data.success
          location.reload()
        else
          setTimeout fetch_repos, 10000

    setTimeout fetch_repos, 10000


# Handle ajax modals
# -----------------------------------------------------------------------------

$ ->

  $('[data-toggle=modal-ajax]').on 'click', ->

    # Create the modal div and append to the body
    div = $('<div class="modal fade modal-ajax">loading...</div>')
    div.appendTo('body')

    # It's a modal!
    div.modal()

    # Cleanup the modal after it is hidden
    div.on 'hidden', -> div.remove()

    # Load the HTML into the modal
    div.load $(this).attr('href')

    false