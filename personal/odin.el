(use-package odin-mode
  :straight (:type git :host github :repo "mattt-b/odin-mode")
  :mode "\\.odin\\'"
  :hook (odin-mode . lsp-deferred)
  :preface
  (defun my-odin-run ()
    (interactive)
    (compile "odin run ."))
  (defun my-odin-debug ()
    (interactive)
    (dape (alist-get 'odin-gdb dape-configs)))
  :bind (:map odin-mode-map
              ("C-c r" . my-odin-run)
              ("C-c d" . my-odin-debug)))


(comment (straight-use-package
  '(odin-mode :type git :host github :repo "mattt-b/odin-mode")))

(add-to-list 'auto-mode-alist '("\\.odin\\'" . odin-mode))

(defun my-odin-run ()
  (interactive)
  (compile "odin run ."))

(add-hook 'odin-mode-hook
          (lambda ()
            (lsp-deferred)
            (define-key odin-mode-map (kbd "C-c r") #'my-odin-run)))

