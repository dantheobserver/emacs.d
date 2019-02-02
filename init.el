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
(require 'init-keymaps)

(utils|use-package-enable which-key
  (setq-default which-key-idle-delay 0.2))

;;;;;;;;;;
;; Evil ;;
;;;;;;;;;;
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (setq evil-want-minibuffer t)
  (global-set-key (kbd "C-u") 'evil-scroll-up))

(use-package evil-escape
  :ensure t
  :requires evil
  :config
  (evil-escape-mode 1)
  (setq-default evil-escape-delay 0.4)
  (setq-default evil-escape-key-sequence "fd"))

(use-package evil-cleverparens
  :ensure t
  :config
  (add-hook 'clojure-mode #'evil-cleverparens-mode)
  (add-hook 'clojurescript-mode #'evil-cleverparens-mode)
  (add-hook 'elisp-mode #'evil-cleverparens-mode)
  (setq evil-move-beyond t))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;;;;;;;;;;;;;;;;
;; Navigation ;;
;;;;;;;;;;;;;;;;

(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (define-key counsel-find-file-map (kbd "C-h") 'counsel-up-directory)
  (define-key counsel-find-file-map (kbd "C-l") 'counsel-down-directory)
  (define-key counsel-mode-map (kbd "C-j") 'ivy-next-line)
  (define-key counsel-mode-map (kbd "C-k") 'ivy-previous-line)
  (add-to-list 'ivy-initial-inputs-alist '(counsel-M-x . ""))
  (add-to-list 'ivy-initial-inputs-alist '(counsel-desribe-function . ""))
  (add-to-list 'ivy-initial-inputs-alist '(counsel-describe-variable . ""))
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

;; TODO: Get working with movement keys
(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale nil)
  (setq golden-ratio-exclude-modes '(ranger-mode))
  (setq golden-ratio-extra-commands '(evil-window-left
                                      evil-window-right
                                      evil-window-up
                                      evil-window-down
                                      winum-select-window-1
                                      winum-select-window-2
                                      winum-select-window-3
                                      winum-select-window-4
                                      winum-select-window-5
                                      winum-select-window-6
				      keyboard-quit
				      quit-window)))

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

;;TODO Better organization required
;;Maybe have the keymaps be function blocks
;;to be called in init.el
;;(require 'init-keymaps)
