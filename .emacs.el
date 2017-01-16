;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;  Customised Variables  ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(modify-all-frames-parameters '((fullscreen . maximized)))

;(setenv "SRC" "")

(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;  Emacs built-in modes  ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tramp)
;(setq tramp-default-method "ssh")
;(setq tramp-default-user "charles.huang"
;      tramp-default-host "sydxplanssh.devel.iress.com.au")
;(whitespace-mode t)

(c-set-offset 'case-label '+)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;  Fancy Diary/Calendar Thingy  ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq calendar-load-hook
      '(lambda ()
         (set-face-foreground 'diary-face "skyblue")
         (set-face-background 'holiday-face "slate blue")
         (set-face-foreground 'holiday-face "white")))
(setq calendar-latitude +43.43)
(setq calendar-longitude +125.19)
(setq calendar-location-name "Sydney")
(setq calendar-remove-frame-by-deleting t)
(setq calendar-week-start-day 1)
(auto-compression-mode 1)
(setq delete-auto-save-file t)

(setq make-backup-files nil);;delete backup files
(setq debug-on-error 1);;when error, go into debug
(setq imenu-auto-rescan 1);;auto scan the function name

(menu-bar-mode -1)
(tool-bar-mode 1)

(setq hippie-expand-try-functions-list
      '(
                                        ;senator-try-expand-semantic
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill
        )
      )

;;;;;;;;;;;;;;;;;;
;;              ;;
;; Key bindings ;;
;;              ;;
;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-'") 'kill-this-buffer)
(global-set-key [(C-f4)] 'server-edit)
(global-set-key (kbd "C-<tab>") 'ido-switch-buffer)
(global-set-key (kbd "C-8") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c <deletechar>") 'git-gutter+-revert-hunk)
;; lazy functions
(global-set-key [(meta p)] 'hippie-expand)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key [(C-f3)] 'isearch-repeat-backward)
(global-set-key '[f3] 'isearch-repeat-forward)
(global-set-key [(C-f7)] 'git-gutter+-previous-hunk)
(global-set-key '[f7] 'git-gutter+-next-hunk)
(global-set-key '[f4] 'jedi:goto-definition)
                                        ;(global-set-key (kbd "M-.") 'helm-etags-select)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-n") 'projectile-find-file-dwim)
(global-set-key (kbd "ESC <f3>") 'isearch-lazy-highlight-cleanup)
(global-set-key (kbd "C-M-l") 'delete-trailing-whitespace)
(global-set-key (kbd "C-M-s") 'tags-apropos)
(global-set-key (kbd "C-M-f") 'ack)
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key (kbd "C-f") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-x |") 'split-window-horizontally)
(global-set-key (kbd "C-x -") 'split-window-vertically)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;  Customised crap        ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(autopair-global-mode t)
 '(back-button-mode t)
 '(blink-cursor-mode nil)
 '(browse-url-generic-program "w3")
 '(c-default-style
   (quote
    ((c-mode . "awk")
     (c++-mode . "awk")
     (objc-mode . "awk")
     (java-mode . "awk")
     (awk-mode . "awk")
     (other . "awk"))))
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   (quote
    ("fad38808e844f1423c68a1888db75adf6586390f5295a03823fa1f4959046f81" "33bb2c9b6e965f9c3366c57f8d08a94152954d4e2124dc621953f5a8d7e9ca41" "f1af57ed9c239a5db90a312de03741e703f712355417662c18e3f66787f94cbe" "89e8cc2d402dbf4a723afc2e4983556d0c4f10cd2ddb3aff0e48ed72a22ff2c7" "e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "885ef8634f55df1fa067838330e3aa24d97be9b48c30eadd533fde4972543b55" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(delete-selection-mode nil)
 '(display-time-mode t)
 '(ecb-layout-name "ultimate")
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-file-regexps
   (quote
    ((".*"
      ("\\(^\\(\\.\\|#\\)\\|\\(~$\\|\\.\\(elc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\|pyc\\|min\\.js\\)$\\)\\)")
      ("^\\.\\(emacs\\|gnus\\)$")))))
 '(ecb-source-path (quote (("c:" "c:"))))
 '(global-whitespace-mode t)
 '(grep-command "grep -InH ")
 '(grep-window-height 13)
 '(indent-tabs-mode nil)
 '(js2-indent-switch-body t)
 '(ldap-host-parameters-alist nil)
 '(mark-even-if-inactive t)
 '(package-selected-packages
   (quote
    (yascroll yafolding web-mode ubuntu-theme typescript-mode tumble tabbar-ruler soap-client smex rustfmt rust-mode realgud python-mode neotree magit js2-refactor jedi ido-yes-or-no ido-ubiquitous ido-grid-mode idea-darkula-theme git-gutter+ flymake-python-pyflakes flycheck-pyflakes flx-ido flappymacs django-mode darcula-theme csv-mode autopair)))
 '(scroll-bar-mode (quote right))
 '(semantic-mode t)
 '(show-trailing-whitespace t)
 '(tab-stop-list
   (quote
    (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-mwheel-mode t nil (tabbar))
 '(tool-bar-max-label-size 10)
 '(tool-bar-mode nil)
 '(tool-bar-style (quote text))
 '(transient-mark-mode 1)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(web-mode-markup-indent-offset 2)
 '(whitespace-display-mappings
   (quote
    ((space-mark 32
                 [183]
                 [46])
     (space-mark 160
                 [164]
                 [95])
     (tab-mark 9
               [187 9]
               [92 9]))))
 '(whitespace-line-column 120))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "DarkOrange3"))))
 '(ecb-default-highlight-face ((t (:background "indian red" :foreground "black"))) t)
 '(fringe ((t nil)))
 '(tabbar-button ((t (:inherit tabbar-default))))
 '(tabbar-default ((t (:foreground "grey75" :height 0.8 :family "Monaco"))))
 '(tabbar-highlight ((t (:underline t))))
 '(tabbar-selected ((t nil)))
 '(vertical-border ((t (:inherit mode-line-inactive))))
 '(whitespace-line ((t nil)))
 '(whitespace-space ((t (:foreground "black"))))
 '(whitespace-tab ((t nil))))

(setq isearch-lazy-highlight t)

;;;;;;;;;;;;
;;        ;;
;;  Misc  ;;
;;        ;;
;;;;;;;;;;;;
(setq kill-ring-max 200)
(setq global-mark-ring-max 100)
(setq default-major-mode 'text-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(display-time-mode 1)
(setq-default truncate-lines nil)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-interval 10)
(global-font-lock-mode t)
(auto-image-file-mode t)
(mouse-avoidance-mode 'animate)
(setq mouse-yank-at-point t)
(setq x-select-enable-clipboard t)

(transient-mark-mode t)
(setq resize-mini-windows t)

(setq uniquify-buffer-name-style 'forward)

(setq Man-notify-method 'pushy)

(mouse-wheel-mode t)
(setq visible-bell nil)
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000)
(setq sentence-end "\\([¡££¡£¿]\\|¡¡\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)
(setq next-line-add-newlines nil)
(setq require-final-newline t)
(setq track-eol t)
(setq-default kill-whole-line t)
(setq apropos-do-all t)
(setq-default ispell-program-name "aspell")
;; disable CUA key bindings
(setq cua-enable-cua-keys nil)
;; set the cursor to be a bar instead of block
(setq-default cursor-type 'bar)

(setq mouse-wheel-scroll-amount '(3 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq ring-bell-function 'ignore)

(global-git-gutter+-mode t)

(setq ecb-examples-bufferinfo-buffer-name nil)

(global-auto-revert-mode 1)

(load-theme 'darcula)
(setq default-frame-alist '((font . "Monaco-9")))
(set-default-font "Monaco-9")
(setq scroll-preserve-screen-position t)
(autopair-mode 1)

(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)
(add-hook 'python-mode-hook 'jedi:setup)

(scroll-bar-mode -1)
(yascroll-bar-mode t)
(yas-global-mode t)
(projectile-mode t)


;;MAGIT
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")
(defun magit-key-mode--add-default-options (arguments)
  (if (eq (car arguments) 'pulling)
      (list 'pulling (list "--rebase"))
    arguments))
(advice-add 'magit-key-mode :filter-args #'magit-key-mode--add-default-options)


(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(ido-ubiquitous-mode 1)


(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(server-start)
