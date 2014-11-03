$vibration = document.getElementById("vibration")
$vibration.checked = localStorage.getItem("vibration") == "true"
$vibration.onchange = ->
  localStorage.setItem "vibration", this.checked

$eur2usd = document.getElementById("eur2usd")
eur2usd = localStorage.getItem("eur2usd") || math.type.Unit.UNITS.eur.value
$eur2usd.value = eur2usd
math.type.Unit.UNITS.eur.value = eur2usd

$eur2usd.onchange = ->
  localStorage.setItem "eur2usd", this.value
  math.type.Unit.UNITS.eur.value = this.value
