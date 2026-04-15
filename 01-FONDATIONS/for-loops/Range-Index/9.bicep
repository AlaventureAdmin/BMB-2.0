param values array = [10,20,30]

//modulo operator % returns the remainder of a division operation. 
output evenindex array = [
  for (v, i) in values: (i % 2 == 0) ? v : null   // Output will be [10, null, 30]
]


/*
Name             Type                       Value
===============  =========================  ==========
evenindex        Array                      [10,30]
*/
