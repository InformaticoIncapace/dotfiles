(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq custom-file "~/.emacs.custom.el")

(set-face-attribute 'default nil :family "JetBrains Mono" :height 100)

(setq x-super-keysym nil)
(setq inhibit-startup-screen t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(ido-mode 1)
(ido-everywhere 1)
(global-display-line-numbers-mode 1)

(add-hook 'emacs-startup-hook
          (lambda ()
            (set-frame-parameter nil 'fullscreen 'maximized)))

(add-to-list 'load-path "~/.emacs.local/")

(require 'simpc-mode)
(add-to-list 'auto-mode-alist
         '("\\.[hc]\\(pp\\)?\\'" . c-mode))

(unless (package-installed-p 'smex)
  (package-refresh-contents)
  (package-install 'smex))

(require 'smex)

(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")        'mc/skip-to-next-like-this)

(defun duplicate-line()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point ) (point-at-bol)))
	(line (let ((s (thing-at-point 'line t)))
		(if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'duplicate-line)

(add-to-list 'display-buffer-alist
             '("\\*compilation\\*"
               (display-buffer-below-selected)
               (window-height . 0.3)))

(load-file custom-file)
