(straight-use-package 'swiper)
(straight-use-package 'counsel)

(ivy-mode)

(setq ivy-use-virtual-buffers t)

(setq enable-recursive-minibuffers t)

(global-set-key (kbd "C-c s") 'counsel-rg)
