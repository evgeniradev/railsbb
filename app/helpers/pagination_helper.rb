# frozen_string_literal: true

module PaginationHelper
  include ConstantsHelper

  attr_accessor :order_by

  def paginate(records)
    will_paginate(
      prepare(records),
      previous_label: '<i class="fa fa-angle-left"></i>',
      next_label: '<i class="fa fa-angle-right"></i>'
    )
  end

  def prepare(records)
    records.order(order_by).paginate(
      page: params[:page],
      per_page: POSTS_PER_PAGE
    )
  end
end
