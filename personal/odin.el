(straight-use-package
 '(odin-mode :type git :host github :repo "mattt-b/odin-mode"))

(add-to-list 'auto-mode-alist '("\\.odin\\'" . odin-mode))

(add-hook 'odin-mode-hook #'lsp-deferred)

