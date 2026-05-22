param envs array = [
  'dev'
  'test'
  'prod'  
]

output result array = [
for e in envs : e=='dev' ? e : '' // Output will be ["", "", "prod"]

]
