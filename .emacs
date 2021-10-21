;; comfortable code
(global-font-lock-mode t)
(setq transient-mark-mode t)
(show-paren-mode t)
(column-number-mode t)
(menu-bar-mode -1)

;; ;; international language ;)
;; (ispell-change-dictionary "british")

;; I hate [long] tabs
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq c-basic-indent 2)
(setq tab-width 2)

;; I hate backup files hanging everywhere
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
;; allow using a wheel-mouse
(mouse-wheel-mode t)

;; M-g does something useless by default
(global-set-key "\M-g" 'goto-line)

;; reverse of \C-c\C-c (comment out region)
(global-set-key "\C-cu" 'uncomment-region)

;; easy acces to cursor position saving into registers
(global-set-key "\C-xp" 'point-to-register)
(global-set-key "\C-xj" 'jump-to-register)

;; clean file
(global-set-key [f1] 'delete-trailing-whitespace)

;; reload buffer from disk
(global-set-key [f5] 'revert-buffer)
(global-set-key [f6] 'server-start)

;; rectangle editing
(global-set-key [f9]  'kill-rectangle)
(global-set-key [f10] 'yank-rectangle)

;; enable upcase-region command C-x c-u
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; silent bell
(setq visible-bell t)

;; auto update of TAGS file
(setq tags-revert-without-query 1)

;; column 80 mark
(setq fci-mode t)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "red")

;; nice colors
;(set-background-color "DarkSlateGray")
;(set-foreground-color "White")

;; got from: http://www.cgd.ucar.edu/cms/processor/archive/samples/\
;; unsupported/processor-tools.el
(defun kill-trailing-whitespace ()
  "Eliminate trailing whitespace"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (delete-region (match-beginning 0) (point)))))

;; doxygen mode
;; (autoload 'doxymacs-mode "doxymacs" "Deal with doxygen." t)
;; (add-hook 'c-mode-common-hook 'doxymacs-mode)
;; (defun my-doxymacs-font-lock-hook ()
;;   (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;       (doxymacs-font-lock)))
;; (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;; python mode for scons files
(setq auto-mode-alist (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("SConscript" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Sconsfile"  . python-mode) auto-mode-alist))

;; gpg mode
;; TODO: test presence of this mode before using it
;;(require 'epa-setup)

;; ;; c programming macros
;; (fset 'cif
;;    [?i ?f ?  ?( ?) ?  ?{ return tab return ?} up up right right])
;; (fset 'cifelse
;;    [tab ?i ?f ?  ?( ?) ?  ?{ return tab return ?} ?  ?e ?l ?s ?e ?  ?{ return return ?}])
;; (fset 'cfor
;;    [tab ?f ?o ?r ?  ?( ?  ?\; ?  ?\; ?  ?) ?  ?{ return tab return ?}])
;; (fset 'cwhile
;;    [tab ?w ?h ?i ?l ?e ?  ?( ?) ?  ?{ return tab return ?}])
;; (fset 'cfori
;;    [tab ?f ?o ?r ?  ?( ?s ?i ?z ?e ?_ ?t ?  ?i ?  ?= ?  ?0 ?  ?\; ?  ?i ?  ?< ?  ?X ?X ?X ?  ?\; ?  ?+ ?+ ?i ?) ?  ?{ return tab return ?} up up ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f])
;; (fset 'cforj
;;    [tab ?f ?o ?r ?  ?( ?s ?i ?z ?e ?_ ?t ?  ?j ?  ?= ?  ?0 ?  ?\; ?  ?j ?  ?< ?  ?Y ?Y ?Y ?  ?\; ?  ?+ ?+ ?j ?) ?  ?{ return return ?} up tab up ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f ?\M-f])

;; (fset 'rename_dl
;;    [end ?\C-  ?\C-r ?= right ?\M-w end ?  ?\C-y down end ?  ?\C-y ?\M-b left ?c ?l ?o ?s ?c down ?  ?\C-y ?\M-b left ?d ?e ?c ?o ?y ?1 ?0 end backspace backspace backspace ?t ?b ?z down home])

;; for some Ocaml code
(fset 'not_yet
   "failwith \"not implemented yet\"")
(global-set-key [f12] 'not_yet)

(global-set-key "\M-." 'merlin-locate)
(global-set-key "\C-t" 'merlin-type-enclosing)

;; enable use of the emacsclient command
;; (server-force-delete)
;; (server-start)

;; <forward remove of all consecutive whitespaces --------------------------- >
(defmacro hungry-delete-skip-ws-forward (&optional limit)
  "Skip over any whitespace following point.
This function skips over horizontal and vertical whitespace and line
continuations."
  (if limit
      `(let ((limit (or ,limit (point-max))))
         (while (progn
                  ;; skip-syntax-* doesn't count \n as whitespace..
                  (skip-chars-forward " \t\n\r\f\v" limit)
                  (when (and (eq (char-after) ?\\)
                             (< (point) limit))
                    (forward-char)
                    (or (eolp)
                        (progn (backward-char) nil))))))
    '(while (progn
              (skip-chars-forward " \t\n\r\f\v")
              (when (eq (char-after) ?\\)
                (forward-char)
                (or (eolp)
                    (progn (backward-char) nil)))))))

(defun hungry-delete-forward ()
  "Delete the following character or all following whitespace up
to the next non-whitespace character.  See
\\[c-hungry-delete-backward]."
  (interactive)
  (let ((here (point)))
    (hungry-delete-skip-ws-forward)
    (if (/= (point) here)
        (delete-region (point) here)
      (let ((hungry-delete-mode nil))
        (delete-char 1)))))

(global-set-key "\C-cd" 'hungry-delete-forward)
;; </forward remove of all consecutive whitespaces -------------------------- >

;; sh-mode for gnuplot scripts
(add-to-list 'auto-mode-alist '("\\.gpl\\'" . sh-mode))
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
