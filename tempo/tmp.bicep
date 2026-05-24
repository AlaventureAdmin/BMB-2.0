var serveurs = [
{nom: 'web01'
cpu: 2
ram: 8
}

{nom: 'web02'
cpu: 4
ram: 16
}
]


var cpu2 = serveurs[1].cpu
var ram2 = serveurs[1].ram

output result1 string = 'cpu2'
output result2 string = 'ram2'

output premierNom string = serveurs[0].nom
output deuxiemeNom string = serveurs[1].nom
