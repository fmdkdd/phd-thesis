;; Use org version from .emacs.d/elpa directory for latest goodness and
;; consistency with manual export from Emacs.
(package-initialize)

;; How to export 'cite' links
(defun fmdkdd/org-export-cite (path desc format)
  (when (eq format 'latex)
    (format "\\\cite{%s}" path)))

(with-eval-after-load 'org
  (org-add-link-type "cite" nil #'fmdkdd/org-export-cite))

(with-eval-after-load 'ox-latex
  ;; Custom LATEX_CLASS that sets the documentclass, removes all default
  ;; packages, and tells Org how to translate headlines into LaTeX sections.
  (add-to-list 'org-latex-classes
               '("thesis"
                 "[NO-DEFAULT-PACKAGES]\n\\input{preamble}"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

  ;; Do not insert maketitle, we do that in frontmatter.tex.
  (setq org-latex-title-command ""))

;; Allow Babel to execute source blocks in batch mode.
(with-eval-after-load 'ob-core
  (require 'ob-js)
  (require 'ob-dot)
  (setq org-confirm-babel-evaluate nil
        org-babel-use-quick-and-dirty-noweb-expansion t))
