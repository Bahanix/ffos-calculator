math.config number: 'bignumber'

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
