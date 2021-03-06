############################################################################################################
TRM                       = require 'coffeenode-trm'
log                       = TRM.log.bind TRM
rpr                       = TRM.rpr.bind TRM
echo                      = TRM.echo.bind TRM
BN                        = require '..'
assert                    = require 'assert'

#-----------------------------------------------------------------------------------------------------------
@test_rpr = ( test ) ->
  probes = [
    '0.0000000000000000000000000000000000001'
    '123456789.123456789'
    '999999999.123456789'
    '3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679'
    '2432902008176640000'
    ]
  #.........................................................................................................
  for probe in probes
    assert.ok ( BN.rpr BN.new probe ) is probe
  #.........................................................................................................
  test.done()

#-----------------------------------------------------------------------------------------------------------
@test_addition = ( test ) ->
  p       = '123456789123456789'
  q       = '547392999827762231.234'
  r       = '670849788951219020.234'
  s       =                  '0.0001'
  t       = '670849788951219020.2341'
  #.........................................................................................................
  p_bn    = BN.new p
  q_bn    = BN.new q
  r_bn    = BN.new r
  s_bn    = BN.new s
  t_bn    = BN.new t
  #.........................................................................................................
  r_bn_c  = BN.add p_bn,   q_bn
  t_bn_c  = BN.add r_bn_c, s_bn
  #.........................................................................................................
  # log TRM.steel BN.rpr r_bn
  # log TRM.steel BN.rpr r_bn_c
  # log TRM.steel BN.equals r_bn_c, r_bn
  assert.ok    ( BN.rpr    r_bn_c ) is r
  assert.ok    ( BN.rpr    t_bn_c ) is t
  assert.equal ( BN.equals r_bn_c, r_bn ), true
  assert.equal ( BN.equals t_bn_c, t_bn ), true
  #.........................................................................................................
  test.done()

#-----------------------------------------------------------------------------------------------------------
@test_sum = ( test ) ->
  addends_txt = [
    '567456745672344234244656789345545578213.33333333'
    '123134356567567.33333333'
    '10000000000000011123459652584256.33333333' ]
  sum_txt = '567456755672344234244668035939554730036.99999999'
  #.........................................................................................................
  addends = ( BN.new addend_txt for addend_txt in addends_txt )
  sum     = BN.new sum_txt
  #.........................................................................................................
  assert.ok BN.equals sum, BN.sum addends
  assert.ok BN.equals sum, BN.sum addends...
  #.........................................................................................................
  test.done()

#-----------------------------------------------------------------------------------------------------------
@test_max = ( test ) ->
  probes_txt = [
    '567456745672344234244656789345545578213.33333333'
    '123134356567567.33333333'
    '567456755672344234244668035939554730036.99999999'
    '10000000000000011123459652584256.33333333' ]
  max_txt = '567456755672344234244668035939554730036.99999999'
  #.........................................................................................................
  probes  = ( BN.new probe_txt for probe_txt in probes_txt )
  max     = BN.new max_txt
  #.........................................................................................................
  assert.ok BN.equals max, BN.max probes
  assert.ok BN.equals max, BN.max probes...
  #.........................................................................................................
  test.done()

#-----------------------------------------------------------------------------------------------------------
@test_average_1 = ( test ) ->
  probes_txt = [
    '123'
    '456.00'
    '789.00'
    '101.00' ]
  average_txt = '367.25'
  #.........................................................................................................
  probes  = ( BN.new probe_txt for probe_txt in probes_txt )
  average = BN.new average_txt
  #.........................................................................................................
  assert.ok BN.equals average, BN.average probes
  assert.ok BN.equals average, BN.average probes...
  #.........................................................................................................
  test.done()

#-----------------------------------------------------------------------------------------------------------
@test_average_2 = ( test ) ->
  probes = []
  #.........................................................................................................
  assert.throws ( -> BN.average probes    ), /^Error: unable to get average value from empty list$/
  assert.throws ( -> BN.average probes... ), /^Error: unable to get average value from empty list$/
  #.........................................................................................................
  test.done()

# log ( BN.rpr BN.new '1e1234' )

->
  log BN.rpr d1
  log BN.rpr d2
  log BN.rpr BN.add       d1, d2
  log BN.rpr BN.subtract  d1, d2
  log BN.rpr BN.multiply  d1, d2
  log BN.rpr BN.divide    d1, d2
  log()
  log BN.rpr BN.sum()
  log BN.rpr BN.sum d1
  log BN.rpr BN.sum d1, d2
  log()
  log BN.rpr BN.sum []
  log BN.rpr BN.sum [ d1, ]
  log BN.rpr BN.sum [ d1, d2, ]
  log BN.equals d1, d2
  log BN.equals d1, d3
  log BN.equals ( BN.new '42' ), 42
  log BN.equals d1, 'foo'
  # log BN.compare d1, 'foo'
  log BN.compare d1, d2
  log BN.compare d1, d3
  log BN.compare d3, d1
  log BN._count_numbers [ ( BN.new '2' ), ( BN.new '8' ), ( BN.new '11' )]
  log BN.rpr BN.average_of ( BN.new '2' ), ( BN.new '8' ), ( BN.new '11' )
  log BN.rpr BN.average_of [ ( BN.new '2' ), ( BN.new '8' ), ( BN.new '11' ), ]

# log()

# log ( name for name of new BD.BigDecimal '42' ).sort()
# log BD.BigDecimal.ONE
# log (name for name of BIGDECIMAL.MathContext )
# log BIGDECIMAL.MathContext.ROUND_HALF_UP
# # @_math_context = new BIGDECIMAL.MathContext 9, 'ROUND_HALF_UP' # BIGDECIMAL.MathContext.ROUND_HALF_UP
# @_math_context = new BIGDECIMAL.MathContext 12, BIGDECIMAL.MathContext.SCIENTIFIC, false, BIGDECIMAL.MathContext.ROUND_HALF_UP
# d = new BIGDECIMAL.BigDecimal '1234567890.1234567890123456789'
# log d.toString()
# # d = d.round @_math_context
# # log d.setScale 2, BIGDECIMAL.MathContext.ROUND_HALF_UP
# # d = d.setScale @_math_context
# d = d.setScale 5, BIGDECIMAL.MathContext.ROUND_HALF_UP
# log d.toString()
# d = new BIGDECIMAL.BigDecimal '1'
# d = d.setScale 500, BIGDECIMAL.MathContext.ROUND_HALF_UP
# d = d.divide new BIGDECIMAL.BigDecimal '5'
# log d.toString()

# d = new BIGDECIMAL.BigDecimal '123.12345678'
# log ( name for name of d ).sort().join ' '
# log d.toPrecision 5






