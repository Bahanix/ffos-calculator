mySwiper = new Swiper '.swiper-container',
  loop: true,
  moveStartThreshold: 32,
  resistance: false,
  onSlideChangeStart: ->
    swiping = true
  onSlideChangeEnd: ->
    swiping = false
