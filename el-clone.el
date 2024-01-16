;;; el-clone.el --- just git clone  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Takeo Obara

;; Author: Takeo Obara <bararararatty@gmail.com>
;; Version: 1.0.0
;; Keywords: package-manager
;; Package-Requires: ((emacs "29.0"))
;; URL: https://github.com/takeokunn/el-clone

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; package-vc wrapper

;;; Code:

(require 'cl-lib)

(defcustom el-clone-root (locate-user-emacs-file "el-clone")
  "Set el-clone root directory."
  :group 'el-clone
  :type 'string)

(cl-defun el-clone (&key (fetcher "github") url repo name load-paths)
  ;; make directory
  (unless (file-directory-p el-clone-root)
    (make-directory el-clone-root))

  (let* ((repo-url (or url (format "https://www.%s.com/%s.git" fetcher repo)))
         (package-name (or name (file-name-base repo)))
         (default-directory el-clone-root))
    (unless (file-directory-p (expand-file-name package-name el-clone-root))
      (message (concat "Install " repo-url "..."))
      (shell-command-to-string
       (mapconcat #'shell-quote-argument
                  `("git" "clone" "--depth" "1" ,repo-url ,package-name)
                  " ")))
    (add-to-list 'load-path (concat el-clone-root package-name)))

  ;; add path manually
  (when load-paths
    (dolist (path load-paths)
      (add-to-list 'load-path path))))

(defun el-clone-byte-compile ()
  (interactive)
  (dolist (el (file-expand-wildcards (concat el-clone-root "/**/*.el")))
    (byte-compile-file el)))

(provide 'el-clone)

;;; el-clone.el ends here
