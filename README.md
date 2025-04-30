# Instalador de Programas via Winget - PowerShell

Este script PowerShell oferece uma interface interativa para instalar rapidamente diversos programas categorizados, utilizando o gerenciador de pacotes **[winget](https://learn.microsoft.com/windows/package-manager/winget/)**.

---

## ✅ Como usar (executar direto da internet)

No PowerShell (executado como Administrador), rode:

```powershell
iex "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/vitorhalk/PS1-install/main/winget.ps1') }"
```

---

## ⚙️ Como configurar o PowerShell

1. Execute o PowerShell como **Administrador**.
2. Libere a execução de scripts com:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
```

---

## 📦 Pré-requisitos

- Windows 10 ou 11
- PowerShell 5.1 ou superior
- `winget` instalado e funcionando ([saiba mais](https://learn.microsoft.com/windows/package-manager/winget/install))
- Acesso à internet

---

## 🧰 Programas disponíveis

### 🧑‍💻 Desenvolvimento
| Nome | Descrição | Site |
|------|-----------|------|
| Visual Studio Code | Editor de código leve e poderoso | [code.visualstudio.com](https://code.visualstudio.com) |
| MySQL Workbench | Gerenciamento de banco de dados MySQL | [mysql.com/products/workbench](https://www.mysql.com/products/workbench/) |

### 🛠️ Utilitários
| Nome | Descrição | Site |
|------|-----------|------|
| 7-Zip | Compactador e extrator de arquivos | [7-zip.org](https://www.7-zip.org) |
| PicPick | Captura e edição de tela | [ngwin.com/picpick](https://picpick.app) |
| WinRAR | Compactador de arquivos | [rarlab.com](https://www.rarlab.com) |
| AnyDesk | Acesso remoto rápido e leve | [anydesk.com](https://anydesk.com) |

### 🌐 Navegadores
| Nome | Descrição | Site |
|------|-----------|------|
| Google Chrome | Navegador rápido e seguro | [google.com/chrome](https://www.google.com/chrome) |
| Opera | Navegador com VPN integrada e foco em privacidade | [opera.com](https://www.opera.com) |

### 🔐 Segurança
| Nome | Descrição | Site |
|------|-----------|------|
| Enpass | Gerenciador de senhas seguro e multiplataforma | [enpass.io](https://www.enpass.io) |

### 🎮 Entretenimento
| Nome | Descrição | Site |
|------|-----------|------|
| VLC Media Player | Reprodutor de mídia versátil | [videolan.org](https://www.videolan.org/vlc/) |
| Steam | Plataforma de distribuição de jogos | [store.steampowered.com](https://store.steampowered.com) |

### 📝 Escritório
| Nome | Descrição | Site |
|------|-----------|------|
| Office 365 | Pacote de produtividade da Microsoft | [microsoft.com/office](https://www.microsoft.com/microsoft-365) |
| LibreOffice | Suite de escritório gratuita e open source | [libreoffice.org](https://www.libreoffice.org) |

### 💬 Comunicação
| Nome | Descrição | Site |
|------|-----------|------|
| WhatsApp Desktop | Versão desktop do popular app de mensagens | [whatsapp.com](https://www.whatsapp.com/download) |

---

## 🧑‍💻 Contribuições

Sinta-se à vontade para abrir issues ou pull requests com novos programas ou melhorias para o script!

---

**Desenvolvido por [@vitorhalk](https://github.com/vitorhalk)**

