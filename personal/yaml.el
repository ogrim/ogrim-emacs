;; -*- lexical-binding: t; -*-

(use-package yaml-mode
  :straight t
  :ensure t)

(when (fboundp 'yaml-ts-mode)
  (add-to-list 'major-mode-remap-alist '(yaml-mode . yaml-ts-mode)))

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))


(setq treesit-language-source-alist
      '((yaml "https://github.com/ikatyang/tree-sitter-yaml")))
;; Then run:
;; M-x treesit-install-language-grammar RET yaml RET

;; ;; npm i -g yaml-language-server
;; (add-hook 'yaml-mode-hook #'eglot-ensure)
;; (add-hook 'yaml-ts-mode-hook #'eglot-ensure)

;; ;; Enable server-side formatting
;; (setq eglot-workspace-configuration '(:yaml (:format (:enable t))))

;; ;; Handy keybinding for manual format
;; (with-eval-after-load 'eglot
;;   (define-key eglot-mode-map (kbd "C-c C-f") #'eglot-format-buffer))
