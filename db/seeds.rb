# db/seeds.rb
=begin
# Criando um SystemAdmin
system_admin = SystemAdmin.create(
  name: 'Admin Bernardo',
  email: 'dinhomcardozo@gmail.com',
  password: 'senha123'
)

# Criando um Client associado ao SystemAdmin
client = Client.create(
  name: 'Cliente Bernardo',
  email: 'bernardomcardozo@gmail.com',
  system_admin_id: system_admin.id
)

# Criação de um User associado ao Client
user = User.create!(
  name: 'Usuário Bernardo',
  email: 'bernardomcardozo@gmail.com',
  password: 'senha123', # Adicione a senha para o usuário
  client: client
)
=end

=begin
=end


# ------------------- ARQUIVO CRIADO PARA POPULAR DB POSTGRESQL -------------------

# ------------------- SystemAdmin

system_admin1 = SystemAdmin.create!(
  name: "Admin Principal",
  email: "admin1@example.com",
  password: "senha123",
)

system_admin2 = SystemAdmin.create!(
  name: "Admin Secundário",
  email: "admin2@example.com",
  password: "senha123",
)

# ------------------- Clients

client1 = Client.create!(
  name: "Cliente Alpha",
  email: "cliente_alpha@example.com",
  system_admin_id: system_admin1.id
)

client2 = Client.create!(
  name: "Cliente Beta",
  email: "cliente_beta@example.com",
  system_admin_id: system_admin2.id
)

# ------------------- Users
User.create!(
  name: "Bernardo User",
  email: "dinhobear.ness@gmail.com",
  password: 'senha123', # Adicione uma senha aqui
  client_id: client1.id,
  user_admin: true,
)

User.create!(
  name: "Usuário Comum",
  email: "common_user@example.com",
  password: 'senhad123', # Adicione uma senha aqui
  client_id: client2.id,
  user_admin: false,
)

# ------------------- Stages

# Definindo os estágios com suas descrições e posições
stages = [
  { description: 'Prospects', position: 1, active: true },
  { description: 'Lead', position: 2, active: true },
  { description: 'Demonstration', position: 3, active: true },
  { description: 'Quote', position: 4, active: true },
  { description: 'Sale', position: 5, active: true },
  { description: 'LossSale', position: 6, active: true },
  { description: 'PostSales', position: 7, active: true },
  { description: 'AboutToRenew', position: 8, active: true },
  { description: 'Renewed', position: 9, active: true },
  { description: 'NotRenewed', position: 10, active: true }
]

# Criando ou atualizando os estágios no banco de dados
stages.each do |stage|
  Stage.find_or_create_by!(description: stage[:description]) do |s|
    s.position = stage[:position]
    s.active = stage[:active]
  end
end


# ------------------- ClientsProducts

ClientsProduct.create!(
  name: "Produto Alpha",
  product_license_start: Time.now,
  product_license_end: Time.now + 1.year,
  client_id: client1.id
)

ClientsProduct.create!(
  name: "Produto Beta",
  product_license_start: Time.now,
  product_license_end: Time.now + 1.year,
  client_id: client2.id
)

# ------------------- Groups
group1 = Group.create!(
  name: "Grupo A",
  client_id: client1.id
)

group2 = Group.create!(
  name: "Grupo B",
  client_id: client2.id
)

# ------------------- Companies

company1 = Company.create!(
  name: "Empresa X",
  cnpj: "12345678901234",
  group_id: group1.id
)

company2 = Company.create!(
  name: "Empresa Y",
  cnpj: "98765432109876",
  group_id: group2.id
)

# ------------------- Contacts

contact1 = Contact.create!(
  first_name: "João",
  last_name: "Silva",
  email: "joao.silva@example.com",
  telephone: "123456789",
  company_id: company1.id,
  group_id: group1.id
)

contact2 = Contact.create!(
  first_name: "Maria",
  last_name: "Souza",
  email: "maria.souza@example.com",
  telephone: "987654321",
  company_id: company2.id,
  group_id: group2.id
)

# ------------------- Opportunities

=begin
# Verificando se o estágio 'Prospects' existe e movendo a oportunidade para ele
new_stage = Stage.find_by(description: 'Prospects')
if new_stage
  opportunity.move_to_stage(new_stage)
else
  puts "Estágio 'Prospects' não encontrado!"
end

# Caso o estágio não exista, você pode criá-lo ou pular a movimentação
=end

if new_stage
  opportunity = Opportunity.create!
  opportunity.move_to_stage(new_stage)
else
  puts "Estágio 'Prospects' não encontrado!"
end

# Criando uma nova oportunidade associada ao contato e ao estágio correto
Opportunity.create(
  contact: contact,
  user: user,
  stage: stage,  # Certifique-se de passar o estágio correto aqui
  opp_status: :ativo
)

opportunity = Opportunity.create!(
  contact: contact,
  user: user,
  stage: stage,
  clients_products: [product],
  opp_status: :ativo
)

# ------------------- Contracts
Contract.create!(
  opportunity_id: opportunity1.id,
  contract_date: Date.today,
  contract_end_date: Date.today + 1.year
)

Contract.create!(
  opportunity_id: opportunity2.id,
  contract_date: Date.today,
  contract_end_date: Date.today + 2.years
)

clients_product = ClientsProduct.create!(
  name: 'Produto A',
  product_license_start: Time.now,
  product_license_end: Time.now + 1.year,
  client: client
)


# ------------------- FIM DO ARQUIVO CRIADO PARA POPULAR DB POSTGRESQL -------------------

# Exemplo de outros dados, caso necessário
puts "SystemAdmin e Client criados com sucesso!"


SystemAdmin.create(name: 'Admin Principal', email: 'admin@ellipsis.com')
Client.create(name: 'Cliente 1', email: 'client1@empresa.com', system_admin_id: 1)
Stage.create(name: 'Prospect')
Stage.create(name: 'Lead')
Stage.create(name: 'Demonstration')
Stage.create(name: 'Quote')
Stage.create(name: 'Sale')