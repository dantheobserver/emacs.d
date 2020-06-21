;; -*- lexical-binding: t -*-
(require 'utils)
(require 'init-hydras)

;; **Global Bindings (no leader)
(general-create-definer global-def
  :states '(normal visual motion)
  :keymaps 'override)

(global-def
  ;;"ESC" 'keyboard-escape-quit
  "M-x" 'counsel-M-x
  "C-;" 'evil-iedit-state/iedit-mode
  "C-'" 'eyebrowse-last-window-config
  "C-:"'yas-insert-snippet
  "M-u" 'revert-buffer)

;; **ielm
(general-create-definer ielm-def
  :states '(normal instert motion emacs)
  :keymaps 'ielm)

(ielm-def
  "C-j" 'comint-next-input
  "C-k" 'comint-previous-input)

(general-create-definer minibuffer-def
  :states '(normal motion insert)
  :keymaps 'minibuffer-local-map)
(minibuffer-def
  "C-y" 'evil-paste-after)

(general-create-definer minibuffer-def)
(general-define-key
 :keymaps 'ivy-minibuffer-map
 "TAB" 'ivy-call)

;; ==visual state==
(vmap
  "s" 'evil-surround-region)

;; ==motion state==
(mmap :keymaps 'override
  ";" 'evil-ex
  ":" 'evil-repeat-find-char
  "C-u" 'evil-scroll-up)

;; ==org==
(nmap 'evil-org
  "H" 'org-shiftleft
  "J" 'org-shiftdown
  "K" 'org-shiftup
  "L" 'org-shiftright
  "TAB" 'org-cycle)

;; ==global==
(imap 'override
  "C-SPC"'company-complete)

(general-evil-define-key '(insert normal emacs) '(ivy-minibuffer-map) 
  "C-j" 'ivy-next-line
  "C-k" 'ivy-previous-line
  "C-h" 'counsel-up-directory
  "C-l" 'counsel-down-directory)

(imap '(minibuffer-inactive-mode-map evil-ex-map)
  "C-h" 'counsel-up-directory
  "C-l" 'counsel-down-directory
  "C-c C-o" 'ivy-occur)

(general-create-definer minor-mode-def
  :prefix ","
  :non-normal-perfix "M-,")

;; ** Org Modes
(minor-mode-def 'normal 'org-mode-map
  "," #'org-ctrl-c-ctrl-c)

(minor-mode-def 'normal 'org-roam-mode-map
  :major-modes '(org-mode t)
  "f" #'org-roam-find-file
  "d" #'org-roam-find-directory
  "r" #'org-roam-find-ref
  "t" #'org-tags-view
  "B" #'org-roam-db-build-cache)

(minor-mode-def '(normal motion) 'evil-org
  :major-modes '(org-mode t)
  "a" #'org-capture
  "f" #'org-roam-find-file

  "c" '(:ignore t :which-key "clock")
  "ci" #'org-clock-in
  "co" #'org-clock-out
  "cc" #'org-clock-cancel
  "cd" #'org-clock-display

  "p" '(:ignore t :which-key "pomodoro")
  "pp" #'org-pomodoro
  "pk" #'org-pomodoro-kill

  "e" '(:ignore t :which-key "error")
  "en" #'next-error
  "ep" #'previous-error)

(minor-mode-def 'normal 'c-mode-map
  :major-modes '(c-mode t)
  "c" '(:ignore t :which-key "compile")
  "cc" #'projectile-compile-project
  "cr" #'recompile
  "ca" #'utils/gcc-autocompile-file
  "r" '(:ignore t :which-key "run")
  "rd" #'gdb)

(minor-mode-def 'normal 'with-editor-mode-map
  :major-modes '(with-editor-mode t)
  "," #'with-editor-finish
  "a" #'with-editor-cancel)

;; ==company==
(general-define-key
 :keymaps 'company-active-map
 "C-j" 'company-select-next
 "C-k" 'company-select-previous
 "C-w" 'company-filter-candidates)

;; ==stacktrace==

(general-evil-define-key 'normal '(clj-stacktrace
				   cider-test-report-mode-map)
  "q" 'quit-window)

(defun eval-and-run-tests (type)
  (eval-buffer)
  (ert type))

(general-evil-define-key '(normal visual) elisp
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

  "p" '(:ignore t :which-key "pretty-print" :major-modes 'elisp-mode)
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
  "a" 'wdired-abort-changes)

;; Leader
(general-create-definer global-leader
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  :states '(normal visual motion)
  :keymaps 'override)

(global-leader
  "u" 'universal-argument
  "l" 'hydra-eyebrowse-nav/body ;;My layout hydra
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
  "6" 'winum-select-window-6)

;; Apps Leader
(general-create-definer global-apps-leader
  :prefix "SPC a"
  :states '(normal visual motion)
  :keymaps 'override)
(global-apps-leader
  "u" 'undo-tree-visualize
  "s" '(:ignore t :which-key "server")
  "ss" 'edit-server-start
  "sq" 'edit-server-done
  "sa" 'edit-server-abort)

;; Ring/resume Leader
(general-create-definer global-ring-leader
  :prefix "SPC r"
  :states '(normal visual motion)
  :keymaps 'override)
(global-ring-leader
 "l" 'ivy-resume
 "y" 'counsel-yank-pop)

;; Search Leader
(general-create-definer global-search-leader
  :prefix "SPC s"
  :states '(normal visual motion)
  :keymaps 'override)
(global-search-leader
 "b" 'counsel-bookmark
 "s" 'counsel-grep-or-swiper
 "S" (utils//wkbinding "swiper"
       (let ((initial (if (region-active-p)
			  (buffer-substring-no-properties (region-beginning) (region-end))
			(word-at-point))))
	 (counsel-grep-or-swiper initial)))
 "a" 'swiper-avy
 "h" (utils//wkbinding "search headers"
       (swiper "^.*;;.?==.*")))

(general-create-definer global-org-leader
  :prefix "SPC o"
  :states '(normal visual motion)
  :keymaps 'override)
(global-org-leader
  "a" 'org-agenda
  "c" 'org-capture
  "e" 'org-refile
  "r" '(:ignore t :which-key "roam")
  "rf" 'org-roam-find-file
  "ri" 'org-roam-insert
  "ri" 'org-roam-find-index)

;; Window Leader
(general-create-definer global-window-leader
  :prefix "SPC w"
  :states '(normal visual motion)
  :keymaps 'override)

(global-window-leader
  "a" 'ace-swap-window
  "m" 'utils//maximize-restore-window
  "d" 'delete-window
  "s" 'split-window-below
  "S" 'utils//split-window-below-and-focus
  "v" 'split-window-right
  "V" 'utils//split-window-right-and-focus
  "k" 'evil-window-up
  "j" 'evil-window-down
  "h" 'evil-window-left
  "l" 'evil-window-right
  "L" 'evil-window-move-far-right
  "H" 'evil-window-move-far-left
  "J" 'evil-window-move-very-bottom
  "K" 'evil-window-move-very-top
  "u" 'winner-undo
  "U" 'winner-redo
  "r" 'evil-window-rotate-downwards
  "R" 'evil-window-rotate-upwards)

;; Frames Leader
(general-create-definer global-frames-leader
  :prefix "SPC F"
  :states '(normal visual motion)
  :keymaps 'override)
(global-frames-leader
 "n" 'make-frame
 "D" 'delete-frame
 "o" 'other-frame)

;; Files Leader
(general-create-definer global-files-leader
  :prefix "SPC f"
  :states '(normal visual motion)
  :keymaps 'override)
(global-files-leader
 "." (utils//wkbinding "dired here"
       (dired "."))
 "D" 'delete-file
 "s" 'save-buffer
 "R" (utils//wkbinding "rename-file"
       (let ((filename (buffer-file-name)))
	 (rename-file filename
		      (read-file-name
		       (format "rename file %s to :" filename)))))
 "f" 'counsel-find-file
 "F" 'counsel-git
 "g" 'counsel-git
 "X" 'delete-file
 "t" 'neotree-show
 "p" 'neotree-projectile-action
 
 "e" '(:ignore t :which-key "emacs")
 "ei" (utils//wkbinding "open emacs init file"
	(utils//open-config-file "init.el"))
 "ek" (utils//wkbinding "open keymaps config file"
	(utils//open-config-file "lisp" "init-keymaps.el")))

;; Buffer Leader
(general-create-definer global-buffer-leader
  :prefix "SPC b"
  :states '(normal visual motion)
  :keymaps 'override)
(global-buffer-leader
 ;; ==buffers==
 "." 'hydra-buffer-menu/body
 "b" 'ivy-switch-buffer
 "p" 'previous-buffer
 "n" 'next-buffer
 "d" 'kill-this-buffer
 "s" (utils//wkbinding "scratch-buffer"
       (switch-to-buffer "*scratch*"))
 "m" '(view-echo-area-messages :which-key "messages buffer")
 "l" 'electric-buffer-list)

;; Projectile Leader
(general-create-definer global-projectile-leader
  :prefix "SPC p"
  :states '(normal visual motion)
  :keymaps 'override)
(global-projectile-leader
 "f" 'counsel-projectile-find-file
 "F" 'projectile-find-file-dwim
 "p" 'counsel-projectile-switch-project
 "I" 'projectile-invalidate-cache
 "c" 'projectile-compile-project
 "r" 'projectile-run-project)

;; Comment Leader
(general-create-definer global-comment-leader
  :prefix "SPC c"
  :states '(normal visual motion)
  :keymaps 'override)
(global-comment-leader
 "l" '(utils//comment-line :which-key "comment-line")
 "y" (utils//wkbinding "copy-and-comment"
       (utils//comment-and-yank)))

;; Help Leader
(general-create-definer global-help-leader
  :prefix "SPC h"
  :states '(normal visual motion)
  :keymaps 'override)
(global-help-leader
 "d" '(:ignore t :which-key  "describe")
 "dm" '(describe-mode :which-key "describe mode")
 "df" '(describe-function :which-key "describe function")
 "dv" '(describe-variable :which-key "describe variable")
 "dk" '(describe-key :which-key "describe key")

 "c" '(:ignore t :which-key "customize")
 "cv" 'customize-variable
 "cg" 'customize-group)

;; Magit Leader
(general-create-definer global-git-leader
  :prefix "SPC g"
  :states '(normal visual motion)
  :keymaps 'override)
(global-git-leader
 "s" 'magit-status)


(general-create-definer global-insert-leader
  :prefix "SPC i"
  :states '(normal visual motion)
  :keymaps 'override)
(global-insert-leader
 ;; Insert Leader
 "s" 'yas-insert-snippet
 "h" 'utils/code-header)

;; Zoom Leader
(general-create-definer global-zoom-leader
  :prefix "SPC z"
  :states '(normal visual motion)
  :keymaps 'override)
(global-zoom-leader
 "k" 'text-scale-increase
 "j" 'text-scale-decrease
 "0" (utils//wkbinding "reset"
       (text-scale-set 0))
 "a" 'text-scale-adjust)

;; Quit Leader
(general-create-definer global-quit-leader
  :prefix "SPC q"
  :states '(normal visual motion)
  :keymaps 'override)

(global-quit-leader
 "q" '(save-buffers-kill-terminal :which-key "save & quit")
 "r" 'restart-emacs)

;; Theme Leader
(general-create-definer global-theme-leader
  :prefix "SPC T"
  :states '(normal visual motion)
  :keymaps 'override)
(global-theme-leader
  "ts" 'counsel-load-theme)

;; Text Leader
(general-create-definer global-text-leader
  :prefix "SPC "
  :states '(normal visual motion)
  :keymaps 'override)

(global-text-leader
 "t" '(:ignore t :which-key "transpose")
 "tw" 'transpose-words
 "tc" 'transpose-chars
 "tl" 'transpose-lines
 "tp" 'transpose-paragraphs
 "ts" 'transpose-sexps)


(provide 'init-keymaps)
