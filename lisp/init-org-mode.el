(with-eval-after-load 'org
  (add-hook 'org-mode-hook 'visual-line-mode)
  ;; (evil-define-key 'normal ' "J" #'evil-join)
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
				 (file+headline "~/gtd/todo.org" "Tasks")
				 "* TODO %i%?")
				("j" "journal" entry
				 (file+headline "~/gtd/journal.org" "Tickler")
				 "* %i%? \n %U"))))

(use-package org-roam
  :ensure t
  :pin "melpa-stable"
  :init
  (add-to-list 'exec-path "/usr/bin/sqlite3")
  :config
  (setq org-roam-directory "~/org-roam")
  (add-hook 'after-init-hook 'org-roam-mode)
  (setq org-roam-completion-system 'ivy))

;; (use-package deft
;;   :ensure t)

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "○" "✸" "✿"))
  (setq org-agenda-files '("~/gtd/inbox.org"
                           "~/gtd/gtd.org"
                           "~/gtd/tickler.org")))

(use-package org-pomodoro :ensure t)

(use-package emojify
  :ensure t
  :hook (org-mode . emojify-mode))

(provide 'init-org-mode)
