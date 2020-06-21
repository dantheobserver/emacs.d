;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (if (< (string-to-number emacs-version) 27)
;;     (package-initialize))

(defun setup//add-packages (lisp-dir)
  (dolist (package-dir (directory-files lisp-dir t "\\w+"))
    (when (file-directory-p package-dir)
      (add-to-list 'load-path package-dir)
      (add-to-list 'load-path (concat package-dir "/lisp")))))

(defun setup//load-path ()
  (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
  (setup//add-packages (expand-file-name "site-lisp" user-emacs-directory)))

(setup//load-path)

(require 'bootstrap-use-package)
(require 'init-evil-mode)
(require 'init-package-config)
(require 'init-org-mode)
(require 'init-common)
(require 'init-hydras)
(require 'init-lisps)
(require 'init-rust)
(require 'init-keymaps)
(require 'init-themes)
(require 'init-js)

;; Utilities
