param rgNames array = [
  'rg01'
  'rg02'
  'rg03'
]

/*

ou bien 

param rgNames array = ['rg01', 'rg02', rg03']
*/

output result array = [
  for (rg, i) in rgNames: {
    name: rg
    index: i
  }
]

/*
Name             Type                       Value
===============  =========================  ==========
result           Array                      [{"name":"rg01","index":0},{"name":"rg02","index":1},{"name":"rg03","index":2}]
*/
