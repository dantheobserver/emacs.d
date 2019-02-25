(use-package hydra
  :load-path "site-lisp/hydra"
  :config	
  (defhydra hydra-buffer-menu (:color red :columns 3)
    ("n" next-buffer "next buffer")
    ("p" previous-buffer "next buffer")
    ("D" kill-this-buffer "kill buffer")
    ("+" text-scale-increase "zoom inc")
    ("_" text-scale-decrease "zoom dec")
    ("0" (text-scale-set 0) "zoom reset"))

  (defhydra hydra-eyebrowse-nav (:hint nil)
    "
_n_: next            _0_: window config 0   _6_: window config 6   _q_:quit
_p_: prev            _1_: window config 1   _7_: window config 7
_l_: last            _2_: window config 2   _8_: window config 8
_c_: create config   _3_: window config 3   _9_: window config 9
_D_: delete config   _4_: window config 4
_r_: rename config   _5_: window config 5
"
    ("n" eyebrowse-next-window-config)
    ("p" eyebrowse-prev-window-config)
    ("l" eyebrowse-last-window-config)

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

    ("q" nil :color blue))

  (defhydra hydra-perspective (:hint nil)
    "
^Perspectives^                            ^Buffers^
------------------------------------------------------------------
_s_ switch                                _k_ persp-remove-buffer
_c_ persp-kill                            _a_ persp-add-buffer
_r_ persp-rename                          _A_ persp-set-buffer
_n_ switch to next perspective		  _i_ persp-import
_p_ switch to previous perspective
"
    ("s" persp-switch)
    ("k" persp-remove-buffer)
    ("c" persp-kill )
    ("r" persp-rename)
    ("a" persp-add-buffer)
    ("A" persp-set-buffer)
    ("i" persp-import)
    ("n" persp-next)
    ("p" persp-prev)
    ("q" nil :color blue))

  ;; s -- persp-switch: query a perspective to switch or create
  ;; k -- persp-remove-buffer: query a buffer to remove from current perspective
  ;; c -- persp-kill : query a perspective to kill
  ;; r -- persp-rename: rename current perspective
  ;; a -- persp-add-buffer: query an open buffer to add to current perspective
  ;; a -- persp-set-buffer: add buffer to current perspective and remove it from all others
  ;; i -- persp-import: import a given perspective from another frame.
  ;; n, <right> -- persp-next : switch to next perspective
  ;; p, <left> -- persp-prev: switch to previous perspective

  )

(provide 'init-hydras)
