---
title: Domain-specific language
description: Present a collection of functions as a domain-specific language
author: Stephen Taylor
---
# Domain-specific language

A [domain-specific language](https://en.wikipedia.org/wiki/Domain-specific_language "Wikipedia") extends a programming language with functions that deal with topics in your subject domain. 
Effectively a DSL is a [text-based user interface](https://en.wikipedia.org/wiki/Domain-specific_language "Wikipedia") to your code.

Here we consider an _embedded_ DSL, which is to say the DSL consists of functions that you use in an APL session.

An embedded DSL differs from a package: its functions do not suspend if they encounter errors, but provide messages that help the user, who might not be a programmer.

=== "package"

	```apl
	      mean 'abc'
	DOMAIN ERROR
	mean[0] mean←{(+⌿⍵)÷≢⍵}     ⍝ arithmetic mean
	               ∧
    ```

=== "DSL"

	```apl
	      mean 'abc'
	DOMAIN ERROR: numeric arguments only
	      mean 'abc'
	      ∧
	```

## Validate inputs

==FIXME Much of this discussion should probably move to an article on validation.==

You have two ways to validate the input in the DSL:

Prospective
: Test it before it passes to the core function for evaluation. This is safest: the core function evaluates only what it is designed to evaluate, and does not have to handle any error conditions.

Retrospective
: Analyse it only if an error is encountered. This is more efficient: tests are performed only if a problem occurs. Users pass valid arguments most of the time, so this saves unnecessary work. 

	You should *not* use retrospective analysis if the function has a side effect, as it might have been effected before the error was encountered and evaluation aborted. (It might also be *in*efficient if significant work gets done before the error.)

	Retrospective analysis also relies on the core function to break on an invalid argument, which it might not do. For example `#.core.mean` evaluates (correctly) on a 3-dimensional numeric array, even though the argument is ‘out of scope’ of the DSL.

The definition of `mean` in the DSL uses both prospective and retrospective validation.

```apl
 Z←mean arg;e;m
 :If arg≡⍬
     Z←0
 :ElseIf 2<≢⍴arg ⍝ treat as error
     ⎕SIGNAL 4
 :Else
     :Trap 0
         Z←#.core.mean arg
     :Else
         e m←valid8_ arg
         m ⎕SIGNAL e
     :EndTrap
 :EndIf
```

The first test catches empty vectors. The core function returns 1 as the mean of an empty list.
Strictly, this is correct: the sum of the numbers divided by the number of numbers: `0÷0` is 1. 
But the DSL follows most people’s intuition: that the average of no numbers is zero.

The second test is for rank higher than 2.
The core function actually evaluates a higher-rank argument correctly; it’s just out of the DSL’s scope. 

The trap catches any error in the evaluation of `#.core.mean` and invokes `valid8_` to signal what is wrong with the argument. 


## Testing validation

The simple error testing we used when writing the core functions would report evaluation errors as code 2 – broke. 
But we now need a way to test that certain errors are signalled *correctly*; that is, specify when we expect an error to be signalled, and which one.

