module ApplicationHelper
 	def link_to_add_image_fields(name, f, association, disp, partial = "upload_image_fields", locals = {})
    new_object = association.to_s.classify.constantize.new
    	partial ||= f.object.class.to_s.tableize+"/"+association.to_s.singularize + "_fields"
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
     locals[:f] = builder
     locals[:disp] = disp
     render(:partial => partial, :locals => locals)
    end
    link_to name, '#', :onclick => "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "add-document-btn"
  end
end
