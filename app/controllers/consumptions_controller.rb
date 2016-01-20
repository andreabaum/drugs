class ConsumptionsController < ApplicationController
  before_action :set_consumption, only: [:show, :edit, :update, :destroy]

  def index
    @consumptions = Consumption.all
  end

  def show
  end

  def new
    @consumption = Consumption.new
  end

  def edit
  end

  def create
    @consumption = Consumption.new(consumption_params)
    @consumption.drug_id = params[:drug_id]

    respond_to do |format|
      if @consumption.save
        format.html { redirect_to @consumption.drug, notice: 'Consumption was successfully created.' }
        format.json { render :show, status: :created, location: @consumption }
      else
        format.html { render :new }
        format.json { render json: @consumption.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @consumption.update(consumption_params)
        format.html { redirect_to @consumption, notice: 'Consumption was successfully updated.' }
        format.json { render :show, status: :ok, location: @consumption }
      else
        format.html { render :edit }
        format.json { render json: @consumption.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    drug = @consumption.drug
    @consumption.destroy
    respond_to do |format|
      format.html { redirect_to drug, notice: 'Consumption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumption
      @consumption = Consumption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumption_params
      params.require(:consumption).permit(:when, :note, :amount, :drug_id)
    end
end
