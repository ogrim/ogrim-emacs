;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cosmetic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(straight-use-package 'all-the-icons)
(straight-use-package 'all-the-icons-dired)
(straight-use-package 'rainbow-delimiters)

(when (display-graphic-p)
  (require 'all-the-icons))

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(global-hl-line-mode +1)

(set-face-attribute 'default nil :bold t :height 140 :family "Fantasque Sans Mono")

(add-hook 'text-mode-hook 'remove-dos-eol)

(use-package doom-modeline
  :straight t
  :ensure t
  :init (doom-modeline-mode 1))
;; if icons are missing, need to install nerd-icons
;; M-x nerd-icons-install-fonts

;(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(add-hook 'prog-mode-hook
          (lambda ()
            (display-line-numbers-mode 1)
            (local-set-key (kbd "C-j") #'newline-and-indent)))
