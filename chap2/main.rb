require "./numberType.rb"
require "./booleanType.rb"
require "./variable.rb"
require "./machine.rb"


m = Machine.new(
    # x + y < 3 という式に対応する抽象構文木
    Not.new(Boolean.new(false)),
    {}
)

m.run
