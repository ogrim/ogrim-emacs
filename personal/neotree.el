;; -*- lexical-binding: t; -*-

(use-package neotree
  :straight t
  :bind ("<f8>" . neotree-toggle)
  :custom
  (neo-window-width 35)
  (neo-theme (if (display-graphic-p) 'icons 'arrow)))

(define-minor-mode my/neotree-keys-mode
  "Global neotree bindings that override major-mode maps."
  :global t
  :keymap (let ((m (make-sparse-keymap)))
            (define-key m (kbd "C-c C-n") #'neotree-find)
            m))
(my/neotree-keys-mode 1)
