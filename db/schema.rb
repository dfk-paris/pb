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

ActiveRecord::Schema.define(version: 20180601234542) do

  create_table "main_entries", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "location"
    t.string   "sequence"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.text     "provenience",                 limit: 65535
    t.text     "historical_evidence",         limit: 65535
    t.text     "literature",                  limit: 65535
    t.text     "description",                 limit: 65535
    t.text     "appreciation",                limit: 65535
    t.boolean  "publish",                                   default: true
    t.string   "title_reverse"
    t.text     "provenience_reverse",         limit: 65535
    t.text     "historical_evidence_reverse", limit: 65535
    t.text     "literature_reverse",          limit: 65535
    t.text     "description_reverse",         limit: 65535
    t.text     "appreciation_reverse",        limit: 65535
    t.text     "people",                      limit: 65535
    t.index ["title", "location"], name: "searchy", using: :btree
    t.index ["title", "provenience", "historical_evidence", "literature", "description", "appreciation"], name: "me_terms", type: :fulltext
    t.index ["title_reverse", "provenience_reverse", "historical_evidence_reverse", "literature_reverse", "description_reverse", "appreciation_reverse"], name: "me_terms_reverse", type: :fulltext
  end

  create_table "media", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sub_entry_id"
    t.string   "caption"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "publish"
    t.string   "sequence"
    t.index ["sub_entry_id"], name: "index_media_on_sub_entry_id", using: :btree
  end

  create_table "sub_entries", force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer  "main_entry_id"
    t.string   "title"
    t.string   "sequence"
    t.text     "description",                limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "material"
    t.string   "creator"
    t.string   "location"
    t.string   "dating"
    t.text     "markings",                   limit: 65535
    t.string   "height"
    t.string   "width"
    t.string   "depth"
    t.string   "diameter"
    t.string   "weight"
    t.string   "height_with_socket"
    t.string   "width_with_socket"
    t.string   "depth_with_socket"
    t.text     "framing",                    limit: 65535
    t.text     "restaurations",              limit: 65535
    t.boolean  "no_title"
    t.string   "title_reverse"
    t.text     "description_reverse",        limit: 65535
    t.text     "markings_reverse",           limit: 65535
    t.text     "restaurations_reverse",      limit: 65535
    t.string   "material_reverse"
    t.string   "creator_reverse"
    t.string   "dating_reverse"
    t.string   "height_reverse"
    t.string   "width_reverse"
    t.string   "depth_reverse"
    t.string   "diameter_reverse"
    t.string   "weight_reverse"
    t.string   "height_with_socket_reverse"
    t.string   "width_with_socket_reverse"
    t.string   "depth_with_socket_reverse"
    t.text     "framing_reverse",            limit: 65535
    t.text     "people",                     limit: 65535
    t.index ["main_entry_id", "title", "location", "creator"], name: "searchy", length: { title: 100, location: 50, creator: 50 }, using: :btree
    t.index ["main_entry_id"], name: "index_sub_entries_on_main_entry_id", using: :btree
    t.index ["title", "description", "markings", "restaurations", "material", "creator", "dating", "height", "width", "depth", "diameter", "weight", "height_with_socket", "width_with_socket", "depth_with_socket", "framing"], name: "se_terms", type: :fulltext
    t.index ["title", "description", "markings", "restaurations", "material", "creator", "dating", "height", "width", "depth", "diameter", "weight", "height_with_socket", "width_with_socket", "depth_with_socket", "framing"], name: "se_terms_reverse", type: :fulltext
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
