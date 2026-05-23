param vms array = [
  {
    name: 'vm1'
    size: 'Bs2'
  }
  {
    name: 'vm2'
    size: 'B2ms'
  }
]


output size array = [
  for vm in vms: vm.name 
  ]


  /*
Name             Type                       Value
===============  =========================  ==========
size             Array                      ["vm1","vm2"]
  
  */
