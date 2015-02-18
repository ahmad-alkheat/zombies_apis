class Api::ZombiesController < ApplicationController

  def index
    zombies = Zombie.all
    if weapon = params[:weapon]
      zombies = zombies.where(weapon: weapon)
    end
    respond_to do |format|
      format.json { render json: zombies, status: 200 }
      format.xml { render xml: zombies, status: 200 }
    end
  end

  def show 
    zombie = Zombie.find(params[:id])
    render json: zombie, status: 200
  end
end
