(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/#/"))
(add-to-list 'package-archives '("melpa-milkbox" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(setq make-backup-files nil)
(setq frame-background-mode 'dark)

(require 'whitespace)
(setq whitespace-style '(face trailing tabs spaces empty space-mark tab-mark))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
	(tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

(setq whitespace-space-regexp "\\(\u3000+\\)")
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
		    :background my/bg-color
		    :foreground "DeepPink"
		    :underline t)
(set-face-attribute 'whitespace-tab nil
		    :background my/bg-color
		    :foreground "LightSkyBlue"
		    :underline t)
(set-face-attribute 'whitespace-space nil
		    :background my/bg-color
		    :foreground "GreenYellow"
		    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
		    :background my/bg-color)
