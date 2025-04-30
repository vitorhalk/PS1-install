# 🛠️ Instalador de Programas via Winget

Este repositório contém um script PowerShell (`winget.ps1`) com menu interativo para instalação automatizada de softwares essenciais no Windows utilizando o gerenciador de pacotes **[winget](https://learn.microsoft.com/windows/package-manager/winget/)**.

## ✅ Funcionalidades

- Menu de seleção por categoria (Desenvolvimento, Utilitários, Navegadores, etc)
- Instalação automatizada e silenciosa dos programas selecionados
- Verificação se o pacote está disponível antes da instalação

## 📦 Softwares incluídos

Exemplos de programas que podem ser instalados com o script:

- Visual Studio Code
- MySQL Workbench
- 7-Zip, WinRAR, PicPick
- Google Chrome, Opera
- Enpass, AnyDesk
- VLC Media Player, Steam
- Office 365, LibreOffice
- WhatsApp Desktop

## 🚀 Como executar diretamente da web

> ⚠️ Requer permissão de administrador no PowerShell.

### Copie e cole no PowerShell (como administrador):

```powershell
iex "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/vitorhalk/PS1-install/main/winget.ps1') }"
