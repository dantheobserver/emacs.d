(setq config--org-roam-dir "~/org-roam")

(with-eval-after-load 'org
  (add-hook 'org-mode-hook 'visual-line-mode)
  ;; (evil-define-key 'normal ' "J" #'evil-join)
  (setq org-agenda-window-setup 'reorganize-frame)
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
				 (file+headline "~/gtd/todo.org" "Tasks")
				 "* TODO %i%?")
				("j" "journal" entry
				 (file+headline "~/gtd/journal.org" "Tickler")
				 "* %i%? \n %U"))))

(use-package org-roam
  :ensure t
  :pin "melpa-stable"
  :hook after-init-hook
  :init
  (add-to-list 'exec-path "/usr/bin/sqlite3")
  :config
  (add-hook 'after-init-hook 'org-roam-mode)
  (add-hook 'org-mode-hook 'org-roam-backlinks-mode)
  (setq org-roam-directory config--org-roam-dir)
  (setq org-roam-completion-system 'ivy))

(use-package company-org-roam
  :ensure t
  :after '(org-roam company)
  :config
  (add-to-list 'company-backends 'company-org-roam))

(use-package org-journal
  ;; :bind
  ;; ("C-c n j" . org-journal-new-entry)
  :pin "melpa-stable"
  :config
  (setq org-journal-dir (string-join `(,config--org-roam-dir "journal")  "/"))
  (setq org-journal-date-prefix "#+TITLE: ")
  (setq org-journal-file-format "%Y-%m-%d.org")
  (setq org-journal-date-format "%A, %d %B %Y")
  (setq org-journal-enable-agenda-integration t))

;; (use-package deft
;;   :ensure t)
(use-package deft
  :after org
  :config
  (setq deft-recursive t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-default-extension "org")
  (setq deft-directory config--org-roam-dir))

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
