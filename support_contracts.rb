
class SupportContracts


  def free
   {name: 'Free',
    lifetime_license: true, 
    so_support:true}
  end

  def elite 
    {}.merge(free).merge({
      name: 'Elite Edition',
      target: 'Individual',
      all_plugins: true, 
      hotfix: true, 
      lengths:[
        {months:6,price_usd: 849}
      ]}
    )
  end 

  def bronze
    {}.merge(elite).merge({
      name: 'Bronze',
      target: 'Startup',
      dev_hours_yr: 1, 
      assisted_installs_yr: 2, 
      architecture_hours_yr: 0.5, 
      contacts: 1,  
      support_incidents_mo: 1,
      response_24: true,
      upgrades: true,
      early_access:true,
      lengths: [
        {months: 6,
        price_usd: 949,
        product_id: 'Bronze Tier 6 Month Contract'},
         {months: 12,
        price_usd: 1500,
        product_id: 'Bronze Tier 1 Year Contract'},
         {months: 24,
        price_usd: 2000,
        product_id: 'Bronze Tier 2 Year Contract'}
      ]
    })
  end


  def silver
    {}.merge(bronze).merge({
      name: 'Silver',
      target: 'Small Business',
      response_2: true,
      hotfix_7: true,
      contacts: Float::INFINITY, 
      emergency_incidents_yr: 1, 
      support_incidents_mo: Float::INFINITY, 
      dev_hours_yr: 3, 
      assisted_installs_yr: 5, 
      architecture_hours_yr: 2, 
      lengths: [
        {months: 6,
        price_usd: 3000,
        product_id: 'Silver Tier 6 Month Contract'},
         {months: 12,
        price_usd: 5000,
        product_id: 'Silver Tier 1 Year Contract'},
         {months: 24,
        price_usd: 8000,
        product_id: 'Silver Tier 2 Year Contract'}
      ]
    })
  end

  def gold 
    {}.merge(silver).merge({
     name: 'Gold',
      target: 'Enterprise',
      dev_hours_yr: 10, 
      assisted_installs_yr: 10, 
      architecture_hours_yr: 5, 
      emergency_incidents_yr: Float::INFINITY, 
      hotfix_2: true,
      lengths: [
        {months: 6,
        price_usd: 6000,
        product_id: 'Gold Tier 6 Month Contract'},
         {months: 12,
        price_usd: 10000,
        product_id: 'Gold Tier 1 Year Contract'},
         {months: 24,
        price_usd: 17000,
        product_id: 'Gold Tier 2 Year Contract'}
      ]
    })
end

end