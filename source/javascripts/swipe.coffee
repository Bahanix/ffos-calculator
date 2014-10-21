mySwiper = new Swiper '.swiper-container',
  loop: true,
  keyboardControl: true,
  resistance: false,
  onSlideChangeStart: ->
    swiping = true
  onSlideChangeEnd: ->
    swiping = false
