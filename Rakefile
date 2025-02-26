# frozen_string_literal: true

require_relative "src/resume"

task default: %w[html pdf]

directory "build"

SRC_FILES = FileList.new("build", "*-resume.yaml", "src/**/*", "erb/**/*", "style/**/*")
YAML_FILES = FileList.new("*-resume.yaml")
HTML_FILES = YAML_FILES.ext(".html").gsub(/^/, "build/")
PDF_FILES = YAML_FILES.ext(".pdf").gsub(/^/, "build/")
DOCX_FILES = YAML_FILES.ext(".docx").gsub(/^/, "build/")

YAML_FILES.each do |yaml_file|
  html_file = yaml_file.ext(".html").gsub(/^/, "build/")
  file "#{html_file}": SRC_FILES do
    puts "Building HTML"
    build_resume(yaml_file, "erb/resume-template.html.erb", html_file)
  end

  pdf_file = yaml_file.ext(".pdf").gsub(/^/, "build/")
  file "#{pdf_file}": html_file do
    puts "Building PDF"
    sh "weasyprint --custom-metadata #{html_file} #{pdf_file}"
  end

  docx_file = yaml_file.ext(".docx").gsub(/^/, "build/")
  file "#{docx_file}": html_file do
    puts "Building Word DOCX"
    sh "pandoc -s #{html_file} -o #{docx_file}"
  end
end

task html: HTML_FILES

task pdf: [:html, PDF_FILES].flatten

task word: [:html, DOCX_FILES].flatten

task all: %i[html pdf word]

task :clean do
  rm_r "build"
end
