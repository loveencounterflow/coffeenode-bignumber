





############################################################################################################
MULTIMIX                  = require 'coffeenode-multimix'
TEXT                      = require 'coffeenode-text'
TYPES                     = require 'coffeenode-types'
base                      = require './base'
#...........................................................................................................
### https://github.com/dtrebbien/BigDecimal.js ###
BDC                       = require '../other-modules/BigDecimal.js/BigDecimal-all-last.js'


#===========================================================================================================
# CREATION & TYPE CHECKING
#-----------------------------------------------------------------------------------------------------------
@new = ( x ) ->
  return @_zero if x is '0'
  return @_one  if x is '1'
  #.........................................................................................................
  if @_isa_BigDecimal x
    substrate = x
  else switch type = TYPES.type_of x
    when 'text'
      substrate = new BDC.BigDecimal x
    when 'BIGNUMBER/decimal'
      substrate = x[ '%self' ]
    else
      throw new Error "expected a suitable text, a BigDecimal object, or a BIGNUMBER/decimal, got a #{type}"
  #.........................................................................................................
  R =
    '~isa':       'BIGNUMBER/decimal'
    '%self':      substrate
  #.........................................................................................................
  return R

#-----------------------------------------------------------------------------------------------------------
@_isa_BigDecimal = ( x ) ->
  return x instanceof BDC.BigDecimal

#-----------------------------------------------------------------------------------------------------------
@_zero  = @new BDC.BigDecimal.ZERO
@_one   = @new BDC.BigDecimal.ONE


#===========================================================================================================
# ELEMENTARY ARITHMETICS
#-----------------------------------------------------------------------------------------------------------
@add      = ( me, you ) -> return @new me[ '%self' ].add       you[ '%self' ]
@subtract = ( me, you ) -> return @new me[ '%self' ].subtract  you[ '%self' ]
@multiply = ( me, you ) -> return @new me[ '%self' ].multiply  you[ '%self' ]
@divide   = ( me, you ) -> return @new me[ '%self' ].divide    you[ '%self' ]


#===========================================================================================================
# COMPARISON
#-----------------------------------------------------------------------------------------------------------
@equals = ( me, you ) ->
  return me[ '%self' ].equals you[ '%self' ]

#-----------------------------------------------------------------------------------------------------------
@compare = ( me, you ) ->
  try
    return me[ '%self' ].compareTo you[ '%self' ]
  catch error
    type_of_me  = TYPES.type_of me
    type_of_you = TYPES.type_of you
    throw error if ( type_of_me is 'BIGNUMBER/decimal' ) and ( type_of_you is 'BIGNUMBER/decimal' )
    throw new Error "expected two BIGNUMBER/decimal objects, got a #{type_of_me} and a #{type_of_you}"


#===========================================================================================================
# AGGREGATE FUNCTIONS
#-----------------------------------------------------------------------------------------------------------
@sum = ( P... ) ->
  numbers = get_list_of_arguments P
  return @new @_reduce @_zero[ '%self' ], numbers, 'add'

#-----------------------------------------------------------------------------------------------------------
@average = ( P... ) ->
  numbers = get_list_of_arguments P
  sum     = @_reduce @_zero[ '%self' ], numbers, 'add'
  return @new sum.divide new BDC.BigDecimal ( numbers.length ).toString()

#-----------------------------------------------------------------------------------------------------------
@min = ( P... ) ->
  numbers = get_list_of_arguments P
  throw new Error "unable to get minimum value from empty list" if numbers.length is 0
  return @new @_reduce_without_seed numbers, 'min'

#-----------------------------------------------------------------------------------------------------------
@max = ( P... ) ->
  numbers = get_list_of_arguments P
  throw new Error "unable to get maximum value from empty list" if numbers.length is 0
  return @new @_reduce_without_seed numbers, 'max'

#-----------------------------------------------------------------------------------------------------------
@_reduce = ( seed, numbers, method_name ) ->
  R = seed
  R = R[ method_name ] number[ '%self' ] for number in numbers
  return R

#-----------------------------------------------------------------------------------------------------------
@_reduce_without_seed = ( numbers, method_name ) ->
  R = numbers[ 0 ][ '%self' ]
  R = R[ method_name ] numbers[ idx ][ '%self' ] for idx in [ 1 ... numbers.length ]
  return R


#===========================================================================================================
# SERIALIZATION
#-----------------------------------------------------------------------------------------------------------
@rpr = ( me ) ->
  return me[ '%self' ].toString()


#===========================================================================================================
# HELPERS
#-----------------------------------------------------------------------------------------------------------
get_list_of_arguments = ( P ) ->
  return P[ 0 ] if P.length == 1 and TYPES.isa_list P[ 0 ]
  return P


############################################################################################################
module.exports = MULTIMIX.compose base, @






