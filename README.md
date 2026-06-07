# FIREMAX - Otimizador de PC (v1.0)

FIREMAX é um otimizador de sistema escrito em PowerShell, voltado para melhorar o desempenho de PCs usados para jogos. Este repositório contém o script principal, utilitários, documentação e um script de empacotamento para facilitar a distribuição.

Autor: Silva
Versão: 1.0 (2026-06-06)

## Resumo

Ferramentas principais:
- Limpeza de sistema (arquivos temporários, cache)
- Otimização de inicialização
- Limpeza de memória e ajustes de prioridade
- Otimizações para jogos (perfis por jogo)
- Monitoramento básico (CPU, memória, disco)
- Backup/restore de configurações

## Requisitos

- Windows 10/11
- PowerShell 5.1 ou superior
- Executar como Administrador para aplicar alterações

## Instalação e uso

1. Faça o download do projeto para uma pasta local.
2. Abra o PowerShell como Administrador.
3. (Opcional) Permita execução de scripts:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

4. Execute o script principal:

```powershell
cd C:\Users\<seu_usuario>\Documents\firemax-otimizer
.\firemax.ps1
```

Siga as instruções do menu para escolher o perfil ou a otimização desejada. Logs são gravados em `logs/` e backups em `backups/`.

## Empacotamento para distribuição

Para gerar um arquivo ZIP pronto para upload, use o script `package.ps1`:

```powershell
.\package.ps1
# O ZIP será criado em .\dist\FIREMAX-YYYYMMDD.zip
```

Este arquivo compactado é adequado para fazer upload em serviços como MediaFire.

## Arquivos importantes

- `firemax.ps1` — script principal
- `INICIAR.bat` / `firemax.bat` — atalho para iniciar como administrador
- `install.ps1` — instalador (cria pastas, atalho)
- `monitor.ps1` — monitor simples de uso de recursos
- `package.ps1` — cria o ZIP para distribuição
- `README.md`, `GUIA_RAPIDO.txt`, `CHANGELOG.md`, `AUTHOR.txt`

**Aproveite a ferramenta!**
