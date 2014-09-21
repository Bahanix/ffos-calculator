//= require_tree .

$(document).ready ->
  humanize = (number) ->
    (Math.round(number * 100000) / 100000).toString().replace(new RegExp("-", "g"), "−")

  compile = (string) ->
    string.replace(new RegExp("×", "g"), "*").replace(new RegExp("−", "g"), "-").replace(new RegExp("÷", "g"), "/")

  $expression = $(".expression")
  $result = $(".result")
  restart = null

  $expression.on "keypress", (e) ->
    $(".equal").click() if e.which is 13

  $(".digit").on "click", ->
    $expression.val "" if restart
    $expression.val $expression.val() + @textContent
    restart = null

  $(".operator").on "click", ->
    $expression.val humanize(restart) if restart
    $expression.val $expression.val() + @textContent
    restart = null

  $(".backspace").on "click", ->
    $expression.val $expression.val().slice(0, -1)
    restart = null

  $(".equal").on "click", ->
    result = math.eval(compile($expression.val()))
    $result.val humanize(result)
    restart = result
