(use-package general
  :ensure t
  :config
  (general-define-key
   :keymaps 'visual
   "s" 'evil-surround-region)

  (general-define-key
   :keymaps 'normal
   "ESC" 'keyboard-escape-quit)

  (general-define-key
   :keymaps 'motion
   ";" 'evil-ex
   ":" 'evil-repeat-find-char
   "C-u" 'evil-scroll-up)

  (general-define-key
    :keymaps '(normal visual insert emacs)
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
    
    ;;emacs
    "fe" '(:ignore t :which-key "emacs")
    "er" (lambda () (load-file "~/.emacs.d/init.el"))
    
    ;; buffers
    "b" '(:ignore t :which-key "buffers")
    "bp" 'previous-buffer
    "bn" 'next-buffer
    "bd" 'kill-this-buffer
    
    ;   ;; projects
    ;   "p" '(:ignore t :which-key "projects")
    ;   "ph" 'helm-projectile
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
    ;   ;; Applications
    ;   "a" '(:ignore t :which-key "Applications")
    ;   "ar" 'ranger
    ;
    ;   ;; Git
    ;   "g" '(:ignore t :which-key "Magit")
    ;   "gs" 'magit-status
    ;
    ;   ;; ivy
    ;   "s"  '(:ignore t :which-key "ivy")
    ;   "ss" 'swiper
    ;   "sr" 'helm-resume
    ;
    ;   ;; quit and close
    "q" '(:ignore t :which-key "quit")
    "qq" '(save-buffers-kill-terminal :which-key "save & quit")
  ))

(provide 'init-keymaps)
