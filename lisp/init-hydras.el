(use-package hydra
  :load-path "site-lisp/hydra")

(defhydra hydra-buffer-menu (:color red :columns 3)
  ("n" next-buffer "next buffer")
  ("p" previous-buffer "next buffer")
  ("D" kill-this-buffer "kill buffer")
  ("+" text-scale-increase "zoom inc")
  ("_" text-scale-decrease "zoom dec")
  ("0" (text-scale-set 0) "zoom reset"))

(defhydra hydra-eyebrowse-nav (:color blue :columns 3)
  "
^Nav^                ^manage^            
^^^^^^^----------------------------------
_n_: next            _c_: create config
_p_: prev            _D_: delete config
_l_: last            _r_: rename config
"
  ("c" eyebrowse-create-window-config "create window-config")
  ("D" eyebrowse-close-window-config "delete window-config" :color red)
  ("n" eyebrowse-next-window-config "next window-config" :color red)
  ("p" eyebrowse-prev-window-config "previous window-config" :color red)
  ("l" eyebrowse-last-window-config "last window-config" :color red)
  ("r" eyebrowse-rename-window-config "rename window-config")
  ("0" eyebrowse-switch-to-window-config-0 "window-config-0")
  ("1" eyebrowse-switch-to-window-config-1 "window-config-1")
  ("2" eyebrowse-switch-to-window-config-2 "window-config-2")
  ("3" eyebrowse-switch-to-window-config-3 "window-config-3")
  ("4" eyebrowse-switch-to-window-config-4 "window-config-4")
  ("5" eyebrowse-switch-to-window-config-5 "window-config-5")
  ("q" nil "cancel"))

(provide 'init-hydras)
