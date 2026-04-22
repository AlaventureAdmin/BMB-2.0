//Array
var apps = [
  { name: 'app1', env: 'dev' }
  { name: 'app2', env: 'prod' }
  { name: 'app3', env: 'dev' }
]

// Output filtré
output devApps array = [
for app in filter(apps, a => a.env == 'dev'): app.name
]


/*Résultat
[
  "app1",
  "app3"
]
🧠 Le if agit comme un filtre
*/
