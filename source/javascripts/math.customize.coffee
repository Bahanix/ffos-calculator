math.config number: 'bignumber'

math.type.Unit.BASE_UNITS.MONEY = {}

math.type.Unit.UNITS.usd =
  name: 'usd',
  base: math.type.Unit.BASE_UNITS.MONEY,
  prefixes: math.type.Unit.PREFIXES.NONE,
  value: 1,
  offset: 0

math.type.Unit.UNITS.eur =
  name: 'eur',
  base: math.type.Unit.BASE_UNITS.MONEY,
  prefixes: math.type.Unit.PREFIXES.NONE,
  value: 1.3,
  offset: 0

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
