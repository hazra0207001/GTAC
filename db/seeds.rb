# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
member =Member.new(
 name: "Rafiz",
 father_name:"Akter",
 mother_name:"mmm ",
 flat_no: "8A",
 nid_no: 22335600003
)
product =Product.new(
    name: "CPU",
    unit: 5,
    price: 1000,
    purchase_date:10-10-2023

)
