task default: %w[html pdf]

directory "build"

file "build/markmorga-resume.html": %w[build markmorga-resume.html.haml style/resume.css] do
  puts "Building HTML"
  sh "bundle exec haml markmorga-resume.html.haml build/markmorga-resume.html"
end

file "build/markmorga-resume.pdf": %w[build build/markmorga-resume.html] do
  puts "Building PDF"
  sh "wkhtmltopdf -s Letter build/markmorga-resume.html build/markmorga-resume.pdf"
# -B 1in -L 1in -R 1in -T 1in
end

task html: "build/markmorga-resume.html"

task pdf: [:html, "build/markmorga-resume.pdf"]

task :clean do
  rm_r "build"
end
