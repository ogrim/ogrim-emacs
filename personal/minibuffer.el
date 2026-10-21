;; -*- lexical-binding: t; -*-

(straight-use-package 'swiper)
(straight-use-package 'counsel)

(use-package prescient
  :straight t
  :config
  (prescient-persist-mode 1))

(use-package vertico-prescient
  :straight t
  :after (vertico prescient)
  :config
  (vertico-prescient-mode 1))

(setq enable-recursive-minibuffers t)

(global-set-key (kbd "C-c s") #'consult-ripgrep)
(global-set-key (kbd "C-s")   #'consult-line)
