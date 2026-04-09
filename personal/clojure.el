;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clojure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                        ;(require 'clojure-mode)
(use-package clojure-mode 
  :straight t
  :ensure t)

(use-package cider
  :straight t
  :ensure t
  :hook ((clojure-mode . cider-mode))
  :config
  (setq cider-repl-display-help-banner nil
        cider-preferred-build-tool 'clojure-cli
        cider-clojure-cli-global-options ""))


(use-package eglot
  :straight t
  :ensure t)

(add-hook 'clojure-mode-hook 'eglot-ensure)
(add-hook 'clojurescript-mode-hook 'eglot-ensure)
(add-hook 'clojurec-mode-hook 'eglot-ensure)

(use-package paredit
  :straight t
  :ensure t
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(use-package rainbow-delimiters
  :straight t
  :ensure t
  :hook (clojure-mode . rainbow-delimiters-mode))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "λ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "ƒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∈")
                               nil))))))

(eval-after-load 'find-file-in-project
  '(add-to-list 'ffip-patterns "*.clj"))

;(defun turn-on-paredit () (paredit-mode 1))
;(add-hook 'clojure-mode-hook 'turn-on-paredit)

