math.config number: 'bignumber'

math.type.Unit.BASE_UNITS.MONEY = {}

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

math.zero = (a) ->
  (a.re == 0 && a.im == 0) ||
  (a.value == 0) ||
  (a instanceof math.type.BigNumber && a.toNumber() == 0)

math.divide.transform = (a, b) ->
  if math.zero b
    throw new math.error.ArgumentsError()
  else
    math.divide a, b

# 1. Fill all inputs from settings pages
# 2. Set all mathjs units
# 3. Set rates in localstorage
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
  localStorage.setItem "rates", JSON.stringify(rates)

# If network is enabled, window.rates contains up to date rates yet
if !window.rates && rates = localStorage.getItem("rates")
  window.rates = JSON.parse(rates)

setRates window.rates
