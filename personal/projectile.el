(use-package rg
  :straight t)

(use-package projectile
  :straight t
  :init
  (setq projectile-project-search-path '("~/work/kode"))
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t)
  (projectile-mode +1))

