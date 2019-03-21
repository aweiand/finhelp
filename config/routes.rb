Rails.application.routes.draw do
	root 'extracaos#index'

	resources :welcome

	resources :extracaos do 
		collection do
			get 	:import
			post	:importer

			get 	:search
			post 	:copiar
			get 	"edita_massa/:id" => 'extracaos#edita_massa', as: :edita_massa
		end
	end

end
