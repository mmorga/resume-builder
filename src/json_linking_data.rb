# frozen_string_literal: true

require "json"

module JsonLinkingData
  def self.anchor(data)
    "##{data.meta.given_name}"
  end

  def self.alumni_of(data)
    jobs = data.history.jobs
    return nil if jobs.nil? || jobs.empty?

    jobs.map do |job|
      {
        "@type" => "Organization",
        "name" => job.company,
        "sameAs" => job.url,
        "employee" => {
          "@type" => "Person",
          "hasOccupation" => {
            "@type" => "EmployeeRole",
            "roleName" => job.title,
            "startDate" => job.start_date,
            "endDate" => job.end_date
          }.compact,
          "sameAs" => anchor(data)
        }.compact
      }.compact
    end
  end

  def self.skills(skills)
    return skills if skills.is_a?(Array)

    skills.content.map do |k, v|
      {
        "@type" => "DefinedTerm",
        "name" => k,
        "description" => v
      }.compact
    end
  end

  def self.address(data)
    {
      "@type" => "PostalAddress",
      "streetAddress" => data.meta.street_address,
      "addressLocality" => data.meta.address_locality,
      "addressRegion" => data.meta.address_region,
      "addressCountry" => data.meta.address_country,
      "postalCode" => data.meta.postal_code
    }.compact
  end

  def self.contact_points(data)
    data.meta.contact_points.map do |cp|
      {
        "@type" => "ContactPoint",
        "contactType" => cp.contact_type,
        "identifier" => cp.identifier,
        "image" => cp.image,
        "url" => cp.url
      }.compact
    end
  end

  def self.aggregate_rating(aggregate_rating)
    return nil if aggregate_rating.nil? || [aggregate_rating.rating_value, aggregate_rating.name].all?(&:nil?)

    {
      "@type" => "aggregateRating",
      "ratingValue" => aggregate_rating.rating_value,
      "name" => aggregate_rating.name
    }.compact
  end

  def self.degree_about(degree)
    return nil if degree.department.nil?

    {
      "@type" => "EducationalOccupationalProgram",
      "name" => degree.department
    }
  end

  def self.degree_recognized_by(degree)
    return nil if [degree.school, degree.url].all? { |f| f.nil? || f.empty? }

    {
      "@type" => "CollegeOrUniversity",
      "name" => "Some Awesome University",
      "sameAs" => "urlgoeshere"
    }
  end

  def self.credentials(degrees)
    return nil if degrees.nil? || degrees.empty?

    degrees.map do |degree|
      {
        "@type" => "EducationalOccupationalCredential",
        "aggregateRating" => aggregate_rating(degree.aggregate_rating),
        "credentialCategory" => degree.credential_category,
        "educationalLevel" => degree.education_level,
        "dateCreated" => degree.date_created,
        "about" => degree_about(degree),
        "recognizedBy" => degree_recognized_by(degree)
      }.compact
    end
  end

  def self.json_linking_data(data)
    JSON.pretty_generate({
      "@context" => "http://schema.org/",
      "@type" => "Person",
      "@id" => "##{data.meta.given_name}",
      "name" => data.title.name,
      "givenName" => data.meta.given_name,
      "familyName" => data.meta.family_name,
      "jobTitle" => data.meta.job_title,
      "description" => data.meta.description,
      "telephone" => data.meta.phone,
      "email" => data.meta.email,
      "url" => data.meta.home_page,
      "image" => data.meta.image,
      "birthDate" => data.meta.birth_date,
      "gender" => data.meta.gender,
      "nationality" => data.meta.nationality,
      "address" => address(data),
      "contactPoint" => contact_points(data),
      "hasCredential" => credentials(data.education.degrees),
      "hasOccupation" => occupation(data.meta.occupation),
      "worksFor" => works_for(data.meta.works_for),
      "award" => award(data.meta.award),
      "skills" => skills(data.skills),
      "alumniOf" => alumni_of(data)
    }.compact)
  end

  def self.occupation(occupation)
    return nil if occupation.nil? || [occupation.role_name, occupation.start_date].all?(&:nil?)

    {
      "@type" => "EmployeeRole",
      "roleName" => occupation.role_name,
      "startDate" => occupation.start_date
    }.compact
  end

  def self.works_for(works_for)
    return nil if works_for

    {
      "@type" => "Organization",
      "name" => works_for.name,
      "sameAs" => works_for.same_as
    }.compact
  end

  def self.award(award)
    return nil if award.nil? || award.empty?

    award
  end
end
