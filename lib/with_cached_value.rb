def cache_value(file,value)
  File.open(file,'w') {|f| f.write(value)}
end

def with_cached_value(file, init_value, &block)
  cache_value(file, init_value) unless File.exist?(file)
  value = File.open(file).read.to_i
  begin
    next_value = yield value
  rescue => e
    puts e.message
    next_value = value + 1
  end
  cache_value(file, next_value)
end
