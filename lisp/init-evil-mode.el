(use-package evil
  :ensure t
  :init 
  (setq evil-want-integration nil)
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer nil)
  (setq evil-move-beyond-eol t)
  :config
  (evil-mode 1)
  (global-set-key (kbd "C-u") 'evil-scroll-up)
  ;; (setq evil-jumps-cross-buffers)
  ;; (add-hook 'iedit-mode-keymap 'evil-normalize-keymaps)
  )

(use-package evil-magit
  :ensure t
  :after (evil magit))

(use-package evil-iedit-state
  ;; :ensure t
  :commands (evil-iedit-state evil-iedit-state/iedit-mode)
  ;; (setq iedit-current-symbol-default t
  ;;       iedit-only-at-symbol-boundaries t
  ;;       iedit-toggle-key-default nil)
  )

(use-package evil-adjust
  :load-path "site-lisp/evil-adjust"
  :after evil
  :pin manual
  :config
  (evil-adjust))

;;configure key-chords
(use-package key-chord
  :after evil
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-insert-state-map "fj" #'evil-write)
  (key-chord-define evil-normal-state-map "fj" #'evil-write)
  (key-chord-define evil-insert-state-map "fd" #'evil-normal-state)
  (key-chord-define evil-normal-state-map "fd" #'keyboard-escape-quit)
  (key-chord-mode 1))

;; (use-package evil-escape
;;   :after evil
;;   :config
;;   (evil-escape-mode 1)
;;   (setq evil-escape-delay 0.4)
;;   (setq evil-escape-key-sequence nil))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :init
  (setq evil-collection-mode-list nil)
  (setq evil-collections-setup-minibuffer t)
  :config
  (evil-collection-init '(minibuffer ivy dired magit neotree elisp-mode slime)))

(use-package evil-leader
  :after evil
  :after org
  :ensure t)

(use-package evil-org
  :after evil
  :after org
  :ensure t)

(provide 'init-evil-mode)
