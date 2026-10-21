;; -*- lexical-binding: t;-*-

(use-package recentf
  :straight (:type built-in)
  :init
  (recentf-mode 1)
  :custom
  (recentf-max-saved-items 200))

(use-package consult
  :straight t
  :bind (("C-x b" . consult-buffer))
  :custom
  (xref-show-xrefs-function       #'consult-xref)
  (xref-show-definitions-function #'consult-xref))
