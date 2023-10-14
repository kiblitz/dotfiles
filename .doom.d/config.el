;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(require 'transient)
(require 'yasnippet)

(transient-define-prefix resize-transient ()
  "Resize transient mode"
  :transient-suffix 'transient--do-stay
  ["Resize"
    ("k" "grow vertical" enlarge-window)
    ("j" "shrink vertical" shrink-window)
    ("l" "grow horizontal" enlarge-window-horizontally)
    ("h" "shrink horizontal" shrink-window-horizontally)
    ]
  )
(transient-define-prefix font-zoom-transient ()
  "Font zoom transient mode"
  :transient-suffix 'transient--do-stay
  ["Zoom"
    ("k" "zoom in" text-scale-increase)
    ("j" "zoom out" text-scale-decrease)
    ]
  )

;; (defun init-ocaml-project (type)
;;   (interactive "sproject name: ")
;;   (shell-command (concatenate 'string "dune init " type " %s")))

;; (transient-define-prefix init-project ()
;;   "Initialize project"
;;   ["OCaml"
;;     ("l" "lib" (init-ocaml-project "lib"))
;;     ("x" "exec" (init-ocaml-project "exec"))
;;     ]
;;   )

(map!
 :leader "SPC" nil
 :leader "SPC" #'execute-extended-command

 :leader "!" #'shell-command

 :leader "f e" nil
 :leader "f e d" #'doom/open-private-config
 :leader "f e l" #'load-file

 :leader "w -" #'evil-window-split
 :leader "w /" #'evil-window-vsplit
 :leader "w ." #'resize-transient

 :leader "TAB" #'previous-buffer
 :leader "<backtab>" #'next-buffer

 :leader "b l" #'buffer-menu

 :leader "a" nil
 :leader "a f t" (lambda () (interactive) (find-file "~/projects"))
 ;; :leader "a f i" #'init-project
 :leader "a f c" #'magit-clone
 :leader "a f l" #'magit-log-head

 :leader "z x" #'font-zoom-transient
 ;; requires [focus]
 :leader "z f" #'focus-mode

 :leader ";" nil
 :leader "; ;" #'comment-line
 )

(add-hook 'emacs-startup-hook (lambda () (yas-load-directory "~/.doom.d/snippets/emacs-lisp-mode/")))

;; surround text
(map!
 :v "s" #'evil-surround-region
 )
(after! evil-surround
  (let ((pairs '(
                 (?> "< " . " >")
                 (?\) "( " . " )")
                 (?\] "[ " . " ]")
                 )))
    (prependq! evil-surround-pairs-alist pairs)
    (prependq! evil-embrace-evil-surround-keys (mapcar #'car pairs))))

(defun glee-emacs ()
  (let* ((banner '(
"                                           '                              )`·.                                                     ’                                                  ’"
"                        )·.          '             /(    .·´(        (`·.                    )`·._.·´(        )`·.     (`·.                    )`·._.·´(        )`·."
"               /(    .·´  ('                 )\    ) `·._):. )’'       \::`·._)`·.     )\.·´::...  .::)   .·´   ./       \::`·._)`·.     )\.·´::...  .::)   .·´   ./"
"        )\    ’) `·._):::. )            )\.·´.:`·.(:;;-' '\:(     .·´(   )::. ..:::).·´;· --  ´ ´\::.`·.(::...:(’    .·´(   )::. ..:::).·´;· --  ´ ´\::.`·.(::...:(’  "
"  )\ .·´ .:`·.(:;--’’\:. :(.·)   )\ .·´(,): --  ' '       _\;   ·´):.\(;;::--´ ´          ’\:::::::...::)    ):..\(;;::--  ´ ´               ’\:::::::...::)  "
";´ (,):--’’           \....::`·.( ():.:/\           ,..:´/     (:..:/\                          ’¯¯¯¯¯¯/'   (::...:/\                          ’¯¯¯¯¯¯/'   "
"):.:/\                 ¯¯¯¯`· ::·’' `·/::\..:´/    /::::/       `·:/::\..:´/     _________'/       `·:/::::\...:´/        ___________'/     "
"`·:/::\..:´/    ______       \     '  \::/:::/    /;::-'     '     \::/:::/     /:::::::;; --  ´ ´\     ’     \::::/::::/        /:::::::::;; --  ´ ´\     ’"
"   \::/:::/    /:::::/\       |   ’    \/;:'/    /          '       \/;:'/     /;:·-´ ´         _\    '       \/;::-'/        /;;::·-  ´ ´         _\    '"
"    \/;:'/    /;:·´¯¯¯'\\,,..-´   '        /    /                       /              .,.,·:::::'/   ’'            /                      .,.,·:::::'/   ’'"
"        /    /\         \:::'/           ,/    /      )`·.      )`·.  '/      _.,,·:::::::::::::::/     '  )`·.    '/         _ ,.,.,·:::::::::::::::/     '"
"      ,/    /::\,-´/    /::-´          .·/|    |   .·´ ..( '   (:.:(.·/      /:::::::::::::::::::--  ´      ’(::..:(.·/         /:::::::::::::::::::--  ´      ’"
"      /|    '|\/::/    /       '       )/:|,   `·’.):..::/.--.`·::..'/       `·__:::::· ’\:   .·´            `·::..'/          `·__:::::· ’\:   .·´           "
"     /:/`·,   `·:/    /    '           |:::::.,     ¯¯¯¯¯¯  ;/     )/`.                         \(              ’     )/`·.                        \(              ’"
"    |:/:::::`·,___,.·/          '      |:::::::::..______.·´:/’    /:::`·._____ ...·::/                    /::::::`·._____ ...·::::::/                "
"     `·:;::::/:::/::/            '      ´'·::::;:/::::::/::·´'     `;::::/::::/::::::/                 ’    `·:::::::/::::::::/:::::::::/                 ’"
"         `·;/:::/;·´     '                   ´'·/::::::/:·´          `·:/::::/::: ·´´                   ’        `·::/::::::::/::::: ·´´                   ’"
"            ¯¯¯¯                     ’'          ¯¯¯¯¯¯     '           ¯¯¯¯¯                                          ¯¯¯¯¯                              "
))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'glee-emacs)
