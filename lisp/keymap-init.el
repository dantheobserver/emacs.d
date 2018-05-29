(use-package general :ensure t
  :config
  (set-frame-font "IBMPlexMono 14" nil t)
  (general-define-key
   :states 'visual
   "s" 'evil-surround-region)

  (general-define-key
   :states 'motion
   ";" 'evil-ex
   ":" 'evil-repeat-find-char
   "C-u" 'evil-scroll-up)

  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; simple command
   "u"   'universal-argument
   "'"   '(iterm-focus :which-key "iterm")
   "?"   '(iterm-goto-filedir-or-home :which-key "iterm - goto dir")
   "/"   'counsel-ag
   "TAB" '(switch-to-other-buffer :which-key "prev buffer")
   "SPC" '(counsel-M-x :which-key "M-x")
   "1" 'winum-select-window-1
   "2" 'winum-select-window-2
   "3" 'winum-select-window-3
   "4" 'winum-select-window-4
   "5" 'winum-select-window-5
   "6" 'winum-select-window-6

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

   ;; variables

   ;; files
   "f" '(:ignore t :which-key "find")
   "fs" 'save-buffer
   "ff" 'counsel-find-file
   "fl" 'counsel-find-library

   ;; projects
   "p" '(:ignore t :which-key "projects")
   "ph" 'counsel-projectile
   "pp" 'counsel-projectile-switch-project
   "p/" 'counsel-projectile-ag
   "pb" 'counsel-projectile-switch-to-buffer
   "pf" 'counsel-projectile-find-file
   "pd" 'counsel-projectile-find-dir

   ;; buffers
   "b" '(:ignore t :which-key "buffers")
   "bp" 'previous-buffer
   "bn" 'next-buffer
   "bd" 'kill-this-buffer

   ;;comment
   "c" '(:ignore t :which-key "comment")
   "cl" 'comment-line

   ;; help
   "h" '(:ignore t :which-key "help")
   "hd" '(:ignore t :which-key  "describe")
   "hdm" '(describe-mode :which-key "describe mode")
   "hdf" '(counsel-describe-function :which-key "describe function")
   "hdv" '(counsel-describe-variable :which-key "describe variable")
   "hdk" '(describe-key :which-key "describe key")
   "hm" '(view-echo-area-messages :which-key "messages buffer")
   "hc" '(:ignore t :which-key "customize")
   "cv" 'customize-variable
   "cg" 'customize-group

   ;; Applications
   "a" '(:ignore t :which-key "Applications")
   "ar" 'ranger
   "ad" 'dired

   ;; Git
   "g" '(:ignore t :which-key "Magit")
   "gs" 'magit-status

   ;; ivy
   "s"  '(:ignore t :which-key "ivy")
   "ss" 'swiper
   "sr" 'ivy-resume

   ;; quit and close
   "q" '(:ignore t :which-key "quit")
   "qq" '(save-buffers-kill-terminal :which-key "save & quit")))

(provide 'keymap-init)
