mySwiper = new Swiper '.swiper-container',
  pagination: '#pages',
  paginationClickable: true,
  createPagination: false,
  loop: true,
  moveStartThreshold: 32,
  keyboardControl: true,
  resistance: false,
  onSlideChangeStart: ->
    swiping = true
  onSlideChangeEnd: ->
    swiping = false
