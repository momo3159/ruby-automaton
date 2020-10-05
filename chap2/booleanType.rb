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