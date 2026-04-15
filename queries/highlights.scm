; Groovy highlights — ordered so specific captures win over generic `(identifier) @variable`
; (tree-sitter: later / more specific patterns override earlier matches for the same range).

[
  "!in"
  "!instanceof"
  "as"
  "assert"
  "case"
  "catch"
  "class"
  "def"
  "default"
  "else"
  "extends"
  "finally"
  "for"
  "if"
  "import"
  "in"
  "instanceof"
  "package"
  "pipeline"
  "return"
  "switch"
  "try"
  "while"
  (break)
  (continue)
] @keyword

[
  "true"
  "false"
] @boolean

(null) @constant
"this" @variable.builtin

[ 
  "int"
  "char"
  "short"
  "long"
  "boolean"
  "float"
  "double"
  "void"
] @type.builtin

[ 
  "final"
  "private"
  "protected"
  "public"
  "static"
  "synchronized"
] @type.qualifier

(comment) @comment
(shebang) @comment

(string) @string
(string (escape_sequence) @operator)
(string (interpolation ([ "$" ]) @operator))

("(") @punctuation.bracket
(")") @punctuation.bracket
("[") @punctuation.bracket
("]") @punctuation.bracket
("{") @punctuation.bracket
("}") @punctuation.bracket
(":") @punctuation.delimiter
(",") @punctuation.delimiter
(".") @punctuation.delimiter

(number_literal) @number

[ 
  "%" "*" "/" "+" "-" "<<" ">>" ">>>" ".." "..<" "<..<" "<.." "<"
  "<=" ">" ">=" "==" "!=" "<=>" "===" "!==" "=~" "==~" "&" "^" "|"
  "&&" "||" "?:" "+" "*" ".&" ".@" "?." "*." "*" "*:" "++" "--" "!"
] @operator

(ternary_op ([ "?" ":" ]) @operator)

(map (map_item key: (identifier) @variable.parameter))

(parameter type: (identifier) @type name: (identifier) @variable.parameter)
(parameter
  type: (type_with_generics (identifier) @type)
  name: (identifier) @variable.parameter)
(parameter
  type: (type_with_generics (generics (identifier) @type))
  name: (identifier) @variable.parameter)
(generic_param name: (identifier) @variable.parameter)

(declaration type: (identifier) @type)
(function_definition type: (identifier) @type)
(function_definition type: (type_with_generics (identifier) @type))
(function_definition type: (type_with_generics (generics (identifier) @type)))
(function_declaration type: (identifier) @type)
(function_declaration type: (type_with_generics (identifier) @type))
(function_declaration type: (type_with_generics (generics (identifier) @type)))
(class_definition name: (identifier) @type)
(class_definition superclass: (identifier) @type)
(generic_param superclass: (identifier) @type)

(type_with_generics (identifier) @type)
(type_with_generics (generics (identifier) @type))
(generics [ "<" ">" ] @punctuation.bracket)
(generic_parameters [ "<" ">" ] @punctuation.bracket)

(declaration ("=") @operator)
(assignment ("=") @operator)

; `new Foo()` — keyword + constructor name (VS Code: storage.type / class name)
(unary_op
  "new" @keyword
  (function_call function: (identifier) @type))

(unary_op
  "new" @keyword)

; Import / package path segments (VS Code–style namespace / module path)
(qualified_name (identifier) @namespace)

; Static / type prefix in dotted calls: Math.hypot, Collections.emptyList
((dotted_identifier
  (identifier) @namespace
  (identifier) @function)
  (#match? @namespace "^[A-Z]"))

(function_call 
  function: (identifier) @function)
(function_call
  function: (dotted_identifier
	  (identifier) @function . ))
(function_call (argument_list
		 (map_item key: (identifier) @variable.parameter)))
(juxt_function_call 
  function: (identifier) @function)
(juxt_function_call
  function: (dotted_identifier
	  (identifier) @function . ))
(juxt_function_call (argument_list 
		      (map_item key: (identifier) @variable.parameter)))

(function_definition 
  function: (identifier) @function)
(function_declaration 
  function: (identifier) @function)

; Common Groovy / JDK-style call names (VS Code support.function–like)
((identifier) @function.builtin
  (#match? @function.builtin "^(println|print|printf|sprintf|each|sleep|wait|notify|notifyAll|getClass|invokeMethod|propertyMissing|methodMissing)$"))

(annotation) @function.macro
(annotation (identifier) @function.macro)
"@interface" @function.macro

"pipeline" @keyword

(groovy_doc) @comment.documentation
(groovy_doc 
  [
    (groovy_doc_param)
    (groovy_doc_throws)
    (groovy_doc_tag)
  ] @string.special)
(groovy_doc (groovy_doc_param (identifier) @variable.parameter))
(groovy_doc (groovy_doc_throws (identifier) @type))

; PascalCase identifiers as types (classes, wrappers) — after function/call patterns
((identifier) @type
  (#match? @type "^[A-Z][a-zA-Z0-9_$]*$")
  (#not-match? @type "^[A-Z][A-Z0-9_]+$"))

((identifier) @constant
  (#match? @constant "^[A-Z][A-Z_]+"))

((identifier) @variable.parameter
  (#is? @variable.parameter "local.parameter"))

(identifier) @variable
