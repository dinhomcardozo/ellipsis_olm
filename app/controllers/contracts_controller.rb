class ContractsController < ApplicationController
  load_and_authorize_resource # from app/models/ability.rb

  def index
    # Lista apenas os contratos autorizados para o usuário atual
    @contracts = @contracts.includes(:opportunity) # Evita N+1 queries
  end

  def show
    # Mostra um contrato específico autorizado
  end

  def new
    # Inicializa um novo contrato
    @contract = Contract.new
  end

  def create # Cria um novo contrato
    @contract = Contract.new(contract_params)
    if @contract.save
      flash[:notice] = 'Contrato criado com sucesso!'
      redirect_to contracts_path
    else
      flash[:alert] = 'Erro ao criar contrato.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Edita um contrato autorizado
  end

  def update
    # Atualiza o contrato autorizado
    if @contract.update(contract_params)
      redirect_to @contract, notice: 'Contrato atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # Remove o contrato autorizado
    @contract.destroy
    redirect_to contracts_path, notice: 'Contrato removido com sucesso.'
  end

  private

  def contract_params
    # Permite os atributos do contrato
    params.require(:contract).permit(:opportunity_id, :contract_date, :contract_end_date)
  end
end