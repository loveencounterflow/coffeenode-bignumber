

# CoffeeNode BIGNUMBER

## Rationale

As is well known, **JavaScript has only a single numerical datatype**, an [implementation of the IEEE 754
standard](https://en.wikipedia.org/wiki/IEEE_754#Basic_formats). This means that JavaScript represents all
numerical values as 64-bit floating point values, with the consequence that the largest exact integral
value is 2<sup>53</sup> (ie, 9'007'199'254'740'992). Also, since all values are stored in base 2, even
many of those rational numbers `p/q` that do take on a finite form in a decimal representation are only
approximately expressible in base 2—which leads to the now-famous violation of the assumption that
`0.1 + 0.1 + 0.1` should equal `0.3`. Note that practically all modern languages running on contemporary hardware
suffer from these and similar defects; basically, it is a trade-off where efficiency in storage and performance
have to be balanced with numerical correctness.

**There are several possible solutions** to the problem of how to do calculations with very big integers and
precise decimal fractions: for example, NodeJS's `process.hrtime` returns a tuple `[ s, ns, ]` where `s`
represents the full seconds and `ns` the nanoseconds that have elapsed since some epoch in the past.
Separating the two parts means each part can be represented as a JavaScript integer without becoming too
big, but  it also means that adding and subtracting such time values becomes a chore as you have to take
over- and underflows in the nanoseconds part into account. Even doing something as mundane as storing a
numerically stable price in some online shop software is difficult—of course you can represent prices in
the smallest unit of the currency in question and remain sure that all additions and subtractions will
then be exact, but the difficulties start when you want to do things like adding 19.5% tax or include a
33% percent rebate: all of a sudden, your implementation has not only to be reasonable, but also to comply
with relevant laws.

Within current (2013) JavaScript VMs, there is little doubt that **nothing but a dedicated library** for
numerically correct big integers and long decimal fractions can be called a scalable, reliable, and
manageable solution for the outlined applications. In order to be scalable, such a library should be
reasonably fast; in order to be reliable, it should have been in widespread use for a number of years, and
in order to be manageable, it should have a 'nice' API. Also, it would be good if the library didn't rely
on some C code to get compiled, for that excludes usage within the browser and provides for an additional
point of failure (on unusual hardware, or with bleeding-edge NodeJS distros. That said, an *optional* compilation step
to make use of speed advantages not within reach of a JavaScript VM would of course be fine).

Turns out **it is not easy to find a BigNumber / BigDecimal / BigInteger library** which satisfies all of the
above criteria. It has also become quite obvious to me that no matter what the 'best' library for the
problem at hand is today, the 'even better' or 'less bad' library is just waiting for tomorrow to come.
Sadly, the APIs of many of the promising solutions as are available today tend to be quite awful, being inherited
from their ancestors who originated in the highly convoluted ecosystem that is Java. So i concluded it would
be best to make a 'shim'—basically, a standardized API that fits well into the CoffeeNode way of thinking
and that is potentially amenable for using a number of different underlying libraries to do the number-crunching.


## Underlying 3<sup>rd</sup> Party Library

I will not here go into detail what my experiences with many BigDecimal libraries have been so far—it would
be too unsystematic, to anecdotal, and probably unfair to some. The library i've settled on for the time being
is https://github.com/dtrebbien/BigDecimal.js, for the simple reason that it seemed to work. It is a
corrected, human-readable, 100% JavaScript translation of the Great BigDecimal Ancestor which has been part of
Java distros for years. The source is included under `other-modules/BigDecimal.js`—quite a few files, of which
only `build/BigDecimal-all-last.min.js` and `build/BigDecimal-all-last.js` are essential.

The [**License**](http://source.icu-project.org/repos/icu/icu4j/tags/milestone-52-0-1/main/shared/licenses/license.html)
is online for you to read; it would appear to allow commercial usage.

## API


### Object Creation

#### `new = ( x ) ->`

Given a value `x`, return a new `BIGNUMBER/decimal` object. This is little more than an object with a
type indicator and a `%self` member holding the result of doing `new BigDecimal x`. At this point in time,
`x` should be a string spelling out an integer or factional number in decimal; in the future, more kinds of
values and / or options may become available, pending research on what is essential, desirable, and
widely expected & supported.

### Elementary Arithmetics

#### `add      = ( me, you ) ->`
#### `subtract = ( me, you ) ->`
#### `multiply = ( me, you ) ->`
#### `divide   = ( me, you ) ->`

### Comparison

#### `equals = ( me, you ) ->`
#### `compare = ( me, you ) ->`

### Aggregate Functions

#### `sum = ( P... ) ->`
#### `average_of = ( P... ) ->`

Return the result of summing up several `BIGNUMBER/decimal` values which may be given as direct arguments or
as list elements.

### Serialization

#### `rpr = ( me ) ->`


## Further Reading

* http://stackoverflow.com/a/13541939/256361
* http://stackoverflow.com/questions/744099/is-there-a-good-javascript-bigdecimal-library
* http://stackoverflow.com/questions/2622144/is-there-a-decimal-math-library-for-javascript
* https://github.com/MikeMcl/big.js/
* https://github.com/iriscouch/bigdecimal.js
* http://docs.python.org/2/tutorial/floatingpoint.html#tut-fp-issues
