

class SupportTier
  attr_accessor :name, :target_customer

  attr_accessor :price_usd, :support_months, :sku

  attr_accessor :so_support, :email_support, :phone_support, :contacts

  attr_accessor :dev_hours_yr, :architecture_hours_yr, :assisted_installs_yr, :emergency_incidents_yr,  :support_incidents_mo

  attr_accessor :lifetime_license, :all_plugins_included,  :early_access, :major_upgrades

  attr_accessor :response_time_hours
  attr_accessor :hotfix_time_days

  def hotfix_7
    hotfix_time_days && hotfix_time_days <= 7
  end

  def hotfix_2
    hotfix_time_days && hotfix_time_days <= 2
  end

  def hotfix
    !hotfix_time_days.nil?
  end

  def response_24
    response_time_hours && response_time_hours <= 24
  end

  def response_2
    response_time_hours && response_time_hours <= 2
  end


  def set_elite_tier
    @lifetime_license = true
    @so_support = true
    @name = 'Elite Edition'
    @target_customer = 'Startup/Individual'
    @all_plugins_included = true
    @hotfix_time_days = Float::INFINITY
    @price_usd = 849
    @lengths = [
      create_support_sku(6,849,'Elite Edition (1 Enterprise)'),
      create_support_sku(12,849,'Elite Edition (1 Enterprise)'),
      create_support_sku(24,849,'Elite Edition (1 Enterprise)')
    ]
  end 

  def create_support_sku(months, price_usd, sku)
    n = Marshal::load(Marshal.dump(self))
    n.support_months = months
    n.price_usd = price_usd
    n.sku = sku
    n 
  end

  attr_accessor :lengths

  def set_bronze_tier
    set_elite_tier
    @price_usd = nil
    @name = 'Bronze'
    @target_customer = 'Startup'
    @dev_hours_yr = 1
    @assisted_installs_yr = 2
    @architecture_hours_yr = 0.5
    @contacts = 1
    @support_incidents_mo = 1
    @response_time_hours = 24
    @major_upgrades = true
    @early_access = true
    @email_support = true
    @lengths = [
      create_support_sku(6,949,'Bronze Tier 6 Month Contract'),
      create_support_sku(12,1500,'Bronze Tier 1 Year Contract'),
      create_support_sku(24,2000,'Bronze Tier 2 Year Contract')
    ]
  end

  def set_silver_tier
    set_bronze_tier
    @name = 'Silver'
    @target_customer = 'Small Business'
    @response_time_hours = 2
    @hotfix_time_days = 7
    @contacts = Float::INFINITY
    @emergency_incidents_yr = 1
    @support_incidents_mo = Float::INFINITY
    @dev_hours_yr = 3
    @assisted_installs_yr = 5
    @architecture_hours_yr = 2
    @lengths = [
      create_support_sku(6,3000,'Silver Tier 6 Month Contract'),
      create_support_sku(12,5000,'Silver Tier 1 Year Contract'),
      create_support_sku(24,8000,'Silver Tier 2 Year Contract')
    ]
  end

  def set_gold_tier
    set_silver_tier
    @name = 'Gold'
    @target_customer = 'Enterprise'
    @dev_hours_yr = 10
    @assisted_installs_yr = 10
    @architecture_hours_yr = 5
    @emergency_incidents_yr = Float::INFINITY
    @hotfix_time_days = 2
    @lengths = [
      create_support_sku(6,6000,'Gold Tier 6 Month Contract'),
      create_support_sku(12,10000,'Gold Tier 1 Year Contract'),
      create_support_sku(24,17000,'Gold Tier 2 Year Contract')
    ]
  end

  def self.elite
    n = SupportTier.new
    n.set_elite_tier
    n
  end 

  def self.gold
    n = SupportTier.new
    n.set_gold_tier
    n
  end 
  def self.silver
    n = SupportTier.new
    n.set_silver_tier
    n
  end 
  def self.bronze
    n = SupportTier.new
    n.set_bronze_tier()
    n
  end 
end

