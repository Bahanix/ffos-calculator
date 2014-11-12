//= require_tree ./lib
//= require_directory .

$settings = document.getElementById("settings")
$close = document.getElementById("close")
$expression = document.getElementById("expression")
$buttons = document.getElementById("buttons")
$result = document.getElementById("result")

operators = ["^", "/", "*", "-", "+", "×", "−", "÷",",","%","mod"]
units = [" m", " in", " ft", " mi", " L", " floz", " cp", " pt", " g", " kg", " oz", " lb", " K", " °C", " °F"]
currencies = [" JPY", " CNY", " EUR", " GBP", " CHF", " SGD", " USD", " AUD", " CAD", " HKD", " SEK", " NOK", " BTC"]
restart = null
ans = 0
swiping = false
history = []

humanize = (number) ->
  math.format(number, 6).toString().
    replace(/-/g, "−").
    replace(/deg/g, "°")

compile = (string) ->
  string.
    replace(/×/g, "*").
    replace(/−/g, "-").
    replace(/÷/g, "/").
    replace(/mod/g, "%").
    replace(/√/g, " sqrt").
    replace(/log/g, " log10").
    replace(/ln/g, " log").
    replace(/ans/g, " (" + ans + ") ").
    replace(/rand/g, " random() ").
    replace(/([0-9]*)d([0-9]+)/g, (match, n, sides) ->
      Array(parseInt(n || 1) + 1).join("ceil(" + sides + " * random()) +").slice(0,-1)
    ).
    replace(/π/g, " PI ").
    replace(/→/g, " to ").
    replace(/°/g, " deg")

doDigit = (button) ->
  doClear() if restart
  string = button.textContent
  $expression.value += string
  history.push string

doFunction = (button) ->
  string = button.textContent + "("
  if restart
    string += humanize(restart) + ")"
    doClear()
  $expression.value += string
  history.push string

getResult = ->
  string = humanize(restart)
  string = "(" + string + ")" if restart.re and restart.im

  $expression.value = string
  history = [string]
  restart = null

doUnit = (button) ->
  getResult() if restart
  string = " " + button.textContent
  if history[history.length - 1] in units
    doBackspace()
  $expression.value += string
  history.push string

doCurrency = (button) ->
  getResult() if restart
  string = " " + button.getAttribute("value")
  if history[history.length - 1] in currencies
    doBackspace()
  $expression.value += string
  history.push string

doOperator = (button) ->
  getResult() if restart
  if history[history.length - 1] in operators
    doBackspace()
  string = button.textContent
  $expression.value += string
  history.push string

doClear = ->
  $expression.value = ""
  $result.value = ""
  history = []
  restart = null

doBackspace = ->
  last = history.pop()
  $expression.value = $expression.value.slice(0, 0 - last.length)
  restart = null

fixParentheses = ->
  open = ($expression.value.match(/\(/g) || []).length
  close = ($expression.value.match(/\)/g) || []).length
  for n in [0 ... open-close] by 1
    $expression.value += ")"
    history.push ")"

doEqual = ->
  if $expression.value
    try
      fixParentheses()
      result = math.eval compile($expression.value)
      $result.value = humanize(result)
      ans = restart = result
    catch
      $result.value = 'error'.toLocaleString()

event = if 'ontouchend' in document.documentElement then 'touchend' else 'click'

$buttons.addEventListener event, (e) ->
  return if swiping

  if localStorage.getItem("vibration") == "true"
    window.navigator.vibrate(50)

  button = e.target
  classes = button.className.split(" ")
  lastClass = classes[classes.length - 1]

  switch lastClass
    when "digit"
      doDigit button
      break
    when "function"
      doFunction button
      break
    when "unit"
      doUnit button
      break
    when "currency"
      doCurrency button
      break
    when "operator"
      doOperator button
      break
    when "clear"
      doClear button
      break
    when "backspace"
      doBackspace button
      break
    when "equal"
      doEqual button
      break
    when "settings"
      $settings.style.display = "block"
      break

$close.addEventListener event, (e) ->
  $settings.style.display = "none"
