class Company < ApplicationRecord
    # Includes

    # Attributes

    # Associations
    has_many :work_groups
    has_many :contracts
    belongs_to :user
    
    # Delegates

    # Constants

    # Validations
    validates :name, :city, :country, presence: true

    # Scopes

    # Callbacks

    # Constants Methods

    # Default

    private
end
