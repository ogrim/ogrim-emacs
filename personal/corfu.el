(use-package corfu
  :straight t
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode 1)
  :bind (:map corfu-map
              ("M-n" . corfu-popupinfo-scroll-up)
              ("M-p" . corfu-popupinfo-scroll-down))
  :custom
  (corfu-auto nil)
  (corfu-auto-prefix 2)
  (corfu-preview-current nil)
  (corfu-min-width 30)
  (corfu-max-width 100)
  (corfu-count 10)
  (corfu-cycle t)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-popupinfo-max-height 20))

(use-package nerd-icons-corfu 
  :straight t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(corfu-popupinfo-mode 1)
