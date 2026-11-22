# dotfiles

Tema **Solarized Dark** para [Omarchy](https://omarchy.org/), alinhado com a
[referência oficial do Solarized](https://ethanschoonover.com/solarized/), mais
a configuração de Neovim que o acompanha e um prompt/status line
[Powerline](https://powerline.readthedocs.io/en/master/) com ícones Nerd Font.

![Ghostty e Neovim com Solarized Dark no Omarchy](.github/screenshots/desktop.png)

<sub>Ghostty (JetBrainsMono Nerd Font) com a paleta ANSI do tema e Neovim com
[solarized.nvim](https://github.com/maxmx03/solarized.nvim), com o modo glass
(transparência) do Omarchy ligado.</sub>

## Conteúdo

| Caminho | O que faz |
|---|---|
| `omarchy/themes/solarized-dark/colors.toml` | Paleta do tema; o Omarchy gera dela as configs dos apps sem arquivo próprio (alacritty, btop, VS Code…) |
| `omarchy/themes/solarized-dark/ghostty.conf` | Ghostty: ANSI canônico do Solarized e cursor base1 |
| `omarchy/themes/solarized-dark/foot.ini` | foot: a mesma paleta do Ghostty |
| `omarchy/themes/solarized-dark/neovim.lua` | Neovim/LazyVim com `maxmx03/solarized.nvim` |
| `omarchy/themes/solarized-dark/unlock.png` | Logo das telas de desbloqueio do disco (Plymouth), desligamento e login (SDDM) |
| `omarchy/themes/solarized-dark/backgrounds/` | Wallpapers CC0 (fontes em `CREDITS.md`) |
| `nvim/lua/plugins/all-themes.lua` | Instala o solarized.nvim para o hot-reload de tema do Omarchy |
| `powerline/config.json` | Powerline: esquema `solarized` em truecolor, tema `default_leftonly` no bash |
| `powerline/themes/nerd.json` | Tema de nível superior do Powerline: separadores e ícones Nerd Font |
| `bash/powerline.bash` | Liga o prompt do Powerline no bash e tira o Starship que o Omarchy ativa |
| `tmux/tmux.conf` | tmux do Omarchy com a status line do Powerline |
| `nvim/lua/plugins/lualine-powerline.lua` | Separadores Powerline no lualine do LazyVim |

## Paleta

| Papel | Solarized | Hex |
|---|---|---|
| Fundo | base03 | `#002b36` |
| Fundo de realce, seleção, ANSI 0 | base02 | `#073642` |
| Comentários, ANSI 8 | base01 | `#586e75` |
| Texto | base0 | `#839496` |
| Texto em destaque, texto selecionado, cursor | base1 | `#93a1a1` |
| ANSI 7 | base2 | `#eee8d5` |
| ANSI 15 | base3 | `#fdf6e3` |
| Acento | blue | `#268bd2` |

Diferenças em relação ao Solarized clássico, ambas de propósito:

- **ANSI 8 é base01** e não base03: base03 é a própria cor do fundo e deixa
  invisível o texto "dim".
- **Brights mantêm as cores** (o clássico transforma quase todos em cinzas),
  com o laranja (9) e o violeta (13) do Solarized.

## Tela de desbloqueio e desligamento

![Tela de desbloqueio do disco em Solarized Dark](omarchy/themes/solarized-dark/preview-unlock.png)

A mesma arte aparece ao pedir a senha do disco no boot, ao desligar e ao
reiniciar; o login (SDDM) usa o mesmo fundo e logo.

## Powerline

![Prompt do bash, status do tmux e Neovim com Powerline em Solarized Dark](.github/screenshots/powerline.png)

- **bash**: usuário, virtualenv, branch git, diretório, jobs em segundo plano e
  código de saída do último comando quando falha.
- **tmux** (barra no topo): sessão, janelas, uptime, carga, data, hora e host.
- **Neovim**: o binding de Vim do Powerline 2.8.4 não roda no Neovim 0.12 (chama
  `.decode()` na `str` que o pynvim devolve), então o lualine do LazyVim desenha
  as mesmas setas  .

Os separadores (U+E0B0–E0B3) e os ícones vêm da JetBrainsMono Nerd Font, sem
`powerline-fonts`. O esquema usa os hex do Solarized (`term_truecolor`): os
índices de 256 cores do esquema seguem o Solarized clássico e mostrariam verde
no lugar de base01 com a paleta ANSI deste tema.

## Instalação

O repositório espelha `~/.config`. Em outra máquina com Omarchy:

```bash
git clone https://github.com/Esegnorelli/dotfiles /tmp/dotfiles
cp -r /tmp/dotfiles/omarchy/themes/solarized-dark ~/.config/omarchy/themes/
cp /tmp/dotfiles/nvim/lua/plugins/{all-themes,lualine-powerline}.lua ~/.config/nvim/lua/plugins/
cp -r /tmp/dotfiles/{powerline,bash} ~/.config/
cp /tmp/dotfiles/tmux/tmux.conf ~/.config/tmux/

omarchy pkg add powerline
echo '[[ -r ~/.config/bash/powerline.bash ]] && source ~/.config/bash/powerline.bash' >> ~/.bashrc

omarchy theme set solarized-dark
omarchy plymouth set by theme solarized-dark   # boot/desligamento/login; pede sudo
```

Não clone o repositório nem crie um `.git` **dentro** de
`~/.config/omarchy/themes/solarized-dark`: o Omarchy trata um tema com `.git`
como instalado de terceiros e ignora `ghostty.conf`, `foot.ini` e `neovim.lua`.

Terminais foot já abertos só pegam a paleta deste tema depois de reabertos; o
Ghostty recarrega sozinho.

## Créditos

- [Solarized](https://ethanschoonover.com/solarized/), de Ethan Schoonover
- [solarized.nvim](https://github.com/maxmx03/solarized.nvim), de maxmx03
- [Powerline](https://github.com/powerline/powerline)
- Wallpapers: ver [`CREDITS.md`](omarchy/themes/solarized-dark/CREDITS.md)
