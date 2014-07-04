(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(defun recompile-everything-under-the-sun ()
  (interactive)
  (dolist (path load-path)
    (byte-recompile-directory path 0)))

(defun condense-whitespace ()
  "Kill the whitespace between two non-whitespace characters"
  (interactive "*")
  (save-excursion
    (save-restriction
      (save-match-data
        (progn
          (re-search-backward "[^ \t\r\n]" nil t)
          (re-search-forward "[ \t\r\n]+" nil t)
          (replace-match " " nil nil))))))

(defun my-custom-frames ()
  "Set the frames to three even-width columns"
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (split-window-horizontally)
  (balance-windows))

(defun ipdb-trace ()
  (interactive)
  (insert "import ipdb; ipdb.set_trace()"))

;(package-refresh-contents)
; Illegal1 = 0.123456789 '"[](){} !@#$%^&*
; ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789 abcdefghijklmnopqrstuvwxyz
; !@#$%^&*()[]{}<>-_=+\|;:'",./?
;; (set-frame-font "Terminus-12")
;; (set-frame-font "DejaVuSansMono-10")
;; (set-frame-font "UbuntuMono-12")
;; (set-frame-font "Inconsolata-12")
(set-frame-font "DroidSansMono-10")

(add-to-list 'load-path "~/.emacs.d")
(require 'color-theme)
(color-theme-initialize)
(require 'color-theme-aaron)
(color-theme-aaron)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-\\") 'condense-whitespace)
(global-set-key (kbd "C-;") 'dabbrev-expand)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key [M-f12] 'revert-buffer)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key [C-tab] 'next-multiframe-window)
(global-set-key [C-S-iso-lefttab] 'previous-multiframe-window)
(global-set-key (kbd "C-s-d") 'ipdb-trace)
(global-set-key [f6] 'buffer-menu)
(global-set-key [f7] 'my-custom-frames)

(global-auto-revert-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t)
(transient-mark-mode t)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/bin/lintrunner.py"(list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

(add-hook 'python-mode-hook
          '(lambda () (if (not (null buffer-file-name)) (flymake-mode))))
(require 'python)

(set-fringe-mode 0)
(column-number-mode 1)
(show-paren-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(require 'autopair)

; Custom colors for rst mode
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rst-level-1-face ((t (:foreground "Red"))) t)
 '(rst-level-2-face ((t (:foreground "Orange"))) t)
 '(rst-level-3-face ((t (:foreground "Yellow"))) t)
 '(rst-level-4-face ((t (:foreground "Green"))) t)
 '(rst-level-5-face ((t (:foreground "Blue"))) t)
 '(rst-level-6-face ((t (:foreground "Purple"))) t))
 ;; (rst-level-7-face ((t (:foreground "LightSteelBlue"))) t)
 ;; (rst-level-8-face ((t (:foreground "LightSalmon"))) t)

(put 'downcase-region 'disabled nil)
