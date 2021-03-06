class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  def index
    @purchases = Purchase.all.reverse
  end

  # GET /purchases/1
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.drug_id = params[:drug_id]

    respond_to do |format|
      if @purchase.save
        track(@purchase, :create, @purchase.inspect)
        format.html { redirect_to @purchase.drug, notice: create_success_notice }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        track(@purchase, :udpate, purchase_params)
        format.html { redirect_to @purchase, notice: update_success_notice }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  def destroy
    drug = @purchase.drug
    track(@purchase, :destroy, @purchase.inspect)
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to drug, notice: destroy_success_notice }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:when, :note, :amount, :drug_id)
    end
end
