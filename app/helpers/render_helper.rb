# frozen_string_literal: true

module RenderHelper
  def render(*args)
    options, extra_options, block = *args
    return super(*args) if options.instance_of? String

    super process_options(options), extra_options, &block
  end

  def process_options(options)
    case options.class.to_s
    when /ActiveRecord/
      @no_records_msg = 'No sections' if no_sections?
      @no_records_msg = 'No results' if search_query?
      @no_records_msg = "#{controller_name.singularize.capitalize} empty" if @no_records_msg.blank?
      options.presence || 'shared/empty_collection'
    else
      options
    end
  end

  def no_sections?
    Section.all.empty?
  end

  def search_query?
    params[:search].present?
  end
end
