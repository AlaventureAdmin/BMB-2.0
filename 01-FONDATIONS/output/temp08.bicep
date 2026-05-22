param subs array = [

  's1'
  's2'
  ]

/*
  output result array = [
    for (s,i) in subs:'sub${i}=${s}'
    
  ]
*/

  output result array = [
    for (s,i) in subs:{
      
      subnetName:'sub${i}=${s}'
  }
  ]
