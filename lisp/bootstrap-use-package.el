;;Initialize Package
(require 'package)
(setq
 package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ;; ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

(setq package-archive-priorities
      '(("melpa" . 50)
	("melpa-stable" . 0)
        ("gnu" . 10)))
;;(add-to-list 'package-pinned-packages '(use-package . "melpa-unstable") t)
;;(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

(package-initialize) ; guess what this one does ?

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(eval-when-compile
  (require 'use-package))

(require 'bind-key)

(setq use-package-always-ensure t)
;; (require 'use-package) ; guess what this one does too ?

(provide 'bootstrap-use-package)
