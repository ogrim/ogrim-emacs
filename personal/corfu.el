(use-package corfu
  :straight t
  :init
  (global-corfu-mode)
  :config
  (setq corfu-auto nil
        corfu-auto-prefix 2
        corfu-preview-current nil
        corfu-min-width 30
        corfu-max-width 100
        corfu-popupinfo-max-height 20
        corfu-count 10
        corfu-cycle t))

;(setq corfu-backend #'corfu-backend-regexp)
;(setq corfu-backend #'cape--completion-at-point)

(use-package nerd-icons-corfu 
  :straight t
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(corfu-popupinfo-mode 1)

(setq corfu-popupinfo-delay '(0.5 . 0.2))

(define-key corfu-map (kbd "M-n") #'corfu-popupinfo-scroll-up)
(define-key corfu-map (kbd "M-p") #'corfu-popupinfo-scroll-down)

