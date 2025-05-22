# Province data
$myProvURI= "https://api.covid19tracker.ca/provinces"
$provdata= Invoke-RestMethod -uri $myProvURI
$provdata | Export-Csv -Path "C:\Users\elain\OneDrive\Documents\NSCC\Term_3\DBAS3019\repo\Project\rawData\Provinces.csv" -NoTypeInformation

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
        $dataWithProv | Export-Csv -Path "C:\Users\elain\OneDrive\Documents\NSCC\Term_3\DBAS3019\repo\Project\rawData\CovidDataAll.csv" -Append -NoTypeInformation
    }
}
