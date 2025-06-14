# frozen_string_literal: true

module Helpers
  def body
    JSON.parse(response.body)
  end
end
