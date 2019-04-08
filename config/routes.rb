Rails.application.routes.draw do
	root 'extracaos#index'

	resources :welcome

	resources :bancos
	resources :extracaos do 
		collection do
			get 	:import
			post	:importer

			get 	:search

			get 	:copiar_mes
			post 	:copiar

			get 	"edita_massa/:id" => 'extracaos#edita_massa', as: :edita_massa
		end
	end

end
