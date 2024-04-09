class ExtracaosController < ApplicationController
  before_action :set_extracao, only: [:show, :edit, :update, :destroy]

  def search
    if (params[:format] == "edit")
      redirect_to edita_massa_extracaos_path(params[:search][:mes], params[:search][:sequencial], params[:search][:grupo_id])
      return
    elsif (params[:format] == "bulk_destroy")
      @extracaos = Extracao.where({
        mes:           params[:search][:mes],
        ano: 	     Time.now.year,
        sequencial:    params[:search][:sequencial],
        grupo:         params[:search][:grupo_id]
      })
      @extracaos.destroy_all
      redirect_to root_path(notice: "Itens removidos")
      return
    end

    @extracaos = Extracao.where({
      mes:           params[:search][:mes],
      ano: 	     Time.now.year,
      sequencial:    params[:search][:sequencial],
      grupo:         params[:search][:grupo_id]
    })
    
    if @extracaos.count == 0
      redirect_to extracaos_path
      return
    end

    @filename = @extracaos.first.data.strftime("%d-%m-%Y").to_s + "_" + @extracaos.first.sequencial.to_s

    respond_to do |format|
      format.any  {
        response.headers['Content-Disposition'] = "attachment; filename=#{@filename}.xml"
      }
      format.xml  {
        response.headers['Content-Disposition'] = "attachment; filename=#{@filename}.xml"
      }
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{@filename}.xlsx"
      }
    end
  end

  # GET /extracaos
  # GET /extracaos.json
  def index
    if params[:por_data].blank?
      @extracaos = Extracao.unscoped.paginate(:page => params[:page], :per_page => per_page)
      .order(sort_column + " " + sort_direction)
    else
      @extracaos = Extracao.unscoped.where(data: params[:por_data])
      .paginate(:page => params[:page], :per_page => per_page)
      .order(sort_column + " " + sort_direction)
    end
  end

  # GET /extracaos/1
  # GET /extracaos/1.json
  def show
  end

  # GET /extracaos/new
  def new
    @extracao = Extracao.first.dup
  end

  # GET /extracaos/1/edit
  def edit
  end

  def copiar_mes    
  end

  def copiar
    errors = []
    extracaos = Extracao.where(grupo_id: params[:grupo_de], mes: params[:mes_de], ano: params[:ano_de], sequencial: params[:sequencial_de])
    extracaos.each do |extracao|
      new_extracao                    = extracao.dup
      new_extracao.data               = params[:data]
      new_extracao.mes                = params[:mes_para]
      new_extracao.ano		            = params[:ano_para]
      new_extracao.sequencial         = params[:sequencial_para]
      new_extracao.grupo_id           = params[:grupo_para]
      new_extracao.dataemissao        = params[:dataemissao]
      new_extracao.datavencimento     = params[:datavencimento]
      new_extracao.dataateste         = params[:dataateste]
      new_extracao.datapagamento      = params[:datapagamento]
      new_extracao.dtemissaodocorigem = params[:dtemissaodocorigem]
      new_extracao.observacao         = params[:observacao]
      new_extracao.numerodocorigem    = params[:numerodocorigem]
      new_extracao.visto              = false

      unless (new_extracao.save)
        errors << new_extracao.errors.full_messages.to_s
        next
      end
    end

    if (errors.length != 0)
      logger.fatal errors.to_s
      flash[:notice] = "Não foi possível duplicar, verifique os dados fornecidos e tente novamente"
      redirect_to root_path(errors: errors.to_s)
    else
      redirect_to edita_massa_extracaos_path(params[:mes_para], params[:sequencial_para], params[:grupo_para])
    end
  end

  def edita_massa
    @extracaos = Extracao.where(mes: params[:mes], sequencial: params[:sequencial], grupo: params[:grupo])

    if @extracaos.count == 0
      flash[:notice] = "Não foi encontrado nenhum registro com os parâmetros especificados"
      redirect_to root_path
    end
  end

  def salva_edita_massa
    base = Extracao.find(params[:id])
    extracaos = Extracao.where(mes: base.mes, sequencial: base.sequencial, grupo: base.grupo_id)

    extracaos.update_all({
      ug:            extracao_params[:ug],
      agenciaug:     extracao_params[:agenciaug],
      mes:           extracao_params[:mes],
      ano:           extracao_params[:ano],
      data:          extracao_params[:data],
      sequencial:    extracao_params[:sequencial],
      operador:      extracao_params[:operador],
      dataemissao:   extracao_params[:dataemissao],
      datavencimento: extracao_params[:datavencimento],
      dataateste:    extracao_params[:dataateste],
      datapagamento: extracao_params[:datapagamento],
      dtemissaodocorigem: extracao_params[:dtemissaodocorigem],
      observacao:         extracao_params[:observacao],
      processodh:         extracao_params[:processodh],
      numerodocorigem:    extracao_params[:numerodocorigem],
      situacao:           extracao_params[:situacao],
      empenho:            extracao_params[:empenho],
      contavpd:           extracao_params[:contavpd],
      centrodecusto:      extracao_params[:centrodecusto],
      codigosiorg:        extracao_params[:codigosiorg],
      tipoob:             extracao_params[:tipoob],
      tipodh:             extracao_params[:tipodh],
      contapagadora:      extracao_params[:contapagadora],
      valor:              extracao_params[:valor]
    })

    flash[:notice] = ""
    redirect_to edita_massa_extracaos_path(extracao_params[:mes], extracao_params[:sequencial], extracao_params[:grupo_id])
  end

  def import    
  end

  def importer
    doc = File.open(params[:file].tempfile) { |f| Nokogiri::XML(f) }
    
    doc.xpath("//sb:detalhe").each do |detalhe|
      cprdhcadastrar = detalhe.xpath("ns2:CprDhCadastrar")

      dadospgto      = cprdhcadastrar.xpath("dadosPgto")
      predoc         = dadospgto.xpath("predoc")
      predocob       = predoc.xpath("predocOB")
      numdomibancfav = predocob.xpath("numDomiBancFavo")
      contapagadora  = predocob.xpath("numDomiBancPgto")

      centrocusto    = cprdhcadastrar.xpath("centroCusto")

      pco            = cprdhcadastrar.xpath("pco")
      pcoitem        = pco.xpath("pcoItem")

      dadosbasicos   = cprdhcadastrar.xpath("dadosBasicos")
      docorigem      = dadosbasicos.xpath("docOrigem")
      tmp = Extracao.new

      tmp.agenciaug         = 694
      tmp.grupo_id          = params[:grupo]

      tmp.data              = doc.xpath("//sb:dataGeracao").text
      tmp.sequencial        = doc.xpath("//sb:sequencialGeracao").text
      tmp.ug                = doc.xpath("//sb:ugResponsavel").text
      tmp.operador          = doc.xpath("//sb:cpfResponsavel").text
      tmp.tipodh            = cprdhcadastrar.xpath("codTipoDH").text
      tmp.dataemissao       = dadosbasicos.xpath("dtEmis").text
      tmp.datavencimento    = dadosbasicos.xpath("dtVenc").text
      tmp.observacao        = dadosbasicos.xpath("txtObser").text
      tmp.processodh        = dadosbasicos.xpath("txtProcesso").text
      tmp.dataateste        = dadosbasicos.xpath("dtAteste").text
      tmp.credor            = dadosbasicos.xpath("codCredorDevedor").text
      tmp.datapagamento     = dadosbasicos.xpath("dtPgtoReceb").text
      tmp.dtemissaodocorigem = docorigem.xpath("dtEmis").text
      tmp.numerodocorigem   = docorigem.xpath("numDocOrigem").text
      tmp.situacao          = pco.xpath("codSit").text
      tmp.empenho           = pcoitem.xpath("numEmpe").text
      tmp.valor             = pcoitem.xpath("vlr").text
      tmp.contavpd          = pcoitem.xpath("numClassA").text
      tmp.centrodecusto     = centrocusto.xpath("codCentroCusto").text
      tmp.mes               = centrocusto.xpath("mesReferencia").text
      tmp.ano               = centrocusto.xpath("anoReferencia").text
      tmp.codigosiorg       = centrocusto.xpath("codSIORG").text
      tmp.tipoob            = predocob.xpath("codTipoOB").text
      tmp.banco             = numdomibancfav.xpath("banco").text
      tmp.agencia           = numdomibancfav.xpath("agencia").text
      tmp.contafavorecido   = numdomibancfav.xpath("conta").text
      tmp.contapagadora     = contapagadora.xpath("conta").text
      tmp.visto             = true

      tmp.save
    end

    redirect_to extracaos_url
  end

  # POST /extracaos
  # POST /extracaos.json
  def create
    @extracao = Extracao.new(extracao_params)

    respond_to do |format|
      if @extracao.save
        format.html { redirect_to new_extracao_path, notice: "Criado o Registro para o credor #{@extracao.credor}" }
      else
        format.html { render :new }
        format.json { render json: @extracao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extracaos/1
  # PATCH/PUT /extracaos/1.json
  def update
    respond_to do |format|
      if @extracao.update(extracao_params)
        format.json { render json: { status: 'info', notice: 'Item Atualizado!', id: @extracao.id, method: 'update' } }
        format.html { redirect_to edita_massa_extracaos_path(@extracao.mes, @extracao.sequencial, @extracao.grupo)+'?#'+@extracao.id.to_s, notice: 'Item Atualizado!' }
      else
        format.json { render json: { status: 'danger', notice: 'Houve um problema ao atualizar!', id: @extracao.id, method: 'update' } }
        format.html { render :edit }
      end
    end
  end

  # DELETE /extracaos/1
  # DELETE /extracaos/1.json
  def destroy
    extracao = @extracao
    @extracao.destroy
    respond_to do |format|
      format.html { redirect_to edita_massa_extracaos_path(extracao.mes, extracao.sequencial, extracao.grupo_id), notice: 'Item Destruído!' }
      format.json { render json: { status: 'info', notice: 'Removido com sucesso!', id: extracao.id, method: 'destroy' } }
    end
  end

  def contagem
    @extracaos = Extracao.where(grupo_id: params[:grupo_de], mes: params[:mes_de], ano: params[:ano_de], sequencial: params[:sequencial_de])

    render json: { conta: @extracaos.count }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extracao
      @extracao = Extracao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extracao_params
      params.require(:extracao).permit(
        :agenciaug, :data, :sequencial, 
        :ug, :operador, :tipodh, :dataemissao, :datavencimento,
        :observacao, :processodh, :dataateste, :credor, 
        :datapagamento, :dtemissaodocorigem, :numerodocorigem, 
        :situacao, :empenho, :valor, :contavpd, :centrodecusto, 
        :mes, :ano, :codigosiorg, :tipoob, :banco, :agencia, 
        :contafavorecido, :contapagadora, :grupo_id, :visto
        )
    end
  end
