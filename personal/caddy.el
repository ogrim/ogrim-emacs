(use-package caddyfile-mode
  :straight t
  :ensure t)

(add-to-list 'auto-mode-alist '("Caddyfile\\'" . caddyfile-mode))
(add-to-list 'auto-mode-alist '("\\.caddy\\'" . caddyfile-mode))
