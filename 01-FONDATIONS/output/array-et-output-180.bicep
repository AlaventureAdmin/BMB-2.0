param vnets array = [

  'vnet1'
  'vnet2' 

]

output result1 array = [
for vnet in vnets: vnet
]

output result2 array = [
for vnet in vnets: {
  VnetName: vnet
}
]

/*

Outputs                 :
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      ["vnet1","vnet2"]
  result2          Array                      [{"VnetName":"vnet1"},{"VnetName":"vnet2"}]
*/
