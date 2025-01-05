Importante ressaltar que pode haver um User do Client com atributo Admin, que pode permitir, editar, deletar oportunidades, criar novos usuários apenas no ambiente do Cliente, mas não é o mesmo do System_admin. Inclusive, nenhum usuário do Client pode ter acesso ao System_admin e nenhum usuário do System_Admin pode ter User do Client. A condição pode ser e-mail e/ou CPF e/ou CNPJ. Se o email tiver @ellipsis.com.br, o CPF estiver cadastrado no User do System_Admin ou se o CNPJ for um específico do System_Admin, não deve permitir cadastro no Client, informando uma mensagem direcionada "Usuário é administrador geral do OLM. O mesmo deve ocorrer para um User do System_Admin que tenta cadastrar com email @ellipsis.com.br, e/ou tem CPF no System_Admin e/ou está no CNPJ do System_Admin. Este não terá permissão para cadastrar User no Client.
Dito pelo ChatGPT:
ChatGPT
Memória atualizada
Para adaptar a lógica que você descreveu, vamos trabalhar nos seguintes pontos:

1. Modelo User
A verificação de email, CPF e CNPJ deve ser feita antes da criação do usuário. Vamos adicionar essas validações diretamente no modelo User para garantir que nenhum usuário do tipo "SystemAdmin" possa ser criado dentro do ambiente do cliente.

2. Controle de Criação de Usuários e Oportunidades
No controller do User dentro do Client, podemos verificar se o usuário está tentando criar um admin do SystemAdmin e bloquear a criação, enviando uma mensagem de erro apropriada.

3. Validação de Estágio na Criação de Oportunidade
Ao criar uma nova oportunidade, precisamos garantir que ela seja vinculada a um contact, um cliente_product e um user do Client.

Vamos começar com as mudanças sugeridas:

Modelo User
ruby
Copiar código
# app/models/user.rb
class User < ApplicationRecord
  belongs_to :client
  validates :email, :cpf, :cnpj, presence: true
  validate :check_for_system_admin

  private

  def check_for_system_admin
    if email&.include?("@ellipsis.com.br") || SystemAdmin.exists?(cpf: cpf) || client.cnpj == SystemAdmin.first&.cnpj
      errors.add(:base, "Usuário é administrador geral do OLM. O mesmo não pode ser cadastrado no Cliente.")
    end
  end
end
Aqui, a validação de SystemAdmin é feita usando o email, CPF e CNPJ. Se qualquer uma dessas condições for atendida, o usuário não será criado no ambiente do Client.

Controlador UsersController
No controller do User, podemos ter a seguinte lógica para a criação de novos usuários no ambiente do cliente, levando em conta as validações que adicionamos no modelo.

ruby
Copiar código
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_system_admin, only: [:create]

  def create
    @user = current_client.users.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Usuário criado com sucesso.'
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :cpf, :cnpj, :admin)
  end

  def check_if_system_admin
    if current_user.system_admin?
      redirect_to root_path, alert: 'Não é permitido cadastrar usuários no Client como System Admin.'
    end
  end
end
Criação de Oportunidades
Ao criar uma nova oportunidade, o User deve estar vinculado a um contact e a um cliente_product. Certifique-se de que todos os requisitos sejam atendidos ao criar a oportunidade:

ruby
Copiar código
# app/controllers/opportunities_controller.rb
class OpportunitiesController < ApplicationController
  def new
    @opportunity = Opportunity.new
    @contacts = current_client.contacts
    @cliente_products = current_client.cliente_products
  end

  def create
    @opportunity = Opportunity.new(opportunity_params)
    
    # Verificar se a oportunidade tem pelo menos um contato e um cliente_product
    if @opportunity.contact.nil? || @opportunity.cliente_product.nil?
      flash.now[:alert] = "A oportunidade precisa de pelo menos um contato e um produto cliente."
      render :new
      return
    end

    if @opportunity.save
      redirect_to opportunities_path, notice: 'Oportunidade criada com sucesso.'
    else
      render :new
    end
  end

  private

  def opportunity_params
    params.require(:opportunity).permit(:contact_id, :cliente_product_id, :user_id, :stage_id, :opp_status)
  end
end
Validação de Estágio no Opportunity
Garanta que a oportunidade seja criada com um estágio válido. O SystemAdmin deve ser responsável por gerenciar quais estágios estão ativos.

ruby
Copiar código
# app/models/opportunity.rb
class Opportunity < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  belongs_to :stage
  belongs_to :cliente_product

  validates :contact, :cliente_product, :user, :stage, presence: true

  def move_to_stage(new_stage)
    return if new_stage.nil? || !new_stage.active
    update(stage: new_stage)
  end
end
Views
Na view de criação de oportunidades, ofereça uma interface onde o usuário do cliente possa selecionar o estágio e associar os contatos e produtos do cliente à oportunidade.

erb
Copiar código
<!-- app/views/opportunities/new.html.erb -->
<%= form_with model: @opportunity do |f| %>
  <div>
    <%= f.label :contact_id, 'Contato' %>
    <%= f.collection_select :contact_id, @contacts, :id, :name, prompt: "Selecione um contato" %>
  </div>

  <div>
    <%= f.label :cliente_product_id, 'Produto Cliente' %>
    <%= f.collection_select :cliente_product_id, @cliente_products, :id, :name, prompt: "Selecione um produto cliente" %>
  </div>

  <div>
    <%= f.label :stage_id, 'Estágio' %>
    <%= f.collection_select :stage_id, Stage.where(active: true), :id, :description, prompt: "Selecione um estágio" %>
  </div>

  <div>
    <%= f.submit 'Criar Oportunidade' %>
  </div>
<% end %>
Considerações Finais
Validações de SystemAdmin: Nenhum usuário do Client pode ter acesso aos dados do SystemAdmin. Para isso, fizemos as validações diretamente no modelo User.
Criação de Oportunidades: A criação de oportunidades só será permitida se houver um contato e um produto cliente.
Staging: Apenas um SystemAdmin pode alterar os estágios e definir quais estão ativos.
E-mails, CNPJs e CPFs: A verificação de cadastro de usuários foi ajustada para impedir a criação de usuários que se alinhem com o SystemAdmin.
Essas alterações devem garantir que a lógica seja aplicada corretamente para as regras que você mencionou. Se precisar de mais detalhes ou ajustes específicos, estou à disposição!