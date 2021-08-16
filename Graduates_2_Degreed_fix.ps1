<#Adding Domain Users group. Setting Domain Users as primary. Adding Degreed group. Removing Students-related groups#>
$Graduates = Get-Content "C:\Users\kenny.forrest\Desktop\rem_students.txt"
<#Text list from csv export#>
$group = get-adgroup "Domain Users" -properties @("primaryGroupToken")
<#Getting token from specific group.#>
foreach ($Grad in $Graduates) {
Add-ADGroupMember -Identity "Domain Users" -Members $Grad -Confirm:$false
get-aduser $Grad | set-aduser -replace @{primaryGroupID=$group.primaryGroupToken}
Add-ADGroupMember -Identity "DEGREED" -Members $Grad -Confirm:$false
Remove-ADGroupMember -Identity "Students" -Members $Grad -Confirm:$false
Remove-ADGroupMember -Identity "Students Primary Group" -Members $Grad -Confirm:$false
}
