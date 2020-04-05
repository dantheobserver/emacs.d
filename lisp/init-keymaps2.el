;; use definers for keymaps
(require 'utils)

;; Prefix Definitions
(general-create-definer global-leader-def
  :prefix "SPC"
  :non-normal-prefix "M-SPC")

(general-create-definer minor-mode-keymap
  :prefix ",")

(general-create-definer app-prefix
  :prefix "SPC a")


;; Global definitions
(general-def 'motion 'override
  ";" 'evil-ex
  ":" 'evil-repeat-find-char)

;; Add bindings to prefixes
(global-leader-def
  :states 'normal
  :keymaps 'override)

(comment 
 (general-create-definer my-leader-def
   ;; :keymaps 'clojure-mode-map ;;can include modes
   ;; :prefix my-leader
   ;; or without a variable
   :prefix "C-c")

 (my-leader-def
  "a" 'org-agenda
  "b" 'counsel-bookmark
  "c" 'org-capture))
