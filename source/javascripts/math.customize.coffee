math.config number: 'bignumber'

math.type.Unit.BASE_UNITS.MONEY = {}

setRates = (rates) ->
  for currency of rates
    if $currency = document.getElementById(currency.toLowerCase())
      $currency.value = rates[currency]
    math.type.Unit.UNITS[currency] =
      name: currency,
      base: math.type.Unit.BASE_UNITS.MONEY,
      prefixes: math.type.Unit.PREFIXES.NONE,
      value: 1 / rates[currency],
      offset: 0

if localStorage.getItem("rates")
  window.rates = JSON.parse(localStorage.getItem("rates"))

setRates window.rates

request = new XMLHttpRequest({ mozSystem: true })
request.open 'get', '/rates.json', true
request.responseType = 'json'
request.addEventListener 'error', ->
  console.log "Error XHR rates.json"
request.addEventListener 'load', (data) ->
  window.rates = data.srcElement.response.rates
  localStorage.setItem("rates", JSON.stringify(window.rates))
  setRates(window.rates)
request.send()

math.sin.transform = (a) ->
  if a % math.pi == 0
    0
  else
    math.sin a

math.factorial.transform = (a) ->
  if a > 100000
    throw new math.error.ArgumentsError()
  else
    math.factorial a

math.divide.transform = (a, b) ->
  if b.toNumber() == 0
    throw new math.error.ArgumentsError()
  else
    math.divide a, b
