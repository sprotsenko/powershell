$lines = 30

[string[]]$A = Get-Content -Path 'C:\Working Documentation\recalculate.txt' -Tail $lines

[string]$body = "["

foreach($barcode in $A){
    $body = $body + '"' + $barcode + '"' + ","
}
$body = $body.Substring(0,$body.Length-1)
$body = $body + "]"
$body


try {

foreach($barcode in $A){
    $r = Invoke-RestMethod -Method PUT -Uri http://10.255.102.215:8080/UkrPostAPI/shipments/recalculation/barcode?token=debf2025-78c6-42ea-b120-21dce332ac15 -Body ($body)
    $r
}
Write-Output "FINISH"     

}

catch {
    throw "Unnable to recalculate the provided barcode"
}