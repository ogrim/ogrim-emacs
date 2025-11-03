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
;(set-clipboard-coding-system 'utf-16le-dos)
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

(defun mp-toggle-window-dedication ()
  "Toggles window dedication in the selected window."
  (interactive)
  (set-window-dedicated-p (selected-window)
     (not (window-dedicated-p (selected-window)))))
