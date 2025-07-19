local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("ee", {
    t { "if err != nil {", "\t" },
    i(0), -- final cursor stop, empty insert point
    t { "", "}" },
  }),
  s("print", {
    t 'fmt.Println("',
    i(1, "msg"),
    t '")',
  }),
  s("struct", {
    t "type ",
    i(1, "Name"),
    t { " struct {", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("fn", {
    t "func ",
    i(1, "FunctionName"), -- first jump
    t "(",
    i(2, "params"), -- second jump
    t ") ",
    i(3, "returnType"), -- third jump
    t { " {", "\t" },
    i(0), -- final jump (body)
    t { "", "}" },
  }),
  s("fnr", {
    t "func (",
    i(1, "recv"), -- receiver name
    t " *",
    i(2, "Type"), -- receiver type
    t ") ",
    i(3, "FuncName"), -- function name
    t "(",
    i(4, "params"), -- parameters
    t ") ",
    i(5, "returnType"), -- return type
    t { " {", "\t" },
    i(0), -- function body (last stop)
    t { "", "}" },
  }),
}
