ruby-enum-attr
==============

Use Ruby symbols for enumerated integer values on a given class attribute.

If you had a class called Animal and you defined an attribute called species, you could 
use symbols like :lion and :walrus in your code, but the underlying values would be enumerated
integers 0 and 1.

Usage
-----

Include the module...

    require 'enum_attr'

    class Person
      include EnumAttr

      enum_attr :my_property, :readable_symbol1
      enum_attr :my_property, :readable_symbol2
    end

    p = Person.new
    p.my_property = :readable_symbol1
    p.instance_variable_get "@my_property"
    => 0

    p.my_property = :readable_symbol2
    p.instance_variable_get "@my_property"
    => 1

It gracefully handled attributes defined by the super class.

Authors
===========

* Johnny Diligente                       