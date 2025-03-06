# frozen_string_literal: true

module ResumeYaml
  class Meta
    include YamlMapping

    attr_accessor :description, :keywords, :author, :copyright, :license,
                  :canonical_link, :pdf_link, :created, :given_name, :family_name,
                  :home_page, :job_title, :phone, :email, :image, :birth_date, :gender,
                  :nationality, :post_office_box_number, :street_address, :address_locality,
                  :address_region, :postal_code, :address_country
    attr_reader :twitter, :same_as

    output_yaml_order :created, :description, :keywords, :author, :copyright, :license,
                      :canonical_link, :pdf_link, :twitter, :given_name, :family_name,
                      :home_page, :job_title, :phone, :email, :image, :birth_date, :gender,
                      :nationality, :post_office_box_number, :street_address, :address_locality,
                      :address_region, :postal_code, :address_country, :same_as

    def twitter=(obj)
      @twitter = Twitter.from_hash(obj)
    end

    def same_as=(ary)
      @same_as = default_array(ary)
    end
  end
end
