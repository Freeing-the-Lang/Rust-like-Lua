package.path = "src/?.lua;" .. package.path

local Lexer = require("lexer")
local Parser = require("parser")
local AST = require("ast")

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

print("AST OK")
