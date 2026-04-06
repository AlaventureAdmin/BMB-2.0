param servers array = ['app', 'sql']

output name array = [
  for s in servers: '${s}-SRV'
]

/*
Name             Type                       Value
===============  =========================  ==========
  name             Array                      ["app-SRV","sql-SRV"]
*/
