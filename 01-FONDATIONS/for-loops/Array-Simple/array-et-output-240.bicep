param vms array = [

'vm1|B2s'
'vm2|B2ms'
]

/*
This Bicep expression splits the string variable vm 
into an array using the pipe character (`|`) as 
the delimiter. The split function divides the original 
string wherever it finds the delimiter, resulting 
in an array of substrings.

The `[0]` index accesses the first element of the resulting
 array (since arrays in Bicep are zero-based). 
 For example, if vm is `'vm1|B2s'`, then split(vm, '|') 
 produces `['vm1', 'B2s']`, and split(vm, '|')[0] returns `'vm1'`.

This approach is useful when you want to extract 
the first part of a structured string, such as 
retrieving a virtual machine name from a string 
that combines the name and size separated by a delimiter.
 If the delimiter is missing, the entire string 
 will be returned as the first element.

*/

output result1 array = [
for vm in vms:split(vm,'|')[0]
]

output result2 array = [
for vm in vms: {
VmName: split(vm,'|')[0]
}
]

output result3 array = [
for vm in vms:split(vm,'|')[1]
]

output result4 array = [
for vm in vms: {
VmSize: split(vm,'|')[1]
}
]

/*

Outputs                 :
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      ["vm1","vm2"]
  result2          Array                      [{"VmName":"vm1"},{"VmName":"vm2"}]
  result3          Array                      ["B2s","B2ms"]
  result4          Array                      [{"VmSize":"B2s"},{"VmSize":"B2ms"}]
*/
