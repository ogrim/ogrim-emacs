(straight-use-package 'neotree)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;(define-key neotree-mode-map (kbd "<backtab>") ') 
;(define-key csharp-mode-map (kbd "C-c C-n") nil)

(add-hook 'c-mode-common-hook
          (lambda () 
            (define-key csharp-mode-map (kbd "C-c C-n") 'neotree-find)))

(global-set-key (kbd "C-c C-n")  'neotree-find)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;(setq neo-smart-open t)

(setq neo-window-width 35)

(add-hook 'nxml-mode-hook 
          (lambda () 
            (define-key nxml-mode-map (kbd "C-c C-n") 'neotree-find)))
