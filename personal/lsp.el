;;;;;;;;;;;;;;;;;;;;;;;
;; LSP and things
;;;;;;;;;;;;;;;;;;;;;;;

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook (csharp-ts-mode . lsp)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  :custom
  (lsp-completion-provider :capf)
)

(setq lsp-lens-enable nil)

(require 'lsp-mode)

;; (use-package lsp-ui
;;   :straight t
;;   :config
;;   (setq lsp-ui-doc-enable t
;;         lsp-ui-doc-show-with-cursor t
;;         lsp-ui-doc-position 'at-point))

(add-hook 'lsp-mode-hook #'lsp-signature-mode)
