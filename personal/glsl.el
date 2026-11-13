;; -*- lexical-binding: t; -*-

(use-package glsl-mode
  :straight t
  :mode ("\\.\\(frag\\|vert\\|geom\\|glsl\\)\\'"
         "\\.\\(fs\\|vs\\)\\'")
  :hook (glsl-mode . eglot-ensure))

(use-package eglot
  :straight (:type built-in)
  :config
  (add-to-list 'eglot-server-programs
               '(glsl-mode . ("glsl_analyzer"))))
