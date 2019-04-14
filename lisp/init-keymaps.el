(require 'utils)
(require 'init-hydras)

(use-package general
  :ensure t
  :init
  (add-to-list 'general-keymap-aliases '(elisp . emacs-lisp-mode-map))
  (add-to-list 'general-keymap-aliases '(clj . clojure-mode-map))
  (add-to-list 'general-keymap-aliases '(cljs . clojurescript-mode-map))
  (add-to-list 'general-keymap-aliases '(cider . cider-mode-map))
  (add-to-list 'general-keymap-aliases '(cider-repl . cider-repl-mode-map))
  (add-to-list 'general-keymap-aliases '(cider-doc . cider-doc-mode-map))
  (add-to-list 'general-keymap-aliases '(racket . racket-mode-map))
  (add-to-list 'general-keymap-aliases '(racket-repl . racket-repl-mode-map))
  (add-to-list 'general-keymap-aliases '(clj-stacktrace . cider-stacktrace-mode-map))
  (add-to-list 'general-keymap-aliases '(help . help-mode-map))
  (add-to-list 'general-keymap-aliases '(global . global-map))

  :config
  (general-define-key
   "M-x" 'counsel-M-x
   "C-;" 'iedit-mode
   "C-'" 'hydra-eyebrowse-nav/body
   "C-:" 'yas-insert-snippet)

  ;;*visual state
  (general-define-key
   :states 'visual
   "s" 'evil-surround-region)

  ;;*motion state
  (general-define-key
   :states 'motion
   ";" 'evil-ex
   ":" 'evil-repeat-find-char
   "C-u" 'evil-scroll-up)

  (general-define-key
   :keymaps 'special-mode-map)

  ;;*global
  (general-evil-define-key 'insert '(global minibuffer-inactive-mode-map)
    "C-SPC" 'company-complete
    "C-h" 'counsel-up-directory
    "C-l" 'counsel-down-directory
    "C-j" 'ivy-next-line
    "C-k" 'ivy-previous-line
    "C-c C-o" 'ivy-occur)

  ;;*company
  (general-define-key
   :keymaps 'company-active-map
   "C-j" 'company-select-next
   "C-k" 'company-select-previous)

  ;;*stacktrace

  (general-evil-define-key 'normal 'clj-stacktrace
    "q" 'quit-window)

  ;;*text-mode
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
    "ef" 'eval-defun
    "ep" 'eval-print-last-sexp

    "d" '(:ignore t :which-key "debug")
    "di" 'edebug-instrument-function
    "df" 'edebug-defun
    "db" 'edebug-set-breakpoint

    "p" '(:ignore t :which-key "pretty-print")
    "pe" 'pp-macroexpand-expression
    "pl" 'pp-macroexpand-last-sexp)

  (general-evil-define-key 'normal '(clj cljs elisp racket)
    "C-k" 'kill-sexp
    "C-S-k" 'kill-line)

  ;;*clojure-mode
  ;; (general-evil-define-key '(normal visual emacs) '(clj cljs)
  ;;   :prefix ","
  ;;   "'" 'cider-jack-in
  ;;   "\"" 'cider-jack-in-clojurescript

  ;;   "e" '(:ignore t :which-key "eval")
  ;;   "eb" 'cider-eval-buffer
  ;;   "ee" 'cider-eval-last-sexp
  ;;   "ef" 'cider-eval-defun-at-point
  ;;   "er" 'cider-eval-region

  ;;   "h" '(:ignore t :which-key "help")
  ;;   "hh" 'cider-doc

  ;;   "s" '(:ignore t :which-key "repl")
  ;;   "sn" 'cider-repl-set-ns
  ;;   "ss" 'cider-switch-to-repl-buffer

  ;;   "d" '(:ignore t :which-key "debug")
  ;;   "df" 'cider-debug-defun-at-point)

  ;;*Racket
  (general-evil-define-key '(normal visual emacs) 'racket
    :prefix ","
    "r" 'racket-run
    "e" 'racket-eval-last-sexp)

  (general-evil-define-key '(normal insert emacs) 'racket-repl
    "C-k" 'comint-previous-input
    "C-j" 'comint-next-input
    "C-l" 'racket-repl-submit)

  (general-evil-define-key '(normal visual emacs) 'racket-repl-mode
    "C-k" 'previous-history-element
    "C-j" 'next-history-element)

  (general-evil-define-key '(normal visual emacs) 'cider
    :prefix ","
    "'" 'cider-jack-in
    "." 'cider-interrupt
    "\"" 'cider-jack-in-clojurescript

    "d" '(:ignore t :which-key "debug")
    "df" 'cider-debug-defun-at-point

    "e" '(:ignore t :which-key "eval")
    "eb" 'cider-eval-buffer
    "ec" 'cider-eval-last-sexp-in-context
    "ee" 'cider-eval-last-sexp
    "ef" 'cider-eval-defun-at-point
    "en" 'cider-eval-ns-form
    "ep" 'cider-eval-sexp-at-point-in-context
    "er" 'cider-eval-region
    "es" 'cider-eval-sexp-at-point
    "eu" 'cider-undef
    "ew" 'cider-eval-last-sexp-and-replace
    "e." 'cider-read-and-eval-defun-at-point
    "ez" 'cider-eval-defun-up-to-point

    "h" '(:ignore t :which-key "help")
    "ha" 'cider-apropos
    "hd" 'cider-doc
    "he" 'cider-apropos-documentation-select
    "hf" 'cider-apropos-documentation
    "hj" 'cider-javadoc
    "hr" 'cider-grimoire
    "hs" 'cider-apropos-select
    "hw" 'cider-grimoire-web

    "i" '(:ignore t :which-key "insert")
    "id" 'cider-insert-defun-in-repl
    "ie" 'cider-insert-last-sexp-in-repl
    "in" 'cider-insert-ns-form-in-repl
    "ir" 'cider-insert-region-in-repl

    "m" '(:ignore t :which-key "macro")
    "mm" 'cider-macroexpand-1
    "ma" 'cider-macroexpand-all

    "s" '(:ignore t :which-key "repl")
    "sn" 'cider-repl-set-ns
    "ss" 'cider-switch-to-repl-buffer

    "t" '(:ignore t :which-key "test")
    "tb" 'cider-test-show-report
    "tg" 'cider-test-rerun-test
    "tl" 'cider-test-run-loaded-tests
    "tn" 'cider-test-run-ns-tests
    "tp" 'cider-test-run-project-tests
    "tr" 'cider-test-rerun-failed-tests
    "ts" 'cider-test-run-ns-tests-with-filters
    "tt" 'cider-test-run-test

    ;; C-c C-.		cider-find-ns
    ;; C-c C-:		cider-find-keyword
    ;; C-c C-=		cider-profile-map

    ;; C-c C-M-l	cider-load-all-files
    ;; C-c M-.		cider-find-resource
    ;; C-c M-:		cider-read-and-eval
    ;; C-c M-;		cider-eval-defun-to-comment
    ;; C-c M-d		cider-describe-connection
    ;; C-c M-e		cider-eval-last-sexp-to-repl
    ;; C-c M-i		cider-inspect
    ;; C-c M-n		cider-ns-map
    ;; C-c M-p		cider-insert-last-sexp-in-repl
    ;; C-c M-r		cider-restart
    ;; C-c M-s		cider-selector
    ;; C-c M-t		Prefix Command
    ;; C-c M-z		cider-load-buffer-and-switch-to-repl-buffer

    ;; C-c M-n ESC	Prefix Command
    ;; C-c M-n b	cider-browse-ns
    ;; C-c M-n e	cider-eval-ns-form
    ;; C-c M-n f	cider-find-ns
    ;; C-c M-n l	cider-ns-reload
    ;; C-c M-n n	cider-repl-set-ns
    ;; C-c M-n r	cider-ns-refresh

    ;; C-c M-t n	cider-toggle-trace-ns
    ;; C-c M-t v	cider-toggle-trace-var
    )

  (general-define-key
   :states '(normal visual insert emacs)
   :keymaps '(global help dired)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"

   ;; ==simple command==
   "u" 'universal-argument
   "/" 'counsel-rg
   "." 'ivy-resume
   ";" 'hydra-window/body
   "TAB" '(evil-switch-to-windows-last-buffer :which-key "prev buffer")
   "SPC" 'counsel-M-x
   "1" 'winum-select-window-1
   "2" 'winum-select-window-2
   "3" 'winum-select-window-3
   "4" 'winum-select-window-4
   "5" 'winum-select-window-5
   "6" 'winum-select-window-6
   
   ;; ==ring/resume==
   "r" '(:ignroe t :which-key "ring/resumed")
   "rl" 'ivy-resume
   "ry" 'counsel-yank-pop
   
   ;; ==search==
   "s" '(:ignore t :which-key "search")
   "ss" 'counsel-grep-or-swiper
   "sa" 'swiper-avy
   "sh" (utils//wkbinding "search headers"
	  (swiper "^.*;;.?==.*"))

   ;; ==layouts==
   "l" '(:ignore t :which-key "layouts")
   "la" 'ivy-push-view
   "ld" 'ivy-pop-view
   "ll" 'ivy-switch-view

   ;; ==layouts==
   "o" '(:ignore t :which-key "orgmode")
   "oa" 'org-agenda
   "oc" 'org-capture
   "or" 'org-refile

   ;; ==window==
   "w" '(:ignore t :which-key "window")
   "wd" 'delete-window
   "wv" 'split-window-below
   "wV" 'utils//split-window-below-and-focus
   "ws" 'split-window-right
   "wS" 'utils//split-window-right-and-focus
   "wk" 'evil-window-up
   "wj" 'evil-window-down
   "wh" 'evil-window-left
   "wl" 'evil-window-right
   "wL" 'evil-window-move-far-right
   "wH" 'evil-window-move-far-left
   "wJ" 'evil-window-move-very-bottom
   "wK" 'evil-window-move-very-top
   "wu" 'winner-undo
   "wU" 'winner-redo

   ;; ==frame==
   "F" '(:ignore t :which-key "Frames")
   "Fn" 'make-frame
   "FD" 'delete-frame
   "Fo" 'other-frame

   ;; ==files==
   "f" '(:ignore t :which-key "find")
   "f." (utils//wkbinding "dired here"
	  (dired "."))
   "fD" 'delete-file
   "fs" 'save-buffer
   "fR" 'rename-file
   "ff" 'counsel-find-file
   "fF" 'counsel-git
   "fg" 'counsel-git
   "fX" 'delete-file

   ;; ==emacs==
   "fe" '(:ignore t :which-key "emacs")
   "fei" (utils//wkbinding "open emacs init file"
	   (utils//open-config-file "init.el"))
   "fek" (utils//wkbinding "open keymaps config file"
	   (utils//open-config-file "lisp" "init-keymaps.el"))

   ;; ==buffers==
   "b" '(:ignore t :which-key "buffers")
   "b." 'hydra-buffer-menu/body
   "bb" 'ivy-switch-buffer
   "bp" 'previous-buffer
   "bn" 'next-buffer
   "bd" 'kill-this-buffer
   "bs" (utils//wkbinding "scratch-buffer"
	  (switch-to-buffer "*scratch*"))
   "bm" '(view-echo-area-messages :which-key "messages buffer")
   "bR" 'revert-buffer

   ;; ==projects==
   "p" '(:ignore t :which-key "projects")
   "pf" 'counsel-projectile-find-file
   "pp" 'counsel-projectile-switch-project

   ;; ==comment==
   "c" '(:ignore t :which-key "comment")
   "cl" 'comment-line
   "cy" (utils//wkbinding "copy-and-comment"
	  (utils//comment-and-yank))

   ;; ==help==
   "h" '(:ignore t :which-key "help")
   "hd" '(:ignore t :which-key  "describe")
   "hdm" '(describe-mode :which-key "describe mode")
   "hdf" '(describe-function :which-key "describe function")
   "hdv" '(describe-variable :which-key "describe variable")
   "hdk" '(describe-key :which-key "describe key")
   "hc" '(:ignore t :which-key "customize")

   ;;   ==customize==
   "hcv" 'customize-variable
   "hcg" 'customize-group

   ;; ==magit==
   "g" '(:ignore t :which-key "magit")
   "gs" 'magit-status

   ;; ==insert==
   "is" 'yas-insert-snippet

   ;; ==zoom==
   "z" '(:ignore t :which-key "text-zooming")
   "zk" 'text-scale-increase
   "zj" 'text-scale-decrease
   "z0" (utils//wkbinding "reset"
	  (text-scale-set 0))
   "za" 'text-scale-adjust

   ;; ==quit== 
   "q" '(:ignore t :which-key "quit")
   "qq" '(save-buffers-kill-terminal :which-key "save & quit")
   "qr" 'restart-emacs

   ;; ==text==
   "t" '(:ignore t :which-key "text")

   ;; ==transpose==
   "tt" '(:ignore t :which-key "transpose")
   "ttw" 'transpose-words
   "ttc" 'transpose-chars
   "ttl" 'transpose-lines
   "ttp" 'transpose-paragraphs
   "tts" 'transpose-sexps
   ))

(provide 'init-keymaps)
