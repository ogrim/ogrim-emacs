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


(setq org-agenda-files (list "~/work/org/work.org"))
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
(setq org-directory "~/work/org")


(use-package org-roam
  :straight t
  :ensure t
  :custom
  (org-roam-directory "~/work/org/roam-notes")
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
;  (setq org-roam-graph-executable "C:\\Program Files\\Graphviz\\bin\\dot.exe")
)



                                        ;(find-file "C:\\work\\work.org")
