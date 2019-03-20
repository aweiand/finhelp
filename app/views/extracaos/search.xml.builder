xml.instruct!(:xml, :version=>"1.0", :encoding=>"UTF-8", :standalone=>"yes")

xml.tag!("sb:arquivo", "xmlns:ns2"=>"http://services.docHabil.cpr.siafi.tesouro.fazenda.gov.br/", "xmlns:sb"=>"http://www.tesouro.gov.br/siafi/submissao", "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance") do |arquivo|

	xml.tag!("sb:header") do |sbheader|
		xml.tag!("sb:codigoLayout", "DH001")
		xml.tag!("sb:dataGeracao", @extracaos.first.data.strftime("%d/%m/%Y"))
		xml.tag!("sb:sequencialGeracao", @extracaos.first.sequencial)
		xml.tag!("sb:anoReferencia", @extracaos.first.ano)
		xml.tag!("sb:ugResponsavel", @extracaos.first.ug)
		xml.tag!("sb:cpfResponsavel", @extracaos.first.operador)
	end

	xml.tag!("sb:detalhes") do |sbdetalhes|

		@extracaos.each do |dado|
			xml.tag!("sb:detalhe") do |sbdetalhe|
				xml.tag!("ns2:CprDhCadastrar") do |cprdhcadastrar|
					xml.tag!("codUgEmit", dado.ug)
					xml.tag!("anoDH", dado.ano)
					xml.tag!("codTipoDH", dado.tipodh)
					
					xml.tag!("dadosBasicos") do |dadosbasicos|
						xml.tag!("dtEmis", dado.dataemissao.strftime("%Y-%m-%d"))
						xml.tag!("dtVenc", dado.datavencimento.strftime("%Y-%m-%d"))
						xml.tag!("codUgPgto", dado.ug)
						xml.tag!("vlr", dado.valor)
						xml.tag!("txtObser", dado.observacao)
						xml.tag!("txtProcesso", dado.processodh)
						xml.tag!("dtAteste", dado.dataateste.strftime("%Y-%m-%d"))
						xml.tag!("codCredorDevedor", dado.credor)
						xml.tag!("dtPgtoReceb", dado.datapagamento.strftime("%Y-%m-%d"))

						xml.tag!("docOrigem") do |docorigem|
							xml.tag!("codIdentEmit", dado.ug)
							xml.tag!("dtEmis", dado.dataemissao.strftime("%Y-%m-%d"))
							xml.tag!("numDocOrigem", dado.numerodocorigem)
							xml.tag!("vlr", dado.valor)
						end
					end

					xml.tag!("pco") do |pco|
						xml.tag!("numSeqItem", dado.sequencial)
						xml.tag!("codSit", dado.situacao)
						xml.tag!("codUgEmpe", dado.ug)

						xml.tag!("pcoItem") do |pcoitem|
							xml.tag!("numSeqItem", dado.sequencial)
							xml.tag!("numEmpe", dado.empenho)
							xml.tag!("codSubItemEmpe", "0#{dado.sequencial}")
							xml.tag!("vlr", dado.valor)
							xml.tag!("numClassA", dado.contavpd)
						end
					end

					xml.tag!("centroCusto") do |centrocusto|
						xml.tag!("numSeqItem", dado.sequencial)
						xml.tag!("codCentroCusto", dado.centrodecusto)
						xml.tag!("mesReferencia", dado.mes)
						xml.tag!("anoReferencia", dado.ano)
						xml.tag!("codUgBenef", dado.ug)
						xml.tag!("codSIORG", dado.codigosiorg)

						xml.tag!("relPcoItem") do |relpcoitem|
							xml.tag!("numSeqPai", dado.sequencial)
							xml.tag!("numSeqItem", dado.sequencial)
							xml.tag!("vlr", dado.valor)
						end
					end

					xml.tag!("dadosPgto") do |dadospgto|
						xml.tag!("codCredorDevedor", dado.credor)
						xml.tag!("vlr", dado.valor)

						xml.tag!("predoc") do |predoc|
							xml.tag!("txtObser", dado.observacao)

							xml.tag!("predocOB") do |predocob|
								xml.tag!("codTipoOB", dado.tipoob)
								xml.tag!("codCredorDevedor", dado.credor)

								xml.tag!("numDomiBancFavo") do |numdomibancfavo|
									xml.tag!("banco", dado.banco)
									xml.tag!("agencia", dado.agencia)
									xml.tag!("conta", dado.contafavorecido)
								end

								xml.tag!("numDomiBancPgto") do |numdomibancpgto|
									xml.tag!("conta", dado.contapagadora)
								end

								xml.tag!("txtProcesso", dado.processoob)
							end
						end
					end
				end
			end
		end

	end

	xml.tag!("sb:trailler") do |sbtrailer|
		xml.tag!("sb:quantidadeDetalhe", @extracaos.count)
	end

end