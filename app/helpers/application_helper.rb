module ApplicationHelper

  # convert rails flashes to foundation callout's
  def flash2callout(name)
    case name.to_sym
      when :notice
        'primary'
      when :success
        'success'
      when :alert || :error
        'alert'
    end
  end

  # gets the Name of the parent object if there is any
  def parent_name(object)
    if !object.domain.nil?
      object.domain.name
    else
      'N/A'
    end
  end

  # gets the parent object if there is any
  def parent(object)
    if !object.domain.nil?
      object.domain
    else
      object
    end
  end

  def link_to_parent(object)
    if !object.domain.nil?
      link_to object.domain.name, object.domain
    else
      'N/A'
    end
  end


  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    row = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s, f: builder)
    end
    link_to(name, '#', class: 'button small add_row', data: {id: id, row: row.gsub("\n", "")})
  end

  # find the name of this action's parent if it is
  # an actionfield or returns visitor suggested if its a domain
  def action_parent_name_or_suggested(object)
    parent = object.actionable_type.downcase.to_sym
    parent == :domain ? t('domains.misc.visitor_suggested') : object.actionable.name
  end

  # find the name of this achievement's parent if it is
  # an actionfield or returns visitor suggested if its a domain
  def achievement_parent_name_or_suggested(object)
    parent = object.achievementable_type.downcase.to_sym
    parent == :domain ? t('domains.misc.visitor_suggested') : object.achievementable.name
  end


  def quarter(date)
    return 'N/A' if date.nil?
    quarter =  quarter_name(date.month)
    year = date.year
    "#{quarter}/#{year}"
  end

  def quarter_name(month_number)
    quarter_names = [nil, 'Q1', 'Q2', 'Q3', 'Q4']
    quarter_names[month_number / 3 + 1]
  end
end
