jQuery ->
  draft_pick = $(".draft_pick")

  show_box = draft_pick.on 'click', ->
    $('#'+$(this).attr('id')+'_box').show()

  $(".box_close").on 'click', ->
    $('.draft_box').hide()

