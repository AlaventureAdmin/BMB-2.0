param values array = [10,20,30]

output evenindex array = [
  for (v, i) in values: (i % 2 == 0) ? v : null
]

/*
Name             Type                       Value
===============  =========================  ==========
evenindex        Array                      [10,30]
*/
