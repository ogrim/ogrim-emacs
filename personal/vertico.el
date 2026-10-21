;; -*- lexical-binding: t; -*-

(use-package vertico
  :straight t
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico-count 15))

(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :straight t
  :init
  (marginalia-mode))
