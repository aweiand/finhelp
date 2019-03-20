module ApplicationHelper

	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy) + link_to("#", onclick: "remove_fields(this); return false;", 
			title: "Remover", class: "btn btn-xs btn-danger") do
			name
		end
	end

	def link_to_add_fields(name, classe, f, folder_file, local)
		fields = render("#{folder_file}_fields", :form => f)
		link_to("#", onclick: "add_fields(\"#{local}\", \"#{classe}\", 
			\"#{escape_javascript(fields)}\"); return false", 
			title: "Adicionar", class: "btn btn-xs btn-primary" ) do
			name
		end
	end 	

  	def sortable(column, title = nil)
	  	# binding.pry
	    ltitle = title.nil? ? t(column) : title
	    css_class = column == sort_column ? "btn btn-link #{sort_direction}" : "btn btn-link "
	    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	    link_to ltitle, {:sort => column, :direction => direction, :search => (params[:search] || nil) }, {:class => css_class}
  	end	

	def humanCPF(cpf)
		if cpf.nil?
			""
		else
			cpf[0..2] + "." + cpf[3..5] + "." + 
			cpf[6..8] + "-" + cpf[9..10]
		end
	end
	
end
