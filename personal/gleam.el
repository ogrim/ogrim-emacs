;;;;;;;;;;;;;;; gleam


;; Minimal, works for both TS and legacy modes
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(gleam-ts-mode . ("gleam" "lsp")))
  (add-to-list 'eglot-server-programs
               '(gleam-mode . ("gleam" "lsp"))))

(add-hook 'gleam-ts-mode-hook #'eglot-ensure)
(add-hook 'gleam-mode-hook    #'eglot-ensure)

;; Optional: format on save via LSP
(defun my-gleam-format-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
(add-hook 'gleam-ts-mode-hook #'my-gleam-format-on-save)
(add-hook 'gleam-mode-hook    #'my-gleam-format-on-save)
(add-to-list 'auto-mode-alist '("\\.gleam\\'" . gleam-ts-mode))

