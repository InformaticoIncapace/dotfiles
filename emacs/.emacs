;; -*- lexical-binding: t; -*-

;; ============================================================
;; Package management
;; ============================================================

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)

;; Load the personal customization file.
;; Emacs resolves "~" to the current user's home directory,
;; so this path works on both Windows and Linux.
;; In case it doesn't, the file should be in "C:/Users/USERNAME/AppData/Roaming/"
(setq custom-file (expand-file-name "~/.emacs.custom.el"))

;; ============================================================
;; Appearance and general behavior
;; ============================================================

;; Set the default font and size.
(set-face-attribute 'default nil
                    :family "JetBrains Mono"
                    :height 100)

;; Disable the Super key modifier.
(setq x-super-keysym nil)

;; Skip the startup screen.
(setq inhibit-startup-screen t)

;; Disable the menu bar, tool bar, and scroll bars.
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Enable interactive completion and line numbers.
(ido-mode 1)
(ido-everywhere 1)
(global-display-line-numbers-mode 1)

;; Automatically insert matching delimiters.
(electric-pair-mode 1)

;; Start Emacs with the initial frame maximized.
(add-hook 'emacs-startup-hook
          (lambda ()
            (set-frame-parameter nil 'fullscreen 'maximized)))

;; ============================================================
;; Local configuration modules
;; ============================================================

;; Add the directory containing personal Emacs Lisp modules
;; to the load path.
;; Emacs resolves "~" to the current user's home directory,
;; so this path works on both Windows and Linux.
;; In case it doesn't, the file should be in "C:/Users/USERNAME/AppData/Roaming/"
(add-to-list 'load-path
             (expand-file-name "~/.emacs.local/"))

;; ============================================================
;; C and C++ development
;; ============================================================

(require 'simpc-mode)

;; Use simpc-mode for C, C++, and their header files.
(add-to-list 'auto-mode-alist
             '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; ============================================================
;; Smex: enhanced M-x command completion
;; ============================================================

;; Install Smex if it is not already available.
(unless (package-installed-p 'smex)
  (package-refresh-contents)
  (package-install 'smex))

(require 'smex)

(smex-initialize)

;; Use Smex for M-x while preserving the original command
;; under an alternative key binding.
(global-set-key (kbd "M-x") #'smex)
(global-set-key (kbd "C-c C-c M-x") #'execute-extended-command)

;; ============================================================
;; Multiple Cursors
;; ============================================================

;; Install Multiple Cursors if it is not already available.
(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))

(require 'multiple-cursors)

;; Create and manage multiple editing cursors.
(global-set-key (kbd "C-S-c C-S-c") #'mc/edit-lines)
(global-set-key (kbd "C->")         #'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         #'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     #'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")      #'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         #'mc/skip-to-next-like-this)

;; Insert a tilde using the custom keyboard shortcut.
(define-key global-map (kbd "C-M-ì")
  (lambda ()
    (interactive)
    (insert ?~)))

;; ============================================================
;; Editing utilities
;; ============================================================

(defun duplicate-line ()
  "Duplicate the current line and preserve the cursor column."
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

;; Duplicate the current line with C-,.
(global-set-key (kbd "C-,") #'duplicate-line)

;; Display compilation output in a window below the current one,
;; occupying approximately 30% of the frame height.
(add-to-list 'display-buffer-alist
             '("\\*compilation\\*"
               (display-buffer-below-selected)
               (window-height . 0.3)))

;; ============================================================
;; Snippets: YASnippet
;; ============================================================

(require 'yasnippet)
(require 'yasnippet-snippets)

;; Enable snippets globally and reload their definitions.
(yas-global-mode 1)
(yas-reload-all)

(defun my/yas-expand-or-indent ()
  "Expand a snippet, or indent the current line if none matches."
  (interactive)
  (let ((yas-fallback-behavior 'return-nil))
    (unless (yas-expand)
      (indent-for-tab-command))))

;; Use TAB to expand a matching snippet or indent otherwise.
(with-eval-after-load 'yasnippet
  (define-key yas-minor-mode-map (kbd "TAB")
              #'my/yas-expand-or-indent)
  (define-key yas-minor-mode-map (kbd "<tab>")
              #'my/yas-expand-or-indent))

;; ============================================================
;; Live Server for HTML, CSS, and JavaScript
;; ============================================================

(defun my/live-server-start ()
  "Start Live Server in the current project's directory."
  (interactive)
  (let* ((default-directory
          (or (and (boundp 'projectile-project-root)
                   (projectile-project-root))
              (locate-dominating-file default-directory "index.html")
              default-directory)))
    (start-process
     "live-server"
     "*live-server*"
     "cmd.exe" "/c" "live-server")))

(defun my/live-server-stop ()
  "Stop the running Live Server process."
  (interactive)
  (when (get-process "live-server")
    (delete-process "live-server")))

;; ============================================================
;; Load personal customizations
;; ============================================================

(load-file custom-file)
