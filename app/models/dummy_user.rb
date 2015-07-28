class DummyUser
	def name
		"dummy"
	end
	alias_method :nice_name, :name

	def sid
		"dummy"
	end

	def admin?
		APP_CONFIG[:ignore_ldap]
	end
end
