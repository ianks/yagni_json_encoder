require 'bigdecimal'

module JSONTest
  class Foo
    def initialize(a, b)
      @a, @b = a, b
    end
  end

  class Hashlike
    def to_hash
      { :foo => "hello", :bar => "world" }
    end
  end

  class Custom
    def initialize(serialized)
      @serialized = serialized
    end

    def as_json(options = nil)
      @serialized
    end
  end

  class MyStruct < Struct.new(:name, :value)
    def initialize(*)
      @unused = "unused instance variable"
      super
    end
  end

  module EncodingTestCases
    TrueTests     = [[ true,  %(true)  ]]
    FalseTests    = [[ false, %(false) ]]
    NilTests      = [[ nil,   %(null)  ]]
    NumericTests  = [[ 1,     %(1)     ],
                     [ 2.5,   %(2.5)   ],
                     [ 0.0/0.0,   %(null) ],
                     [ 1.0/0.0,   %(null) ],
                     [ -1.0/0.0,  %(null) ],
                     [ BigDecimal('0.0')/BigDecimal('0.0'),  %(null) ],
                     [ BigDecimal('2.5'), %("#{BigDecimal('2.5')}") ]]

    StringTests   =  [[ 'http://test.host/posts/1', %("http://test.host/posts/1")]]

    ArrayTests    = [[ ['a', 'b', 'c'],          %([\"a\",\"b\",\"c\"])        ],
                     [ [1, 'a', :b, nil, false], %([1,\"a\",\"b\",null,false]) ]]

    HashTests     = [[ {foo: "bar"}, %({\"foo\":\"bar\"}) ],
                     [ {1 => 1, 2 => 'a', 3 => :b, 4 => nil, 5 => false}, %({\"1\":1,\"2\":\"a\",\"3\":\"b\",\"4\":null,\"5\":false}) ]]

    RangeTests    = [[ 1..2,     %("1..2")],
                     [ 1...2,    %("1...2")],
                     [ 1.5..2.5, %("1.5..2.5")]]

    SymbolTests   = [[ :a,     %("a")    ],
                     [ :this,  %("this") ],
                     [ :"a b", %("a b")  ]]

    ObjectTests   = [[ Foo.new(1, 2), %({\"a\":1,\"b\":2}) ]]
    HashlikeTests = [[ Hashlike.new, %({\"bar\":\"world\",\"foo\":\"hello\"}) ]]
    StructTests   = [[ MyStruct.new(:foo, "bar"), %({\"name\":\"foo\",\"value\":\"bar\"}) ],
                     [ MyStruct.new(nil, nil), %({\"name\":null,\"value\":null}) ]]
    CustomTests   = [[ Custom.new("custom"), '"custom"' ],
                     [ Custom.new(nil), 'null' ],
                     [ Custom.new(:a), '"a"' ],
                     [ Custom.new([ :foo, "bar" ]), '["foo","bar"]' ],
                     [ Custom.new({ :foo => "hello", :bar => "world" }), '{"bar":"world","foo":"hello"}' ],
                     [ Custom.new(Hashlike.new), '{"bar":"world","foo":"hello"}' ],
                     [ Custom.new(Custom.new(Custom.new(:a))), '"a"' ]]

    RegexpTests   = [[ /^a/, '"(?-mix:^a)"' ], [/^\w{1,2}[a-z]+/ix, '"(?ix-m:^\\\\w{1,2}[a-z]+)"']]

    DateTests     = [[ Date.new(2005,2,1), %("2005/02/01") ]]
    TimeTests     = [[ Time.utc(2005,2,1,15,15,10), %("2005/02/01 15:15:10 +0000") ]]
    DateTimeTests = [[ DateTime.civil(2005,2,1,15,15,10), %("2005/02/01 15:15:10 +0000") ]]

    StandardDateTests     = [[ Date.new(2005,2,1), %("2005-02-01") ]]
    StandardTimeTests     = [[ Time.utc(2005,2,1,15,15,10), %("2005-02-01T15:15:10.000Z") ]]
    StandardDateTimeTests = [[ DateTime.civil(2005,2,1,15,15,10), %("2005-02-01T15:15:10.000+00:00") ]]
    StandardStringTests   = [[ 'this is the <string>', %("this is the <string>")]]
  end
end
