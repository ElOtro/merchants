# frozen_string_literal: true

class VoidTransaction < Transaction
  belongs_to :parent, -> { where status: %i[approved] }, polymorphic: true
end
