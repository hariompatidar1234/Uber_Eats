ActiveAdmin.register Dish do
  permit_params :name, :price, :category_id, :restaurant_id, :picture
  index do
    selectable_column
    id_column
    column :picture do |img|
      image_tag url_for(img.picture), size: '30x30' if img.picture.present?
    end
    column :name
    column :price
    column :category_id
    column :restaurant_id
    actions
  end
  filter :name
  filter :price
  filter :category_id
  filter :restaurant_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :category_id
      f.input :restaurant_id
      f.input :picture, as: :file,label: "Dish image"

    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :category_id
      row :restaurant_id
      row :picture do |img|
        image_tag url_for(img.picture), size: '200x150' if img.picture.present?
      end
    end
  end
end
