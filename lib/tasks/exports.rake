# frozen_string_literal: true

namespace :export do
  include Decidim::TranslatableAttributes

  desc "Checks for the environment"
  task :signatures, [:initiative_id] => :environment do |task, args|
    initiative= Decidim::Initiative.find(args.initiative_id)
    puts "Loaded Initiative: #{translated_attribute(initiative.title)}"

    votes= initiative.votes.votes
    puts "ID,Initiative title,Name and surname,document_number,date_of_birth,postal_code,created_at,timestamp"
    votes.each do |vote|
      metadata= read_metadata(vote)
      row= [initiative.reference]
      row << translated_attribute(initiative.title)
      row << name_and_surname(metadata)
      row << document_number(metadata)
      row << date_of_birth(metadata)
      row << postal_code(metadata)
      row << vote.created_at
      row << vote.sha1
      puts row.join(',')
    end
  end

  def name_and_surname(metadata)
    metadata[:name_and_surname]
  end

  def document_number(metadata)
    metadata[:document_number]
  end

  def date_of_birth(metadata)
    metadata[:date_of_birth]
  end

  def postal_code(metadata)
    metadata[:postal_code]
  end

  def encryptor
    @encryptor ||= Decidim::Initiatives::DataEncryptor.new(secret: "personal user metadata")
  end

  def read_metadata(vote)
    vote.encrypted_metadata ? encryptor.decrypt(vote.encrypted_metadata) : {}
  end

end
