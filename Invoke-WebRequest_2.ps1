﻿$response = Invoke-WebRequest -URI https://www.bing.com/search?q=how+many+feet+in+a+mile

$response.InputFields | Where-Object {
    $_.name -like "* Value*"
} | Select-Object Name, Value