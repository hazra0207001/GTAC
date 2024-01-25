class Member < ApplicationRecord
  validates :name, :father_name, :mother_name, presence:true
  validates :flat_no, :nid_no, presence:true, uniqueness: true
end
