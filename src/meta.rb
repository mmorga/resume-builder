# frozen_string_literal: true

HEAD_META = [
  ->(meta) { tag(:meta, itemprop: "inLanguage", content: meta&.language || "en") },
  ->(meta) { tag(:meta, name: "description", content: meta.description) if meta&.description },
  ->(meta) { tag(:meta, name: "keywords", itemprop: "keywords", content: meta.keywords) if meta&.keywords },
  ->(meta) { tag(:meta, name: "author", itemprop: "author", content: meta.author) if meta&.author },
  ->(meta) { tag(:meta, name: "copyright", content: meta.copyright) if meta&.copyright },
  ->(meta) { tag(:link, rel: "license", href: meta.license) if meta&.license },
  ->(meta) { tag(:link, rel: "canonical", href: meta.canonical_link) },
  ->(meta) { tag(:link, rel: "alternate", type: "application/pdf", href: meta.pdf_link) if meta&.pdf_link },
  ->(meta) { tag(:meta, name: "twitter:card", content: meta.twitter.card) if meta&.twitter&.card },
  ->(meta) { tag(:meta, name: "twitter:site", content: meta.twitter.site) if meta&.twitter&.site },
  ->(meta) { tag(:meta, name: "twitter:creator", content: meta.twitter.creator) if meta&.twitter&.creator },
  ->(meta) { tag(:meta, name: "twitter:domain", content: meta.twitter.domain) if meta&.twitter&.domain },
  lambda { |meta|
    if meta&.description
      tag(:meta, name: "twitter:description", property: "og:description", itemprop: "description",
                 content: meta.description)
    end
  },
  lambda { |meta|
    tag(:meta, name: "twitter:title", property: "og:title", content: meta.twitter.title) if meta&.twitter&.title
  },
  lambda { |meta|
    tag(:meta, name: "twitter:image", property: "og:image", content: meta.twitter.image) if meta&.twitter&.image
  }
].freeze

def tag(name, **kwargs)
  "<#{name} #{kwargs.map { |k, v| "#{k}=#{v.inspect}" }.join(' ')} />"
end

def meta_tag_list(data)
  HEAD_META.map { |l| l.call(data.meta) }.compact.join("\n")
end
