$ ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()


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