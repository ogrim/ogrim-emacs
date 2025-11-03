;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
(set-default 'indent-tabs-mode nil)
(auto-compression-mode t)
(show-paren-mode t)
;(setq ring-bell-function 'ignore)
(setq visible-bell t)

(defalias 'yes-or-no-p 'y-or-n-p)

(random t) ;; Seed the random-number generator

(mouse-avoidance-mode 'cat-and-mouse)

(setq display-time-24hr-format t)

(display-time)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

(use-package emojify
  :straight t
  :hook (after-init . global-emojify-mode))

(dolist (hook '(emacs-lisp-mode-hook
                lisp-mode-hook
                lisp-interaction-mode-hook
                clojure-mode-hook
                scheme-mode-hook))
  (add-hook hook #'enable-paredit-mode))

(use-package exec-path-from-shell
  :straight t
  :ensure t
  :init
  ;; Copy these from your shell into Emacs’ env
  (setq exec-path-from-shell-variables '("PATH" "DOTNET_ROOT"))
  :config
  (exec-path-from-shell-initialize))

(electric-pair-mode 1)

(setq electric-pair-preserve-balance t
      electric-pair-open-newline-between-pairs t)
