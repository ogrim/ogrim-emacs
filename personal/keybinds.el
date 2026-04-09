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

(defun move-line-up ()
  "Move the current line up by one."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  ;(indent-according-to-mode)
  )

(defun move-line-down ()
  "Move the current line down by one."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  ;(indent-according-to-mode)
  )

(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)
