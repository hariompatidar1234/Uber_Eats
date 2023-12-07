ActiveAdmin.register Restaurant do
  permit_params :name, :address, :status, :user_id, :picture
  index do
    selectable_column
    id_column
     column :picture do |img|
      image_tag url_for(img.picture), size: '30x30' if img.picture.present?
    end
    column :name
    column :address
    column :status
    column :user_id
    column :created_at
    actions
  end

  filter :name
  filter :address
  filter :status
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :status
      f.input :user_id
      f.input :picture, as: :file,label: "Restaurant image"
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :status
      row :user_id
      row :picture do |img|
        image_tag url_for(img.picture), size: '200x150' if img.picture.present?
      end
    end
  end
end
