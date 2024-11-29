#PowerShell:

function verificaMaior ($num1,$num2) {

    if ($num1 -gt $num2) {
        write-host ("1 - Maior Número"+ $num1)
    }else {
        write-host ("2 - Maior Número"+ $num2)
    }
    
}
verificaMaior 2 4
#verificaMaior 3 1