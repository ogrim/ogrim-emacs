;; -*- lexical-binding: t; -*-

(straight-use-package
  '(sly :type git :host github :repo "joaotavora/sly"))

(require 'sly)

(setq sly-lisp-implementations
      '((sbcl ("sbcl" "--noinform" "--noprint"))))

(setq sly-default-lisp 'sbcl)
