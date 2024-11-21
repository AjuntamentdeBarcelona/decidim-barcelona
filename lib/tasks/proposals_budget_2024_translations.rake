# frozen_string_literal: true

namespace :proposals_budget_2024_translations do
  desc "[CATALAN] Fix translations in proposals for the 2024 particiatory budget"
  task update_ca_translations: :environment do
    updated_content = {
      "decidim.barcelona.pressupostos.2024.pregunta2.enunciat" => "Estat actual i problemes a resoldre:",
      "decidim.barcelona.pressupostos.2024.pregunta3.enunciat" => "Descripció de la proposta i impacte esperat:",
      "decidim.barcelona.pressupostos.2024.pregunta4.enunciat" => "Cost aproximat (opcional):",
      "decidim.barcelona.pressupostos.2024.pregunta5.enunciat" => "A qui més pot interessar la proposta i estaria bé tenir en compte en el projecte?"
    }

    update_content_for_lang "ca", updated_content
  end

  desc "[SPANISH] Fix translations in proposals for the 2024 particiatory budget"
  task update_es_translations: :environment do
    updated_content = {
      "decidim.barcelona.pressupostos.2024.pregunta2.enunciat" => "Estado actual y problemas a resolver:",
      "decidim.barcelona.pressupostos.2024.pregunta3.enunciat" => "Descripción de la propuesta e impacto esperado:",
      "decidim.barcelona.pressupostos.2024.pregunta4.enunciat" => "Coste aproximado (opcional):",
      "decidim.barcelona.pressupostos.2024.pregunta5.enunciat" => "¿A quién más puede interesarle la propuesta y estaría bien tener en cuenta en el proyecto?"
    }

    update_content_for_lang "es", updated_content
  end

  def update_content_for_lang(lang, content)
    puts "Processing lang #{lang}"

    proposals = Decidim::Proposals::Proposal.where(
      "body ->> '#{lang}' LIKE ?", "%decidim.barcelona.pressupostos.2024.pregunta2.enunciat%"
    )

    puts "There are #{proposals.count} proposals to update"

    proposals.find_each do |proposal|
      puts "Processing Proposal ID: #{proposal.id}"

      body = proposal.body[lang]

      content.each do |copy_id, new_text|
        puts "Updating #{copy_id} for Proposal ID: #{proposal.id}"

        body[copy_id] = new_text
      end

      proposal.body[lang] = body
      proposal.save!

      puts "Successfully updated #{lang} content for Proposal ID: #{proposal.id}"
    end
  end
end
