param vms array = [
  'vm'
  'vm'
]


output result array = [
  for (vm,i) in vms :'${vm}${i+1}' 
]


/*
output result array = [
  for (vm,i) in vms : {
    VmName :'${vm}${i+1}' 
  }
]   
*/
