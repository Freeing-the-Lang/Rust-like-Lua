local Lexer = {}
Lexer.__index = Lexer

function Lexer.new(src)
    return setmetatable({ src = src, pos = 1 }, Lexer)
end

function Lexer:peek()
    return self.src:sub(self.pos, self.pos)
end

function Lexer:next()
    local c = self:peek()
    self.pos = self.pos + 1
    return c
end

function Lexer:skip_ws()
    while true do
        local c = self:peek()
        if c == '' or not c:match("%s") then break end
        self:next()
    end
end

function Lexer:next_token()
    self:skip_ws()
    local c = self:peek()

    if c == "" then return { type="eof" } end
    if c:match("%d") then return self:number() end
    if c:match("[%a_]") then return self:ident() end

    self:next()
    return { type=c }
end

function Lexer:number()
    local start = self.pos
    while self:peek():match("%d") do
        self:next()
    end
    return { type="number", value=tonumber(self.src:sub(start, self.pos-1)) }
end

function Lexer:ident()
    local start = self.pos
    while self:peek():match("[%w_]") do
        self:next()
    end
    return { type="ident", value=self.src:sub(start, self.pos-1) }
end

return Lexer
