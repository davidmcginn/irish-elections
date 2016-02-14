class PopulateTwitterListFields < ActiveRecord::Migration
  CONSTITUENCIES_LISTS = [
    {'name' => 'Carlow–Kilkenny', 'list' => 'ge16-cwkk'},
    {'name' => 'Cavan–Monaghan', 'list' => 'ge16-cnmn'},
    {'name' => 'Clare', 'list' => 'ge16-clare'},
    {'name' => 'Cork East', 'list' => 'ge16-cke'},
    {'name' => 'Cork North–Central', 'list' => 'ge16-cknc'},
    {'name' => 'Cork North–West', 'list' => 'ge16-cknw'},
    {'name' => 'Cork South–Central', 'list' => 'ge16-cksc'},
    {'name' => 'Cork South–West', 'list' => 'ge16-cksw'},
    {'name' => 'Donegal', 'list' => 'ge16-dl'},
    {'name' => 'Dublin Bay North', 'list' => 'ge16-dubbn'},
    {'name' => 'Dublin Bay South', 'list' => 'ge16-dubbs'},
    {'name' => 'Dublin Central', 'list' => 'ge16-dubc'},
    {'name' => 'Dublin Fingal', 'list' => 'ge16-dubfl'},
    {'name' => 'Dublin Mid–West', 'list' => 'ge16-dubmw'},
    {'name' => 'Dublin North–West', 'list' => 'ge16-dubnw'},
    {'name' => 'Dublin Rathdown', 'list' => 'ge16-dubrd'},
    {'name' => 'Dublin South–Central', 'list' => 'ge16-dubsc'},
    {'name' => 'Dublin South–West', 'list' => 'ge16-dubsw'},
    {'name' => 'Dublin West', 'list' => 'ge16-dubw'},
    {'name' => 'Dún Laoghaire', 'list' => 'ge16-dunl'},
    {'name' => 'Galway East', 'list' => 'ge16-gye'},
    {'name' => 'Galway West', 'list' => 'ge16-gyw'},
    {'name' => 'Kerry', 'list' => 'ge16-ky'},
    {'name' => 'Kildare North', 'list' => 'ge16-ken'},
    {'name' => 'Kildare South', 'list' => 'ge16-kes'},
    {'name' => 'Laois', 'list' => 'ge16-laois'},
    {'name' => 'Limerick City', 'list' => 'ge16-lkcy'},
    {'name' => 'Limerick County', 'list' => 'ge16-lkco'},
    {'name' => 'Longford–Westmeath', 'list' => 'ge16-ldwh'},
    {'name' => 'Louth', 'list' => 'ge16-louth'},
    {'name' => 'Mayo', 'list' => 'ge16-mayo'},
    {'name' => 'Meath East', 'list' => 'ge16-mhe'},
    {'name' => 'Meath West', 'list' => 'ge16-mhw'},
    {'name' => 'Offaly', 'list' => 'ge16-Off'},
    {'name' => 'Roscommon–Galway', 'list' => 'ge16-rsgal'},
    {'name' => 'Sligo–Leitrim', 'list' => 'ge16-solm'},
    {'name' => 'Tipperary', 'list' => 'ge16-tipp'},
    {'name' => 'Waterford', 'list' => 'ge16-wd'},
    {'name' => 'Wexford', 'list' => 'ge16-wx'},
    {'name' => 'Wicklow', 'list' => 'ge16-wk'}
  ]

  def up
    CONSTITUENCIES_LISTS.each do |constituency|
      c = Constituency.find_by_name(constituency['name'])
      if c
          c.twitter_list = constituency['list']
          c.save!
      else
        print "#{constituency['name']} not found"
      end
    end
  end

  def down
    Constituency.update_all({twitter_list: nil})
  end
end
