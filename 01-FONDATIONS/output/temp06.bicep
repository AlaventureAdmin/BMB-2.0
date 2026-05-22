param items array = [
  'a'
  'b'
  'c' 
]

  output result array = [
  for (item, i) in items:{
    name:  '${i}-${item}'
  }
  ]


/*
output result array = [
  for (item, i) in items:  {
    name:  '${i}-${item}'
  }
]
  */


