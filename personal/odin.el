(straight-use-package
 '(odin-mode :type git :host github :repo "mattt-b/odin-mode"))

(add-to-list 'auto-mode-alist '("\\.odin\\'" . odin-mode))

(defun my-odin-run ()
  (interactive)
  (compile "odin run ."))

(add-hook 'odin-mode-hook
          (lambda ()
            (lsp-deferred)
            (define-key odin-mode-map (kbd "C-c r") #'my-odin-run)))

