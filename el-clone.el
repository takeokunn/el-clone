;;; el-clone.el --- package-vc wrapper -*- lexical-binding: t; -*-

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

(provide 'cl-lib)
(require 'package-vc)

(cl-defun el-clone (&key (fetcher "github") repo name rev backend)

  (let* ((url (format "https://www.%s.com/%s" fetcher repo))
         (iname (when name (intern name)))
         (package-name (or iname (intern (file-name-base repo)))))
    (unless (package-installed-p package-name)
      (package-vc-install url iname rev backend))))

(provide 'el-clone)

;;; el-clone.el ends here
