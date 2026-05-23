param items array = [
  'a'
  'b'
  'c' 
]

  output result1 array = [
  for (item, i) in items:'${i}-${item}'
  ]



output result2 array = [
  for (item, i) in items:  {
    name:  '${i}-${item}'
  }
]


/*

Outputs                 :
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      ["0-a","1-b","2-c"]
  result2          Array                      [{"name":"0-a"},{"name":"1-b"},{"name":"2-c"}]
*/
