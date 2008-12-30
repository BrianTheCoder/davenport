require 'rake/clean'

# use .gitignore to identify files to clean up
patterns = File.read(Merb.root / '.gitignore').split(/\s+/).map do |pattern|
  pattern.include?('/') ? pattern : "**/#{pattern}"
end

CLEAN.include Dir.glob(patterns)
