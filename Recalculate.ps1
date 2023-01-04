$linesNumber = 0

# Read the first 400 lines from the end of file
$linesNumber=$linesNumber+400
[string[]]$barcodeSet = Get-Content -Path 'C:\Working Documentation\recalculate.txt' -Tail $linesNumber

# Prepare the request body
[string]$body = "["
foreach($barcode in $barcodeSet){
    $body = $body + '"' + $barcode + '"' + ","
}
    $body = $body.Substring(0,$body.Length-1)
    $body = $body + "]"
    $body

    # Make a recalculation API request

try {

    $r = Invoke-RestMethod -Method PUT -Uri http://10.255.102.215:8080/UkrPostAPI/shipments/recalculation/barcode?token=debf2025-78c6-42ea-b120-21dce332ac15 -Body ($body)
    $r   
}
catch {
    throw "Unnable to recalculate the provided barcode list"
}