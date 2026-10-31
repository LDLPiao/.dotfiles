# Nix (fallback do Guix)

## Dois repositórios
- **dotfiles**: bare repo com work tree em `$HOME`. Os arquivos ficam nos caminhos
  reais (`~/.config/foot`, `~/.zshrc`...), sem symlink e sem stow.
- **system**: repo git normal (ex.: `~/system`) com esta pasta `nix/` e, depois, `guix/`.
  Separado do bare repo porque flakes precisam enxergar os arquivos como repo git normal.

## Estrutura de nix/
    flake.nix
    hosts/{thinkpad,dell}/   default.nix + hardware-configuration.nix (copiado de /etc/nixos)
    modules/                 base, desktop, nvidia (dell), gaming (dell)   -> nível de sistema
    home/default.nix         Home Manager: SÓ pacotes/serviços de usuário (sem dotfiles)

## Primeira vez (máquina que já roda NixOS)
1. Copie `/etc/nixos/hardware-configuration.nix` para `hosts/<host>/`.
2. Em `hosts/<host>/default.nix`, preencha stateVersion e bootloader (veja os comentários).
3. `git add -A` dentro do repo system (flakes só enxergam arquivos rastreados).
4. Teste sem ativar: `nixos-rebuild build --flake .#<host>`
5. Aplique: `sudo nixos-rebuild switch --flake .#<host>`
6. Voltar: `sudo nixos-rebuild switch --rollback` (ou escolha a geração no boot).

## Dotfiles num host novo (bare repo)
    git clone --bare <url> $HOME/.dotfiles
    alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
    dot config status.showUntrackedFiles no
    dot checkout

- Se o `checkout` reclamar de arquivos existentes (ex.: um `~/.zshrc` padrão), mova-os antes.
- Coloque `.dotfiles` no `.gitignore` do próprio repo, para ele não tentar se rastrear.

O início do Mango pelo tty1 já está no `modules/desktop.nix` (`environment.loginShellInit`),
igual ao que você usa hoje. Não precisa de nada no `~/.zprofile`.

## Atualizar
    nix flake update && sudo nixos-rebuild switch --flake .#<host>
