# Require all files in the main lib directory
Dir[File.dirname(__FILE__) + '/poker/*.rb'].each do |file|
  require file
end
