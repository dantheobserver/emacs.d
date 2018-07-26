;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun setup|add-packages (lisp-dir)
  (dolist (package-dir (directory-files lisp-dir t "\\w+"))
    (when (file-directory-p package-dir)
      (add-to-list 'load-path package-dir)
      (add-to-list 'load-path (concat package-dir "/lisp")))))

(defun setup|load-path ()
  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  (setup|add-packages (expand-file-name "site-lisp" user-emacs-directory)))

(setup|load-path)

(require 'bootstrap-use-package)
(require 'init-common)
(require 'init-utils)
(require 'init-lisps)

(utils|use-package-enable which-key
  (setq-default which-key-idle-delay 0.2))

;;;;;;;;;;
;; Evil ;;
;;;;;;;;;;
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(utils|use-package-enable evil-escape
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "fd"))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;;;;;;;;;;;;;;;;
;; Navigation ;;
;;;;;;;;;;;;;;;;

;; (defun functions|display-helm-window (buffer &optional resume)
;;   "Display the Helm window respecting `helm-position'."
;;   (let ((display-buffer-alist
;;          (list spacemacs-helm-display-help-buffer-regexp
;;                ;; this or any specialized case of Helm buffer must be
;;                ;; added AFTER `spacemacs-helm-display-buffer-regexp'.
;;                ;; Otherwise, `spacemacs-helm-display-buffer-regexp' will
;;                ;; be used before
;;                ;; `spacemacs-helm-display-help-buffer-regexp' and display
;;                ;; configuration for normal Helm buffer is applied for helm
;;                ;; help buffer, making the help buffer unable to be
;;                ;; displayed.
;;                spacemacs-helm-display-buffer-regexp)))
;;     (helm-default-display-buffer buffer)))

(use-package helm
  :ensure t
  :config
  (setq helm-always-two-windows t)
  (setq helm-display-header-line nil)
  (setq helm-echo-input-in-header-line t)
  (setq helm-split-window-inside-p t)
  ;; (setq helm-display-function functions|display-helm-window)
  )

(use-package helm-flx :ensure t
  :config
  (helm-flx-mode 1)
  (setq helm-fuzzy-matching-highlight-fn #'helm-flx-fuzzy-highlight-match)
  (setq helm-fuzzy-sort-fn #'helm-flx-fuzzy-matching-sort)
  )

(use-package helm-ag :ensure t)
(use-package helm-projectile :ensure t)

;; TODO: Get working with movement keys
(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t)
  (setq golden-ratio-exclude-modes '(ranger-mode))
  (setq golden-ratio-extra-commands '(evil-window-left
                                      evil-window-right
                                      evil-window-up
                                      evil-window-down
                                      'winum-select-window-1
                                      'winum-select-window-2
                                      'winum-select-window-3
                                      'winum-select-window-4
                                      'winum-select-window-5
                                      'winum-select-window-6)))

;; TODO Prevent esc from exiting ivy
(use-package winum
  :ensure t
  :config
  (winum-mode)) 

(use-package company
  :ensure t
  :config
  (company-mode 1)
  (add-hook 'after-init-hook 'global-company-mode))

;;;;;;;;;;;;;;;;;
;; Source Control
;;;;;;;;;;;;;;;;;
(use-package magit :ensure t)
(use-package evil-magit
  :ensure t
  :requires magit)

(use-package spacemacs-theme
  :pin "melpa-unstable"
  :defer t ;; Does not require
  :ensure t
  :init (load-theme 'spacemacs-dark t)
  :config
  (spacemacs-theme-org-highlight t))

(require 'init-keymaps)
