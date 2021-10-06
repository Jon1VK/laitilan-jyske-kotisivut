class AthletesController < ApplicationController
  before_action :set_athlete, only: %i[ show edit update ]
  before_action :authenticate_athlete!, only: %i[ edit update ]
  before_action :authorize_athlete, only: %i[ edit update ]

  # GET /athletes
  def index
    @athletes = Athlete.all
  end

  # GET /athletes/joni-vainio-kaila
  def show
  end

  # GET /athletes/joni-vainio-kaila/edit
  def edit
  end

  # PATCH/PUT /athletes/joni-vainio-kaila
  def update
    if @athlete.update(athlete_params)
      redirect_to @athlete, notice: "Tietosi päivitettiin onnistuneesti."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athlete
      @athlete = Athlete.friendly.find(params[:id])
    end

    def authorize_athlete
      if current_athlete != @athlete
        redirect_to @athlete, alert: 'Voit muokata ainoastaan omia tietojasi.'
      end
    end

    # Only allow a list of trusted parameters through.
    def athlete_params
      params.require(:athlete).permit(:event, :content)
    end
end
