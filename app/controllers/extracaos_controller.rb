class ExtracaosController < ApplicationController
  before_action :set_extracao, only: [:show, :edit, :update, :destroy]

  def search
    if (params[:commit] == "Editar em Massa")
      redirect_to edita_massa_extracaos_path(params[:search][:date])
    else
      @extracaos = Extracao.where({
        data:           params[:search][:date],
        sequencialdata: params[:search][:sequencial]
      })

      if @extracaos.count == 0
        redirect_to extracaos_path
      end
    end
  end

  # GET /extracaos
  # GET /extracaos.json
  def index
    if params[:por_data].blank?
      @extracaos = Extracao.paginate(:page => params[:page], :per_page => per_page)
      .order(sort_column + " " + sort_direction)
    else
      @extracaos = Extracao.where(data: params[:por_data])
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
    @extracao = Extracao.last.dup
  end

  # GET /extracaos/1/edit
  def edit
  end

  def copiar
    extracaos = Extracao.where(mes: params[:mes_de], sequencialdata: params[:sequencial_de])
    extracaos.each do |extracao|
      new_extracao                    = extracao.dup
      new_extracao.data               = params[:data]
      new_extracao.mes                = params[:mes_para]
      new_extracao.sequencialdata     = params[:sequencial_para]
      new_extracao.dataemissao        = params[:dataemissao]
      new_extracao.datavencimento     = params[:datavencimento]
      new_extracao.dataateste         = params[:dataateste]
      new_extracao.datapagamento      = params[:datapagamento]
      new_extracao.dtemissaodocorigem = params[:dtemissaodocorigem]
      new_extracao.observacao         = params[:observacao]
      new_extracao.numerodocorigem    = params[:numerodocorigem]

      new_extracao.save
    end

    redirect_to edita_massa_extracaos_path(params[:data])
  end

  def edita_massa
    @extracaos = Extracao.where(data: params[:id])
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
      tmp.data              = doc.xpath("//sb:dataGeracao").text
      tmp.sequencialdata    = doc.xpath("//sb:sequencialGeracao").text
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
        format.html { redirect_to @extracao, notice: 'Extracao was successfully updated.' }
        format.json { render :show, status: :ok, location: @extracao }
      else
        format.html { render :edit }
        format.json { render json: @extracao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extracaos/1
  # DELETE /extracaos/1.json
  def destroy
    @extracao.destroy
    respond_to do |format|
      format.html { redirect_to extracaos_url, notice: 'Extracao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extracao
      @extracao = Extracao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extracao_params
      params.require(:extracao).permit(
        :agenciaug, :data, :sequencialdata, :sequencial, 
        :ug, :operador, :tipodh, :dataemissao, :datavencimento,
        :observacao, :processodh, :dataateste, :credor, 
        :datapagamento, :dtemissaodocorigem, :numerodocorigem, 
        :situacao, :empenho, :valor, :contavpd, :centrodecusto, 
        :mes, :ano, :codigosiorg, :tipoob, :banco, :agencia, 
        :contafavorecido, :contapagadora
        )
    end
  end
