class OpportunitiesController < ApplicationController
  before_action :set_client
  load_and_authorize_resource # from app/models/ability.rb

  def index
  end

  def show
  end

  def new
    @opportunity = Opportunity.new
    @stages = Stage.all
    @contacts = @client.contacts
    @client_products = @client.clients_products
  end

  def create
    @opportunity = @client.opportunities.new(opportunity_params)
    
    if @opportunity.save
      redirect_to @opportunity, notice: 'Oportunidade criada com sucesso.'
    else
      @stages = Stage.all
      @contacts = @client.contacts
      @client_products = @client.clients_products
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_client
    @client = current_user.client
  end

  def opportunity_params
    params.require(:opportunity).permit(:contact_id, :user_id, :stage_id, clients_product_ids: [])
  end
end
