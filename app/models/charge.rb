class Charge
  AMOUNT = 500
  DESCRIPTION = 'Pixtr Membership Upgrade'
  NAME = 'Demo Site'
 
  def initialize(user, token)
    @user = user
    @token = token
  end
 
  def process
    customer = create_customer
    create_charge customer
    user.update(stripe_id: customer.id)
  end
 
  private
 
  attr_reader :user, :token
 
  def create_customer
    Stripe::Customer.create(
      email: user.email,
      card: token
    )
  end
 
  def create_charge(customer)
    Stripe::Charge.create(
      customer: customer.id,
      amount: Charge::AMOUNT,
      description: Charge::DESCRIPTION,
      currency: 'usd'
    )
  end
end