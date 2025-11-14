local Parser = {}
Parser.__index = Parser

local AST = require("ast")

function Parser.new(tokens)
    return setmetatable({ tokens = tokens, pos = 1 }, Parser)
end

function Parser:current()
    return self.tokens[self.pos]
end

function Parser:next()
    self.pos = self.pos + 1
end

function Parser:eat(type)
    if self:current().type ~= type then
        error("expected " .. type .. ", got " .. self:current().type)
    end
    self:next()
end

function Parser:parse_expr()
    local node = self:parse_term()
    while true do
        local tok = self:current()
        if tok.type == "+" or tok.type == "-" then
            self:next()
            node = AST.binary(node, tok.type, self:parse_term())
        else
            break
        end
    end
    return node
end

function Parser:parse_term()
    local tok = self:current()
    if tok.type == "number" then
        self:next()
        return AST.number(tok.value)
    end
    error("unexpected token: " .. tok.type)
end

return Parser
