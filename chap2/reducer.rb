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

    def reduce
        if left.reducible?
            Add.new(left.reduce, right)
        elsif right.reducible?
            Add.new(left.value, right.reduce)
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

    def reduce 
        if left.reducible?
            Add.new(left.reduce, right)
        elsif right.reducible?
            Add.new(left.value, right.reduce)
        else
            Number.new(left.value * right.value)
        end
    end
end

class Machine < Struct.new(:expression)
    def step
        self.expression = expression.reduce
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
    # (4 * 20) + 3 という式に対応する抽象構文木
    Add.new(
        Multiply.new(Number.new(4), Number.new(20)),
        Number.new(3)
    )    
)

m.run
