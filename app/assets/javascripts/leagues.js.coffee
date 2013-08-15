jQuery ->
  draft_button = $(".draft_button")

  show_box = draft_button.on 'click', ->
    $('#'+$(this).attr('id')+'_box').show()

  $(".box_close").on 'click', ->
    $('.draft_box').hide()

