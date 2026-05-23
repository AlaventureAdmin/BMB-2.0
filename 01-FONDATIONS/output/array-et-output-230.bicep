param subs array = [

  's1'
  's2'
  ]


  output result1 array = [
    for (s,i) in subs:'sub${i}=${s}'
  ]

  output result2 array = [
    for (s,i) in subs:{
      subnetName:'sub${i}=${s}'
  }
  ]

  /*
  Outputs                 :
  Name             Type                       Value
  ===============  =========================  ==========
    result1          Array                      ["sub0=s1","sub1=s2"]
    result2          Array                      [{"subnetName":"sub0=s1"},{"subnetName":"sub1=s2"}]
  */
