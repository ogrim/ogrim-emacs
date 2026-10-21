;; -*- lexical-binding: t; -*-

(use-package dape
  :straight t
  :config
  (add-to-list 'dape-configs
    `(odin-gdb
      modes (odin-mode odin-ts-mode)
      command "gdb"
      command-args ("--interpreter=dap")
      compile "odin build . -debug -o:none -out:game"
      :request "launch"
      :program "game"
      :cwd "."
      :stopAtBeginningOfMainSubprogram nil))
  :bind (:map odin-mode-map
              ("<f5>"    . dape-continue)
              ("S-<f5>"  . dape-quit)
              ("<f9>"    . dape-breakpoint-toggle)
              ("<f10>"   . dape-next)
              ("<f11>"   . dape-step-in)
              ("S-<f11>" . dape-step-out)
              ("C-<f11>" . toggle-frame-fullscreen)))
