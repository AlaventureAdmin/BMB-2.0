param servers array = [
  'web'
  'sql'
]

/*
output result array = [
for s in servers: '${s}-srv'
]
  */

output result array = [
  for s in servers: {
    name: '${s}-srv'
  }
]
