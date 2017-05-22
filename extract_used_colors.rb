require 'tmpdir'
require 'pathname'

targets = Pathname.glob('live/app/javascript/styles/*.scss') + Pathname.glob('live/app/assets/stylesheets/*.scss')

target_contents = targets.map{|f| f.read}.join
target_contents.scan(/(?<paren>(?:darken|lighten|rgba)\((?:[^()]|\g<paren>)*\))|(?<var>\$color\d)|(?<hex>\#[\da-f]{6})/).flatten.compact.uniq.sort.each do |colorspec|
  print colorspec, "\n"
end
