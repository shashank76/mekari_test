module CompaniesHelper

  def option_for_select_company
    Company.all.collect{|x| [x.name, x.id]}
  end
end
