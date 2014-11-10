$vibration = document.getElementById("vibration")
$vibration.checked = localStorage.getItem("vibration") == "true"
$vibration.onchange = ->
  localStorage.setItem "vibration", this.checked

updateRate = ->
  window.rates[this.id.toUpperCase()] = this.value
  localStorage.setItem "rates", JSON.stringify(window.rates)
  math.type.Unit.UNITS[this.id.toUpperCase()].value = 1 / this.value

for currency in ["eur", "gbp", "chf", "jpy", "sgd", "cny", "aud", "cad", "hkd", "sek", "nok", "btc"]
  document.getElementById(currency).onchange = updateRate
