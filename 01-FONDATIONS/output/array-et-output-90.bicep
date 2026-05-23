param users array = ['alain', 'bob', 'charlie']

output result array = [
  for (u, i) in users: { // Loop through the users array, with u as the current user and i as the index
    name: u
    id: i 
    
  } 
] 

/*

Outputs                 : 
Name             Type                       Value
===============  =========================  ==========
result           Array
[{"name":"alain","id":0},{"name":"bob","id":1},{"name":"charlie","id":2}]
*/
