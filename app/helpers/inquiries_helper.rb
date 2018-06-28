module InquiriesHelper
  def permited_user?(inquiry)
    current_user == inquiry.user
  end
end
