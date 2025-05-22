
# Province data
$myProvURI= "https://api.covid19tracker.ca/provinces"
$provdata= Invoke-RestMethod -uri $myProvURI
$provdata | Export-Csv -Path "C:\Users\W0038182\OneDrive - Nova Scotia Community College\Classes\Fall2024\BusinessDataModelling\Assignments\Assignment3\Provinces.csv" -NoTypeInformation
  

# One Datafile
foreach ($p in $provdata) {
    if ($p.id -le 13) {
        $prov = $p.code
        $data = Invoke-RestMethod -uri "https://api.covid19tracker.ca/reports/province/$prov"   

        # Create a new object for each entry to include the province code
        $dataWithProv = $data.data | ForEach-Object {
            $_ | Add-Member -NotePropertyName "ProvinceCode" -NotePropertyValue $prov -PassThru
        }

        # Export the modified data to CSV
        $dataWithProv | Export-Csv -Path "C:\Users\W0038182\OneDrive - Nova Scotia Community College\Classes\Fall2024\BusinessDataModelling\Assignments\Assignment3\CovidDataAll.csv" -Append -NoTypeInformation
    }
}



# Seperate Provs
foreach($p in $provdata)
{
    if( $p.id -le 13)
    {
        $prov=$p.code
        $data= Invoke-RestMethod -uri "https://api.covid19tracker.ca/reports/province/$prov"   
        $data.data| export-csv -path "C:\Users\W0038182\OneDrive - Nova Scotia Community College\Classes\Fall2024\BusinessDataModelling\Assignments\Assignment3\$prov.csv" -NoTypeInformation
    }

}
