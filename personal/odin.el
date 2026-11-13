;; -*- lexical-binding: t; -*-

(use-package odin-mode
  :straight (:type git :host github :repo "mattt-b/odin-mode")
  :mode "\\.odin\\'"
  :hook ((odin-mode . lsp-deferred)
         (odin-mode . my/odin-format-on-save)
         (odin-mode . (lambda () (setq-local indent-tabs-mode nil))))
  :preface
  (defun my-odin-run ()
    (interactive)
    (compile "odin run ."))
  (defun my-odin-debug ()
    (interactive)
    (dape (alist-get 'odin-gdb dape-configs)))
  (defun my/odin-format-on-save ()
    (add-hook 'before-save-hook #'lsp-format-buffer nil t))
  :bind (:map odin-mode-map
         ("C-c r" . my-odin-run)
         ("C-c d" . my-odin-debug)))

(with-eval-after-load 'ob
  (defvar org-babel-default-header-args:odin '((:results . "output")))
  (defun org-babel-execute:odin (body params)
  (let* ((dir     (make-temp-file "ob-odin-" t))
         (file    (expand-file-name "main.odin" dir))
         (exe     (expand-file-name "snippet" dir))
         (imports (split-string (format "%s" (or (cdr (assq :imports params)) "core:fmt"))))
         (flags   (format "%s" (or (cdr (assq :flags params)) "")))
         (src     (if (string-match-p "^package " body)
                      body
                    (concat "package main\n\n"
                            (mapconcat (lambda (i) (format "@(require) import \"%s\"\n" i))
                                       imports "")
                            "\nmain :: proc() {\n" body "\n}\n"))))
    (with-temp-file file (insert src))
    (unwind-protect
        (org-babel-eval (format "odin run %s -file -out:%s %s"
                                (shell-quote-argument file)
                                (shell-quote-argument exe)
                                flags)
                        "")
      (delete-directory dir t))))
)


;; if you have odin-mode installed, for C-c ' editing and fontification
(with-eval-after-load 'org-src
  (add-to-list 'org-src-lang-modes '("odin" . odin)))
