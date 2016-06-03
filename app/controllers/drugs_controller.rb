class DrugsController < ApplicationController
  before_action :set_drug, only: [:show, :edit, :update, :destroy]

  # GET /drugs
  def index
    @drugs = Drug.all.sort_by(&:ends_at)
  end

  # GET /drugs/1
  def show
  end

  # GET /drugs/new
  def new
    @drug = Drug.new
    @drug.active = true
  end

  # GET /drugs/1/edit
  def edit
  end

  # POST /drugs
  def create
    @drug = Drug.new(drug_params)
    @drug.active = true

    respond_to do |format|
      if @drug.save
        track(@drug, "Drug added {id: #{@drug.id}} #{drug_params}")
        format.html { redirect_to root_path, notice: 'Drug was successfully created.' }
        format.json { render :show, status: :created, location: @drug }
      else
        format.html { render :new }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drugs/1
  def update
    respond_to do |format|
      if @drug.update(drug_params)
        track(@drug, "Drug updated {id: #{@drug.id}} #{drug_params}")
        format.html { redirect_to @drug, notice: 'Drug was successfully updated.' }
        format.json { render :show, status: :ok, location: @drug }
      else
        format.html { render :edit }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drugs/1
  def destroy
    track(@drug, "Drug removed {id: #{@drug.id}}")
    @drug.destroy
    respond_to do |format|
      format.html { redirect_to drugs_url, notice: 'Drug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_drug
      id = params[:id] || params[:drug_id]
      @drug = Drug.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drug_params
      params.require(:drug).permit(:name, :note, :active, :reset_amount, :reset_at, :format, :format_type, :prescription)
    end
end
