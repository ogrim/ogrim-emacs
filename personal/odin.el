;; -*- lexical-binding: t; -*-

(use-package odin-mode
  :straight (:type git :host github :repo "mattt-b/odin-mode")
  :mode "\\.odin\\'"
  :hook ((odin-mode . lsp-deferred)
         (odin-mode . my/odin-format-on-save)
         (odin-mode . (lambda () (setq-local indent-tabs-mode nil))))
  :preface
  (defun my-odin-run ()
    (interactive)
    (compile "odin run ."))
  (defun my-odin-debug ()
    (interactive)
    (dape (alist-get 'odin-gdb dape-configs)))
  (defun my/odin-format-on-save ()
    (add-hook 'before-save-hook #'lsp-format-buffer nil t))
  :bind (:map odin-mode-map
         ("C-c r" . my-odin-run)
         ("C-c d" . my-odin-debug)))
