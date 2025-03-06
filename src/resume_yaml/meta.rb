# frozen_string_literal: true

module ResumeYaml
  class Meta
    include YamlMapping

    attr_accessor :description, :keywords, :author, :copyright, :license,
                  :canonical_link, :pdf_link, :created, :given_name, :family_name,
                  :home_page, :job_title, :phone, :email, :image, :birth_date, :gender,
                  :nationality, :post_office_box_number, :street_address, :address_locality,
                  :address_region, :postal_code, :address_country
    attr_reader :twitter, :contact_points, :occupation, :works_for, :award

    output_yaml_order :created, :description, :keywords, :author, :copyright, :license,
                      :canonical_link, :pdf_link, :twitter, :given_name, :family_name,
                      :home_page, :job_title, :phone, :email, :image, :birth_date, :gender,
                      :nationality, :post_office_box_number, :street_address, :address_locality,
                      :address_region, :postal_code, :address_country, :contact_points, :occupation, :works_for, :award

    def twitter=(obj)
      @twitter = Twitter.from_hash(obj)
    end

    def occupation=(obj)
      @occupation = Occupation.from_hash(obj)
    end

    def works_for=(obj)
      @works_for = WorksFor.from_hash(obj)
    end

    def contact_points=(contact_points)
      @contact_points = default_array(contact_points).map { |cp| ContactPoint.from_hash(cp) }
    end

    def award=(awards)
      @award = default_array(awards)
    end
  end
end
