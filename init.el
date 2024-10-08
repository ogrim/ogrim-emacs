(defvar current-user
      (getenv
       (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(setq frame-title-format "emacs@ogrim")

(setq default-directory (concat (getenv "HOME") "/"))

(require 'package)
;;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))



;;(add-to-list 'package-archives '("melpa" . "melpa.org/packages/"))

;; remember to install fonts on Windows: 
;; M-x all-the-icons-install-fonts
;; downloads the fonts, install them manually
(defvar my-packages '(better-defaults paredit ido-completing-read+ smex doom-modeline ivy))

(package-initialize)

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; (use-package all-the-icons
;;   :if (display-graphic-p))

(when (display-graphic-p)
  (require 'all-the-icons))

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; (use-package exec-path-from-shell
;;    :if (memq window-system '(mac ns))
;;    :ensure t
;;    :config
;;    (exec-path-from-shell-initialize))


(require 'modus-themes)
(load-theme 'modus-vivendi-tinted :no-confirm)


(require 'git-commit)


;; If package installation fails, make sure you have GnuTLS available
;; http://xn--9dbdkw.se/diary/how_to_enable_GnuTLS_for_Emacs_24_on_Windows/index.en.html
;; http://sourceforge.net/projects/ezwinports/files/

;; To test, eval this code, if it says nil then TLS works:
;; (condition-case e
;;     (delete-process
;;      (gnutls-negotiate
;;       :process (open-network-stream "test" nil "www.google.com" 443)
;;       :hostname "www.google.com"
;;       :verify-error t))
;;   (error e))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun first (list) (car list))
(defun second (list) (car (cdr list)))

(defun my-next-sentence ()
  (interactive)
  (re-search-forward "[.?!]")
  (if (looking-at "[    \n]+[A-Z]\\|\\\\")
      nil
    (my-next-sentence)))

(defun my-last-sentence ()
  (interactive)
  (re-search-backward "[.?!][   \n]+[A-Z]\\|\\.\\\\" nil t)
  (forward-char))

(defun turn-on-linum ()
  (unless (minibufferp)
    (linum-mode 1)))

(setq sentence-end "[.?!][]\"')]*\\($\\|\t\\| \\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq sentence-bg-color "#303A6F")
(setq sentence-face (make-face 'sentence-face-background))
(set-face-background sentence-face sentence-bg-color)

(defun sentence-begin-pos ()
  (save-excursion
    (unless (= (point) (point-max)) (forward-char))
    (backward-sentence) (point)
   ;(if (= (char-after (- (point) 1)) 32) (point) (point))
))

(defun sentence-end-pos ()
  (save-excursion
    (unless (= (point) (point-max)) (forward-char))
    (backward-sentence) (forward-sentence) (point)))

(setq sentence-highlight-mode nil)

(defun sentence-highlight-current (&rest ignore)
  "Highlight current sentence."
  (and sentence-highlight-mode (> (buffer-size) 0)
       (progn
         (and  (boundp 'sentence-extent)
               sentence-extent
               (move-overlay sentence-extent (sentence-begin-pos)
                             (sentence-end-pos) (current-buffer))))))

(setq sentence-extent (make-overlay 0 0))
;(overlay-put sentence-extent 'face sentence-face)

(defun kill-current-sentence (&rest ignore)
  "Kill current sentence."
  (interactive)
  (and sentence-highlight-mode (> (buffer-size) 0)
       (kill-region (sentence-begin-pos) (+ (sentence-end-pos) 1))))

(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-16le-dos)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun reload-and-remove-dos ()
  (interactive)
  (revert-buffer t t)
  (remove-dos-eol))

(defun search-selection (beg end)
  "search for selected text"
  (interactive "r")
  (let ((selection (buffer-substring-no-properties beg end)))
    (deactivate-mark)
    (swiper selection)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cosmetic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(global-hl-line-mode +1)

;;(set-default-font "Consolas-13:antialias=subpixel")
;;(set-face-attribute 'default nil :height 120 :family "Consolas")
(set-face-attribute 'default nil :bold t :height 130 :family "Victor Mono")

(add-hook 'text-mode-hook 'remove-dos-eol)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *timetable* "
| timestamp | timer dag | timer aktivitet | aktivitet |
|-----------+-----------+-----------------+-----------|
|           |           |                 |           |
|           |           |                 |           |
|           |           |                 |           |
|           |           |                 |           |
|           |           |                 |           |
|           |           |                 |           |
| sum       |           |                 |           |
#+TBLFM: @8$2=vsum(@2$2..@7$2)::@8$3=vsum(@2$3..@7$3)::@8$4=@8$2-2.5")

;; Parse an HH::MM date into a list containing a pair of numbers, (HH MM)
(defun my-parse-hhmm (hhmm)
 (let ((date-re "\\([0-9]+\\):\\([0-9]+\\)h?")
        hours
        minutes)
   (unless (string-match date-re hhmm)
     (error "Argument is not a valid date: '%s'" hhmm))
   (setq hours (string-to-number (match-string 1 hhmm))
          minutes (string-to-number (match-string 2 hhmm)))
   (list hours minutes)))

;; Convert a HH:MM date to a (possibly fractional) number of hours
(defun my-hhmm-to-hours (hhmm)
 (let* ((date (my-parse-hhmm hhmm))
        (hours (first date))
        (minutes (second date)))
   (+ (float hours) (/ (float minutes) 60.0))))

(defun timerange-insert-hours (&optional lunch)
  (interactive)
  (org-evaluate-time-range t)
  (kill-word 2)
  (insert (number-to-string (my-hhmm-to-hours (substring-no-properties (car kill-ring)))))
  (org-cycle))

(defun timerange-insert-hours-minus-lunch ()
  (interactive)
  (org-evaluate-time-range t)
  (kill-word 2)
  (insert (number-to-string (- (my-hhmm-to-hours (substring-no-properties (car kill-ring))) 0.5)))
  (org-cycle))

(defun insert-timetable ()
  (interactive)
  (insert *timetable*))

(defun week-number (date)
  (org-days-to-iso-week
   (calendar-absolute-from-gregorian date)))

(defun week-number-current ()
  (interactive)
  (insert (number-to-string (week-number (calendar-current-date)))))

(defun org-agenda-skip-entry-unless-tags (tags)
  "Skip entries that do not contain specified tags.
TAGS is a list specifying which tags should be displayed.
Inherited tags will be considered."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (atags (split-string (org-entry-get nil "ALLTAGS") ":")))
    (if (catch 'match
          (mapc (lambda (tag)
                  (when (member tag atags)
                    (throw 'match t)))
                tags)
          nil)
        nil
      subtree-end)))

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))


(setq org-agenda-files (list "C:\\org\\work.org"))
(setq org-latex-to-pdf-process
       '("pdflatex -interaction nonstopmode %b"
         "bibtex %b"
         "pdflatex -interaction nonstopmode %b"
         "pdflatex -interaction nonstopmode %b"
         "rm %b.bbl %b.blg"))
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c c") 'reftex-citep)
            ;(define-key org-mode-map (kbd "M-e") 'my-next-sentence)
            ;(define-key org-mode-map (kbd "M-a") 'my-last-sentence)
            (define-key org-mode-map (kbd "C-c w") 'week-number-current)
            (define-key org-mode-map (kbd "C-M-k") 'kill-current-sentence)
            (define-key org-mode-map (kbd "C-c h") 'timerange-insert-hours)
            (define-key org-mode-map (kbd "C-c j") 'timerange-insert-hours-minus-lunch)
            (define-key org-mode-map (kbd "C-c t") 'insert-timetable)
            (define-key org-mode-map (kbd "C-c SPC") 'ace-jump-mode)
            (define-key org-mode-map (kbd "M-Q") 'unfill-paragraph)
            (local-unset-key [(meta tab)])
            (reftex-mode)
            ;(add-to-list 'org-export-latex-packages-alist '("" "amsmath" t))
            ;(setcar (rassoc '("wasysym" t) org-export-latex-default-packages-alist) "integrals")
            ;(make-local-variable 'sentence-highlight-mode)
            ;(setq sentence-highlight-mode t)
            ;(add-hook 'post-command-hook 'sentence-highlight-current)
            ;(set (make-local-variable 'global-hl-line-mode) nil)
            (add-to-list 'org-structure-template-alist
             (quote ("C" "#+begin_comment\n?\n#+end_comment" "<!--\n?\n-->")))
            ))

(setq reftex-cite-format 'natbib)
(setq org-log-done t)
(setq org-todo-keywords '((sequence "NEXT" "WAITING" "DELEGATED" "|" "DONE" "CANCELED" )))
(setq org-tag-alist '(("telefon" . ?t) ("epost" . ?e) ("hjemma" . ?h) ("data" . ?d)))
(setq org-indent-mode-turns-on-hiding-stars nil)
(setq org-directory "C:\\org")


(use-package org-roam 
  :ensure t
  :custom
  (org-roam-directory "C:\\org\\roam-notes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode)
  (setq org-return-follows-link  t)
  (setq org-roam-db-update-on-save t)
  (setq org-roam-graph-executable "C:\\Program Files\\Graphviz\\bin\\dot.exe"))



                                        ;(find-file "C:\\work\\work.org")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clojure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                        ;(require 'clojure-mode)

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "λ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "ƒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∈")
                               nil))))))

(eval-after-load 'find-file-in-project
  '(add-to-list 'ffip-patterns "*.clj"))

(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f8>") 'org-agenda-list)
(global-set-key (kbd "<C-f8>") 'org-todo-list)

(global-set-key "\C-c\C-w" 'comment-or-uncomment-region)
(global-set-key "\C-cw" 'comment-or-uncomment-region)

(global-set-key "\M-i" 'shrink-window)
(global-set-key (kbd "M-I") 'enlarge-window-horizontally)

(global-set-key (kbd "<f9>") 'gtd)

(global-set-key (kbd "C-x O") 'previous-multiframe-window)

(global-set-key (kbd "M-T") (lambda () (interactive) (transpose-words -1)))

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-<backspace>") 'backward-kill-word)


(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(global-set-key (kbd "C-s") 'swiper)
(define-key global-map (kbd "C-M-s") 'search-selection)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
(set-default 'indent-tabs-mode nil)
(auto-compression-mode t)
(show-paren-mode t)
;(setq ring-bell-function 'ignore)
(setq visible-bell t)

(defalias 'yes-or-no-p 'y-or-n-p)

(random t) ;; Seed the random-number generator

(mouse-avoidance-mode 'cat-and-mouse)

(setq display-time-24hr-format t)

(display-time)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

(use-package emojify
  :hook (after-init . global-emojify-mode))


;;;;;;;;;;;;;;;;;;;;;;;
;; LSP and things
;;;;;;;;;;;;;;;;;;;;;;;

(require 'lsp-mode)
;; Either place zls in your PATH or add the following:
(setq lsp-zig-zls-executable "C:\\bin\\zls.exe")

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
)

(add-to-list 'auto-mode-alist '("\\.csproj\\'" . nxml-mode))
(add-hook 'nxml-mode-hook 
          (lambda () 
            (define-key nxml-mode-map (kbd "C-c C-n") 'neotree-find)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load files dropped in the personal folder
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(mapc 'load (directory-files (expand-file-name ".emacs.d/personal") 't "^[^#].*el$"))



(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;(setq backup-directory-alist `(("." . "~/.saves")))
;(setq create-lockfiles nil)

;(setq backup-by-copying t)
;(setq backup-directory-alist '((".*" . ,"~/.emacs.d/backups")))
;;(setq auto-save-file-name-transforms '((".*" . "~/.emacs.d/backups" t)))


(defvar --backup-directory (concat user-emacs-directory "backups/"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

(setq lock-file-name-transforms `((".*" ,--backup-directory t)))

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;(define-key neotree-mode-map (kbd "<backtab>") ') 
;(define-key csharp-mode-map (kbd "C-c C-n") nil)

(add-hook 'c-mode-common-hook
          (lambda () 
            (define-key csharp-mode-map (kbd "C-c C-n") 'neotree-find)))

(global-set-key (kbd "C-c C-n")  'neotree-find)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;(setq neo-smart-open t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
;; if icons are missing, need to install nerd-icons
;; M-x nerd-icons-install-fonts


(defun mp-toggle-window-dedication ()
  "Toggles window dedication in the selected window."
  (interactive)
  (set-window-dedicated-p (selected-window)
     (not (window-dedicated-p (selected-window)))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-window-width 35)
 '(package-selected-packages
   '(counsel powershell modus-themes magit gleam-ts-mode org-roam-ui emojify docker-compose-mode org-roam neotree all-the-icons-dired format-all exec-path-from-shell which-key-posframe swiper which-key lsp-mode zig-mode slime all-the-icons markdown-mode org slack json-mode jq-format dockerfile-mode yaml-mode doom-modeline hackernews nlinum helm smex paredit ido-completing-read+)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

