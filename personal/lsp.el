(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook (csharp-ts-mode . lsp)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-completion-provider :none)
  :custom
  (lsp-completion-provider :capf))

(setq lsp-lens-enable nil)

(require 'lsp-mode)

(add-hook 'lsp-mode-hook #'lsp-signature-mode)
