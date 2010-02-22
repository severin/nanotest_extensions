module Nanotest

  @@errors = []
  
  alias :error_handling__orig_assert :assert
  def assert(msg=nil, file=nil, line=nil, stack=caller, &block)
    error_handling__orig_assert(msg, file, line, stack, &block)
  rescue Exception => e
    f,l = stack.first.match(/(.*):(\d+)/)[1..2]
    @@errors << "(%s:%0.3d) %s" % [file || f, line || l, msg || "assertion raised error #{e.class}: #{e.message}"]
    @@dots << 'E'  
  end
  

  def self.results #:nodoc:
    @@dots.join + "\n" + @@failures.join("\n") + "\n" + @@errors.join("\n")
  end
end