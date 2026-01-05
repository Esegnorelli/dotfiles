# 🧪 Scripts Revisados e Corrigidos

Todos os scripts foram revisados e corrigidos para evitar erros.

## ✅ Correções Realizadas

### 1. **restore.sh**
- **Corrigido**: Backup correto de `.config/starship.toml` (era tratado como diretório)
- **Corrigido**: Uso de `$HOME` em vez de `~` para melhor compatibilidade
- **Melhoria**: Separação clara entre backup de diretórios e arquivos individuais

### 2. **sync.sh**
- **Corrigido**: Verifica se é repositório git antes de executar comandos git
- **Corrigido**: Valida mensagem do commit (não permite vazia)
- **Corrigido**: Trata erro de upstream não configurado automaticamente
- **Melhoria**: Usa `read -r` para evitar problemas com caracteres especiais

### 3. **setup-esegnorelli.sh**
- **Corrigido**: Valida URL do repositório (não permite vazia)
- **Corrigido**: Usa `set-url` em vez de `remove/add` quando remote já existe
- **Corrigido**: Tratamento de erro melhorado para push com instruções claras
- **Melhoria**: Mensagens de erro mais informativas sobre como configurar SSH

### 4. **setup-work.sh**
- **Corrigido**: Prompt padrão mostra URL correta (Esegnorelli em vez de usuario)
- **Corrigido**: Detecção segura do caminho do zsh usando `command -v`
- **Melhoria**: Validação de caminho antes de mudar shell

### 5. **copy-to-pendrive.sh**
- **Corrigido**: Tratamento de erro se sync.sh falhar (não para o script)
- **Corrigido**: Detecção mais confiável de pen drive (verifica /dev/sd*)
- **Corrigido**: Aceita 's' ou 'S' para confirmação
- **Melhoria**: Mostra dispositivos disponíveis quando pen drive não encontrado
- **Melhoria**: Verifica sucesso do rsync antes de continuar

## 🧪 Teste.sh (Novo)

Script para testar todos os scripts:
```bash
cd ~/dotfiles
./test.sh
```

**Verifica**:
- ✅ Sintaxe de todos os scripts (bash -n)
- ✅ Permissões de execução
- ✅ Estrutura de diretórios completa
- ✅ Arquivos essenciais presentes
- ✅ Dependências instaladas (git, stow)

## 📋 Como Usar

### No PC de Casa (Configuração Inicial)

```bash
cd ~/dotfiles
./setup-esegnorelli.sh
```

Este script:
1. Configura Git
2. Gera chave SSH
3. Configura repositório GitHub
4. Envia para GitHub

### No PC do Trabalho (Primeira Vez)

```bash
git clone git@github.com:Esegnorelli/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup-work.sh
```

Este script:
1. Instala todas as dependências
2. Clona do GitHub
3. Restaura configurações
4. Instala plugins
5. Configura shell padrão

### Sincronizar Mudanças

```bash
cd ~/dotfiles
./sync.sh
```

Este script:
1. Verifica mudanças
2. Pede mensagem de commit
3. Commita mudanças
4. Envia para GitHub
5. Trata erros automaticamente

### Backup no Pen Drive

```bash
cd ~/dotfiles
./copy-to-pendrive.sh
```

Este script:
1. Sincroniza com GitHub
2. Detecta pen drive
3. Copia dotfiles
4. Cria script de instalação

### Testar Scripts

```bash
cd ~/dotfiles
./test.sh
```

## 🔒 Segurança

- ✅ Validações de entrada em todos os prompts
- ✅ Tratamento de erros em operações críticas
- ✅ Mensagens de erro claras e informativas
- ✅ Não permite comandos vazio ou inválidos
- ✅ Verifica dependências antes de executar

## 🎯 Melhorias Gerais

- **Mensagens mais claras**: Todos os outputs são informativos e coloridos
- **Validação de entrada**: Todos os prompts validam a entrada do usuário
- **Tratamento de erros**: Operações críticas têm tratamento de erro
- **Compatibilidade**: Usa `$HOME` em vez de `~` para melhor portabilidade
- **Permissões**: Todos os scripts têm `chmod +x`

## 📦 Scripts Disponíveis

| Script | Propósito | Quando Usar |
|--------|-----------|--------------|
| `restore.sh` | Restaurar configurações | Após clonar dotfiles |
| `sync.sh` | Sincronizar mudanças | Após alterar configurações |
| `setup-esegnorelli.sh` | Configurar GitHub | Primeira vez (PC casa) |
| `setup-work.sh` | Instalar tudo | Primeira vez (PC trabalho) |
| `copy-to-pendrive.sh` | Backup em pen drive | Backup offline |
| `test.sh` | Testar scripts | Verificar tudo está ok |

## ⚠️ Notas Importantes

1. **SSH Key**: Certifique-se de adicionar a chave SSH no GitHub antes de usar sync.sh ou setup scripts
2. **Repositório GitHub**: Crie o repositório no GitHub antes de executar setup-esegnorelli.sh
3. **Pen Drive**: Formate o pen drive como ext4 ou exfat para compatibilidade
4. **Backup**: O restore.sh faz backup automático antes de instalar
5. **Teste**: Execute `./test.sh` sempre que fizer mudanças nos scripts

## 🚀 Próximos Passos

Todos os scripts estão prontos para uso! Execute `./test.sh` para verificar que tudo está funcionando.
