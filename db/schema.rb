# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190502130104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bancos", force: :cascade do |t|
    t.string "codigo"
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extracaos", force: :cascade do |t|
    t.integer "agenciaug", default: 694
    t.date "data"
    t.integer "sequencial", default: 1
    t.integer "ug", default: 158327
    t.string "operador"
    t.string "tipodh"
    t.date "dataemissao"
    t.date "datavencimento"
    t.string "observacao"
    t.string "processodh"
    t.date "dataateste"
    t.string "credor"
    t.date "datapagamento"
    t.date "dtemissaodocorigem"
    t.string "numerodocorigem"
    t.string "situacao", default: "DSP061"
    t.string "empenho"
    t.integer "valor"
    t.integer "contavpd"
    t.string "centrodecusto"
    t.integer "mes"
    t.integer "ano"
    t.integer "codigosiorg"
    t.string "tipoob"
    t.string "banco"
    t.string "agencia"
    t.string "contafavorecido"
    t.string "contapagadora", default: "UNICA"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "grupo_id", default: 1, null: false
    t.boolean "visto", default: false, null: false
    t.index ["grupo_id"], name: "index_extracaos_on_grupo_id"
  end

  create_table "grupos", force: :cascade do |t|
    t.string "nome", default: "G1", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "extracaos", "grupos"
end
