





############################################################################################################
TEXT                      = require 'coffeenode-text'
TYPES                     = require 'coffeenode-types'
#...........................................................................................................
### https://github.com/dtrebbien/BigDecimal.js ###
BD                        = require '../other-modules/BigDecimal.js/build/BigDecimal-all-last.js'


#===========================================================================================================
# CREATION & TYPE CHECKING
#-----------------------------------------------------------------------------------------------------------
@new = ( x ) ->
  if @_isa_BigDecimal x
    substrate = x
  else switch type = TYPES.type_of x
    when 'text'
      substrate = new BD.BigDecimal x
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
  return x instanceof BD.BigDecimal

#-----------------------------------------------------------------------------------------------------------
@_zero  = @new BD.BigDecimal.ZERO
@_one   = @new BD.BigDecimal.ONE


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
  R = @_zero[ '%self' ]
  #.........................................................................................................
  for x in P
    if TYPES.isa_list x then  R = R.add @_sum x
    else                      R = R.add x[ '%self' ]
  #.........................................................................................................
  return @new R

#-----------------------------------------------------------------------------------------------------------
@_sum = ( numbers ) ->
  ### Expects a list of `BIGNUMBER/decimal` values, returns an instance of the underlying substrate class.
  Sums up while avoiding to create superfluous object wrappers. ###
  return @_zero[ '%self' ] if numbers.length is 0
  R = numbers[ 0 ][ '%self' ]
  R = R.add numbers[ idx ][ '%self' ] for idx in [ 1 ... numbers.length ]
  #.........................................................................................................
  return R

#-----------------------------------------------------------------------------------------------------------
@average_of = ( P... ) ->
  return @new ( @sum P... )[ '%self' ].divide new BD.BigDecimal ( @_count_numbers P ).toString()

#-----------------------------------------------------------------------------------------------------------
@_count_numbers = ( values, level = 0 ) ->
  R = 0
  #.........................................................................................................
  for x in values
    type = TYPES.type_of x
    if type is 'BIGNUMBER/decimal'
      R += 1
    else if type is 'list'
      throw new Error "detected illegal nested list" unless level is 0
      R += @_count_numbers x, level + 1
    else
      throw new Error "encountered incompatible type #{rpr type}"
  #.........................................................................................................
  return R

#===========================================================================================================
# SERIALIZATION
#-----------------------------------------------------------------------------------------------------------
@rpr = ( me ) ->
  return me[ '%self' ].toString()


