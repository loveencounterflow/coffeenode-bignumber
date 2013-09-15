############################################################################################################
TRM                       = require 'coffeenode-trm'
log                       = TRM.log.bind TRM
rpr                       = TRM.rpr.bind TRM
echo                      = TRM.echo.bind TRM
BN = @


d1 = BN.new '123456789.123456789'
d2 = BN.new '123456789.123456789'
d3 = BN.new '999999999.123456789'
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

log()

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






