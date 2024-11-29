Write-Output Providing SonarQube Analysis

$Env:BROWSERSLIST_IGNORE_OLD_DATA = "true"

[String] $ProjectKey = "$(ProjectKey)"
$versaoProjeto = $(versaoProjeto)
$versaoDotNetCore = $(versaoDotNetCore)
$path2 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-2\"
$path3 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-3\"
$path5 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-5\"
$path51 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-51\"

if( $versaoDotNetCore -match "2"){
Write-Output  versão 2
cd $path2
dotnet "$path2\SonarScanner.MSBuild.dll" begin /k:$ProjectKey /n:$ProjectName /v:$versaoProjeto /d:sonar.login="admin"

}
elseif ( $versaoDotNetCore -match "3"){
Write-Output  versão 3
cd $path3
dotnet "$path3\SonarScanner.MSBuild.dll" begin /k:$ProjectKey /n:$ProjectName /v:$versaoProjeto /d:sonar.login="admin"

}
elseif ( $versaoDotNetCore -match "5"){
Write-Output  versão 5
cd $path5
dotnet "$path5\SonarScanner.MSBuild.dll" begin /k:$ProjectKey /n:$ProjectName /v:$versaoProjeto /d:sonar.login="admin"

}
elseif ( $versaoDotNetCore -match "6"){

cd $path51
pwd
Write-Output  versão 5.3-SonarScanner
dotnet "$path51\SonarScanner.MSBuild.dll" begin /k:$ProjectKey /n:$ProjectName /v:$versaoProjeto /d:sonar.login="admin" /d:sonar.cs.opencover.reportsPaths=$(Agent.TempDirectory)\**\coverage.opencover.xml
}


Write-Output Sonar Scanner Build Solutions 

$path2 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-2\"
$path3 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-3\"
$path5 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-5\"
$path51 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-51\"

$versaoDotNetCore = $(versaoDotNetCore)
[String] $filePathSolution = "$(filePathSolution)"

if( $versaoDotNetCore -match "2") {

    cd $path2
    dotnet build $(Build.SourcesDirectory)\$filePathSolution
    
    } elseif ( $versaoDotNetCore -match "3") {
    
    cd $path3
    dotnet build $(Build.SourcesDirectory)\$filePathSolution
    
   }elseif ( $versaoDotNetCore -match "5") {
    
    cd $path5
    dotnet build $(Build.SourcesDirectory)\$filePathSolution

   }elseif ( $versaoDotNetCore -match "6") {
    Write-Output  versão 5.3-SonarScanner
    cd $path51
    dotnet build $(Build.SourcesDirectory)\$filePathSolution
}

Write-Output Publishing SonarQube Analysis


$Env:BROWSERSLIST_IGNORE_OLD_DATA = "true"

$password = '<env-password-aqui->'

$versaoDotNetCore = $(versaoDotNetCore)
$path2 = 'c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-2\'
$path3 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-3\"
$path5 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-5\"
$path6 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-51\"

if( $versaoDotNetCore -match "2") {
   pwd
    
    cd $path2
    Write-Output Você está usando a versão 2.0
    dotnet sonarscanner end /d:sonar.login="<env-user-admin->" /d:sonar.password=$password
    pwd
    
} elseif ( $versaoDotNetCore -match "3") {
   pwd
    
    cd $path3
    Write-Output Você está usando a versão 3.0
    dotnet sonarscanner end /d:sonar.login="<env-user-admin->" /d:sonar.password=$password
    pwd

} elseif ( $versaoDotNetCore -match "5") {
   pwd
    
    cd $path5
    Write-Output Você está usando a versão 5.0
    dotnet sonarscanner end /d:sonar.login="<env-user-admin->" /d:sonar.password=$password
    pwd
	
	
} elseif ( $versaoDotNetCore -match "6") {
    pwd
    
    cd $path6
    Write-Output  versão 5.3-SonarScanner
    dotnet sonarscanner end /d:sonar.login="<env-user-admin->" /d:sonar.password=$password
    pwd
}


