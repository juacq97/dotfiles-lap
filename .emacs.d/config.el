(defalias 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively 100)

(global-hl-line-mode t)

(setq backup-directory-alist
      `((".*" . ,"~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/backups/")))

(tool-bar-mode -1)

(scroll-bar-mode -1)

(menu-bar-mode -1)
(global-set-key (kbd "M-m") 'menu-bar-mode) ; M-m hace aparecer el menú

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
  )
(global-set-key (kbd "C-c r") 'config-reload)

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(setq electric-pair-pairs '(
			    (?\( . ?\))
			    (?\[ . ?\])
			    (?\{ . ?\})
			    ))
(setq electric-pair-preserve-balance nil)
(electric-pair-mode)

(line-number-mode 1)
(column-number-mode 1)

(defun kill-curr-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-curr-buffer)

(global-set-key (kbd "C-c v") 'visual-line-mode)

(global-set-key (kbd "<f5>")  'ispell-word)

(when (version<= "26.0.50" emacs-version )
(global-display-line-numbers-mode))

; (setq browse-url-browser-function 'eww-browse-url)

(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode)
      :config
      ;; How tall the mode-line should be (only respected in GUI Emacs).
(setq doom-modeline-height 25)

;; How wide the mode-line bar should be (only respected in GUI Emacs).
(setq doom-modeline-bar-width 4)

;; Determines the style used by `doom-modeline-buffer-file-name'.
;;
;; Given ~/Projects/FOSS/emacs/lisp/comint.el
;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
;;   truncate-with-project => emacs/l/comint.el
;;   truncate-except-project => ~/P/F/emacs/l/comint.el
;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
;;   truncate-all => ~/P/F/e/l/comint.el
;;   relative-from-project => emacs/lisp/comint.el
;;   relative-to-project => lisp/comint.el
;;   file-name => comint.el
;;   buffer-name => comint.el<2> (uniquify buffer name)
;;
;; If you are expereicing the laggy issue, especially while editing remote files
;; with tramp, please try `file-name' style.
;; Please refer to https://github.com/bbatsov/projectile/issues/657.
(setq doom-modeline-buffer-file-name-style 'truncate-upto-project)

;; Whether show `all-the-icons' or not (if nil nothing will be showed).
(setq doom-modeline-icon t)

;; Whether show the icon for major mode. It respects `doom-modeline-icon'.
(setq doom-modeline-major-mode-icon t)

;; Display color icons for `major-mode'. It respects `all-the-icons-color-icons'.
(setq doom-modeline-major-mode-color-icon t)

;; Whether display minor modes or not. Non-nil to display in mode-line.
(setq doom-modeline-minor-modes nil)

;; If non-nil, a word count will be added to the selection-info modeline segment.
(setq doom-modeline-enable-word-count t)

;; If non-nil, only display one number for checker information if applicable.
(setq doom-modeline-checker-simple-format t)

;; Whether display perspective name or not. Non-nil to display in mode-line.
(setq doom-modeline-persp-name t)

;; Whether display `lsp' state or not. Non-nil to display in mode-line.
(setq doom-modeline-lsp nil)

;; Whether display github notifications or not. Requires `ghub` package.
(setq doom-modeline-github t)

;; The interval of checking github.
(setq doom-modeline-github-interval (* 30 60))

;; Whether display environment version or not
(setq doom-modeline-env-version t)
;; Or for individual languages
(setq doom-modeline-env-enable-python t)
(setq doom-modeline-env-enable-ruby t)
(setq doom-modeline-env-enable-perl t)
(setq doom-modeline-env-enable-go t)
(setq doom-modeline-env-enable-elixir t)
(setq doom-modeline-env-enable-rust t)

;; Change the executables to use for the language version string
(setq doom-modeline-env-python-executable "python")
(setq doom-modeline-env-ruby-executable "ruby")
(setq doom-modeline-env-perl-executable "perl")
(setq doom-modeline-env-go-executable "go")
(setq doom-modeline-env-elixir-executable "iex")
(setq doom-modeline-env-rust-executable "rustc")

;; Whether display mu4e notifications or not. Requires `mu4e-alert' package.
(setq doom-modeline-mu4e t)

;; Whether display irc notifications or not. Requires `circe' package.
(setq doom-modeline-irc t)

;; Function to stylize the irc buffer names.
(setq doom-modeline-irc-stylize 'identity)
)

(use-package org-bullets
  :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode)))

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-window-setup
      'other-window)
(setq org-agenda-span 7)
(setq org-agenda-start-on-weekday nil)
(setq calendar-day-name-array ["domingo" "lunes" "martes" "miércoles"
                                 "jueves" "viernes" "sábado"])
(setq calendar-month-name-array ["enero" "febrero" "marzo" "abril" "mayo"
                                   "junio" "julio" "agosto" "septiembre"
                                   "octubre" "noviembre" "diciembre"])

(defun agenda-frame ()
  (interactive)
  (org-agenda nil "n")
  (delete-other-windows))

(defadvice org-capture-finalize
(after delete-capture-frame activate)
"Advise capture-finalize to close the frame"
(if (equal "capture" (frame-parameter nil 'name))
(delete-frame)))

(defadvice org-capture-destroy
(after delete-capture-frame activate)
"Advise capture-destroy to close the frame"
(if (equal "capture" (frame-parameter nil 'name))
(delete-frame)))

(use-package noflet
:ensure t )
(defun make-capture-frame ()
"Create a new frame and run org-capture."
(interactive)
;(make-frame '((name . "capture")))
(select-frame-by-name "capture")
(delete-other-windows)
(noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
(org-capture)))

(global-set-key (kbd "C-c l") 'org-store-link)

(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(("i" "Inbox" entry
	 (file "~/Drive/sync/gtd/ai.org")
	 "* %?\n%u" :prepend t)

	("t" "TODO" entry
	 (file+headline "~/Drive/sync/gtd/a.org" "TO-DO")
	 "* TODO %?\n%u" :prepend t)

	("c" "Consulta" entry
	 (file+headline "~/Drive/sync/gtd/a.org" "Consulta")
	 "* INFO %?\n" :prepend t)

	("a" "Agenda"  entry
	 (file+headline "~/Drive/sync/gtd/a.org" "Agenda")
	 "* CITA %?\n SCHEDULED: %t" :prepend t)
	
	("n" "Notas" entry
	 (file+headline "~/Drive/sync/gtd/a.org" "Notas")
	 "* %?" :prepend t)

	("m" "Después" entry
	 (file+headline "~/Drive/sync/gtd/a.org" "Tal vez")
	"* %?" :prepend t) 

	("d" "Diario" entry
	 (file+olp+datetree "~/Drive/sync/cuaderno/diario.org")
	 "* %?" :prepend t)))

(setq org-support-shift-select t)

(add-hook 'org-mode-hook 'turn-on-flyspell)

(use-package org-ref
  :ensure t)
(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

(add-to-list 'load-path "/home/juan/.emacs.d/modes/")
(require 'citeproc-org)
;  (citeproc-org-setup)
;'(citeproc-org-locales-dir "/home/equipo/.emacs.d/csl-locales/")

(add-to-list 'org-structure-template-alist
       '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(org-beamer-mode)

(use-package ox-pandoc
  :ensure t)
(setq helm-bibtex-format-citation-functions
      '((org-mode . (lambda (x) (insert (concat
                                         "\\cite{"
                                         (mapconcat 'identity x ",")
                                         "}")) ""))))

(use-package org-re-reveal
  :ensure t
  )
(use-package org-re-reveal-ref
  :ensure t)
(use-package oer-reveal
  :ensure t)
(setq org-re-reveal-root "file:///home/equipo/revealjs")
(setq org-re-reveal-title-slide nil)

;(require 'ox-reveal)
;(setq org-reveal-root "file:///home/equipo/revealjs")

(add-to-list 'org-latex-classes
      '("koma-article"
	"\\documentclass{scrartcl}"
	("\\section{%s}" . "\\section*{%s}")
	("\\subsection{%s}" . "\\subsection*{%s}")
	("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	("\\paragraph{%s}" . "\\paragraph*{%s}")
	("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
	    
(add-to-list 'org-latex-classes
	     '("doc-recepcional"
	       "\\documentclass{report}"
	       ("\\chapter{%s}" . "\\chapter*{%s}")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
	       )
)

(eval-after-load 'org 
		    '(define-key org-mode-map (kbd "C-ñ") 'org-todo)
		    )

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  
;; Make movement keys work respect visual lines
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)
;; Make horizontal movement cross lines
(setq-default evil-cross-lines t))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)
  )

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package evil-magit
  :ensure t)

;; (add-to-list 'load-path "~/place/to/your/mu4e")
;(add-to-list 'load-path "/usr/bin")
;;(require 'smtpmail)
;
;; smtp
;;(setq message-send-mail-function 'smtpmail-send-it
;;      smtpmail-starttls-credentials
;;      '(("imap.gmail.com" 587 nil nil))
;;      smtpmail-default-smtp-server "imap.gmail.com"
;
;;      smtpmail-smtp-server "imap.gmail.com"
;;      smtpmail-smtp-service 587
;;      smtpmail-debug-info t)
;
;(require 'mu4e)
;
;(setq mu4e-maildir (expand-file-name "~/.email/gmail"))
;
;(setq mu4e-drafts-folder "/Drafts")
;(setq mu4e-sent-folder   "/Sent Items")
;(setq mu4e-trash-folder  "/Trash")
;;(setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file
;
;; get mail
;(setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/.mbsyncrc gmail"
;      mu4e-html2text-command "w3m -T text/html"
;      mu4e-update-interval 120
;      mu4e-headers-auto-update t
;      mu4e-compose-signature-auto-include nil)
;
;(setq mu4e-maildir-shortcuts
;      '( ("/INBOX"               . ?i)
;         ("/Sent Items"   . ?s)
;         ("/Trash"       . ?t)
;         ("/Drafts"    . ?d)))
;
;;; show images
;(setq mu4e-show-images t)
;
;;; use imagemagick, if available
;(when (fboundp 'imagemagick-register-types)
;  (imagemagick-register-types))
;
;;; general emacs mail settings; used when composing e-mail
;;; the non-mu4e-* stuff is inherited from emacs/message-mode
;(setq mu4e-reply-to-address "juacq97@gmail.com"
;    user-mail-address "juacq97@gmail.com"
;    user-full-name  "Juan Adrián Castro Quintana")
;
;;; don't save message to Sent Messages, IMAP takes care of this
;; (setq mu4e-sent-messages-behavior 'delete)
;
;;; spell check
;(add-hook 'mu4e-compose-mode-hook
;        (defun my-do-compose-stuff ()
;           "My settings for message composition."
;           (set-fill-column 72)
;           (flyspell-mode)))
;
;;; Para enviar correos
;(setq message-send-mail-function 'message-send-mail-with-sendmail)
;(setq sendmail-program "/usr/bin/msmtp")
;; tell msmtp to choose the SMTP server according to the from field in the outgoing email
;(setq message-sendmail-extra-arguments '("--read-envelope-from"))
;(setq message-sendmail-f-is-evil 't)
;
;(use-package mu4e-alert
;  :ensure t)

(use-package dashboard
  :ensure t
 :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((agenda . 5)
			  (projects . 5)
			  (recents . 5)
			  (registers . 5)))
  (setq dashboard-startup-banner 3)
  (setq dashboard-banner-logo-title "Pizza Mozzarella! Pizza Mozzarella! Rella Rella Rella Rella...")
  (setq show-week-agenda-p t)
  (add-to-list 'evil-emacs-state-modes 'dashboard-mode)
)

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d ")
  (setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                                (t . ivy--regex-fuzzy)))
)

(use-package counsel
  :config
  (counsel-mode 1)
  :bind
  ("M-x" . counsel-M-x)
  )
(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)

(use-package yasnippet
   :ensure t
   :config
   (yas-global-mode)
   (use-package yasnippet-snippets
   :ensure t)
   (yas-reload-all))

(use-package hydra
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))
(global-set-key (kbd "C-c p") 'projectile-switch-project)
(global-set-key (kbd "C-c f") 'projectile-find-file)

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper))
  )

(use-package magit
  :ensure t
)
(global-set-key (kbd "C-x g") 'magit)

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
(setq markdown-command "/usr/bin/pandoc")

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package ace-window
   :ensure t
   :init (ace-window 1))
(global-set-key (kbd "C-x o") 'ace-window)

(use-package nov
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(use-package rainbow-mode
   :ensure t
   :config (rainbow-mode))

(use-package neotree
  :ensure t
  :config
  (global-set-key [f8] 'neotree-toggle)
)

(use-package all-the-icons
  :ensure t)
(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
(use-package all-the-icons-ivy
  :ensure t
  :after (all-the-icons ivy)
  :custom (all-the-icons-ivy-file-commands '(counsel-dired-jump
                                             counsel-find-file
                                             counsel-file-jump
                                             counsel-find-library
                                             counsel-git
                                             counsel-projectile-find-dir
                                             counsel-projectile-find-file
                                             counsel-recentf))
  :config (all-the-icons-ivy-setup))

(defun my-frame-config (&optional frame)
  (with-selected-frame (or frame (selected-frame))

    ;==== Telephone line ====
;(require 'telephone-line)
;(telephone-line-defsegment* my-vc-info ()
;  (when vc-mode
;    (cond
;      ((string-match "Git[:-]" vc-mode)
;        (let ((branch (mapconcat 'concat (cdr (split-string vc-mode "[:-]")) "-")))
;          (concat (propertize (format "")
;                              'face `(:foreground "yellow" :height 1.3)
;                              'display '(raise -0.1))
;                  (propertize (format " %s" branch)
;                              'face `(:foreground "yellow" :height 0.9)))))
;      ((string-match "SVN-" vc-mode)
;        (let ((revision (cadr (split-string vc-mode "-"))))
;          (concat (propertize (format "")
;                              'face `(:height 1.3)
;                              'display '(raise -0.1))
;                  (propertize (format " %s" revision)
;                              'face `(:height 0.9)))))
;      (t (format "%s" vc-mode)))))
;
;(telephone-line-defsegment* my-airline-position-segment (&optional lines columns)
;  (let* ((l (number-to-string (if lines lines 1)))
;         (c (number-to-string (if columns columns 2))))
;    (if (eq major-mode 'paradox-menu-mode)
;        (telephone-line-raw mode-line-front-space t)
;      `((-3 "%p") ,(concat "  " "%" l "l:%" c "c")))))
;
;
;(setq telephone-line-lhs
;'((evil . (telephone-line-evil-tag-segment))
;;(accent . (telephone-line-vc-segment
;(accent . (my-vc-info
;    telephone-line-erc-modified-channels-segment
;    telephone-line-process-segment))
;(nil . (telephone-line-buffer-segment))))
;
;(setq telephone-line-subseparator-faces '()) 
;(setq telephone-line-primary-left-separator 'telephone-line-tan-left
;telephone-line-secondary-left-separator 'telephone-line-tan-hollow-left
;telephone-line-primary-right-separator 'telephone-line-tan-right
;telephone-line-secondary-right-separator 'telephone-line-tan-hollow-right)
;(setq telephone-line-height 20)
;(telephone-line-mode 1)

;(use-package nord-theme
;  :ensure t
;  :config
;  (setq nord-region-highlight "frost")
;  (setq nord-comment-brightness 15)
;  :init
;  (load-theme 'nord t)
;  )
))

  (use-package doom-themes
    :ensure t
    :config

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
  ;; may have their own settings.
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )

(add-hook 'after-make-frame-functions 'my-frame-config)
(add-hook 'after-init-hook 'my-frame-config)

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  )
