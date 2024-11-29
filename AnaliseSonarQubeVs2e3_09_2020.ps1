# -- 1º Script Task
[String] $ProjectKey = "$(ProjectKey)"
$versaoProjeto = $(versaoProjeto)
$versaoDotNetCore = $(versaoDotNetCore)
$userSonar = $(userSonar)
$path2 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-2\"
$path3 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-3\"

    if( $versaoDotNetCore -match "2"){

            cd $path2
            dotnet "$path2\SonarScanner.MSBuild.dll" begin /k:$ProjectKey /n:$ProjectName /v:$versaoProjeto /d:sonar.login=$(userSonar)

    } elseif ( $versaoDotNetCore -match "3"){

            cd $path3
            dotnet "$path3\SonarScanner.MSBuild.dll" begin /k:$ProjectKey /n:$ProjectName /v:$versaoProjeto /d:sonar.login=$(userSonar)
    }

# -- 2º Script Task
    [String] $filePathSolution = "$(filePathSolution)"

    $versaoDotNetCore = $(versaoDotNetCore)
    if( $versaoDotNetCore -match "2") {

    cd $path2
    dotnet build $(Build.SourcesDirectory)\$filePathSolution
    
    } elseif ( $versaoDotNetCore -match "3") {
    
    cd $path3
    dotnet build $(Build.SourcesDirectory)\$filePathSolution
    
    }

# -- 3º Script Task

    $versaoDotNetCore = $(versaoDotNetCore)
    $path2 = c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-2\
    $path3 = "c:\sonarqube\sonarqube-8.0\bin\sonar-scanner-msbuild-3\"


    if( $versaoDotNetCore -match "2") {

    cd $path2
    dotnet sonarscanner end /d:sonar.login="<env-user-aqui>" /d:sonar.password='<env-password-aqui>'
    dotnet sonarscanner end /d:sonar.login="<env-user-aqui>" /d:sonar.password="<env-password-aqui>"
    
    } elseif ( $versaoDotNetCore -match "3") {
    
    cd $path3
    dotnet sonarscanner end /d:sonar.login="<env-user-aqui>" /d:sonar.password="<env-password-aqui>"
    dotnet sonarscanner end /d:sonar.login="<env-user-aqui>" /d:sonar.password="<env-password-aqui>"
    
    }