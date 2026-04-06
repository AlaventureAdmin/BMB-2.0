param envs array = [
  'dev'
  'test'
  'prod'
]

output prodonly array = [
  for e in envs: e == 'prod' ? e : '' // Output will be ["", "", "prod"]
]

/*
Name             Type                       Value
===============  =========================  ==========
prodonly         Array                      ["","","prod"]
*/
