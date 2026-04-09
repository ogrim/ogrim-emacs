(setq frame-title-format "emacs@ogrim")

(defvar bootstrap-versivon)

(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(dolist (pkg '(project xref))
  (add-to-list 'straight-built-in-pseudo-packages pkg))

;; load theme already here so it doesn't flash white whilst loading configs from personal folder
(straight-use-package 'modus-themes)
(require 'modus-themes)
(load-theme 'modus-vivendi-tinted :no-confirm)

(straight-use-package 'use-package)
(straight-use-package 'paredit)
(straight-use-package 'sudo-edit)
;(straight-use-package 'wl-clipboard)
(straight-use-package 'ido-completing-read+)
(straight-use-package 'better-defaults)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load files dropped in the personal folder ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(mapc 'load (directory-files (expand-file-name ".emacs.d/personal") 't "^[^#].*el$"))

(server-start)
