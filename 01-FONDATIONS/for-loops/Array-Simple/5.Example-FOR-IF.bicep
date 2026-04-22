param envs array = [
  'dev'
  'test'
  'prod'
]

output prodonly array = [
  for e in envs: e == 'test' ? e : '' // Output will be ["", "", "prod"]
]
/*
?condition ? TrueValue : FalseValue
C'est comme IF `condition` THEN `TrueValue` ELSE `FalseValue`
e = test 
if e = e donc c'est vrai 

Name             Type                       Value
===============  =========================  ==========
prodonly         Array                      ["","Test",""]
*/
