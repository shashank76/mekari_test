class Employee < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :policies

  validates :name, presence: true
  validates :email, uniqueness: true


  acts_as_nested_set

  def self.import(file, params)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet[0]
    n = spreadsheet.length - 1
    @company = Company.find_by_id(params[:company_id])
    (1..n).each do |i|
      row = Hash[[header, spreadsheet[i]].transpose]
      employee = find_by_email(row["email"]) || new
      employee.attributes = row.to_hash.slice("name", "email", "phone")
      employee.parent_id = find_by_email(row["report_to"]).try(:id)
      employee.company_id = @company.id
      employee.save!
      binding.pry
      policies = row["assigned_policies"].split["|"] if row["assigned_policies"].present?
      policies.each do |policy|
        @policy = @company.policies.find_or_create_by(name: policy)
        employee.policies.find_or_create_by(policy_id: @policy.id)
      end if policies.present?
    end
  end

  def self.open_spreadsheet(file)
    infile = file.read
    case File.extname(file.original_filename)
    when ".csv" then CSV.parse(infile)
    # when ".xls" then Excel.new(file.path, nil, :ignore)
    # when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
