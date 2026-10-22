;; -*- lexical-binding: t; -*-

(straight-use-package
 '(magit :type git :host github :repo "magit/magit"))

(straight-use-package
 '(git-commit :type git :host github :repo "magit/magit"))

(use-package magit
  :straight t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))

(use-package git-commit
  :straight t
  :after magit)

(require 'git-commit)
