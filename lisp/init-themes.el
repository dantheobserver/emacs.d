(use-package ewal
  :init (setq ewal-use-built-in-always-p nil
              ewal-use-built-in-on-failure-p t
              ewal-built-in-palette "sexy-material"))

;; (use-package ewal-spacemacs-themes
;;   :init (progn
;;           (setq spacemacs-theme-underline-parens t
;;                 my:rice:font (font-spec
;;                               :family "Source Code Pro"
;;                               :weight 'semi-bold
;;                               :size 14.0))

;;           (show-paren-mode +1)
;;           (global-hl-line-mode)
;;           (set-frame-font my:rice:font nil t)
;;           (add-to-list  'default-frame-alist
;;                         `(font . ,(font-xlfd-name my:rice:font))))
;;   :config (progn
;;             (load-theme 'ewal-spacemacs-modern t)
;;             (enable-theme 'ewal-spacemacs-modern)))

;; (use-package ewal-evil-cursors
;;   :after (ewal-spacemacs-themes)
;;   :config (ewal-evil-cursors-get-colors
;;            :apply t :spaceline t))

;; (use-package spaceline
;;   :after (ewal-evil-cursors winum)
;;   :init (setq powerline-default-separator nil)
;;   :config (spaceline-spacemacs-theme))

(use-package dracula-theme
  :defer t
  :ensure t
  :config 
  (require 'dracula-theme))

(use-package color-theme-sanityinc-tomorrow
  :defer t
  :ensure t
  :config
  (require 'color-theme-sanityinc-tomorrow))

(defun pick-theme (theme)
  (nth (random (length theme))
       theme))

;; (let* ((dark-themes '(spacemacs-dark dracula-dark))
;;        (light-themes '())
;;        (both-themes (cl-concatenate 'list dark-themes light-themes)))
;;   (pick-theme both-themes)))



(provide 'init-themes)
