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