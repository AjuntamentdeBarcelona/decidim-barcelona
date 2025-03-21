# frozen_string_literal: true

namespace :fix_proposals_translations do
  desc "Fix translations in the body of the proposals for Catalan"
  task ca: :environment do
    updated_content = {
      "decidim.barcelona.pressupostos.2024.pregunta2.enunciat" => "Estat actual i problemes a resoldre:",
      "decidim.barcelona.pressupostos.2024.pregunta3.enunciat" => "Descripció de la proposta i impacte esperat:",
      "decidim.barcelona.pressupostos.2024.pregunta4.enunciat" => "Cost aproximat (opcional):",
      "decidim.barcelona.pressupostos.2024.pregunta5.enunciat" => "A qui més pot interessar la proposta i estaria bé tenir en compte en el projecte?",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.encapcalemanet1.titol" => "SOBRE L'ACCIÓ PER LA SOSTENIBILITAT",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.encapcalemanet2.titol" => "SOBRE L'ORGANITZACIÓ",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta2.enunciat" => "Breu descripció de l'acció:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta3.enunciat" => "Enllaç a més informació:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta4.enunciat" => "Data d'inici:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta5.enunciat" => "Nom de l'organització:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta6.enunciat" => "Web de l'organització:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta7.enunciat" => "Correu electrònic de l'organització:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta8.enunciat" => "En el cas d'estar adherit a alguna entitat associativa (associació, gremi, col·legi) indica'ns el nom:"
    }

    update_content_for_lang "ca", updated_content
  end

  desc "Fix translations in the body of the proposals for Spanish"
  task es: :environment do
    updated_content = {
      "decidim.barcelona.pressupostos.2024.pregunta2.enunciat" => "Estado actual y problemas a resolver:",
      "decidim.barcelona.pressupostos.2024.pregunta3.enunciat" => "Descripción de la propuesta e impacto esperado:",
      "decidim.barcelona.pressupostos.2024.pregunta4.enunciat" => "Coste aproximado (opcional):",
      "decidim.barcelona.pressupostos.2024.pregunta5.enunciat" => "¿A quién más puede interesarle la propuesta y estaría bien tener en cuenta en el proyecto?",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.encapcalemanet1.titol" => "SOBRE LA ACCIÓN PARA LA SOSTENIBILIDAD",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.encapcalemanet2.titol" => "SOBRE LA ORGANIZACIÓN",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta2.enunciat" => "Breve descripción de la acción:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta3.enunciat" => "Enlace a más información:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta4.enunciat" => "Fecha de inicio:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta5.enunciat" => "Nombre de la organización:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta6.enunciat" => "Web de la organización:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta7.enunciat" => "Correo electrónico de la organización:",
      "decidim.barcelona.consell.sostenibilitat.bones.practiques.2024.pregunta8.enunciat" => "En el caso de estar adherido a alguna entidad asociativa (asociación, gremio, colegio) indícanos el nombre:"
    }

    update_content_for_lang "es", updated_content
  end

  def update_content_for_lang(lang, content)
    puts "Processing language #{lang}"

    proposals = Decidim::Proposals::Proposal.where(content.keys.map { |_| "body ->> ? LIKE ?" }.join(" OR "), *content.keys.flat_map { |key| [lang, "%#{key}%"] })

    puts "There are #{proposals.count} proposals to update"

    proposals.find_each do |proposal|
      puts "Processing Proposal ID: #{proposal.id}"

      body = proposal.body[lang]

      content.each do |copy_id, new_text|
        next if body[copy_id].nil?

        puts "Updating #{copy_id} for Proposal ID: #{proposal.id}"
        body[copy_id] = new_text
      end

      proposal.body[lang] = body
      proposal.save!

      puts "Successfully updated #{lang} content for Proposal ID: #{proposal.id}"
    end
  end
end
