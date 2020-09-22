class User::AcceptTerm < ApplicationService

  def call(version)
    accept_term = current_user.accept_term
    User::GuardValidation.new.validate_accept_term(accept_term, version)

    version_hash = { number: version, timestamp: DateTime.now }
    if accept_term.nil?
      accept_term = { versions: [version_hash] } 
    else
      accept_term["versions"] << version_hash
    end

    current_user.attributes = { accept_term: accept_term }
    current_user.save!
    "success"
  end
end