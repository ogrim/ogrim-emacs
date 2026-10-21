;; -*- lexical-binding: t; -*-

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

(use-package consult-lsp
  :straight t
  :after (consult lsp-mode)
  :bind (:map lsp-mode-map
         ("C-S-t"   . consult-lsp-symbols)          ; workspace-wide, live narrowing
         ("C-c l f" . consult-lsp-file-symbols)
         ("C-S-M-t" . consult-lsp-file-symbols)))   ; current file only

(require 'lsp-mode)
(require 'consult-lsp)
