(use-package hydra
  :load-path "site-lisp/hydra")

(defhydra hydra-buffer-menu (:color red :columns 3)
  ("n" next-buffer "next buffer")
  ("p" previous-buffer "next buffer")
  ("D" kill-this-buffer "kill buffer")
  ("+" text-scale-increase "zoom inc")
  ("_" text-scale-decrease "zoom dec")
  ("0" (text-scale-set 0) "zoom reset"))

(defhydra hydra-cider-menu (:color ))

(provide 'init-hydras)
