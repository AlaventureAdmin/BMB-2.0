


param names array =[
'vm1'
'vm2'

]

output uppername array = [
  for name in names : toUpper(name)
]
