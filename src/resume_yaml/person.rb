# frozen_string_literal: true

require "json"

module ResumeYaml
  class Person
    include YamlMapping

    attr_accessor :description, :name, :given_name, :family_name, :home_page, :job_title,
                  :phone, :email, :image, :birth_date, :gender, :nationality, :skills
    attr_reader :address, :contact_points, :credentials, :occupation, :works_for, :award, :alumni_of

    output_yaml_order :name, :given_name, :family_name, :description,
                      :home_page, :job_title, :phone, :email, :image, :birth_date, :gender,
                      :nationality, :address, :contact_points, :credentials, :occupation, :works_for,
                      :award, :alumni_of, :skills

    def address=(obj)
      @address = PostalAddress.from_hash(obj)
    end

    def occupation=(obj)
      @occupation = EmployeeRole.from_hash(obj)
    end

    def works_for=(obj)
      @works_for = Organization.from_hash(obj)
    end

    def contact_points=(contact_points)
      @contact_points = default_array(contact_points).map { |cp| ContactPoint.from_hash(cp) }
    end

    def credentials=(credentials)
      @credentials = default_array(credentials).map { |cp| Degree.from_hash(cp) }
    end

    def alumni_of=(jobs)
      @alumni_of = default_array(jobs).map { |job| Job.from_hash(job) }
    end

    def award=(awards)
      @award = default_array(awards)
    end

    def anchor
      "##{given_name}"
    end

    def json_ld_array(ary)
      return nil if ary.nil?

      ld_ary = ary.map(&:json_ld).compact

      ld_ary.empty? ? nil : ld_ary
    end

    def nilable_array(val)
      return nil if val.nil? || val.empty?

      val
    end

    def alumni_of_json_ld
      return nil if alumni_of.nil? || alumni_of.empty?

      alumni_of.map { |j| j.json_ld(anchor) }.compact
    end

    def skills_json_ld
      return nil if skills.nil? || skills.empty?

      return skills if skills.is_a?(Array)

      skills.map do |k, v|
        {
          "@type" => "DefinedTerm",
          "name" => k,
          "description" => v
        }.compact
      end
    end

    def json_ld
      JSON.pretty_generate({
        "@context" => "http://schema.org/",
        "@type" => "Person",
        "@id" => anchor,
        "name" => name,
        "givenName" => given_name,
        "familyName" => family_name,
        "jobTitle" => job_title,
        "description" => description,
        "telephone" => phone,
        "email" => email,
        "url" => home_page,
        "image" => image,
        "birthDate" => birth_date,
        "gender" => gender,
        "nationality" => nationality,
        "address" => address&.json_ld,
        "contactPoint" => json_ld_array(contact_points),
        "hasCredential" => json_ld_array(credentials),
        "hasOccupation" => occupation&.json_ld,
        "worksFor" => works_for&.json_ld,
        "award" => nilable_array(award),
        "skills" => skills_json_ld,
        "alumniOf" => alumni_of_json_ld
      }.compact)
    end
  end
end
