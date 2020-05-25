;;; package --- doom-templatek.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 TemplateK
;;
;; Author: TemplateK <http://github/templateK>
;; Maintainer: TemplateK <templatek@github.com>
;; Created: 5월 25, 2020
;; Modified: 5월 25, 2020
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/templateK/doom-templatek
;; Package-Requires: ((emacs 27.0.90) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(defun setalpha (alpha-active alpha-inactive)
  "Setting frame's opacity. ALPHA-ACTIVE ALPHA-INACTIVE are used when frame is active/inactive respectively."
  (interactive
   (list
    (read-number "enter alpha-active value (0 - 100):" (nth 0 (alist-get 'alpha default-frame-alist)))
    (read-number "enter alpha-inactive value (0 - 100):" (nth 1 (alist-get 'alpha default-frame-alist)))))
  (set-frame-parameter (selected-frame) 'alpha (list alpha-active alpha-inactive))
  (setq default-frame-alist `((undecorated . t)
                              (vertical-scroll-bars  . nil)
                              (horizontal-scroll-bars  . nil)
                              (font . "Noto Sans Mono CJK KR-14:width=normal")
                              (alpha . (,alpha-active ,alpha-inactive)))))

(provide 'doom-templatek)
;;; doom-templatek.el ends here
