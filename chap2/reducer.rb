class Number < Struct.new(:value)
    def to_s
        value.to_s
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        false
    end
end

class Boolean < Struct.new(:value)
    def to_s
        value.to_s
    end

    def inspect
        "<<#{self}>"
    end

    def reducible?
        false
    end
end

class Add < Struct.new(:left, :right)
    def to_s
        "#{left} + #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            Add.new(left.reduce(environment), right)
        elsif right.reducible?
            Add.new(left, right.reduce(environment))
        else
            Number.new(left.value + right.value)
        end
    end
end

class Multiply < Struct.new(:left, :right)
    def to_s
        "#{left} * #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment) 
        if left.reducible?
            Add.new(left.reduce(environment), right)
        elsif right.reducible?
            Add.new(left, right.reduce(environment))
        else
            Number.new(left.value * right.value)
        end
    end
end

class Div < Struct.new(:left, :right)
    def to_s
        "#{left} / #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment) 
        if left.reducible?
            Div.new(left.reduce(environment), right)
        elsif right.reducible?
            Div.new(left, right.reduce(environment))
        else
            Number.new(left.value / right.value)
        end
    end
end

class Mod < Struct.new(:left, :right)
    def to_s
        "#{left} % #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment) 
        if left.reducible?
            Mod.new(left.reduce(environment), right)
        elsif right.reducible?
            Mod.new(left, right.reduce(environment))
        else
            Number.new(left.value % right.value)
        end
    end
end

class LessThan < Struct.new(:left, :right)
    def to_s
        "#{left} < #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            LessThan.new(left.reduce(environment), right)
        elsif right.reducible?
            LessThan.new(left, right.reduce(environment))
        else
            Boolean.new(left.value < right.value)
        end
    end
end

class GreaterThan < Struct.new(:left, :right)
    def to_s
        "#{left} > #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            GreaterThan.new(left.reduce(environment), right)
        elsif right.reducible?
            GreaterThan.new(left, right.reduce(environment))
        else
            Boolean.new(left.value > right.value)
        end
    end
end

class And < Struct.new(:left, :right)
    def to_s
        "#{left} && #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            And.new(left.reduce(environment), right)
        elsif right.reducible?
            And.new(left, right.reduce(environment))
        else
            Boolean.new(left.value && right.value)
        end
    end
end

class Or < Struct.new(:left, :right)
    def to_s
        "#{left} || #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            Or.new(left.reduce(environment), right)
        elsif right.reducible?
            Or.new(left, right.reduce(environment))
        else
            Boolean.new(left.value || right.value)
        end
    end
end

class Not < Struct.new(:right)
    def to_s
        "!#{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        Boolean.new(!(right.value))
    end
end

class Variable < Struct.new(:name)
    def to_s
        name.to_s
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        environment[name] # nil or 変数の値
    end
end

class Machine < Struct.new(:expression, :environment)
    def step
        self.expression = expression.reduce(environment)
    end

    def run
        while expression.reducible?
            puts expression
            step
        end
        puts expression # 最終的な結果
    end
end

m = Machine.new(
    # x + y < 3 という式に対応する抽象構文木
    Not.new(Boolean.new(false)),
    {}
)

m.run
