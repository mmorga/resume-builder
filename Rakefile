task default: %w[html]

directory "build"

file "build/markmorga-resume.html": %w[build markmorga-resume.html.haml style/resume.css] do
  puts "Building HTML"
  system "bundle exec haml markmorga-resume.html.haml build/markmorga-resume.html"
end

task html: "build/markmorga-resume.html"

task :clean do
  rm "build/markmorga-resume.html"
  rmdir "build"
end
