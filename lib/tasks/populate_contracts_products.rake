namespace :db do
    desc "Popula a coluna products em contracts com os produtos da oportunidade"
    task populate_contracts_products: :environment do
      puts "Iniciando a atualização dos contratos..."
  
      Contract.find_each do |contract|
        if contract.opportunity.present?
          contract.update(products: contract.opportunity.clients_products.pluck(:id))
          puts "Contrato ##{contract.id} atualizado com produtos: #{contract.products}"
        else
          puts "Contrato ##{contract.id} ignorado (sem oportunidade associada)."
        end
      end
  
      puts "Atualização concluída!"
    end
  end
  