# Province data
$myProvURI= "https://api.covid19tracker.ca/provinces"
$provdata= Invoke-RestMethod -uri $myProvURI
$provdata | Export-Csv -Path "C:\Users\elain\OneDrive\Documents\NSCC\Term_3\DBAS3019\repo\Project\rawData\Provinces.csv" -NoTypeInformation