

class SupportTier
  attr_accessor :name, :target_customer

  attr_accessor :price_usd, :support_months, :sku

  attr_accessor :so_support, :email_support, :phone_support, :contacts

  attr_accessor :dev_hours_yr, :architecture_hours_yr, :assisted_installs_yr, :emergency_incidents_yr,  :support_incidents_mo

  attr_accessor :min_dev_hours, :min_architecture_hours

  attr_accessor :lifetime_license, :all_plugins_included,  :early_access, :major_upgrades

  attr_accessor :response_time_hours
  attr_accessor :hotfix_time_days
  attr_accessor :includes_oem


  def total_of(member, divisor = 1, ceil = false)
    val = send(member)
    return nil if val.nil? || support_months.nil?
    return Float::INFINITY if val == Float::INFINITY
    val = val.to_f * support_months.to_f / divisor.to_f
    return ceil ? val.ceil.to_i : val
  end 

  def total_dev_hours
    [min_dev_hours,total_of(:dev_hours_yr, 12)].max
  end

  def total_architecture_hours
    [min_architecture_hours, total_of(:architecture_hours_yr, 12)].max
  end

  def total_assisted_installs
    total_of(:assisted_installs_yr, 12, true)
  end

  def total_emergency_incidents
    total_of(:emergency_incidents_yr, 12, true)
  end

  def total_support_incidents
    total_of(:support_incidents_mo, 1, true)
  end

  def percent_discount
    cheapest = lengths.first #min_by{|c| c.price_usd}
    base_rate = cheapest.price_usd.to_f / cheapest.support_months.to_f
    this_rate = price_usd.to_f / support_months.to_f
    pct = (((base_rate - this_rate) / base_rate)) * 100.0

    #puts " #{base_rate} to #{this_rate} is #{pct}%"
    pct
  end 

  def price_usd_str
    "$%.0f USD" % price_usd
  end 

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
    @min_dev_hours = 0
    @min_architecture_hours = 0
    @includes_oem = false
    @lengths = []
    @lengths << create_support_sku(6,849,'R3Elite')
    @lengths << create_support_sku(12,849,'R3Elite')
    #@lengths << create_support_sku(24,849,'R3Elite')
    
  end 

  def create_support_sku(months, price_usd, sku)
    n = self.dup #Marshal::load(Marshal.dump(self))
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
    @min_architecture_hours = 0.5
    @lengths = [] #So the clones reference the same array and can access their siblings
    @lengths << create_support_sku(6,949,'Bronze6MO')
    @lengths << create_support_sku(12,1500,'Bronze1YR')
    #@lengths << create_support_sku(24,2000,'Bronze2YR')
    
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
    @min_architecture_hours = 2
    @lengths = []
    @lengths << create_support_sku(6,3000,'Silver6MO')
    @lengths << create_support_sku(12,5000,'Silver1YR')
    #@lengths << create_support_sku(24,8000,'Silver2YR')
    @includes_oem = true
    
  end

  def set_gold_tier
    set_silver_tier
    @name = 'Gold'
    @target_customer = 'Enterprise'
    @dev_hours_yr = 10
    @assisted_installs_yr = 10
    @architecture_hours_yr = 5
    @min_architecture_hours = 5
    @emergency_incidents_yr = Float::INFINITY
    @hotfix_time_days = 2
    @lengths = []
    @lengths << create_support_sku(6,6000,'Gold6MO')
    @lengths << create_support_sku(12,10000,'Gold1YR')
    @lengths << create_support_sku(24,17000,'Gold2YR')
    
  end

  def set_oem_tier
    set_elite_tier
    @dev_hours_yr = 0
    @name = "OEM/SaaS"
    @target_customer = 'Startup'
    @includes_oem = true
    @price_usd = 2800
    @architecture_hours_yr = 2
    @contacts = 1
    @support_incidents_mo = 1
    @response_time_hours = 24
    @major_upgrades = true
    @early_access = true
    @email_support = true
    @min_architecture_hours = 2
    @lengths = []
    @lengths << create_support_sku(12, 2800, 'OEMSaaS')
    
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
  def self.oem
    n = SupportTier.new
    n.set_oem_tier
    n
  end
end

