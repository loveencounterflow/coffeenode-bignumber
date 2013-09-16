

### This module defines the API for CoffeeNode BIGNUMBER. End-user faced submodules should (1) use this
implementation module as root object for their mixin; (2) override the public members with actual
implementations; (3) use private methods or local functions to define helpers and the like.


############################################################################################################
bye = -> throw new Error "method not implemented"


#===========================================================================================================
# CREATION & TYPE CHECKING
#-----------------------------------------------------------------------------------------------------------
@new = ( x ) -> bye()


#===========================================================================================================
# ELEMENTARY ARITHMETICS
#-----------------------------------------------------------------------------------------------------------
@add      = ( me, you ) -> bye()
@subtract = ( me, you ) -> bye()
@multiply = ( me, you ) -> bye()
@divide   = ( me, you ) -> bye()


#===========================================================================================================
# COMPARISON
#-----------------------------------------------------------------------------------------------------------
@equals   = ( me, you ) -> bye()
@compare  = ( me, you ) -> bye()


#===========================================================================================================
# AGGREGATE FUNCTIONS
#-----------------------------------------------------------------------------------------------------------
@sum        = ( P... ) -> bye()
@average_of = ( P... ) -> bye()


#===========================================================================================================
# SERIALIZATION
#-----------------------------------------------------------------------------------------------------------
@rpr = ( me ) ->
  ### This is the only method whose implementation is likely shareable across various bignumber libraries,
  so we provide some code here. ###
  return me[ '%self' ].toString()


