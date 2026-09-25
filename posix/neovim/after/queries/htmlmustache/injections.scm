;; extends

;; Parse Mustache text nodes as one combined LaTeX document.
((text) @injection.content
  (#set! injection.language "latex")
  (#set! injection.combined))
