;;; doom-templatek --- doom-templatek.el -*- lexical-binding: t; -*-
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
;;;

(defgroup doom-templatek nil
  "Templatek Doom Emacs Configurations."
  :group 'doom-templatek)

(defcustom doom-templatek--default-alpha '(90 . 85)
  "Setting default alpha of the frame variable."
  :group 'doom-templatek
  :type 'list)

(defcustom doom-templatek--set-default-frame-alist :enable
  "Setting default alpha of the frame variable."
  :type '(choice
          (const :tag "Change alpha value of the current and default frame." :enable)
          (const :tag "Change only current frame alpha value." :disable))
  :group 'doom-templatek)

(defun doom-templatek--setalpha (&optional active inactive)
  "Setting frame's opacity. FRAME ACTIVE INACTIVE are used when frame is active/inactive respectively."
  (let* ((frame            (selected-frame))
         (current-alpha    (frame-parameter frame 'alpha))
         (current-active   (car-safe current-alpha))
         (current-inactive (car-safe (cdr-safe current-alpha)))
         (new-active       (cond (active active)
                                 (current-active current-active)
                                 (t (car-safe doom-templatek--default-alpha))))
         (new-inactive     (cond (inactive inactive)
                                 (current-inactive current-inactive)
                                 (t (car-safe (cdr-safe doom-templatek--default-alpha)))))
         (new-alpha        `(,new-active . ,new-inactive)))

    (when frame (set-frame-parameter frame 'alpha new-alpha))

    (when (eq doom-templatek--set-default-frame-alist :enable)
      (add-to-list 'default-frame-alist `(alpha . ,new-alpha)))))

(defun doom-templatek-setalpha (&optional alpha-active alpha-inactive)
  "Setting frame's opacity. ALPHA-ACTIVE ALPHA-INACTIVE are used when frame is active/inactive respectively."
  (interactive
   (list
    (read-number "enter alpha-active value (0 - 100):" (car (alist-get 'alpha default-frame-alist)))
    (read-number "enter alpha-inactive value (0 - 100):" (cdr (alist-get 'alpha default-frame-alist)))))
  (doom-templatek--setalpha alpha-active alpha-inactive))

(defun doom-templatek-replace-last-sexp ()
  "Replace sexp right before the cursor."
  (interactive)
  (let ((value (eval (elisp--preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))

(provide 'doom-templatek)
;;; doom-templatek.el ends here
