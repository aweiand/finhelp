Rails.application.routes.draw do
  resources :grupos
	root 'extracaos#index'

	resources :bancos

	resources :extracaos do 
		collection do			
			get 	:import
			post	:importer

			get 	:search

			get 	:copiar_mes
			post 	:copiar

			get 	:contagem

			get 	"edita_massa/:mes/:sequencial/:grupo" 	=> 'extracaos#edita_massa', 		as: :edita_massa
			put		"salva_edita_massa/:id"					=> 'extracaos#salva_edita_massa', 	as: :salva_edita_massa
		end
	end

	get 	'login'		=> 'welcome#login', 	as: :login
	post 	'login'		=> 'welcome#loginin', 	as: :loginin
	get 	'logou'		=> 'welcome#logout', 	as: :logout

end
