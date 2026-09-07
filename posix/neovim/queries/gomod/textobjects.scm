;; nvim-treesitter-textobjects queries for go.mod
;;
;; Semantic mapping:
;;   block      -> a whole top-level directive (module, go, require, ...)
;;   statement  -> a single spec line inside a directive
;;   parameter  -> same as statement (operate on one dependency at a time)
;;   assignment -> a "replace foo => bar" spec, with lhs / rhs
;;   comment    -> // comments

; ----- block: the entire directive -----

[
  (module_directive)
  (go_directive)
  (toolchain_directive)
  (require_directive)
  (replace_directive)
  (exclude_directive)
  (retract_directive)
  (tool_directive)
] @block.outer

; Inner block: the meaningful contents of each directive. For grouped
; forms (require ( ... )) each spec is an independent inner block, so
; `dib` deletes whichever spec the cursor is on.
(require_directive  (require_spec)  @block.inner)
(replace_directive  (replace_spec)  @block.inner)
(exclude_directive  (exclude_spec)  @block.inner)
(retract_directive  (retract_spec)  @block.inner)
(tool_directive     (tool)          @block.inner)
(module_directive   (module_path)   @block.inner)
(go_directive       (go_version)    @block.inner)
(toolchain_directive (toolchain_name) @block.inner)

; ----- statement: one spec line -----

[
  (require_spec)
  (replace_spec)
  (exclude_spec)
  (retract_spec)
] @statement.outer

; ----- parameter: also one spec line (so `di,` / `da,` work) -----

[
  (require_spec)
  (replace_spec)
  (exclude_spec)
  (retract_spec)
] @parameter.outer

(require_spec . (module_path) @parameter.inner)
(exclude_spec . (module_path) @parameter.inner)
(retract_spec (version) @parameter.inner)
(replace_spec . (module_path) @parameter.inner)

; ----- assignment: replace foo [vX] => bar [vY] -----

(replace_spec
  . (module_path) @assignment.lhs
  "=>"
  [(module_path) (file_path)] @assignment.rhs) @assignment.outer

(replace_spec
  (module_path)
  "=>"
  [(module_path) (file_path)] @assignment.inner)

; ----- comment -----

(comment) @comment.outer
