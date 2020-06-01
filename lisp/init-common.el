(setq custom-file "~/.emacs.d/custom.el") ;move customs out of init.el
(load custom-file)
(setq delete-old-versions -1)    ; delete excess backup versions silently
(setq version-control t)    ; use version control
(setq vc-make-backup-files t)    ; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups"))) ; which directory to put backups file
(setq vc-follow-symlinks t)               ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))) ;transform backups file name
(setq inhibit-startup-screen t)  ; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore)  ; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8)  ; use utf-8 by default
(setq coding-system-for-write 'utf-8)
(setq sentence-end-double-space nil)  ; sentence SHOULD end with only a point.
(setq default-fill-column 80)    ; toggle wrapping text at the 80th character
(setq scroll-bar-mode 0)
(setq help-window-select t)
(setq dired-auto-revert-buffer t)
(setq dired-dwim-target t)
(with-eval-after-load 'smartparens-mode (show-smartparens-global-mode))
(show-paren-mode 1)

;; Hideshow mode for folding support
(add-hook 'prog-mode-hook 'hs-minor-mode)
(setq show-parend-delay 0)
(setq show-paren-style 'mixed)
;; (set-frame-font "IBMPlexMono 18" nil)
;; (set-frame-font "Source Code Pro 18")
(set-frame-font "Menlo 18")
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq kill-ring-max 150)
(setq initial-scratch-message nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(add-hook 'org-mode-hook 'auto-fill-mode)
(setq x-alt-keysym 'meta)
(set-keyboard-coding-system nil)

;; Desktop Save Mode
(desktop-save-mode 1)
(setq desktop-load-locked-desktop t)
(add-to-list 'desktop-globals-to-save 'ivy-views)

;;line-numbers
(setq-default display-line-numbers-type 'visual
              display-line-numbers-current-absolute t
              display-line-numbers-width 3
              display-line-numbers-widen t)

(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;setup path for node

(getenv "PATH")

(setq explicit-shell-file-name "/usr/bin/zsh")
(setq shell-file-name "zsh")
(setenv "SHELL" shell-file-name)

(provide 'init-common)
