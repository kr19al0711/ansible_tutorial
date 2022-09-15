#This PowerShell script starts VMs registered in VirtualBox added in AnsibleHosts group

clear

$groupName = "/AnsibleHosts"

$vms = vboxmanage list vms

echo "Listing all Virtual Machines created in VirtualBox:"
echo ""

vboxmanage list vms

echo ""
echo "Starting VMs from group $($groupName.Substring(1,$groupName.Length-1))"

foreach($vm in $vms){

    $vm = $vm.Split(" ")[0]
    $vmGroup = ((vboxmanage showvminfo --machinereadable "$vm" ) | Select-String -Pattern $groupName).Matches.Value
    
    if( $vmGroup -like $groupName){
        echo "Starting $vm"
        vboxmanage startvm $vm
    }
}
