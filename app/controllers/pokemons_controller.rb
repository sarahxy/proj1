class PokemonsController < ApplicationController
	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.update_attribute(:trainer_id, current_trainer.id)
		redirect_to '/'
	end

	def damage
		@pokemon = Pokemon.find(params[:id])
		@pokemon.update_attribute(:health, (@pokemon.health.to_f - 10))

		if @pokemon.health.to_f <= 0
			@pokemon.destroy
		end

		redirect_to trainer_path(current_trainer)
	end

	def create
		@pokemon = Pokemon.create(pokemon_params)
		@pokemon.level = 1
		@pokemon.trainer_id = current_trainer.id
		@pokemon.health = 100
		@pokemon.save
		
		if @pokemon.save
			redirect_to trainer_path(current_trainer)
		else
			flash[:error] = @pokemon.errors.full_messages.to_sentence
		end
	end

	private
	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
end
