# Carrega as assemblies necessárias para usar Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Estrutura de Dados: Hashtable com categorias e programas
$Programs = @{
    "Desenvolvimento" = @(
        [PSCustomObject]@{ Name = "Visual Studio Code"; Description = "Editor de código leve e poderoso"; ID = "Microsoft.VisualStudioCode" },
        [PSCustomObject]@{ Name = "MySQL Workbench"; Description = "Ferramenta de gerenciamento de bancos de dados"; ID = "Oracle.MySQLWorkbench" }
    ),
    "Utilitários" = @(
        [PSCustomObject]@{ Name = "7-Zip"; Description = "Compactador e extrator de arquivos"; ID = "7zip.7zip" },
        [PSCustomObject]@{ Name = "PicPick"; Description = "Captura e edição de tela"; ID = "NGWIN.PicPick" }
    ),
    "Navegadores" = @(
        [PSCustomObject]@{ Name = "Google Chrome"; Description = "Navegador rápido e seguro"; ID = "Google.Chrome" }
    ),
    "Segurança" = @(
        [PSCustomObject]@{ Name = "Enpass"; Description = "Gerenciador de senhas seguro"; ID = "Sinew.Enpass" }
    ),
    "Entretenimento" = @(
        [PSCustomObject]@{ Name = "VLC Media Player"; Description = "Reprodutor de mídia versátil"; ID = "VideoLAN.VLC" },
        [PSCustomObject]@{ Name = "Steam"; Description = "Plataforma de jogos da Valve"; ID = "Valve.Steam" }
    )
}

# Função para criar a interface gráfica
function Create-UI {
    $Form = New-Object System.Windows.Forms.Form
    $Form.Text = 'Instalador de Programas'
    $Form.Size = New-Object System.Drawing.Size(800, 600)
    $Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

    # Cria o botão "Marcar Todos"
    $btnMarkAll = New-Object System.Windows.Forms.Button
    $btnMarkAll.Text = 'Marcar Todos'
    $btnMarkAll.Size = New-Object System.Drawing.Size(100, 30)
    $btnMarkAll.Location = New-Object System.Drawing.Point(50, 500)
    $btnMarkAll.Add_Click({
        foreach ($groupBox in $groupBoxes) {
            foreach ($item in $groupBox.Controls) {
                if ($item -is [System.Windows.Forms.CheckedListBox]) {
                    $item.SetItemChecked(0, !$item.GetItemChecked(0)) # Alterna entre marcar e desmarcar
                }
            }
        }
    })

    # Cria o botão "Instalar Selecionados"
    $btnInstallSelected = New-Object System.Windows.Forms.Button
    $btnInstallSelected.Text = 'Instalar Selecionados'
    $btnInstallSelected.Size = New-Object System.Drawing.Size(150, 30)
    $btnInstallSelected.Location = New-Object System.Drawing.Point(200, 500)
    $btnInstallSelected.Add_Click({
        $selectedPrograms = @()

        foreach ($groupBox in $groupBoxes) {
            foreach ($item in $groupBox.Controls) {
                if ($item -is [System.Windows.Forms.CheckedListBox]) {
                    for ($i = 0; $i -lt $item.Items.Count; $i++) {
                        if ($item.GetItemChecked($i)) {
                            $program = $Programs[$groupBox.Text][$i]
                            $selectedPrograms += $program
                        }
                    }
                }
            }
        }

        if ($selectedPrograms.Count -gt 0) {
            foreach ($program in $selectedPrograms) {
                try {
                    Write-Host "Instalando $($program.Name) via winget..."
                    winget install --id $program.ID --silent
                    [System.Windows.Forms.MessageBox]::Show("Instalação do programa $($program.Name) concluída com sucesso!", "Sucesso")
                } catch {
                    [System.Windows.Forms.MessageBox]::Show("Erro ao instalar $($program.Name).", "Erro")
                }
            }
        } else {
            [System.Windows.Forms.MessageBox]::Show("Nenhum programa selecionado.", "Erro")
        }
    })

    # Cria o botão "Sair"
    $btnExit = New-Object System.Windows.Forms.Button
    $btnExit.Text = 'Sair'
    $btnExit.Size = New-Object System.Drawing.Size(100, 30)
    $btnExit.Location = New-Object System.Drawing.Point(400, 500)
    $btnExit.Add_Click({
        $Form.Close()
    })

    # Organiza os GroupBoxes de categorias
    $yPosition = 10
    $groupBoxes = @()

    foreach ($category in $Programs.Keys) {
        $groupBox = New-Object System.Windows.Forms.GroupBox
        $groupBox.Text = $category
        $groupBox.Size = New-Object System.Drawing.Size(750, 150)
        $groupBox.Location = New-Object System.Drawing.Point(20, $yPosition)
        $yPosition += 160

        # Cria um CheckedListBox para cada categoria
        $checkedListBox = New-Object System.Windows.Forms.CheckedListBox
        $checkedListBox.Size = New-Object System.Drawing.Size(720, 120)
        $checkedListBox.Location = New-Object System.Drawing.Point(10, 20)

        # Adiciona programas ao CheckedListBox
        foreach ($program in $Programs[$category]) {
            $checkedListBox.Items.Add("$($program.Name) - $($program.Description)")
        }

        # Adiciona o CheckedListBox ao GroupBox
        $groupBox.Controls.Add($checkedListBox)

        # Adiciona o GroupBox à lista e ao formulário
        $groupBoxes += $groupBox
        $Form.Controls.Add($groupBox)
    }

    # Adiciona os botões ao formulário
    $Form.Controls.Add($btnMarkAll)
    $Form.Controls.Add($btnInstallSelected)
    $Form.Controls.Add($btnExit)

    # Exibe a interface gráfica
    $Form.ShowDialog()
}

# Chama a função para criar e exibir a interface gráfica
Create-UI
