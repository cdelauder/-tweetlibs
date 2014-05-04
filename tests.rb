def assert test
  raise "oops!" unless test
end

def assert_equal actual, expected
  raise "whoops! expected #{expected} but got #{actual}" unless expected == actual
end

def assert_false test
  raise "waat?" if test
end

def assert_empty collection
  raise "derp." unless collection.empty?
end
