class Owner < User
  # self.table_name = "users"c

  has_many :restaurants, foreign_key: 'user_id', dependent: :destroy #, inverse_of: 'user '
end
