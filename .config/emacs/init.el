;;; -*- lexical-binding: t -*-
;; Define o caminho relativo usando a pasta base do Emacs
(add-to-list 'custom-theme-load-path (expand-file-name "themes/" user-emacs-directory))

;; Carrega o tema noctalia
(load-theme 'noctalia t)

(add-to-list 'default-frame-alist
             '(font . "JetBrainsMono Nerd Font 14"))

;; (set-fontset-font "fontset-default" nil "Symbols Nerd Font" nil 'append)

;; Desabilita barras de rolagem e ferramentas
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Habilita os números das linhas
(global-display-line-numbers-mode 1)
;; Define a opacidade do fundo do frame
(set-frame-parameter nil 'alpha-background 60)

(setq history-length 25)
(setq make-backup-files nil)
(savehist-mode 1)

(recentf-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)

;; Configura e organiza os backups do emacs
; Source - https://stackoverflow.com/a/151946
; Posted by jfm3, modified by community. See post 'Timeline' for change history
; Retrieved 2026-08-23, License - CC BY-SA 3.0
(setq backup-directory-alist `(("." . "~/.saves")))
(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.
(setq vc-make-backup-files t) ;; Backup versioned files

(setq use-dialog-box nil)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Ativa pacotes MELPA para serem instalados
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Navegação vim-like com evil-mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode)
  :config
  (evil-set-undo-system 'undo-tree))

;; Configuração de syntax highlighting
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist
   '(lua
     pytho))
  (global-treesit-auto-mode))

(use-package fish-mode
  :ensure t
  :mode ("\\.fish\\'" . fish-mode))

;; Ativa lsp-mode


;; Emulador de terminal dentro do emacs
(use-package vterm
  :ensure t
  :commands vterm
  :custom
  (vterm-always-compile-module t)
  :bind
  ("<f7>" . vterm))
