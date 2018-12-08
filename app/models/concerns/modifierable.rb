# -*- coding: utf-8 -*-
module Modifierable
  extend ActiveSupport::Concern

  included do |_klass|
    class_attribute :create_user_id_column, :update_user_id_column

    self.create_user_id_column = 'create_user_id'
    self.update_user_id_column = 'update_user_id'

    before_create { |record| record.assign_modify_user_info(self.class.create_user_id_column) }
    before_save { |record| record.assign_modify_user_info(self.class.update_user_id_column) if record.changed? }
  end

  module ClassMethods
    def define_modifier_user(name)
      foreign_key = "#{name.to_s.sub(/=$/, '')}_id"
      belongs_to(name.to_s.sub(/=$/, '').to_sym, class_name: 'User', foreign_key: foreign_key) \
        if [:create_user_id_column, :update_user_id_column].map { |n| send(n) }.select { |c| column_names.include?(c) }.include?(foreign_key)
    end

    def method_missing(name, *args, &block)
      unless \
          name =~ /^(?:sort_)?by_(\w+)(?:_(id|name))?(?:_(desc|asc))?$/ &&
          [:create_user_id_column, :update_user_id_column].map { |n| send(n) }.select { |c| column_names.include?(c) }.include?("#{$1}_id")
        super
      else
        modifier, sort_direction = $1, $2
        define_modifier_user(modifier)
        scope :"by_#{modifier}", ->(modifier_user) { includes(modifier.to_sym).where(User.arel_table[User.primary_key].eq(modifier_user.send(User.primary_key))) }
        if sort_direction
          scope :"sort_by_#{modifier}_#{sort_direction}", ->(direction) { includes(modifier.to_sym).order(User.arel_table[sort_direction.to_sym].send(direction)) }
          [:asc, :desc].each { |direction| scope :"sort_by_#{modifier}_#{sort_direction}_#{direction}", -> { send("sort_by_#{modifier}_#{sort_direction}", direction) } }
        end
        send(name, *args, &block)
      end
    end

    def respond_to?(name, include_private=false)
      super ||
        name =~ /^(?:sort_)?by_(\w+)(?:_(id|name))?(?:_(desc|asc))?$/ &&
        [:create_user_id_column, :update_user_id_column].map { |n| send(n) }.select { |c| column_names.include?(c) }.include?("#{$1}_id")
    end
  end

  # TODO: reconsider methods to detect logged in user
  def assign_modify_user_info(column_name)
    # TODO: revivi following code after decide method to detect logged in user
    # User.current_user && self.class.column_names.include?(column_name) && send("#{column_name}=", User.current_user.id) || true
  end

  def method_missing(name, *args, &block)
    foreign_key = "#{name.to_s.sub(/=$/, '')}_id"
    unless [:create_user_id_column, :update_user_id_column].map { |n| self.class.send(n) }.select { |c| self.class.column_names.include?(c) }.include?(foreign_key)
      super
    else
      self.class.class_eval { belongs_to name.to_s.sub(/=$/, ''), class_name: 'User', foreign_key: foreign_key }
      send(name, *args)
    end
  end

  def respond_to?(name, include_private=false)
    super ||
      [:create_user_id_column, :update_user_id_column] \
        .map { |n| self.class.send(n) }.select { |c| self.class.column_names.include?(c) }.include?("#{name.to_s.sub(/=$/, '')}_id")
  end
end
