$linesNumber = 0
$filePath = 'C:\Working Documentation\recalculate.txt'
$numberOfIterations = [Math]::Ceiling((Get-Content -Path $filePath).Length/400)

for($i=1; $i -le $numberOfIterations; $i++){

# Read the first 400 lines from the beggining of file
[string[]]$barcodeSet = Get-Content -Path $filePath | select -first 400 -skip $linesNumber
$linesNumber=$linesNumber+400

# Prepare the request body
[string]$body = "["
foreach($barcode in $barcodeSet){
    $body = $body + '"' + $barcode + '"' + ","
}
    $body = $body.Substring(0,$body.Length-1)
    $body = $body + "]"


# Make a recalculation API request
try {

    $req = Invoke-RestMethod -Method PUT -Uri http://10.255.102.215:8080/UkrPostAPI/shipments/recalculation/barcode?token=debf2025-78c6-42ea-b120-21dce332ac15 -Body ($body)
    $req   
}
catch {
    throw "Unnable to recalculate the provided barcode list"
}
}
