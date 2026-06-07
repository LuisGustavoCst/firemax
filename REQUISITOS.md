# FIREMAX - REQUISITOS E COMPATIBILIDADE

## ðŸ–¥ï¸ Requisitos do Sistema

### MÃNIMOS:
- **Windows 10** ou superior (22H2 recomendado)
- **PowerShell 5.1** ou superior
- **4 GB de RAM**
- **2 GB de espaÃ§o em disco** (para backups)
- **ConexÃ£o com Internet** (opcional, apenas para downloads)

### RECOMENDADOS:
- **Windows 11 Pro** ou superior
- **PowerShell 7.x** (Preview ou newer)
- **8 GB de RAM** ou superior
- **SSD com 10 GB livre**
- **Processador Intel i5/AMD Ryzen 5** ou melhor

---

## ðŸ”§ Software CompatÃ­vel

### Para Monitoramento de Temperatura:
âœ… **Recomendado:**
- [HWiNFO](https://www.hwinfo.com) - Mais completo
- [GPU-Z](https://www.techpowerup.com/gpu-z/) - Para NVIDIA
- [Ryzen Master](https://www.amd.com/en/technologies/ryzen-master) - Para AMD
- [Open Hardware Monitor](https://openhardwaremonitor.org/) - Open source

### AntivÃ­rus CompatÃ­veis:
âœ… Todos os antivÃ­rus modernos funcionam:
- Windows Defender (recomendado)
- Norton
- McAfee
- Kaspersky
- Avast
- AVG

### Drivers Recomendados:
âœ… Manter sempre atualizados:
- **NVIDIA GeForce** - nvidia.com
- **AMD Radeon** - amd.com
- **Intel Graphics** - intel.com
- **Chipset** - fabricante da placa-mÃ£e

---

## âš ï¸ Incompatibilidades Conhecidas

### NÃƒO CompatÃ­vel Com:
âŒ Windows 7 ou anterior
âŒ VersÃµes nÃ£o ativadas do Windows
âŒ Windows Server (nÃ£o testado)

### Pode Causar Problemas:
âš ï¸ Ferramentas de otimizaÃ§Ã£o conflitantes
âš ï¸ VPNs (podem interferir com permissÃµes)
âš ï¸ Sandboxes (como Virtualbox sem modo real)

---

## ðŸŽ® Compatibilidade com Games

### Testado e CompatÃ­vel Com:
âœ… Counter-Strike 2
âœ… Dota 2
âœ… Grand Theft Auto V/VI
âœ… Minecraft
âœ… Fortnite
âœ… Valorant
âœ… League of Legends
âœ… Elden Ring
âœ… Cyberpunk 2077
âœ… Star Wars Outlaws
âœ… Dead Space Remake
âœ… Resident Evil 4 Remake
âœ… Final Fantasy XVI
âœ… Kingdom Come: Deliverance
âœ… Metal Gear Solid V
âœ… Call of Duty (todas versÃµes)
âœ… World of Warcraft
âœ… Final Fantasy XIV

### Problema Conhecidos:
âš ï¸ Alguns anti-cheat podem flagrar otimizaÃ§Ãµes (raro)
   - SoluÃ§Ã£o: use "Restaurar PadrÃµes" antes de jogar

---

## ðŸ” PermissÃµes NecessÃ¡rias

O FIREMAX requer:
- âœ… Leitura/Escrita no Registry
- âœ… Acesso ao System32
- âœ… PermissÃ£o para modificar configuraÃ§Ãµes de energia
- âœ… PermissÃ£o para alterar prioridade de processos

**NÃ£o requer:**
- âŒ Acesso Ã  internet
- âŒ Acesso a arquivos pessoais
- âŒ PermissÃµes de rede

---

## ðŸ“‹ Checklist Antes de Usar

- [ ] Windows 10/11 Pro instalado
- [ ] Executando como Administrador
- [ ] PowerShell 5.1+ instalado
- [ ] EspaÃ§o em disco suficiente
- [ ] Backup de dados importantes
- [ ] AntivÃ­rus nÃ£o vai interferir
- [ ] Sem programas crÃ­ticos em execuÃ§Ã£o

---

## ðŸš€ Procedimento de InstalaÃ§Ã£o

1. **Download/Clone do projeto**
   ```bash
   git clone [url-do-repositorio]
   cd firemax-otimizer
   ```

2. **Executar Instalador**
   - Clique com botÃ£o direito em `install.ps1`
   - Selecione "Executar com PowerShell"
   - Escolha "Sim" em qualquer prompt

3. **Primeira ExecuÃ§Ã£o**
   - FaÃ§a backup antes (opÃ§Ã£o 12)
   - Comece com otimizaÃ§Ãµes leves
   - Teste antes de usar opÃ§Ã£o 15 (Completa)

---

## ðŸ”„ Requisitos para Cada FunÃ§Ã£o

### 1. Limpeza de Sistema
- âœ… PrivilÃ©gios Admin
- âœ… Nenhum programa usando arquivos temp
- â±ï¸ Tempo: 3-5 minutos

### 2. Otimizar InicializaÃ§Ã£o
- âœ… PrivilÃ©gios Admin
- â±ï¸ Tempo: 1 minuto

### 3. Liberar MemÃ³ria
- âœ… PrivilÃ©gios Admin
- â±ï¸ Tempo: 30 segundos

### 4. Desabilitar Efeitos Visuais
- âœ… PrivilÃ©gios Admin
- âš ï¸ Requer reinicializaÃ§Ã£o para aplicar
- â±ï¸ Tempo: 1 minuto

### 5. Otimizar Disco
- âœ… PrivilÃ©gios Admin
- âœ… Disco nÃ£o fragmentado recomendado
- â±ï¸ Tempo: 5-10 minutos

### 6. Modo Jogo
- âœ… PrivilÃ©gios Admin
- â±ï¸ Tempo: 2 minutos

### 7. Gerenciar Prioridade
- âœ… PrivilÃ©gios Admin
- âœ… Processo deve estar em execuÃ§Ã£o
- â±ï¸ Tempo: 1 minuto

### 8. Boost FPS
- âœ… PrivilÃ©gios Admin
- âš ï¸ Requer suporte ao Power Plan
- â±ï¸ Tempo: 1 minuto

### 9. Status do Sistema
- âœ… Sem requerimentos especiais
- â±ï¸ Tempo: 30 segundos

### 10. Monitorar Temperatura
- âœ… Software de monitoramento (recomendado)
- â±ï¸ Tempo: 1 minuto

### 11. Gerenciador de Processos
- âœ… PrivilÃ©gios Admin (para encerrar)
- â±ï¸ Tempo: VariÃ¡vel

### 12. Fazer Backup
- âœ… PrivilÃ©gios Admin
- âœ… EspaÃ§o em disco (mÃ­n 500 MB)
- â±ï¸ Tempo: 2-5 minutos

### 13. Restaurar Backup
- âœ… PrivilÃ©gios Admin
- âœ… Backup existente
- âš ï¸ Requer reinicializaÃ§Ã£o
- â±ï¸ Tempo: 3 minutos

### 14. Gerenciar Temp Files
- âœ… PrivilÃ©gios Admin
- â±ï¸ Tempo: 2-3 minutos

### 15. OtimizaÃ§Ã£o Completa
- âœ… PrivilÃ©gios Admin
- âœ… Nenhum programa crÃ­tico rodando
- âœ… EspaÃ§o em disco suficiente
- âš ï¸ REQUER REINICIALIZAÃ‡ÃƒO
- â±ï¸ Tempo: 15-30 minutos

### 16. Restaurar PadrÃµes
- âœ… PrivilÃ©gios Admin
- âš ï¸ REQUER REINICIALIZAÃ‡ÃƒO
- â±ï¸ Tempo: 5 minutos

---

## ðŸ†˜ Troubleshooting

### "Acesso Negado"
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

### Script nÃ£o executa
- Verifique se PowerShell estÃ¡ em modo Admin
- Tente: `powershell -NoExit -ExecutionPolicy Bypass -File script.ps1`

### PermissÃµes do Registry
- Use: `runas /user:Administrator cmd`

### Performance nÃ£o melhorou
1. FaÃ§a backup
2. Use opÃ§Ã£o 16 (Restaurar PadrÃµes)
3. Verifique drivers de GPU
4. Aumente RAM se possÃ­vel

---

## ðŸ“Š VersÃ£o do Windows e Suporte

| Windows Version | Suporte | Notas |
|---|---|---|
| Windows 7 | âŒ NÃ£o | Fim de suporte |
| Windows 8.1 | âŒ NÃ£o | Fim de suporte |
| Windows 10 | âœ… Sim | 22H2 recomendado |
| Windows 11 | âœ… Sim | Recomendado |
| Windows Server | âš ï¸ Limitado | NÃ£o testado |

---

## ðŸ” SeguranÃ§a

### O que o FIREMAX **NÃƒO** faz:
- âŒ NÃ£o coleta dados pessoais
- âŒ NÃ£o acessa internet
- âŒ NÃ£o modifica dados pessoais
- âŒ NÃ£o instala software
- âŒ NÃ£o monta malware

### O que o FIREMAX **FAZ**:
- âœ… Modifica apenas configuraÃ§Ãµes de sistema
- âœ… Cria backups antes de mudanÃ§as
- âœ… Registra todas as operaÃ§Ãµes em logs
- âœ… Permite reversÃ£o completa

---

## ðŸ“ Suporte

Para problemas:
1. Verifique os logs em `logs/firemax_YYYYMMDD.log`
2. Use "Restaurar de Backup" (opÃ§Ã£o 13)
3. Use "Restaurar PadrÃµes" (opÃ§Ã£o 16)

---

**Ãšltima atualizaÃ§Ã£o:** 2026-06-05
**VersÃ£o:** 1.0

