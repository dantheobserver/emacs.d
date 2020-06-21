(use-package eb-layout
  :load-path "~/projects/elisp/eb-layout.el/")

(use-package hydra
  :load-path "site-lisp/hydra")

(defhydra hydra-buffer-menu (:color red :columns 3)
  ("n" next-buffer "next buffer")
  ("p" previous-buffer "next buffer")
  ("D" kill-this-buffer "kill buffer")
  ("+" text-scale-increase "zoom inc")
  ("_" text-scale-decrease "zoom dec")
  ("0" (text-scale-set 0) "zoom reset"))

(defun hydra-utils//eyebrowse-list ()
  (mapcar 
   (lambda (cfg) 
     (let* ((config-num (car cfg))
	    (config-name (caddr cfg)))
       (cons config-num config-name)))
   (eyebrowse--get 'window-configs)))

(defun hydra-utils//sel-formatter (cfg-str)
  (propertize (format "[ %s ]" cfg-str)
	      'face '(bold 'warning)))

(defun hydra-utils//format-eyebrowse-config (sel-formatter-f)
  (let ((cur-slot (eyebrowse--get 'current-slot)))
    (mapcar
     (lambda (config)
       (let* ((config-idx (car config))
	      (config-name (cdr config))
	      (config-str (if (string-empty-p config-name)
			      (number-to-string config-idx)
			    (format "%s:%s" config-idx config-name))))
	 (if (eq cur-slot config-idx)
	     (concat (funcall sel-formatter-f config-str))
	   config-str)))
     (hydra-utils//eyebrowse-list))))

(defhydra hydra-eyebrowse-nav (:hint nil)
  "
    %s(string-join (hydra-utils//format-eyebrowse-config #'hydra-utils//sel-formatter) \" | \")

^^^^ _n_: _n_ext           _0_: window config _0_  _5_: window config _5_
^^^^ _p_: _p_rev           _1_: window config _1_  _6_: window config _6_
^^^^ _c_: _c_reate config  _2_: window config _2_  _7_: window config _7_
^^^^ _D_: _D_elete config  _3_: window config _3_  _8_: window config _8_
^^^^ _r_: _r_ename config  _4_: window config _4_  _9_: window config _9_
^^^^ _S_: _S_ave config    _L_: _L_oad config      _q_:_q_uit            " 
  ("n" eyebrowse-next-window-config)
  ("p" eyebrowse-prev-window-config)
  ("TAB" eyebrowse-last-window-config)
  ("c" eyebrowse-create-window-config)
  ("D" eyebrowse-close-window-config)
  ("r" eyebrowse-rename-window-config)
  ("0" eyebrowse-switch-to-window-config-0)
  ("1" eyebrowse-switch-to-window-config-1)
  ("2" eyebrowse-switch-to-window-config-2)
  ("3" eyebrowse-switch-to-window-config-3)
  ("4" eyebrowse-switch-to-window-config-4)
  ("5" eyebrowse-switch-to-window-config-5)
  ("6" eyebrowse-switch-to-window-config-6)
  ("7" eyebrowse-switch-to-window-config-7)
  ("8" eyebrowse-switch-to-window-config-8)
  ("9" eyebrowse-switch-to-window-config-9)
  ("S" ebl-save-current-layout)
  ("L" ebl-load-layout)
  ("<" ebl-move-left)
  (">" ebl-move-right)
  ("q" nil :color blue))

(hydra-set-property 'hydra-eyebrowse-nav :verbosity 1)

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
