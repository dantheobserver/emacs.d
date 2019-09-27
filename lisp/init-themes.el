;; (use-package spacemacs-theme
;;   :pin "melpa-unstable"
;;   :ensure t
;;   :config
;;   (spacemacs-theme-org-highlight t))

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
