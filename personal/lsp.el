(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook ((csharp-ts-mode . lsp)
         (lsp-mode . lsp-signature-mode))
  :bind (:map lsp-mode-map
              ("<f12>"   . lsp-find-definition)
              ("S-<f12>" . lsp-find-references))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  :custom
  (lsp-completion-provider :none)
  (lsp-lens-enable nil))

(require 'lsp-mode)
