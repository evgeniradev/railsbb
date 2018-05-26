# frozen_string_literal: true

# Metaprogramming
module DefaultActions
  extend ActiveSupport::Concern
  %i[belongs_to has_many model].each do |association|
    association_name = "#{association}_name".to_sym
    define_method(association_name) do
      self.class.public_send(association_name)
    end

    association_class = "#{association}_class".to_sym
    define_method(association_class) do
      class_name = public_send("#{association}_name".to_sym)
      class_name.to_s.camelize.demodulize.constantize
    end

    next unless association == :belongs_to

    define_method(:belongs_to_foreign_key) do
      "#{belongs_to_name}_id".to_sym
    end
  end

  def controller_params
    send "#{model_name}_params".to_sym
  end

  def model_name
    temp_array = self.class.name.demodulize.underscore.split('_')
    temp_array.pop
    temp_array.join('_').singularize
  end

  def record_var_name
    "@#{model_name}"
  end

  def record_for_create
    model_class.new(controller_params)
  end

  def record_for_update
    model_class.find(params[:id])
  end

  alias find_record record_for_update

  module ClassMethods
    attr_accessor :belongs_to_name, :has_many_name

    # rubocop:disable Metrics/AbcSize
    def default_actions(options = {}, &block)
      @belongs_to_name = options[:belongs_to]
      @has_many_name = options[:has_many]

      raise 'up to 2 options allowed' if options.size > 2

      %i[create update].each do |action|
        define_method(action) do
          record_value = public_send("record_for_#{action}")
          save_or_update = action == :update ? [action, controller_params] : :save
          fail_view = action == :update ? :edit : :new
          flash[:errors] = []
          record = instance_variable_set(record_var_name, record_value)
          destination = block_given? ? instance_exec(record, &block) : record

          if record.public_send(*save_or_update) && destination
            flash[:notification] = "#{model_name.humanize.camelize} #{action} successfully."
            redirect_to destination
          else
            flash[:errors] += record.errors.full_messages
            render fail_view
          end
        end
      end

      define_method(:destroy) do
        record = find_record
        destination = instance_exec(record, &block)
        record.destroy
        flash[:notification] = "#{model_name.humanize.camelize} deleted successfully."
        redirect_to destination
      end

      define_method(:index) do
        all_records = model_class.all
        instance_variable_set(record_var_name.pluralize, all_records)
      end

      define_method(:new) do
        new_model = model_class.new
        instance_variable_set(record_var_name, new_model)
      end

      %i[show edit].each do |action|
        define_method(action) do
          instance_variable_set(record_var_name, find_record)
          instance_eval(&block) if block_given?
        end
      end

      # rubocop:disable Style/MultilineIfModifier, Metrics/LineLength
      define_method(@belongs_to_name) do
        record = instance_variable_get(record_var_name)
        belongs_to_class.find(record.public_send(belongs_to_name).try(:id) || controller_params[belongs_to_foreign_key])
      end if @belongs_to_name

      define_method(@has_many_name) do
        record = instance_variable_get(record_var_name)
        record.public_send(has_many_name)
      end if @has_many_name
      # rubocop:enable Style/MultilineIfModifier, Metrics/LineLength

      options.each { |association| helper_method association }
    end
    # rubocop:enable Metrics/AbcSize
  end
end
