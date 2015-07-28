class DummyUser
	def name
		"dummy"
	end

	def sid
		"dummy"
	end

	def admin?
		APP_CONFIG[:ignore_ldap]
	end
end
