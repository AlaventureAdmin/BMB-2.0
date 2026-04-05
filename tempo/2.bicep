param names array = [
  'vm1'
  'vm2'
]

output uppernames array = [
  for name in names: toUpper(name)
]

/*
Name             Type                       Value
===============  =========================  ==========
uppernames       Array                      ["VM1","VM2"]
*/
