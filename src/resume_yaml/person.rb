# frozen_string_literal: true

require "json"

module ResumeYaml
  class Person
    include YamlMapping

    yaml_attr :given_name
    yaml_attr :name
    yaml_attr :family_name
    yaml_attr :additional_name
    yaml_attr :description
    yaml_attr :home_page
    yaml_attr :job_title
    yaml_attr(:seeks) { |obj| Demand.from_hash(obj) }
    yaml_attr :phone
    yaml_attr :email
    yaml_attr :image
    yaml_attr :birth_date
    yaml_attr :gender
    yaml_attr :nationality
    yaml_attr(:address) { |obj| PostalAddress.from_hash(obj) }
    yaml_attr(:contact_points) { |cps| default_array(cps, ContactPoint) }
    yaml_attr(:credentials) { |credentials| default_array(credentials, Degree) }
    yaml_attr(:occupation) { |obj| EmployeeRole.from_hash(obj) }
    yaml_attr(:works_for) { |obj| Organization.from_hash(obj) }
    yaml_attr(:award) { |awards| default_array(awards) }
    yaml_attr(:alumni_of) { |jobs| default_array(jobs, Job) }
    yaml_attr :skills

    def anchor
      "##{given_name}"
    end

    def email_link
      "<a href=\"mailto:#{email}\">#{email}</a>"
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

      return skills.join(",") if skills.is_a?(Array)

      skills.map do |k, v|
        {
          "@type" => "DefinedTerm",
          "name" => k,
          "description" => v
        }.compact
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def json_ld
      JSON.pretty_generate({
        "@context" => "http://schema.org/",
        "@type" => "Person",
        "@id" => anchor,
        "name" => name,
        "givenName" => given_name,
        "familyName" => family_name,
        "additionalName" => additional_name,
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
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
