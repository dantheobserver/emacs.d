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
(show-smartparens-global-mode)
;; (setq show-paren-mode t)
;; (setq show-parend-delay 0)
(set-frame-font "IBMPlexMono 14" nil t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq kill-ring-max 150)

;; Desktop Save Mode
(desktop-save-mode 1)
(add-to-list 'desktop-globals-to-save 'ivy-views)

;;line-numbers
(setq-default display-line-numbers-type 'visual
              display-line-numbers-current-absolute t
              display-line-numbers-width 3
              display-line-numbers-widen t)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(provide 'init-common)
