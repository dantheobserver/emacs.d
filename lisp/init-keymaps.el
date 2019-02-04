(defun utils|open-init ()
  (interactive)
  (view-file "~/.emacs.d/init.el"))

(defun utils|open-emacs-directory ()
  (counsel-dired-jump "" "~/.emacs.d/"))

(use-package general
  :ensure t
  :init
  (add-to-list 'general-keymap-aliases '(elisp . emacs-lisp-mode-map)) 
  (add-to-list 'general-keymap-aliases '(clj . clojure-mode-map)) 
  (add-to-list 'general-keymap-aliases '(cljs . clojurescript-mode-map)) 
  (add-to-list 'general-keymap-aliases '(clj-stacktrace . cider-stacktrace-mode-map)) 

  :config
  (general-define-key
   :states 'visual
   "s" 'evil-surround-region)

  (general-define-key
   :states 'motion
   ";" 'evil-ex
   ":" 'evil-repeat-find-char
   "C-u" 'evil-scroll-up)

  (general-evil-define-key 'normal 'clj-stacktrace
   "q" 'quit-window)

  (general-evil-define-key 'normal 'text-mode-map
    :prefix ","
    "," 'with-editor-finish
    "a" 'with-editor-cancel)

  (general-define-key
   :states 'normal
   "ESC" 'keyboard-escape-quit)

  (general-evil-define-key '(normal visual emacs) elisp
   :prefix ","
   "e" '(:ignore t :which-key "eval")
   "eb" 'eval-buffer
   "ee" 'eval-last-sexp
   "ef" 'eval-defun)

  (general-evil-define-key '(normal visual emacs) '(clj cljs)
   :prefix ","
   "'" 'cider-jack-in
   "\"" 'cider-jack-in-clojurescript

   "e" '(:ignore t :which-key "eval")
   "eb" 'cider-eval-buffer
   "ee" 'cider-eval-last-sexp
   "ef" 'cider-eval-defun-at-point

   "s" '(:ignore t :which-key "repl")
   "ss" 'cider-switch-to-repl-buffer

   "d" '(:ignore t :which-key "debug")
   "df" 'cider-debug-defun-at-point)

  (general-define-key
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    
    ;; simple command
    "u"   'universal-argument
    "TAB" '(switch-to-other-buffer :which-key "prev buffer")
    "SPC" 'counsel-M-x
    "1" 'winum-select-window-1
    "2" 'winum-select-window-2
    "3" 'winum-select-window-3
    "4" 'winum-select-window-4
    "5" 'winum-select-window-5
    "6" 'winum-select-window-6
    
    ;;search
    "s" '(:ignore t :which-key "search")
    "ss" 'swiper
    
    ;; window
    "w" '(:ignore t :which-key "window")
    "wd" 'delete-window
    "wv" 'split-window-below
    "wV" 'split-window-below-and-focus
    "ws" 'split-window-right
    "wS" 'split-window-right-and-focus
    "wk" 'evil-window-up
    "wj" 'evil-window-down
    "wh" 'evil-window-left
    "wl" 'evil-window-right
    
    ;; files
    "f" '(:ignore t :which-key "find")
    "fD" 'dired
    "fs" 'save-buffer
    "ff" 'counsel-find-file
    "fX" 'delete-file
    
    ;;emaks
    "fe" '(:ignore t :which-key "emacs")
    "fei" 'utils|open-init
    "fed" 'utils|open-emacs-directory
    
    ;; buffers
    "b" '(:ignore t :which-key "buffers")
    "bp" 'previous-buffer
    "bn" 'next-buffer
    "bd" 'kill-this-buffer
    
      ;; projects
    "p" '(:ignore t :which-key "projects")
    "pf" 'counsel-git
    ;   "pp" 'helm-projectile-switch-project
    ;   "p/" 'helm-projectile-ag
    ;   "pb" 'helm-projectile-switch-to-buffer
    ;   "pf" 'helm-projectile-find-file
    ;   "pd" 'helm-projectile-find-dir
    ;
    
    ;;comment
    "c" '(:ignore t :which-key "comment")
    "cl" 'comment-line
    
    ;;customise
    "cv" 'customize-variable
    "cg" 'customize-group
    
    ;; help
    "h" '(:ignore t :which-key "help")
    "hd" '(:ignore t :which-key  "describe")
    "hdm" '(describe-mode :which-key "describe mode")
    "hdf" '(describe-function :which-key "describe function")
    "hdv" '(describe-variable :which-key "describe variable")
    "hdk" '(describe-key :which-key "describe key")
    "hm" '(view-echo-area-messages :which-key "messages buffer")
    "hc" '(:ignore t :which-key "customize")
    
    ;; magit
    "g" '(:ignore t :which-key "magit")
    "gs" 'magit-status

    ;; quit and close
    "q" '(:ignore t :which-key "quit")
    "qq" '(save-buffers-kill-terminal :which-key "save & quit")
  ))

(provide 'init-keymaps)
