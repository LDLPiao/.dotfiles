;; Define o caminho relativo usando a pasta base do Emacs
(add-to-list 'custom-theme-load-path (expand-file-name "themes/" user-emacs-directory))

;; Carrega o tema noctalia
(load-theme 'noctalia t)


;; Desabilita barras de rolagem e ferramentas
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Habilita os números das linhas
(global-display-line-numbers-mode 1)
;; Define a opacidade do fundo do frame
(set-frame-parameter nil 'alpha-background 80)

(setq history-length 25)
(savehist-mode 1)

(recentf-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)

(setq use-dialog-box nil)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Ativa pacotes MELPA para serem instalados
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
 
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

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist '(lua))
  (global-treesit-auto-mode))
