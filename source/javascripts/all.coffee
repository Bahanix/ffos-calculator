//= require jquery
//= require math
//= require slick
//= require_tree .

$(document).ready ->
  $expression = $(".expression")
  $result = $(".result")
  operators = ["^", "/", "*", "-", "+", "×", "−", "÷",","]
  backspaceHolded = null
  restart = null
  swiping = false

  $('.slider').slick(
    dots: false,
    arrows: false,
    onBeforeChange: ->
      swiping = true
    onAfterChange: ->
      swiping = false
  )

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
    $expression.val("")

  $expression.on "keypress", (e) ->
    $(".equal").click() if e.which is 13

  $(".digit").on "click", ->
    return if swiping
    $expression.val "" if restart
    $expression.val $expression.val() + @textContent
    restart = null

  $(".function").on "click", ->
    return if swiping
    $expression.val "" if restart
    $expression.val $expression.val() + @textContent + "("
    restart = null

  $(".space").on "click", ->
    return if swiping
    $expression.val $expression.val() + " "
    restart = null

  $(".unit").on "click", ->
    return if swiping
    $expression.val "" if restart
    $expression.val $expression.val() + @textContent + " "
    restart = null

  $(".operator").on "click", ->
    return if swiping
    if !!$expression.val()
      $expression.val humanize(restart) if restart
      if $expression.val().slice(-1) in operators
        $expression.val $expression.val().slice(0, -1) + @textContent
      else
        $expression.val $expression.val() + @textContent
      restart = null

  $(".clear").on "click", ->
    return if swiping
    $expression.val ""
    restart = null

  $(".backspace").on "click", ->
    return if swiping
    $expression.val $expression.val().slice(0, -1)
    restart = null

  $(".equal").on "click", ->
    return if swiping
    result = math.eval(compile($expression.val()))
    $result.val humanize(result)
    restart = result
