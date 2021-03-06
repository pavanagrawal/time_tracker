# create_table "users", force: :cascade do |t|
#   t.string   "email",                  default: ""
#   t.string   "encrypted_password",     default: "", null: false
#   t.string   "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.integer  "sign_in_count",          default: 0,  null: false
#   t.datetime "current_sign_in_at"
#   t.datetime "last_sign_in_at"
#   t.string   "current_sign_in_ip"
#   t.string   "last_sign_in_ip"
#   t.datetime "created_at",                          null: false
#   t.datetime "updated_at",                          null: false
#   t.integer  "role"
#   t.index ["email"], name: "index_users_on_email", using: :btree
#   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
# end

class User < ApplicationRecord
  attr_accessor :oauth_callback
  attr_accessor :current_password

  validates_presence_of :email, if: :email_required?
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: Devise.password_length, allow_blank: true


  has_many :allocations

  has_many :projects, through: :allocations

  has_many :current_week_allocations, through: :allocations

  has_many :time_trackers


  def current_week_projects
    d = Date.today
    week_start_date = d.at_beginning_of_week
    week_end_date = d.at_end_of_week
    projects.where("allocations.start_date <= '#{week_start_date.to_s(:db)}'").where("allocations.end_date >= '#{week_end_date.to_s(:db)}'")
  end

  def name
    email
  end

  def password_required?
    return false if email.blank? || !email_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    @oauth_callback != true
  end

  enum role: [:user, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

end
