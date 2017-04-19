module ApplicationHelper
  
  def created_msg
    'Article has been created.'
  end

  def not_created_msg
    'Article has not been created.'
  end
  
  def updated_msg
    'Article has been updated.'
  end

  def not_updated_msg
    'Article has not been updated.'
  end

  def deleted_msg
    'Article has been deleted.'
  end
  
  def not_found_msg
    'The article you are looking for could not be found.'
  end

  def sign_in_before_msg
    'You need to sign in or sign up before continuing.'
  end
  
  def only_edit_own_msg
    'You can only edit your own article.'
  end

  def only_delete_own_msg
    'You can only delete your own article.'
  end
end
