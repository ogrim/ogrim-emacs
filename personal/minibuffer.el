(straight-use-package 'swiper)
(straight-use-package 'counsel)

(use-package prescient
  :straight t
  :config
  (prescient-persist-mode 1))

(use-package ivy-prescient
  :straight t
  :after (ivy prescient)
  :config
  (ivy-prescient-mode 1))

(ivy-mode)

(setq ivy-use-virtual-buffers t)

(setq enable-recursive-minibuffers t)

(global-set-key (kbd "C-c s") 'counsel-rg)
