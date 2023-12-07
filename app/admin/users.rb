ActiveAdmin.register User do
  permit_params  :name, :type, :email, :picture, :password
  index do
    selectable_column
    id_column
     column :picture do |img|
      image_tag url_for(img.picture), size: '30x30' if img.picture.present?
    end
    column :name
    column :type
    column :email
    actions
  end

  filter :name
  filter :type
  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :type
      f.input :email
      f.input :password
      f.input :picture, as: :file,label: "user profile"
    end
    f.actions
  end
  show do
    attributes_table do
      row :name
      row :email
      row :type
      row :picture do |img|
        image_tag url_for(img.picture), size: '200x150' if img.picture.present?
      end
    end
  end
end
