class ContractsDatatable < ApplicationDatatable
    delegate :contract_path, to: :@view
    delegate :edit_contract_path, to: :@view
  
    def valid?
      true
    end
  
    def data
      @contracts.map do |contract|
        [].tap do |row|
          row << contract.id
          row << contract.name
          row << contract.number
          row << contract.description
          row << contract.start_date
          row << contract.end_date
          row << contract.contract_status&.name
          row << contract.user_group&.first_name
          row << contract.company&.name
          links = [].tap do |link|
            link << link_to(contract_path(contract)) do
              content_tag :i, '', class: 'fa fa-eye'
            end
            link << link_to(edit_contract_path(contract)) do
                content_tag :i, '', class: 'fa fa-edit'
            end
            link << link_to(contract_path(contract), method: :delete, data: { confirm: t(:remove_item, count: 0) }) do
                content_tag :i, '', class: 'fa fa-times'
            end
          end
          row << links.join(' ')
        end
      end
    end
  
    def count
      contracts.count
    end
  
    def total_entries
      10
    end
  
    def contracts
      @contracts ||= fetch_records
    end
  
    def fetch_records
      query = []
      search_values = params[:search][:value] if params[:search].present?  
      @contracts = Contract.all

      if search_values.present?
        search_values = search_values.split
        # Search in month description
        search_values.each do |search_value|
          month_numbers = months_to_search(search_value)
          query << "EXTRACT(MONTH FROM date_at) IN (#{month_numbers.join(', ')})" if month_numbers.any?
        end
        # CAST all fields to string
        search_columns.each do |term|
          query << "CAST(#{term} AS VARCHAR) ~* :search"
        end
  
        search_values.each do |search_value|
          search_value.sub! ',', '.' # replace , with . to do numeric search
          contracts = contracts.where(query.join(' or '), search: Regexp.escape(search_value))
        end
      end
      @contracts
    end
  
    def order_columns
      %w[
        id
        name
        number
        description
        start_date
        end_date
        contract_status
        user_group
        company
      ]
    end
  
    def search_columns
      %w[
        id
        name
        number
        description
        start_date
        end_date
        contract_status
        user_group
        company
      ]
    end
  
    def months_to_search(search_value)
      months = t('date.month_names').map(&:to_s).map(&:downcase)
      months.each_index.select { |i| months[i].include?(search_value.downcase) }
    end
  end
  