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

## Avisos

- Sempre faça backup antes de aplicar mudanças críticas.
- Use as opções avançadas com cuidado; algumas mudanças alteram o registro do Windows.

### âš ï¸ Antes de Usar
- Feche todos os programas abertos
- Desative antivÃ­rus temporariamente (pode interferir)
- Garanta que nÃ£o estÃ¡ em um jogo
- FaÃ§a backup de dados importantes

### âš ï¸ ApÃ³s Otimizar
- **REINICIE o PC** para aplicar todas as mudanÃ§as
- Monitore a temperatura nos primeiros minutos
- Se tiver problemas, use "Restaurar de Backup"

---

## ðŸŽ® Dicas Para Melhor Performance em Games

1. **Aplique OtimizaÃ§Ã£o Completa** (opÃ§Ã£o 15)
2. **Ative Modo Jogo** (opÃ§Ã£o 6) antes de jogar
3. **Use Boost FPS** (opÃ§Ã£o 8)
4. **Altere prioridade do game para HIGH** (opÃ§Ã£o 7)
5. **Desabilite overlay do Discord** nas configuraÃ§Ãµes do Discord
6. **Feche navegadores** enquanto joga
7. **Monitore temperatura** com HWiNFO

---

## ðŸ”§ Troubleshooting

### "Script nÃ£o reconhecido"
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

### "Acesso negado"
- Execute como Administrador
- Feche todos os aplicativos
- Tente novamente

### "Temperatura nÃ£o aparece"
- Instale HWiNFO (gratuito)
- Ou GPU-Z para NVIDIA
- Ou Ryzen Master para AMD

### Performance piorou apÃ³s otimizaÃ§Ã£o
- Use "Restaurar PadrÃµes" (opÃ§Ã£o 16)
- Ou restaure um backup anterior (opÃ§Ã£o 13)

---

## ðŸ“Š Registro em Log

Todos os comandos sÃ£o registrados em:
```
logs/firemax_YYYYMMDD.log
```

---

## ðŸ”„ AtualizaÃ§Ãµes Futuras

- [ ] Interface grÃ¡fica (GUI)
- [ ] OtimizaÃ§Ã£o de rede
- [ ] Gerenciador de driver automÃ¡tico
- [ ] Agendamento de tarefas
- [ ] Suporte a macOS e Linux

---

## ðŸ‘¨â€ðŸ’» CrÃ©ditos

Desenvolvido por: **FireMax Development Team**
Ãšltima atualizaÃ§Ã£o: 2026-06-05

---

## ðŸ“§ Suporte

Para problemas ou sugestÃµes, verifique os logs em `/logs/` e tente as soluÃ§Ãµes em Troubleshooting.

---

**Aproveite o FIREMAX e tenha o mÃ¡ximo de performance no seu PC!** ðŸš€ðŸŽ®

