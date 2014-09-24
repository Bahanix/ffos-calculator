//= require idangerous.swiper.js
//= require math
//= require_tree .

$expression = document.getElementById("expression")
$result = document.getElementById("result")

operators = ["^", "/", "*", "-", "+", "×", "−", "÷",","]
restart = null
swiping = false

mySwiper = new Swiper '.swiper-container',
  loop: true,
  moveStartThreshold: 32,
  resistance: false,
  onSlideChangeStart: ->
    swiping = true
  onSlideChangeEnd: ->
    swiping = false

humanize = (number) ->
  math.format(number, 6).toString().replace(new RegExp("-", "g"), "−").replace(new RegExp("deg", "g"), "°")

compile = (string) ->
  string.
    replace(new RegExp("×", "g"), "*").
    replace(new RegExp("−", "g"), "-").
    replace(new RegExp("÷", "g"), "/").
    replace(new RegExp("√", "g"), "sqrt").
    replace(new RegExp("π", "g"), "PI").
    replace(new RegExp("rand", "g"), "random()").
    replace(new RegExp("°", "g"), "deg")

backspaceHolding = ->
  $expression.value = ""

$expression.addEventListener "keypress", (e) ->
  result = math.eval compile($expression.value)
  $result.value = humanize(result)
  restart = result

for e in document.getElementsByClassName("digit")
  e.addEventListener "click", ->
    return if swiping
    $expression.value = "" if restart
    $expression.value += @textContent
    restart = null

for e in document.getElementsByClassName("function")
  e.addEventListener "click", ->
    return if swiping
    $expression.value = "" if restart
    $expression.value += @textContent + "("
    restart = null

for e in document.getElementsByClassName("space")
  e.addEventListener "click", ->
    return if swiping
    $expression.value += " "
    restart = null

for e in document.getElementsByClassName("unit")
  e.addEventListener "click", ->
    return if swiping
    $expression.value = humanize(restart) if restart
    $expression.value += @textContent + " "
    restart = null

for e in document.getElementsByClassName("operator")
  e.addEventListener "click", ->
    return if swiping
    if !!$expression.value
      $expression.value = humanize(restart) if restart
      if $expression.value.slice(-1) in operators
        $expression.value = $expression.value.slice(0, -1) + @textContent
      else
        $expression.value += @textContent
      restart = null

for e in document.getElementsByClassName("clear")
  e.addEventListener "click", ->
    return if swiping
    $expression.value = ""
    restart = null

for e in document.getElementsByClassName("backspace")
  e.addEventListener "click", ->
    return if swiping
    $expression.value = $expression.value.slice(0, -1)
    restart = null

for e in document.getElementsByClassName("equal")
  e.addEventListener "click", ->
    return if swiping
    result = math.eval compile($expression.value)
    $result.value = humanize(result)
    restart = result
