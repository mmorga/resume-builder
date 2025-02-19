task default: %w[html pdf]

directory "build"

file "build/markmorga-resume.html": %w[build markmorga-resume.html.haml style/resume.css] do
  puts "Building HTML"
  sh "bundle exec haml render --no-escape-html markmorga-resume.html.haml > build/markmorga-resume.html"
end

file "build/markmorga-resume.pdf": %w[build build/markmorga-resume.html] do
  puts "Building PDF"
  sh "weasyprint build/markmorga-resume.html build/markmorga-resume.pdf"
end

file "build/markmorga-resume.docx": %w[build build/markmorga-resume.html] do
  puts "Building Word DOCX"
  sh "pandoc -s build/markmorga-resume.html -o build/markmorga-resume.docx"
end

task html: "build/markmorga-resume.html"

task pdf: [:html, "build/markmorga-resume.pdf"]

task word: [:html, "build/markmorga-resume.docx"]

task :clean do
  rm_r "build"
end
