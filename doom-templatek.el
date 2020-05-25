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

(defcustom doom-templatek--default-alpha '(90 80)
  "Setting default alpha of the frame variable."
  :group 'doom-templatek
  :type 'list)

(defcustom doom-templatek--set-default-frame-alist nil
  "Setting default alpha of the frame variable."
  :group 'doom-templatek
  :type 'boolean)

(defun doom-templatek--frame-alpha (&optional active inactive)
  "Setting frame's opacity. ACTIVE INACTIVE are used when frame is active/inactive respectively."
  (let* ((current-frame    (selected-frame))
         (current-alpha    (frame-parameter current-frame 'alpha))
         (current-active   (car current-alpha))
         (current-inactive (cadr current-alpha))
         (new-active       (cond (active active)
                                 (current-active current-active)
                                 (t (car doom-templatek--default-alpha))))
         (new-inactive     (cond (inactive inactive)
                                 (current-inactive current-inactive)
                                 (t (cadr doom-templatek--default-alpha))))
         (new-alpha        (list new-active new-inactive)))

    (when current-frame
      (set-frame-parameter current-frame 'alpha new-alpha))

    (when doom-templatek--set-default-frame-alist
      (let ((current-default-alpha (cdr (assoc 'alpha default-frame-alist))))
        (if current-default-alpha (setf current-default-alpha new-alpha)
          (add-to-list 'default-frame-alist `(alpha . (,new-active . ,new-inactive))))))))

(defun doom-templatek-frame-alpha (&optional alpha-active alpha-inactive)
  "Setting frame's opacity. ALPHA-ACTIVE ALPHA-INACTIVE are used when frame is active/inactive respectively."
  (interactive
   (list
    (read-number "enter alpha-active value (0 - 100):" (nth 0 (alist-get 'alpha default-frame-alist)))
    (read-number "enter alpha-inactive value (0 - 100):" (nth 1 (alist-get 'alpha default-frame-alist)))))
  (doom-templatek--frame-alpha alpha-active alpha-inactive))

(defun doom-templatek-replace-last-sexp ()
  "Replace sexp right before the cursor."
  (interactive)
  (let ((value (eval (elisp--preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))

(provide 'doom-templatek)
;;; doom-templatek.el ends here
