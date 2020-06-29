(use-package hydra
  :load-path "site-lisp/hydra")

(defhydra hydra-buffer-menu (:color red :columns 3)
  ("n" next-buffer "next buffer")
  ("p" previous-buffer "next buffer")
  ("D" kill-this-buffer "kill buffer")
  ("+" text-scale-increase "zoom inc")
  ("_" text-scale-decrease "zoom dec")
  ("0" (text-scale-set 0) "zoom reset"))

(defhydra hydra-window (:hint nil)
  "
Movement^^         ^Split^           ^Switch^           ^misc^
----------------------------------------------------------------
^_h_ ←^           ^_v_ertical^	       ^_b_uffer^       ^max_i_mi^ze
^_j_ ↓^           ^_x_ horizontal^     ^_f_ind files^   ^_z_ Undo^
^_k_ ↑^                            ^^^^^_a_ce 1^        ^_Z_ Redo^
^_l_ →^                            ^^^^^_s_wap^
^_F_ollow^        ^_D_lt Other^        ^_S_ave^
^_SPC_ cancel^    ^_o_nl^y this        ^_d_elete^
"
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ;; ("q" hydra-move-splitter-left)
  ;; ("w" hydra-move-splitter-down)
  ;; ("e" hydra-move-splitter-up)
  ;; ("r" hydra-move-splitter-right)
  ("b" ivy-switch-buffer-map)
  ("f" helm-find-files)
  ("F" follow-mode)
  ("a" (lambda ()
         (interactive)
         (ace-window 1)
         (add-hook 'ace-window-end-once-hook
                   'hydra-window/body)))
  ("v" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)))
  ("x" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)))
  ("s" (lambda ()
         (interactive)
         (ace-window 4)
         (add-hook 'ace-window-end-once-hook
                   'hydra-window/body)))
  ("S" save-buffer)
  ("d" delete-window)
  ("D" (lambda ()
         (interactive)
         (ace-window 16)
         (add-hook 'ace-window-end-once-hook
                   'hydra-window/body)))
  ("o" delete-other-windows)
  ("i" ace-maximize-window)
  ("z" (progn
         (winner-undo)
         (setq this-command 'winner-undo)))
  ("Z" winner-redo)
  ("SPC" nil))

(provide 'init-hydras)
