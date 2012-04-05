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


# Homepage animation
# -----------------------------------------------------------------------------

$ ->
  $.fn.vAlign = ->
    this.each ->
      ah = $(this).height()
      ph = $(window).height()
      mh = (ph - ah) / 2
      $(this).css 'top', if mh < 100 then 100 else mh

$ ->
  $(window).on 'resize', -> $('#home .content').vAlign()


  animate_home = ->
    $('#home .content').vAlign()
    css_opts = {display: 'none', visibility: 'visible'}

    $('#home h2:first').css(css_opts).fadeIn 2000, ->
      $(this).fadeOut 2000, ->
        $(this).remove()
        $('#home h2:first').css(css_opts).fadeIn 2000, ->
          $(this).fadeOut 2000, ->
            $(this).remove()
            $('#home h2:first').css(css_opts).fadeIn 2000, ->
              $(this).fadeOut 2000, ->
                $(this).remove()
                $('#home h2:first').css(css_opts).fadeIn 2000, ->
                  $(this).fadeOut 2000, ->
                    $(this).remove()
                    $('#home h2:first').css(css_opts).fadeIn 2000, ->
                      $(this).fadeOut 3000, ->
                        $(this).remove()
                        $('#home h1').fadeIn 2000, ->
                            $('#home .navbar-fixed-top').fadeIn 3000
                            $('#home .btn-large').fadeIn 1000, ->
                              $('#home footer').fadeIn 1000


  unless showAnimation
    animate_home = ->
      $('#home').find('h1, .navbar-fixed-top, .btn-large, footer').fadeIn 2000

  setTimeout animate_home, 1000


