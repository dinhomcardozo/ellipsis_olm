# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "channels", primary_key: "channel_id", id: :serial, force: :cascade do |t|
    t.text "description"
    t.string "type", limit: 20
    t.integer "stage_id"
    t.string "channel_status", limit: 10
    t.integer "num_entries", default: 0
    t.integer "num_active_opps", default: 0
    t.decimal "active_opps_values", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_sales_values", precision: 10, scale: 2, default: "0.0"
    t.integer "num_sales", default: 0
    t.decimal "loss_sales_values", precision: 10, scale: 2, default: "0.0"
    t.integer "num_loss_sales", default: 0
    t.check_constraint "channel_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "channels_channel_status_check"
    t.check_constraint "type::text = ANY (ARRAY['Telefone'::character varying::text, 'WhatsApp'::character varying::text, 'Telegram'::character varying::text, 'Messenger Facebook'::character varying::text, 'Instagram'::character varying::text, 'Formulário'::character varying::text, 'Chat'::character varying::text, 'E-mail'::character varying::text, 'Visita tecnica'::character varying::text])", name: "channels_type_check"
  end

  create_table "client_products", primary_key: "product_id", id: :integer, default: -> { "nextval('clientsproducts_product_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "product_type", limit: 20, null: false
    t.text "product_description"
    t.string "product_brand", limit: 100
    t.decimal "product_price", precision: 10, scale: 2, null: false
    t.string "product_cat", limit: 100
    t.string "product_status", limit: 10, null: false
    t.interval "product_license"
    t.integer "client_id", null: false
    t.check_constraint "product_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "clientsproducts_product_status_check"
    t.check_constraint "product_type::text = ANY (ARRAY['Physical Product'::character varying::text, 'Digital Product'::character varying::text, 'Service'::character varying::text])", name: "clientsproducts_product_type_check"
  end

  create_table "client_users", primary_key: ["client_id", "user_id"], force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "user_id", null: false
    t.index ["client_id"], name: "idx_client_id"
    t.index ["user_id"], name: "idx_user_id"
  end

  create_table "clients", primary_key: "client_id", id: :serial, force: :cascade do |t|
    t.integer "plan_id", null: false
    t.integer "num_client_users", default: 0
    t.string "cnpj", limit: 18, null: false
    t.integer "tax_regime_id", null: false
    t.integer "segment_id", null: false
    t.integer "subsegment_id"
    t.string "email", limit: 255, null: false
    t.string "telephone", limit: 15
    t.string "state", limit: 2
    t.string "city", limit: 40
    t.string "country", limit: 3
    t.string "address", limit: 50
    t.integer "address_number"
    t.string "state_registration", limit: 50
    t.string "city_registration", limit: 50
    t.integer "users_id", default: [], array: true

    t.unique_constraint ["cnpj"], name: "clients_cnpj_key"
  end

  create_table "companies", primary_key: "company_id", id: :serial, force: :cascade do |t|
    t.string "company_name", limit: 255, null: false
    t.string "company_cnpj", limit: 18, null: false
    t.string "address", limit: 50
    t.integer "address_number"
    t.string "country", limit: 3
    t.string "state", limit: 2
    t.string "city", limit: 40
    t.integer "segment_id", null: false
    t.integer "subsegment_id"
    t.integer "tax_regime_id", null: false
    t.integer "group_id"

    t.unique_constraint ["company_cnpj"], name: "companies_company_cnpj_key"
  end

  create_table "contacts", primary_key: "contact_id", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 15, null: false
    t.string "last_name", limit: 15, null: false
    t.integer "company_id", null: false
    t.string "company_name", limit: 100
    t.string "telephone", limit: 20
    t.integer "group_id", null: false
    t.string "group_name", limit: 100
  end

  create_table "contract_client_products", id: :integer, default: -> { "nextval('contractsclientproducts_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "contract_id", null: false
    t.integer "product_id", null: false
  end

  create_table "contracts", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 15, null: false
    t.string "last_name", limit: 15, null: false
    t.integer "company_id", null: false
    t.string "company_name", limit: 100
    t.string "telephone", limit: 20
    t.integer "group_id", null: false
    t.integer "product_ids", null: false, array: true
  end

  create_table "group_clients", primary_key: ["group_id", "client_id"], force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "client_id", null: false
  end

  create_table "group_companies", primary_key: ["group_id", "company_id"], force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "company_id", null: false
  end

  create_table "groups", primary_key: "group_id", id: :serial, force: :cascade do |t|
  end

  create_table "opportunities", primary_key: "opp_id", id: :serial, force: :cascade do |t|
    t.integer "stage_id"
    t.string "stage_name", limit: 50
    t.string "opp_status", limit: 10
    t.string "created_by", limit: 100
    t.datetime "updated_by", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.decimal "quote_value", precision: 10, scale: 2, default: "0.0"
    t.check_constraint "opp_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "opportunities_opp_status_check"
    t.check_constraint "stage_name::text = ANY (ARRAY['Propect'::character varying::text, 'Lead'::character varying::text, 'Demostration'::character varying::text, 'Quote'::character varying::text, 'Sale'::character varying::text, 'Loss Sale'::character varying::text, 'About to Renew'::character varying::text, 'Not renewed'::character varying::text, 'Post-sales'::character varying::text, 'Renewed'::character varying::text, 'All Customers'::character varying::text])", name: "opportunities_stage_name_check"
  end

  create_table "plans", primary_key: "plan_id", id: :serial, force: :cascade do |t|
    t.string "plan_name", limit: 40, null: false
    t.text "plan_description"
    t.string "plan_status", limit: 10
    t.datetime "plan_validity", precision: nil
    t.decimal "plan_price", precision: 10, scale: 2
    t.string "created_by", limit: 100
    t.datetime "updated_by", precision: nil
    t.integer "num_plan_groups", default: 0
    t.integer "num_plan_clients", default: 0
    t.check_constraint "plan_status::text = ANY (ARRAY['ativo'::character varying::text, 'inativo'::character varying::text])", name: "plans_plan_status_check"
  end

  create_table "product_brands", primary_key: "brand_id", id: :integer, default: -> { "nextval('productbrand_brand_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "brand_name", limit: 15
    t.string "brand_status", limit: 10
    t.check_constraint "brand_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "productbrand_brand_status_check"
  end

  create_table "segments", primary_key: "segment_id", id: :serial, force: :cascade do |t|
    t.string "segment_name", limit: 50, null: false

    t.unique_constraint ["segment_name"], name: "segments_segment_name_key"
  end

  create_table "stages", primary_key: "stage_id", id: :serial, force: :cascade do |t|
    t.string "stage_name", limit: 15, null: false
    t.text "stage_description"
    t.integer "num_active_opps", default: 0
    t.integer "num_contacts", default: 0
    t.integer "stage_position"
    t.boolean "stage_active"

    t.unique_constraint ["stage_name"], name: "unique_stage_name"
  end

  create_table "sub_segments", primary_key: "subsegment_id", id: :integer, default: -> { "nextval('subsegments_subsegment_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "subsegment_name", limit: 100, null: false

    t.unique_constraint ["subsegment_name"], name: "subsegments_subsegment_name_key"
  end

  create_table "system_admins", primary_key: "admin_id", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "cpf", limit: 14
    t.string "cnpj", limit: 18
    t.string "password", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "user_status", limit: 15
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }

    t.check_constraint "user_status::text = ANY (ARRAY['active'::character varying::text, 'inactive'::character varying::text, 'pending'::character varying::text])", name: "system_admins_user_status_check"
    t.unique_constraint ["cnpj"], name: "system_admins_cnpj_key"
    t.unique_constraint ["cpf"], name: "system_admins_cpf_key"
    t.unique_constraint ["email"], name: "system_admins_email_key"
  end

  create_table "tax_regimes", primary_key: "tax_regime_id", id: :serial, force: :cascade do |t|
    t.string "tax_regime", limit: 255, null: false
    t.integer "num_companies", default: 0
    t.integer "num_clients", default: 0
  end

  create_table "users", primary_key: "user_id", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "first_name", limit: 15
    t.string "last_name", limit: 15
    t.string "user_status", limit: 10
    t.boolean "user_admin"
    t.string "password", limit: 15
    t.string "country", limit: 3
    t.string "state", limit: 2
    t.string "city", limit: 40
    t.datetime "first_signin", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "first_signup", precision: nil
    t.datetime "last_signup", precision: nil
    t.boolean "google_signin"
    t.check_constraint "user_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "users_user_status_check"
  end

  add_foreign_key "channels", "stages", primary_key: "stage_id", name: "fk_stage_id"
  add_foreign_key "client_products", "clients", primary_key: "client_id", name: "clientsproducts_client_id_fkey", on_delete: :cascade
  add_foreign_key "client_users", "clients", primary_key: "client_id", name: "clients_users_client_id_fkey", on_delete: :cascade
  add_foreign_key "client_users", "users", primary_key: "user_id", name: "clients_users_user_id_fkey", on_delete: :cascade
  add_foreign_key "clients", "plans", primary_key: "plan_id", name: "clients_plan_id_fkey"
  add_foreign_key "clients", "segments", primary_key: "segment_id", name: "clients_segment_id_fkey"
  add_foreign_key "clients", "sub_segments", column: "subsegment_id", primary_key: "subsegment_id", name: "clients_subsegment_id_fkey"
  add_foreign_key "companies", "segments", primary_key: "segment_id", name: "companies_segment_id_fkey"
  add_foreign_key "companies", "sub_segments", column: "subsegment_id", primary_key: "subsegment_id", name: "companies_subsegment_id_fkey"
  add_foreign_key "contacts", "groups", primary_key: "group_id", name: "fk_group"
  add_foreign_key "contract_client_products", "client_products", column: "product_id", primary_key: "product_id", name: "contractsclientproducts_product_id_fkey", on_delete: :cascade
  add_foreign_key "contract_client_products", "contracts", name: "contractsclientproducts_contract_id_fkey", on_delete: :cascade
  add_foreign_key "contracts", "companies", primary_key: "company_id", name: "contracts_company_id_fkey", on_delete: :cascade
  add_foreign_key "contracts", "groups", primary_key: "group_id", name: "contracts_group_id_fkey", on_delete: :cascade
  add_foreign_key "group_clients", "groups", primary_key: "group_id", name: "group_clients_group_id_fkey"
  add_foreign_key "group_companies", "groups", primary_key: "group_id", name: "group_companies_group_id_fkey"
  add_foreign_key "opportunities", "stages", primary_key: "stage_id", name: "fk_stage"
  add_foreign_key "users", "clients", primary_key: "client_id", name: "fk_client_id"
end
