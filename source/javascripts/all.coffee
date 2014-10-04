//= require idangerous.swiper.js
//= require math
//= require_tree .

$expression = document.getElementById("expression")
$buttons = document.getElementById("buttons")
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

doDigit = (button) ->
  $expression.value = "" if restart
  $expression.value += button.textContent
  restart = null

doFunction = (button) ->
  $expression.value = "" if restart
  $expression.value += button.textContent + "("
  restart = null

doSpace = (button) ->
  $expression.value += " "
  restart = null

doUnit = (button) ->
  $expression.value = humanize(restart) if restart
  $expression.value += button.textContent + " "
  restart = null

doOperator = (button) ->
  if !!$expression.value
    $expression.value = humanize(restart) if restart
    if $expression.value.slice(-1) in operators
      $expression.value = $expression.value.slice(0, -1) + button.textContent
    else
      $expression.value += button.textContent
    restart = null

doClear = (button) ->
  $expression.value = ""
  restart = null

doBackspace = (button) ->
  $expression.value = $expression.value.slice(0, -1)
  restart = null

doEqual = (button) ->
  result = math.eval compile($expression.value)
  $result.value = humanize(result)
  restart = result

$buttons.addEventListener "click", (e) ->
  return if swiping
  button = e.target
  switch e.target.className
    when "button digit"
      doDigit button
    when "button function"
      doFunction button
    when "button space"
      doSpace button
    when "button unit"
      doUnit button
    when "button operator"
      doOperator button
    when "button clear"
      doClear button
    when "button backspace"
      doBackspace button
    when "button equal"
      doEqual button
