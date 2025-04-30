# Lista de programas com categorias e fonte opcional
$programs = @(
    [PSCustomObject]@{ ID = "Microsoft.VisualStudioCode"; Name = "Visual Studio Code"; Categoria = "Desenvolvimento" },
    [PSCustomObject]@{ ID = "Oracle.MySQLWorkbench"; Name = "MySQL Workbench"; Categoria = "Desenvolvimento" },
    [PSCustomObject]@{ ID = "7zip.7zip"; Name = "7-Zip"; Categoria = "Utilitários" },
    [PSCustomObject]@{ ID = "NGWIN.PicPick"; Name = "PicPick"; Categoria = "Utilitários" },
    [PSCustomObject]@{ ID = "RARLab.WinRAR"; Name = "WinRAR"; Categoria = "Utilitários" },
    [PSCustomObject]@{ ID = "AnyDesk.AnyDesk"; Name = "AnyDesk"; Categoria = "Utilitários" },
    [PSCustomObject]@{ ID = "Google.Chrome"; Name = "Google Chrome"; Categoria = "Navegadores" },
    [PSCustomObject]@{ ID = "Opera.Opera"; Name = "Opera"; Categoria = "Navegadores" },
    [PSCustomObject]@{ ID = "Sinew.Enpass"; Name = "Enpass"; Categoria = "Segurança" },
    [PSCustomObject]@{ ID = "VideoLAN.VLC"; Name = "VLC Media Player"; Categoria = "Entretenimento" },
    [PSCustomObject]@{ ID = "Valve.Steam"; Name = "Steam"; Categoria = "Entretenimento" },
    [PSCustomObject]@{ ID = "Microsoft.Office"; Name = "Office 365"; Categoria = "Escritório" },
    [PSCustomObject]@{ ID = "TheDocumentFoundation.LibreOffice"; Name = "LibreOffice"; Categoria = "Escritório" },
    [PSCustomObject]@{ ID = "9NKSQGP7F2NH"; Name = "WhatsApp Desktop"; Categoria = "Comunicação"; Source = "msstore" }
)

# Obtém categorias únicas
$categorias = $programs | Select-Object -ExpandProperty Categoria -Unique

function Show-Categorias {
    Clear-Host
    Write-Host "========== INSTALADOR DE PROGRAMAS ==========" -ForegroundColor Cyan
    for ($i = 0; $i -lt $categorias.Count; $i++) {
        Write-Host "$($i + 1). $($categorias[$i])"
    }
    Write-Host ""
    Write-Host "Digite o número da categoria desejada ou '0' para sair."
    return Read-Host "Sua escolha"
}

function Show-ProgramasPorCategoria($categoriaSelecionada) {
    $programasDaCategoria = $programs | Where-Object { $_.Categoria -eq $categoriaSelecionada }
    Clear-Host
    Write-Host "====== Programas em [$categoriaSelecionada] ======" -ForegroundColor Cyan
    for ($i = 0; $i -lt $programasDaCategoria.Count; $i++) {
        Write-Host "$($i + 1). $($programasDaCategoria[$i].Name)"
    }
    Write-Host ""
    Write-Host "Digite os números dos programas que deseja instalar separados por vírgula (ex: 1,3)"
    Write-Host "Ou digite '0' para voltar ao menu de categorias."
    $entrada = Read-Host "Sua escolha"
    return @{ Escolhas = $entrada; Lista = $programasDaCategoria }
}

function Install-Program($programa) {
    $sourceParam = ""
    if ($programa.PSObject.Properties["Source"]) {
        $sourceParam = "--source $($programa.Source)"
    }

    Write-Host "`nVerificando disponibilidade de $($programa.Name)..." -ForegroundColor Yellow
    $verificacao = winget search --id $programa.ID $sourceParam | Out-String
    if ($verificacao -match $programa.ID) {
        Write-Host "Instalando $($programa.Name)..." -ForegroundColor Green
        try {
            winget install --id $programa.ID $sourceParam --silent --accept-package-agreements --accept-source-agreements
            Write-Host "$($programa.Name) instalado com sucesso!" -ForegroundColor Green
        } catch {
            Write-Host "Erro ao instalar $($programa.Name)" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Pacote não encontrado: $($programa.ID)" -ForegroundColor Red
    }
}

do {
    $opcaoCategoria = Show-Categorias

    if ($opcaoCategoria -eq "0") {
        Write-Host "Saindo..." -ForegroundColor Yellow
        break
    }

    $indiceCategoria = ($opcaoCategoria -as [int]) - 1
    if ($indiceCategoria -lt 0 -or $indiceCategoria -ge $categorias.Count) {
        Write-Host "Opção inválida!" -ForegroundColor Red
        Start-Sleep -Seconds 2
        continue
    }

    $categoriaSelecionada = $categorias[$indiceCategoria]
    $resultado = Show-ProgramasPorCategoria $categoriaSelecionada
    $entrada = $resultado.Escolhas
    $listaProgramas = $resultado.Lista

    if ($entrada -eq "0") { continue }

    $indices = $entrada -split "," | ForEach-Object { ($_ -as [int]) - 1 }

    foreach ($index in $indices) {
        if ($index -ge 0 -and $index -lt $listaProgramas.Count) {
            Install-Program $listaProgramas[$index]
        } else {
            Write-Host "Opção inválida: $($index + 1)" -ForegroundColor Red
        }
    }

    Write-Host "`nPressione qualquer tecla para continuar..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

}
while ($true)
