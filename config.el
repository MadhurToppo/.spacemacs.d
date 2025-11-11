;;; config.el --- User Configuration File -*- no-byte-compile: t; lexical-binding: nil; -*-
;;
;; This file contains user-specific customizations for Spacemacs
;;

;; Org-mode customization
;; (setq org-hide-leading-stars t)
(setq org-superstar-leading-bullet nil)
(setq org-startup-indented t)
(setq org-startup-folded t)
(when (fboundp 'spaceline-toggle-org-clock-on)
  (spaceline-toggle-org-clock-on))

;; Define todo states
(setq org-todo-keywords
      '((sequence "TODO(t)" "SCHEDULED(s)" "NEXT(n)" "ACTIVE(a)" "PAUSED(p)" "|" "DECLINED(x)" "DONE(D)")))

;; Set todo keyword colors
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "orange" :weight bold)
              ("SCHEDULED" :foreground "light blue" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("ACTIVE" :foreground "magenta" :weight bold)
              ("PAUSED" :foreground "violet" :weight bold)
              ("DECLINED" :foreground "dark green" :weight bold)
              ("DONE" :foreground "dark green" :weight bold))))

;; Org-todo automatically change to done when all children are done
(defun org-summary-todo (n-done n-not-done)
  ;; "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "ACTIVE"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

;; Load org agenda files
(load-library "find-lisp")
(add-hook 'org-agenda-mode-hook (lambda ()
                                  (setq org-agenda-files
                                        (find-lisp-find-files "~/workspace/journal" "\.org$"))))

;; Set default launch terminal to kitty
(setq terminal-here-mac-terminal-command 'kitty)

;; Treemacs resize icons
(when (fboundp 'treemacs-resize-icons)
  (treemacs-resize-icons 12))

;; Spacemacs transparency
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; Add org-mode priorities
(setq org-highest-priority ?A
      org-default-priority ?B
      org-lowest-priority ?D)

;; Set org-mode priority colors
(setq org-priority-faces '((?A . (:foreground "green"))
                           (?B . (:foreground "magenta"))
                           (?C . (:foreground "orange"))
                           (?D . (:foreground "yellow"))))

;; Set counsel default search engine to google
(setq counsel-search-engine 'google)

;; Disable ivy counsel fuzzy search
(setq ivy-initial-inputs-alist nil)

;; Change org pomodoro timer
(setq org-pomodoro-length 60)
(setq org-pomodoro-short-break-length 5)
(setq org-pomodoro-long-break-length 60)
(setq org-pomodoro-long-break-frequency 60)

;; Set vterm timer delay to improve performance
(setq vterm-timer-delay 0.005)

;; Increase to 1 MB from default 4 KB, which is too low for TUI apps like lazygit
(setq read-process-output-max (* 1024 1024)) ;; 1 MB

;; Load OrgModeClockingXBar
(load-file "/Users/madhurtoppo/.emacs.d/workspace/OrgModeClockingXBar/OrgModeClockingXBar.el")
