# Kitty - Cheat Sheet de Atalhos

Referência rápida de todos os atalhos configurados.

## Legenda

`kitty_mod` = `Ctrl+Shift`

## Clipboard

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+C` | Copiar para clipboard |
| `Ctrl+Shift+V` | Colar do clipboard |
| `Ctrl+Shift+S` | Colar da seleção |
| `Shift+Insert` | Colar da seleção |

## Tabs

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+T` | Nova tab (no diretório atual) |
| `Ctrl+Shift+W` | Fechar tab |
| `Ctrl+Shift+→` | Próxima tab |
| `Ctrl+Shift+←` | Tab anterior |
| `Ctrl+Shift+Alt+T` | Renomear tab |
| `Ctrl+Shift+1-9` | Ir para tab 1-9 |

## Janelas/Splits

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+Enter` | Nova janela (no diretório atual) |
| `Ctrl+Shift+N` | Nova janela do OS |
| `Ctrl+Shift+Q` | Fechar janela |
| `Ctrl+Shift+]` | Próxima janela |
| `Ctrl+Shift+[` | Janela anterior |
| `Ctrl+Shift+\` | **Split vertical** |
| `Ctrl+Shift+-` | **Split horizontal** |
| `Ctrl+Shift+R` | Modo redimensionar |

## Navegação entre Splits (Vim-like)

| Atalho | Ação |
|--------|------|
| `Ctrl+H` | Ir para janela à esquerda |
| `Ctrl+L` | Ir para janela à direita |
| `Ctrl+K` | Ir para janela acima |
| `Ctrl+J` | Ir para janela abaixo |

## Layouts

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+L` | Próximo layout |
| `Ctrl+Shift+Z` | Toggle layout stack (maximizar/restaurar) |

## Zoom de Fonte

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift++` | Aumentar fonte |
| `Ctrl+Shift+-` | Diminuir fonte |
| `Ctrl+Shift+0` | Resetar tamanho |

## Transparência

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+A M` | Aumentar opacidade (+5%) |
| `Ctrl+Shift+A L` | Diminuir opacidade (-5%) |
| `Ctrl+Shift+A 1` | Opacidade 100% (sem transparência) |
| `Ctrl+Shift+A D` | Opacidade padrão (92%) |

## Scrollback

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+↑` | Scroll uma linha para cima |
| `Ctrl+Shift+↓` | Scroll uma linha para baixo |
| `Ctrl+Shift+Page Up` | Scroll uma página para cima |
| `Ctrl+Shift+Page Down` | Scroll uma página para baixo |
| `Ctrl+Shift+Home` | Scroll para o início |
| `Ctrl+Shift+End` | Scroll para o fim |
| `Ctrl+Shift+H` | Ver histórico completo no pager |

## Busca

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+/` | Buscar no histórico com FZF |

## Configuração

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+F5` | Recarregar configuração |
| `Ctrl+Shift+F6` | Debug da configuração |
| `Ctrl+Shift+E` | Editar arquivo de config |
| `Ctrl+Shift+Escape` | Abrir shell do Kitty |

## Outros

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+Delete` | Limpar terminal (reset) |
| `Ctrl+Shift+F` | Mover janela para frente |
| `Ctrl+Shift+B` | Mover janela para trás |
| `Ctrl+Shift+\`` | Mover janela para topo |

## Dicas

### Criar split vertical rápido
```
Ctrl+Shift+\
```
Abre uma nova janela lado a lado.

### Navegar splits como no Vim
```
Ctrl+H/J/K/L
```
Super intuitivo se você usa Vim!

### Alternar entre maximizado e splits
```
Ctrl+Shift+Z
```
Ótimo para focar em uma tarefa e depois voltar.

### Ajustar transparência na hora
```
Ctrl+Shift+A L/M
```
Útil para apresentações ou quando há muita luz no ambiente.

### Buscar comando no histórico
```
Ctrl+Shift+/
```
Abre FZF com todo histórico visível do terminal.

### Reload instantâneo
```
Ctrl+Shift+F5
```
Após editar kitty.conf, recarregue sem fechar.

## Customização

Para mudar qualquer atalho, edite `~/.config/kitty/kitty.conf` e procure por `map`.

Exemplo:
```conf
# Mudar split vertical de \ para V
map kitty_mod+v launch --location=vsplit --cwd=current
```

Depois: `Ctrl+Shift+F5` para aplicar.

---

**Imprima esta página para referência rápida!**
