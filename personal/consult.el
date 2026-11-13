;; -*- lexical-binding: t;-*-



(use-package recentf
  :straight (:type built-in)
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 200)
  (recentf-auto-cleanup 'never)
  :config
  (add-to-list 'recentf-exclude (expand-file-name "straight/" user-emacs-directory)))

(use-package consult
  :straight t
  :bind (("C-x b" . consult-buffer)
         ("C-c s" . consult-ripgrep)
         ("C-c l" . consult-line)
         :map isearch-mode-map
         ("M-s l" . consult-line))
  :init
  (setq xref-show-xrefs-function       #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-ripgrep consult-xref consult-source-recent-file
   :preview-key '(:debounce 0.4 any)))

(setq isearch-lazy-count t)

