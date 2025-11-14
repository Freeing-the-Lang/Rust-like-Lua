local AST = {}

function AST.number(value)
    return { tag="number", value=value }
end

function AST.binary(left, op, right)
    return { tag="binary", left=left, op=op, right=right }
end

return AST
