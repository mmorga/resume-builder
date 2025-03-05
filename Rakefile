# frozen_string_literal: true

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "src")

require "resume_builder"

directory "build"

SRC_FILES = FileList.new("build", "*-resume.yaml", "src/**/*", "erb/**/*", "style/**/*")
YAML_FILES = FileList.new("*-resume.yaml")
HTML_FILES = YAML_FILES.ext(".html").gsub(/^/, "build/")
PDF_FILES = YAML_FILES.ext(".pdf").gsub(/^/, "build/")
DOCX_FILES = YAML_FILES.ext(".docx").gsub(/^/, "build/")

WEASYPRINT = Gem::Platform.match(Gem::Platform::WINDOWS) ? "weasyprint.exe" : "weasyprint"

YAML_FILES.each do |yaml_file|
  html_file = yaml_file.ext(".html").gsub(/^/, "build/")
  file "#{html_file}": SRC_FILES do
    puts "Building HTML: #{html_file}"
    build_resume(yaml_file, "erb/resume-template.html.erb", html_file)
    sh "tidy -config .tidyrc -m #{html_file}"
  end

  pdf_file = yaml_file.ext(".pdf").gsub(/^/, "build/")
  file "#{pdf_file}": html_file do
    puts "Building PDF: #{pdf_file}"
    sh "#{WEASYPRINT} --custom-metadata #{html_file} #{pdf_file}"
  end

  docx_file = yaml_file.ext(".docx").gsub(/^/, "build/")
  file "#{docx_file}": html_file do
    puts "Building Word DOCX: #{docx_file}"
    sh "pandoc -s #{html_file} -o #{docx_file}"
  end
end

desc "Build HTML resume"
task html: HTML_FILES

desc "Build PDF resume"
task pdf: [:html, PDF_FILES].flatten

desc "Build Word resume"
task word: [:html, DOCX_FILES].flatten

desc "Build all resume formats"
task all: %i[html pdf word]

desc "Remove build directory"
task :clean do
  rm_r "build"
end

task default: :all
