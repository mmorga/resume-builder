# frozen_string_literal: true

require "rake/clean"
require "rubygems"
require_relative "src/resume"

directory "build"
CLEAN.include 'build'

SRC_FILES = FileList.new("build", "*-resume.yaml", "src/**/*", "erb/**/*", "style/**/*")
YAML_FILES = FileList.new("*-resume.yaml")
HTML_FILES = YAML_FILES.ext(".html").gsub(/^/, "build/")
PDF_FILES = YAML_FILES.ext(".pdf").gsub(/^/, "build/")
DOCX_FILES = YAML_FILES.ext(".docx").gsub(/^/, "build/")

WEASYPRINT = Gem.win_platform? ? "weasyprint.exe" : "weasyprint"

YAML_FILES.each do |yaml_file|
  html_file = yaml_file.ext(".html").gsub(/^/, "build/")
  file "#{html_file}": SRC_FILES do
    puts "Building HTML: #{html_file}"
    build_resume(yaml_file, "erb/resume-template.html.erb", html_file)
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

task html: ["build", HTML_FILES].flatten

task pdf: [:html, PDF_FILES].flatten

task word: [:html, DOCX_FILES].flatten

task all: %w[html pdf word]
task all: "build"
task default: :all
