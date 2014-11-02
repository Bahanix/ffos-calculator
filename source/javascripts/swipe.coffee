mySwiper = new Swiper '.swiper-container',
  loop: true,
  moveStartThreshold: 32,
  keyboardControl: true,
  resistance: false,
  onSlideChangeStart: ->
    swiping = true
  onSlideChangeEnd: ->
    swiping = false
