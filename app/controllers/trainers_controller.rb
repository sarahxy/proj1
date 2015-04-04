class TrainersController < ApplicationController
  before_filter :authenticate_trainer!

  def index
    @trainers = Trainer.all
  end

  def show
  	@all_pokemon = Pokemon.all
    @trainer = Trainer.find(params[:id])
  end

end
