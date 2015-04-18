;;; packages.el --- hydra Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar hydra-packages
  '(
    ;; package hydras go here
    hydra
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar hydra-excluded-packages '()
  "List of packages to exclude.")

(defun hydra/init-hydra ()
  "Initialize hydra"
  (use-package hydra
    :config
    (defvar hydra-pager/position nil)
    (defun hydra-pager/save-position ()
      (setq hydra-pager/position (cons (window-start) (point))))
    (defun hydra-pager/reset-position ()
      (interactive)
      (goto-char (cdr hydra-pager/position))
      (set-window-start (selected-window) (car hydra-pager/position))
      (redisplay))
    (defhydra hydra-pager (:body-pre (hydra-pager/save-position))
      "Paging"
      ("f" evil-scroll-page-down "Page down")
      ("b" evil-scroll-page-up "Page up")
      ("d" evil-scroll-down "Scroll down")
      ("u" evil-scroll-up "Scroll up")
      ("e" evil-scroll-line-down "Line down")
      ("y" evil-scroll-line-up "Line up")
      ("q" nil "Quit" :color blue)
      ("Q" hydra-pager/reset-position "Quit and reset point" :color blue))
    (evil-leader/set-key "op" 'hydra-pager/body)
    ))

;; For each package, define a function hydra/init-<package-hydra>
;;
;; (defun hydra/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
