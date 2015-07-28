require 'set'
class User < ActiveLdap::Base
  ldap_mapping dn_attribute: 'sAMAccountName', classes: ['top', 'organizationalPerson', 'person', 'user'], excluded_classes: ['computer'], prefix: '', scope: :sub

  def nice_name
    begin
    givenName + ' ' + sn
    rescue
      'ERR'
    end
  end

  def membership
    @membership ||= Group.find(:all, filter: {member: dn})
  end

  def groups(force=false)
    if !@groups || force
      processed = Set.new
      list =  membership
      while !list.empty?
        x = list.pop
        Group.find(:all, filter: {member: x.dn}).each do |m|
          y = Group.find(:first, m.sAMAccountName)
          list << y if y
        end
        processed << x
      end
      @groups = processed.to_a
    else
      @groups
    end
  end

  def admin?
    groups.include?(Group.find(:first, APP_CONFIG[:admin_group]))
  end

  def User.authenticate(sid, password)
    user = User.find(sid)
    user.bind(password)
    user
  end
end
