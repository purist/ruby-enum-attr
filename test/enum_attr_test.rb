require 'test_helper'
require 'enum_attr'

class ClassA
  include EnumAttr

  enum_attr :prop1, :foo
  enum_attr :prop1, :bar
end

class ClassBSuper
  attr_accessor :attribute_in_super_class
  attr_accessor :prop1

  # override for testing
  def prop1
    @attribute_in_super_class += 1 # modify this value for testing purposes
    @prop1
  end

  # override for testing
  def prop1= v
    @attribute_in_super_class = v
    @prop1 = v
  end
end

class ClassB < ClassBSuper
  include EnumAttr

  enum_attr :prop1, :foo
  enum_attr :prop1, :bar
end

class EnumAttrTest < Test::Unit::TestCase

  def setup
  end

  def test_value_can_be_stored_and_retreived_by_symbol_name
    c = ClassA.new
    
    c.prop1 = :foo
    assert_equal c.prop1, :foo

    c.prop1 = :bar
    assert_equal c.prop1, :bar
  end

  def test_underlying_attributes_are_set_with_expected_integer_values
    c = ClassA.new
    
    c.prop1 = :foo
    assert_equal c.instance_variable_get( "@prop1" ), 0

    c.prop1 = :bar
    assert_equal c.instance_variable_get( "@prop1" ), 1
    
    c.prop1 = :foo
    assert_equal c.instance_variable_get( "@prop1" ), 0
  end

  def test_inheretance_works_as_expected
    c = ClassB.new
    
    c.attribute_in_super_class = 1000

    assert_equal c.instance_variable_get( "@attribute_in_super_class" ), 1000
    
    c.prop1 = :bar
    assert_equal 1, c.instance_variable_get( "@attribute_in_super_class" )

    c.prop1 
    assert_equal 2, c.instance_variable_get( "@attribute_in_super_class" )
  end

  def test_int_value_can_be_obtained
    c = ClassA.new
    assert_equal 0, c.enum_int_val(:prop1, :foo)
  end
end