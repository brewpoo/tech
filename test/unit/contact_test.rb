require File.dirname(__FILE__) + '/../test_helper'

class ContactTest < Test::Unit::TestCase
  fixtures :contacts

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_similiar_name
    c=Contact.new
    c.last_name="Lochner"
    c.first_name="Eric"
    c.save
    assert !c.unsaved?, "Name is unique"
  end

  def test_uniqueness
    c=Contact.new
    c.last_name="Lochner"
    c.first_name="Jon"
    assert !c.save, "Name is not unique"
  end

  def test_associated_manager
    c=Contact.new
    c.last_name="Boss"
    c.first_name="Big"
    c.save
    contacts(:one).manager=c
    assert c.associated_valid? 
  end

  def test_employee_number
    c=Contact.new
    c.last_name="Schmoe"
    c.first_name="Joe"
    c.employer_id=1
    c.employee_number="28760"
    assert !c.save, "employee number already exists for same employer"
  end
    
end
