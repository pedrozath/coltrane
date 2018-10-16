require 'coltrane/ui/views/view'
Dir[File.expand_path('../views/*', __FILE__)].map do |f|
  require(f)
end
