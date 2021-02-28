ready =->
  initializeSelect2()
  initCollapsable($('.description'), '95px')
  initializeDynamicHideShow()
  initializeFilter()

$(document).on('turbolinks:load', ready)


initializeDynamicHideShow =->
  $('body').on 'click', '.more-btn-wrapper', (event) ->
    event.preventDefault()
    toggleHideShowMore $(this)

initializeSelect2 =->
  $('.defaultSelect2').select2
    minimumResultsForSearch: 10
    width: '100%'

  $('.language-box').select2
    width: '100%'
    multiple: true
    closeOnSelect: false
    placeholder: "All Languages"

toggleHideShowMore = (element) ->
  $parent = $(element).parent()
  $toggle = $(element).find '.more-btn'
  $less_tag = $toggle.children '.less-tag'
  $more_tag = $toggle.children '.more-tag'
  $text = $(element).prev()

  if $less_tag.hasClass 'hidden'
    $parent.css 'max-height', 'unset'
    # Save old height somewhere for later use
    $text.prop 'default-max-height', $text.css 'max-height'
    $text.css 'max-height', $text.prop('scrollHeight')+'px'
  else
    $text.css 'max-height', $text.prop 'default-max-height'
  $less_tag.toggleClass 'hidden'
  $more_tag.toggleClass 'hidden'

initCollapsable = (collapsables, max_height) ->
  collapsables.each ->
    if $(this).prop('scrollHeight') > $(this).prop('clientHeight')
      $(this).css 'height', 'unset'
      $(this).css 'max-height', max_height
    else
      $(this).siblings('.more-btn-wrapper').hide()
    addAnimatedSliding()

addAnimatedSliding =->
  setTimeout ->
    $('.collapsable').addClass('animated-sliding')
  , 100

initializeFilter =->
  $("#reset-btn").click ->
    $('#search').val('')
    $(".index").submit()


  $(".change-hidden-field").click ->
    $('#option').val(this.id)
    $(".index").submit()
  $('#'+$('#option').val()).addClass('selected')
  intializeAdvancedFilter()

intializeAdvancedFilter =->
  if $('#dropdownWindowActive')
    if $('#dropdownWindowActive').val() == "true"
      $('.dropdown-content').show()

  $('#advanced').click ->
    $('.dropdown-content').toggle()
    search = $('#search')
    if $('#dropdownWindowActive').val() == "true"
      $(search).css("border-bottom-left-radius", "4px")
      $("#advanced").css("border-bottom-right-radius", "4px")
      $('#dropdownWindowActive').val(false)
      $('#drop').removeClass('fa-caret-up').addClass('fa-caret-down')
    else
      $(search).css("border-bottom-left-radius","0px")
      $("#advanced").css("border-bottom-right-radius", "0px")
      $('#dropdownWindowActive').val(true)
      $('#drop').removeClass('fa-caret-down').addClass('fa-caret-up')

  if order = document.getElementById('order_param')
    #    $('#' + order.value).addClass('active')
    $('#order_created').addClass('active')

    #  $('#order_rating').click ->
    #    $('#order_rating').addClass('active')
    #    $('#order_created').removeClass('active')
    #    document.getElementById('order_param').value = 'order_rating'

  $('#order_created').click ->
    $('#order_created').addClass('active')
    $('#order_rating').removeClass('active')
    $('#order_param').val('order_created')
