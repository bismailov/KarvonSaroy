Use following snipped for authorization and role checking

- if ["admin", "editor"].include?( current_user.try(:role) ) 
    = link_to  t('ui.new_subject'), new_subject_path, class: "btn btn-large btn-primary"

