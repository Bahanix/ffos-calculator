//= require_tree .

$(document).ready ->
  $expression = $(".expression")
  $result = $(".result")
  operators = ["^", "/", "*", "-", "+", "×", "−", "÷"]
  bracketsCount = 0
  backspaceHolded = null
  restart = null

  precision = (float) ->
    if parseInt(float) is float
      float
    else
      float.toPrecision(10)

  humanize = (number) ->
    console.log(typeof number);
    if typeof number is 'object'
      number.value = precision(number.value)
    if typeof number is 'number'
      number = precision(number)
    number.toString().replace(new RegExp("-", "g"), "−")

  compile = (string) ->
    string.replace(new RegExp("×", "g"), "*").replace(new RegExp("−", "g"), "-").replace(new RegExp("÷", "g"), "/")

  backspaceHolding = ->
    $expression.val("")

  $expression.on "keypress", (e) ->
    $(".equal").click() if e.which is 13

  $(".open").on "click", ->
    bracketsCount++
    $expression.val $expression.val() + @textContent
    restart = null

  $(".close").on "click", ->
    if bracketsCount > 0
      bracketsCount--
      $expression.val $expression.val() + @textContent
      restart = null

  $(".digit").on "click", ->
    $expression.val "" if restart
    $expression.val $expression.val() + @textContent
    restart = null

  $(".operator").on "click", ->
    if !!$expression.val()
      $expression.val humanize(restart) if restart
      if $expression.val().slice(-1) in operators
        $expression.val $expression.val().slice(0, -1) + @textContent
      else
        $expression.val $expression.val() + @textContent
      restart = null

  $(".backspace").on "mousedown", ->
    backspaceHolded = setTimeout backspaceHolding, 1500

  $(".backspace").on "mouseup", ->
    clearTimeout backspaceHolded
    $expression.val $expression.val().slice(0, -1)
    restart = null

  $(".equal").on "click", ->
    result = math.eval(compile($expression.val()))
    $result.val humanize(result)
    restart = result
