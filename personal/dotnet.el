(when (fboundp 'treesit-available-p)
  (setq treesit-language-source-alist
        '((c-sharp "https://github.com/tree-sitter/tree-sitter-c-sharp")))
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-ts-mode)))

(use-package eglot
  :straight t
  :hook ((csharp-mode csharp-ts-mode) . eglot-ensure)
  :config
  ;; (add-to-list 'eglot-server-programs
  ;;              '((csharp-mode csharp-ts-mode) . ("csharp-ls")))
  (define-key eglot-mode-map (kbd "C-c i") #'eglot-inlay-hints-mode)
)

(with-eval-after-load 'eglot
  (let* ((omnisharp (or (executable-find "omnisharp")
                        (executable-find "OmniSharp"))))
    (when omnisharp
      (add-to-list 'eglot-server-programs
                   `(csharp-mode . (,omnisharp "-lsp"))))))

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-.") #'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c r") #'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c f") #'eglot-format)
  (defun my/eglot-organize-imports ()
    (interactive) (eglot-code-actions nil "source.organizeImports"))
  (define-key eglot-mode-map (kbd "C-c o") #'my/eglot-organize-imports))


(setq eglot-inlay-hints-mode nil)

(add-hook 'eglot-managed-mode-hook
          (lambda () (eglot-inlay-hints-mode -1)))

;; (add-hook 'eglot-managed-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook #'eglot-format nil t)))



;; (defun my/csharp-format-before-save ()
;;   (when (or (derived-mode-p 'csharp-mode) (derived-mode-p 'csharp-ts-mode))
;;     (eglot-format-buffer)))

;; (add-hook 'before-save-hook #'my/csharp-format-before-save)

(add-hook 'csharp-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format-buffer nil t)
            (add-hook 'before-save-hook #'my/eglot-organize-imports nil t)
            (local-set-key (kbd "<backtab>") #'completion-at-point)
            (rainbow-delimiters-mode 1)))

(use-package dap-mode 
  :straight t 
  :ensure t 
  :defer t
  :config
  (dap-auto-configure-mode)
  (setq dap-netcore-download-url nil)
  (setq dap-netcore-debugger-path "/usr/bin/netcoredbg"))

(add-to-list 'auto-mode-alist '("\\.csproj\\'" . nxml-mode))
