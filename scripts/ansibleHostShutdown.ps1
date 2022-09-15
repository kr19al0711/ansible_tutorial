#This PowerShell script stops all running VMs registered in VirtualBox and added to AnsibleHosts group

clear

$groupName = "/AnsibleHosts"

$runningVMs = vboxmanage list runningvms

echo "Listing all running VMs"
echo ""
vboxmanage list runningvms
echo ""

echo "Stopping all VMs from group $($groupName.Substring(1,$groupName.Length-1))"

foreach($vm in $runningVMs){

    $vm = $vm.Split(" ")[0]
    $vmGroup = ((vboxmanage showvminfo --machinereadable "$vm" ) | Select-String -Pattern $groupName).Matches.Value
    
    if( $vmGroup -like $groupName){
        echo "Stopping $vm"
        vboxmanage controlvm $vm poweroff
    }
}
