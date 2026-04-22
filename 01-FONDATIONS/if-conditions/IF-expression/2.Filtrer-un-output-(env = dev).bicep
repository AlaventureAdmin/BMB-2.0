var apps = [
  { name: 'app1', env: 'prodv' }
  { name: 'app2', env: 'dev' }
  { name: 'app3', env: 'test' }
]
//Output filtré
output devApps array = [
for app in filter(apps, a => a.env == 'dev'): app.name
]

/*
Name             Type                       Value
 ===============  =========================  ==========
devApps          Array                      ["app1","app3"]


var apps = [
  { name: 'app1', env: 'prodv' }
  { name: 'app2', env: 'dev' }
  { name: 'app3', env: 'test' }
]
//Output filtré

output devApps array = [
for app in filter(apps, a => a.env == 'dev'): app.name
]

 Name             Type                       Value
 ===============  =========================  ==========
 devApps          Array                      ["app2"]

*/
