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


$ ->
  $('a.edit-description').on 'click', ->
    btn   = $(this)
    repo  = btn.parents 'tr.repo'
    ele   = repo.find 'p.description'

    if btn.hasClass 'btn-mini'
      ele.hide()

      cancel = btn.clone()
      cancel.text 'cancel'
      cancel.addClass 'cancel-edit'
      cancel.removeClass 'btn-danger'
      cancel.insertAfter btn

      btn.removeClass 'btn-mini'
      btn.text 'save'

      ele.after '<form><textarea name="watch[description]"></textarea></form>'
      repo.find('textarea').val ele.text()

    else
      form = repo.find 'form'

      $.ajax
        type: 'PUT'
        data: form.serializeArray()
        url: "repos/#{repo.attr('id').replace('repo-', '')}"

      ele.text(repo.find('textarea').val()).show()
      repo.find('.cancel-edit').remove()
      form.remove()

      btn.addClass 'btn-mini'
      btn.text 'edit...'


  $('.repo').on 'click', '.cancel-edit', ->
    btn   = $(this)
    repo  = btn.parents 'tr.repo'
    ele   = repo.find 'p.description'
    edit  = repo.find '.edit-description'
    form  = repo.find 'form'

    ele.show()
    btn.remove()
    form.remove()

    edit.addClass 'btn-mini'
    edit.text 'edit...'
    edit.hide()


  $('tr.repo').on
    mouseenter: ->
      $(this).find('a.edit-description').css 'display', 'block'
    mouseleave: ->
      $(this).find('a.edit-description').hide()


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