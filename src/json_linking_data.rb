# frozen_string_literal: true

require "json"

module JsonLinkingData
  def self.alumni_of(degrees)
    degrees.map do |degree|
      {
        "@type" => "CollegeOrUniversity",
        "name" => degree.school,
        "department" => degree.department,
        "url" => degree.url,
        "description" => degree.description
      }.compact
    end
  end

  def self.skills(skills)
    skills.content.map do |skill|
      skill.inspect
    end
  end

  def self.json_linking_data(data)
    JSON.pretty_generate({
                          "@context" => "http://schema.org/",
                          "@type" => "Person",
                          "@id" => data.meta.canonical_link,
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
                          "address" => {
                            "@type" => "PostalAddress",
                            "streetAddress" => data.meta.street_address,
                            "addressLocality" => data.meta.address_locality,
                            "addressRegion" => data.meta.address_region,
                            "addressCountry" => data.meta.address_country,
                            "postalCode" => data.meta.postal_code
                          }.compact,
                          "sameAs" => data.meta.same_as.compact,
                          "skills" => skills(data.skills),
                          "alumniOf" => alumni_of(data.education.degrees)
                        }.compact)
  end
end

# {
#   "@context": "http://schema.org",
#   "@type": "Person",
#   "@id": "#john",
#   "name": "John Smith",
#   "address": {
#     "@type": "PostalAddress",
#     "addressCountry": "US",
#     "addressLocality": "Austin",
#     "addressRegion": "Florida",
#     "postalCode": "12345",
#     "streetAddress": "123 breeze way"
#   },
#   "email": "john@example.org",
#   "telephone": "1234567890",
#   "image": "",
#   "jobTitle": "Software Developer",
#   "description": "Blip about me...",
#   "contactPoint": [{
#       "@type": "ContactPoint",
#       "contactType": "LinkedIn",
#       "identifier": "johnsmith",
#       "image": "imageurl",
#       "url": "profileurl"
#     },
#     {
#       "@type": "ContactPoint",
#       "contactType": "GitHub",
#       "identifier": "johnsmith",
#       "image": "imageurl",
#       "url": "profileurl"
#     }
#   ],
#   "url": "example.org",
#   "hasCredential": [{
#     "@type": "EducationalOccupationalCredential",
#     "aggregateRating": {
#       "@type": "aggregateRating",
#       "ratingValue": "3.51",
#       "name": "GPA"
#     },
#     "credentialCategory": "degree",
#     "educationalLevel": "Bachelors of Science",
#     "dateCreated": "2015-05",
#     "about": {
#       "@type": "EducationalOccupationalProgram",
#       "name": "Computer Engineering"
#     },
#     "recognizedBy": {
#       "@type": "CollegeOrUniversity",
#       "name": "Some Awesome University",
#       "sameAs": "urlgoeshere"
#     }
#   }],
#   "hasOccupation": {
#     "@type": "EmployeeRole",
#     "roleName": "role title goes here",
#     "startDate": "2015-06"
#   },
#   "worksFor": {
#     "@type": "Organization",
#     "name": "big company",
#     "sameAs": "urlgoeshere"
#   },
#   "award": [
#     "Organizational Achievement Awards Q3'17, Q2'19, Q3'19",
#     "Divisional Recognition Award Q1'19",
#     "Dean's List: Spring '12,'14; Fall '13",
#     "President's List: Spring '13; Fall '14",
#     "Eagle Scout Leadership Service Award 2011"
#   ],
#   "alumniOf": [{
#       "@type": "Organization",
#       "name": "old workplace",
#       "sameAs": "urlgoeshere",
#       "employee": {
#         "@type": "Person",
#         "hasOccupation": {
#           "@type": "EmployeeRole",
#           "roleName": "Computer Consultant",
#           "startDate": "2012-08",
#           "endDate": "2015-05"
#         },
#         "sameAs": "#john"
#       }
#     },
#     {
#       "@type": "Organization",
#       "name": "another company",
#       "sameAs": "urlgoeshere",
#       "employee": {
#         "@type": "Person",
#         "hasOccupation": {
#           "@type": "EmployeeRole",
#           "roleName": "internship",
#           "startDate": "2014-05",
#           "endDate": "2014-08"
#         },
#         "sameAs": "#john"
#       }
#     }
#   ]
# }
