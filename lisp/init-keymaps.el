(require 'utils)
(require 'init-hydras)

(defmacro ilambda (spec arrow &rest body)
  (declare (indent 2))
  (if (eq arrow '=>)
      `(lambda (,@args)
	 ,@body)))

(use-package general
  :ensure t
  :init
  (add-to-list 'general-keymap-aliases '(elisp . emacs-lisp-mode-map))
  (add-to-list 'general-keymap-aliases '(miracle . miracle-mode-map))
  (add-to-list 'general-keymap-aliases '(miracle-interaction. miracle-interaction-mode-map))
  (add-to-list 'general-keymap-aliases '(clj . clojure-mode-map))
  (add-to-list 'general-keymap-aliases '(cljs . clojurescript-mode-map))
  (add-to-list 'general-keymap-aliases '(cider . cider-mode-map))
  (add-to-list 'general-keymap-aliases '(ielm . ielm-map))
  (add-to-list 'general-keymap-aliases '(cider-repl . cider-repl-mode-map))
  (add-to-list 'general-keymap-aliases '(cider-doc . cider-doc-mode-map))
  (add-to-list 'general-keymap-aliases '(racket . racket-mode-map))
  (add-to-list 'general-keymap-aliases '(racket-repl . racket-repl-mode-map))
  (add-to-list 'general-keymap-aliases '(clj-stacktrace . cider-stacktrace-mode-map))
  (add-to-list 'general-keymap-aliases '(help . help-mode-map))
  (add-to-list 'general-keymap-aliases '(global . global-map))
  (add-to-list 'general-keymap-aliases '(evil-org . evil-org-mode-map))

  :config
  (general-evil-define-key '(normal visual motion) 'override
    ;;"ESC" 'keyboard-escape-quit
    "M-x" 'counsel-M-x
    "C-;" 'evil-iedit-state/iedit-mode
    "C-'" 'eyebrowse-last-window-config
    "C-:"'yas-insert-snippet
    "M-u" 'revert-buffer)

  (general-evil-define-key '(normal instert motion emacs) 'ielm
    "C-j" 'comint-next-input
    "C-k" 'comint-previous-input)

  (general-evil-define-key '(motion insert) 'minibuffer-local-map
    "C-y" 'evil-paste-after)

  (general-define-key
   :keymaps
   'ivy-minibuffer-map
   "TAB" 'ivy-call)

  ;; ==visual state==
  (general-define-key
   :states 'visual
   "s" 'evil-surround-region)

  ;; ==motion state==
  (general-define-key
   :states '(motion)
   ";" 'evil-ex
   ":" 'evil-repeat-find-char
   "C-u" 'evil-scroll-up)

  ;; ==global==
  (general-evil-define-key 'insert '(minibuffer-inactive-mode-map evil-ex-map override)
    "C-SPC" 'company-complete
    "C-h" 'counsel-up-directory
    "C-l" 'counsel-down-directory
    "C-j" 'ivy-next-line
    "C-k" 'ivy-previous-line
    "C-c C-o" 'ivy-occur)

  (general-evil-define-key 'normal 'evil-org
    "H" 'org-shiftleft
    "J" 'org-shiftdown
    "K" 'org-shiftup
    "L" 'org-shiftright
    "TAB" 'org-cycle)

  (general-evil-define-key 'normal 'evil-org
    :prefix ","
    "c" '(:ignore t :which-key "clock")
    "ci" 'org-clock-in
    "co" 'org-clock-out
    "cc" 'org-clock-cancel
    "cd" 'org-clock-display

    "p" '(:ignore t :which-key "pomodoro")
    "pp" 'org-pomodoro
    "pk" 'org-pomodoro-kill
    )

  ;; ==company==
  (general-define-key
   :keymaps '(company-active-map override)
   "C-j" 'company-select-next
   "C-k" 'company-select-previous
   "C-w" 'company-filter-candidates)

  ;; ==stacktrace==

  (general-evil-define-key 'normal '(clj-stacktrace
				     cider-test-report-mode-map)
    "q" 'quit-window)

  ;; ==text-mode==
  ;; (general-evil-define-key 'normal 'text-mode-map
  ;;   :prefix
  ;;   ","
  ;;   "," 'with-editor-finish
  ;;   "a" 'with-editor-cancel)
  
  ;; (general-define-key
  ;;  :states 'normal
  ;;  "ESC" 'keyboard-escape-quit)

  (defun eval-and-run-tests (type)
    ;; (if (file-exists-p "test-helper.el")
    ;; 	(load "test-helper.el"))
    (eval-buffer)
    (ert type))

  (general-evil-define-key '(normal visual emacs) elisp
    :prefix ","
    "e" '(:ignore t :which-key "eval")
    "eb" 'eval-buffer
    ;; "ee" 'eval-last-sexp
    "ee" 'evil-adjust-eval-last-sexp
    "ef" 'eval-defun
    "ep" 'eval-print-last-sexp
    "er" 'eval-region

    "d" '(:ignore t :which-key "debug")
    "di" 'edebug-instrument-function
    "df" 'edebug-defun
    "db" 'edebug-set-breakpoint

    "p" '(:ignore t :which-key "pretty-print")
    "pe" 'pp-macroexpand-expression
    "pl" 'pp-macroexpand-last-sexp
    
    "t" '(:ignore t :which-key "test")
    "tt" '((lambda () (interactive) (eval-and-run-tests t)) :which-key "cider-test-run-tests")
    "tf" '((lambda () (interactive) (eval-and-run-tests :failed)) :which-key "run failed tests"))

  (general-evil-define-key 'normal '(clj cljs elisp racket)
    "C-k" 'kill-sexp
    "C-S-k" 'kill-line)

  ;; ==Racket==
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

  (general-evil-define-key 'motion 'cider-repl
    "C-j" 'cider-repl-next-input
    "C-k" 'cider-repl-previous-input
    "C-c C-o" 'cider-repl-clear-buffer
    "RET" 'cider-repl-newline-and-indent) 

  (general-evil-define-key 'insert 'cider-repl
    "RET" 'cider-repl-newline-and-indent
    "C-RET" 'cider-eval)

  (general-evil-define-key 'motion 'cider-repl
    :prefix ","
    "," 'cider-repl-handle-shortcut
    "s" '(:ignore t :which-key "switch")
    "ss" 'cider-switch-to-last-clojure-buffer
    ;; "C-RET" 'cider-repl-newline-and-indent
    ) 

  (general-evil-define-key '(normal visual motion) '(miracle-interaction)
    :prefix ","
    "," 'miracle-interrupt
    "r" 'miracle-switch-to-repl

    "e" '(:ignore t :which-key "eval")
    "ee" 'miracle-eval-expression-at-point 
    "er" 'miracle-eval-region
    "eb" 'miracle-eval-buffer
    "ef" 'miracle-eval-defun
    "en" 'miracle-eval-namespace

    "j" 'miracle-jump)

  (defun user/cider-eval-and-run-tests ()
    (interactive)
    (cider-eval-buffer)
    (cider-test-run-test))

  (general-evil-define-key '(normal visual motion) '(clj cljs)
    :prefix ","
    "'" 'cider-jack-in
    ";" 'miracle
    "." 'cider-interrupt
    "\"" 'cider-jack-in-clojurescript

    "bc" 'cider-repl-clear-buffer
    "d" '(:ignore t :which-key "debug")
    "df" 'cider-debug-defun-at-point

    "e" '(:ignore t :which-key "eval")
    "eb" 'cider-eval-buffer
    "ec" 'cider-eval-last-sexp-in-context
    "eC" '((lambda ()
	     (interactive)
	     (setq cider-previous-eval-context nil)
	     (cider-eval-last-sexp-in-context))
	   :which-key "cider-eval-last-sexp-in-context (clear)")
    "ee" 'cider-eval-last-sexp
    "ef" 'cider-eval-defun-at-point
    "en" 'cider-eval-ns-form
    "ep" 'cider-eval-print-last-sexp
    "er" 'cider-eval-region
    "es" 'cider-eval-sexp-at-point
    "eu" 'cider-undef
    "ew" 'cider-eval-last-sexp-and-replace
    "e." 'cider-read-and-eval-defun-at-point
    "ez" 'cider-eval-defun-up-to-point

    "f" '(:ignore t :which-key "format")
    "fb" 'cider-format-buffer
    "ff" 'cider-format-defun
    "fr" 'cider-format-region

    "h" '(:ignore t :which-key "help")
    "ha" 'cider-apropos
    "hh" 'cider-doc
    "he" 'cider-apropos-documentation-select
    "hf" 'cider-apropos-documentation
    "hj" 'cider-javadoc
    "hg" 'cider-grimoire
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

    ;; "r" '(:ignore t :which-key "refactor")
    "r" 'hydra-cljr-code-menu/hydra-cljr-help-menu/body-and-exit

    "s" '(:ignore t :which-key "repl")
    "sn" 'cider-repl-set-ns
    "sc" 'cider-connect-clj
    "sC" 'cider-connect-cljs
    "ss" 'cider-switch-to-repl-buffer
    "sp" 'cider-pprint-eval-last-sexp
    "sr" 'cider-restart
    "sq" 'cider-quit

    "t" '(:ignore t :which-key "test")
    "tb" 'cider-test-show-report
    "tg" 'cider-test-rerun-test
    "tl" 'cider-test-run-loaded-tests
    "tn" 'cider-test-run-ns-tests
    "tp" 'cider-test-run-project-tests
    "tr" 'cider-test-rerun-failed-tests
    "ts" 'cider-test-run-ns-tests-with-filters
    "tt" 'user/cider-eval-and-run-tests

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
    ;; C-c M-s		cider-selector
    ;; C-c M-z		cider-load-buffer-and-switch-to-repl-buffer

    ;; C-c M-n b	cider-browse-ns
    ;; C-c M-n e	cider-eval-ns-form
    ;; C-c M-n f	cider-find-ns
    ;; C-c M-n l	cider-ns-reload
    ;; C-c M-n n	cider-repl-set-ns
    ;; C-c M-n r	cider-ns-refresh

    ;; C-c M-t n	cider-toggle-trace-ns
    ;; C-c M-t v	cider-toggle-trace-var
    )

  (general-evil-define-key '(normal visual) 'wdired-mode-map
    :prefix ","
    "," 'wdired-finish-edit
    "a" 'wdired-abort-changes
    )

  (general-evil-define-key '(normal visual emacs) 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    ;; ==simple command==
    "u" 'universal-argument
    "/" 'counsel-rg
    "." 'ivy-resume
    ";" 'hydra-window/body
    "`" 'previous-multiframe-window
    "TAB" '(evil-switch-to-windows-last-buffer :which-key "prev buffer")
    "SPC" 'counsel-M-x
    "1" 'winum-select-window-1
    "2" 'winum-select-window-2
    "3" 'winum-select-window-3
    "4" 'winum-select-window-4
    "5" 'winum-select-window-5
    "6" 'winum-select-window-6
    "u" 'universal-argument

    ;; ==apps==
    "a" '(:ignore t :which-key "apps")
    "au" 'undo-tree-visualize
    "as" '(:ignore t :which-key "server")
    "ass" 'edit-server-start
    "asq" 'edit-server-done
    "asa" 'edit-server-abort
    
    ;; ==ring/resume==
    "r" '(:ignore t :which-key "ring/resumed")
    "rl" 'ivy-resume
    "ry" 'counsel-yank-pop
    
    ;; ==search==
    "s" '(:ignore t :which-key "search")
    "sb" 'counsel-bookmark
    "ss" 'counsel-grep-or-swiper
    "sS" (utils//wkbinding "swiper"
	   (let ((initial (if (region-active-p)
			      (buffer-substring-no-properties (region-beginning) (region-end))
			    (word-at-point))))
	     (counsel-grep-or-swiper initial)))
    "sa" 'swiper-avy
    "sh" (utils//wkbinding "search headers"
	   (swiper "^.*;;.?==.*"))

    ;; ==layouts==
    "l" 'hydra-eyebrowse-nav/body

    ;; ==layouts==
    "o" '(:ignore t :which-key "orgmode")
    "oa" 'org-agenda
    "oc" 'org-capture
    "or" 'org-refile

    ;; ==window==
    "w" '(:ignore t :which-key "window")
    "wa" 'ace-swap-window
    "wm" 'utils//maximize-restore-window
    "wd" 'delete-window
    "ws" 'split-window-below
    "wS" 'utils//split-window-below-and-focus
    "wv" 'split-window-right
    "wV" 'utils//split-window-right-and-focus
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
    "fR" (utils//wkbinding "rename-file"
	   (let ((filename (buffer-file-name)))
	     (rename-file filename
			  (read-file-name
			   (format "rename file %s to :" filename)))))
    "ff" 'counsel-find-file
    "fF" 'counsel-git
    "fg" 'counsel-git
    "fX" 'delete-file
    "ft" 'neotree-show
    "fp" 'neotree-projectile-action

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
    "bl" 'electric-buffer-list

    ;; ==projects==
    "p" '(:ignore t :which-key "projects")
    "pf" 'counsel-projectile-find-file
    "pF" 'projectile-find-file-dwim
    "pp" 'counsel-projectile-switch-project
    "pI" 'projectile-invalidate-cache

    ;; ==comment==
    "c" '(:ignore t :which-key "comment")
    "cl" '(utils//comment-line :which-key "comment-line")
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
    "ih" 'utils/code-header

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

    ;; ==text/toggle/themes==
    "t" '(:ignore t :which-key "text")
    "ts" 'counsel-load-theme

    ;; ==transpose==
    "tt" '(:ignore t :which-key "transpose")
    "ttw" 'transpose-words
    "ttc" 'transpose-chars
    "ttl" 'transpose-lines
    "ttp" 'transpose-paragraphs
    "tts" 'transpose-sexps)
  

  (provide 'init-keymaps))
