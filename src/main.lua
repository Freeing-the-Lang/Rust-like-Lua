local Lexer = require("lexer")
local Parser = require("parser")

local code = "10 + 20 - 5"

local lx = Lexer.new(code)
local tokens = {}

while true do
    local t = lx:next_token()
    table.insert(tokens, t)
    if t.type == "eof" then break end
end

local ps = Parser.new(tokens)
local ast = ps:parse_expr()

print("AST OK:")
print(ast.tag, ast.op)
