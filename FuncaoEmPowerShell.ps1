function calculo {
    param(
        [int]$valor1,
        [int]$valor2 
    )
    process {    
        $soma = $valor1+$valor2
        return $soma
        Write-Output $soma
    }
}
calculo 1 2