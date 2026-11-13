;; -*- lexical-binding: t; -*-


;; Windows: MSYS2 UCRT64 →
;;   pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
;;   add ucrt64\bin to PATH

;;; Tree-sitter
(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (require 'treesit)
  (add-to-list 'treesit-language-source-alist
               `(c-sharp "https://github.com/tree-sitter/tree-sitter-c-sharp"
                         nil "src"
                         ,@(when (eq system-type 'windows-nt) '("gcc" "g++"))))
  (unless (treesit-language-available-p 'c-sharp)
    (treesit-install-language-grammar 'c-sharp))
  (add-to-list 'major-mode-remap-alist '(csharp-mode . csharp-ts-mode)))

(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-ts-mode))
(add-to-list 'auto-mode-alist '("\\.\\(csproj\\|props\\|targets\\)\\'" . nxml-mode))

;; Eglot
(use-package eglot
  :straight (:type built-in)
  :hook ((csharp-mode csharp-ts-mode) . eglot-ensure)
  :bind (:map eglot-mode-map
         ("C-."   . eglot-code-actions)
         ("C-c r" . eglot-rename)
         ("C-c f" . eglot-format)
         ("C-c o" . eglot-code-action-organize-imports)
         ("C-c i" . eglot-inlay-hints-mode))
  :config
  (when-let ((omnisharp (or (executable-find "omnisharp")
                            (executable-find "OmniSharp"))))
    (add-to-list 'eglot-server-programs
                 `((csharp-mode csharp-ts-mode) . (,omnisharp "-lsp"))))
  (add-hook 'eglot-managed-mode-hook #'my/eglot-managed-setup))

(defun my/csharp-before-save ()
  (ignore-errors
    (eglot-code-action-organize-imports (point-min) (point-max)))
  (eglot-format-buffer))

(defun my/eglot-managed-setup ()
  (eglot-inlay-hints-mode -1)
  (when (derived-mode-p 'csharp-mode 'csharp-ts-mode)
    (if (eglot-managed-p)
        (add-hook 'before-save-hook #'my/csharp-before-save nil t)
      (remove-hook 'before-save-hook #'my/csharp-before-save t))))

;;; Editing
(add-hook 'csharp-ts-mode-hook
          (lambda ()
            (local-set-key (kbd "<backtab>") #'completion-at-point)
            (rainbow-delimiters-mode 1)))

;;; Debugging (DAP, eglot-compatible)
(use-package dape
  :straight t
  :defer t)


;; (use-package dap-mode 
;;   :straight t 
;;   :ensure t 
;;   :defer t
;;   :config
;;   (dap-auto-configure-mode)
;;   (setq dap-netcore-download-url nil)
;;   (setq dap-netcore-debugger-path "/usr/bin/netcoredbg"))

;; (add-to-list 'auto-mode-alist '("\\.csproj\\'" . nxml-mode))
