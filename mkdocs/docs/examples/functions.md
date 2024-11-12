---
title: The functions
description: The basic functions, just as you use them
author: Stephen Taylor
---
# The functions

The functions calculate various simple descriptive statistics. 

Most of these have obvious definitions for vector arguments, but have been coded here to work also on matrices along their *leading* axes.
That is, the mean of a matrix is calculated as the means of its columns.

```apl
 srt←{1=≢⍴⍵:⍵[⍋⍵] ⋄ ⍉(∇⍤1)⍉⍵ }      ⍝ ascending sort
 mean←{(+⌿⍵)÷≢⍵}                    ⍝ arithmetic mean
 med←{                              ⍝ median
     srtd←srt ⍵
     ×1|hlf←(≢⍵)÷2:(⌈hlf)⌷srtd
     ⊃2÷⍨+/(hlf+0 1)⌷¨⊂srtd
 }
 mode←{                             ⍝ sample mode
     1=≢⍴⍵:{⍺/⍨⍵=⌈/⍵}/⊂[1]{⍺,≢⍵}⌸⍵
     ∇¨⊂[1]⍵
 }
 sd←{0.5*⍨var ⍵}                    ⍝ popn std deviation
 var←{mean 2*⍨ ⍵(-⍤1)mean ⍵}        ⍝ variance
```

There is also a file of tests

result|expn
------|----
`V[⍋V]`|`srt V`
`⍉↑srt¨⊂[1]M`|`srt M`
`5.75`|`mean V`
`7.25 8.25 4 5.75 3.5`|`mean M`
`7`|`med V`
`med¨⊂[1]M`|`med M`
`⊂,7`|`mode V`
`mode¨⊂[1]M`|`mode M`
`4`|`var 2 4 4 4 5 5 7 9 ⍝ wikipedia`
`2`|`sd 2 4 4 4 5 5 7 9 ⍝ wikipedia`
`sd¨⊂[1]M`|`sd M`
`var¨⊂[1]M`|`var M`

and a function to run them.

```apl
∇ rpt←{codes}RunTests path;exec;M;S;tst;tsts;V
 ⍝  e.g. RunTests 'core/tests.csv'
 V←7 10 3 8 4 7 6 10 7 2 8 9 2 1 3 7 8 1 7 5
 M←4 5⍴V

 ⍝ 0 1 2 <=> passed, failed, broke
 exec←{0::2 ⍺ ⍵ ⋄ z r←⍎¨⍺ ⍵ ⋄ (z≢r)(⍺)(⍵)}

 tsts←⊃⎕CSV path''⍬ 1
 rpt←0 3⍴0 '' ''
 :For tst :In ↓tsts
     rpt⍪←⊃exec/tst
 :EndFor

 :If 2=⎕NC'codes'
     rpt←rpt⌿⍨rpt[;1]∊codes
 :EndIf
∇
```