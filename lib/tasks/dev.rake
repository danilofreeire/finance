namespace :dev do
  desc "Reset the database"
  task reset: :environment do

    system("rails db:drop")
    system("rails db:create")
    system("rails db:migrate")
    system("rails db:seed")
    system("rails dev:add_accounts")
    system("rails dev:add_transactions")
  end

  desc "Add sample accounts"
  task add_accounts: :environment do
    show_spinner("Adding sample accounts...") { add_accounts}
  end
  desc "Add sample transactions"
  task add_transactions: :environment do
    show_spinner("Adding sample transactions...") { add_transactions}
  end

  
  def add_accounts
    user = User.first
    banks =["Nubank", "Inter", "C6 Bank", "Banco Original", "Banco Pan", "Banco Neon"]

    4.times do 
      bank_name = banks.sample
      Account.create(
        name: bank_name,
        kind: Account.kinds.keys.sample,
        opening_balance: rand(100..1000),
        user: User.first
      )    
    end
  end


  def add_transactions
    accounts = Account.all
    50.times do 
      Transaction.create(
        date: Date.today,
        amount: rand(10..200),
        kind: Transaction.kinds.keys.sample,
        account: accounts.sample,
        description: Faker::Commerce.product_name
      )
    end
  end

   def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
