class UserSkillValidator < ActiveModel::Validator
    def subv(col)
        col.present? && nil != (col.to_s =~ /^[0-9]+$/) && col.to_i >= 1 && col.to_i <= 5
    end
    def validate(record)
        if options[:fields].any?{|field| !subv(record.send(field)) }
            record.errors[:skill] << "skill validation error."
        end
    end
end

class User < ApplicationRecord
    include ActiveModel::Validations
    
    has_many :participants, dependent: :destroy
    has_many :liker_relation, class_name: "Like", foreign_key: "liker_id", dependent: :destroy
    has_many :liked_relation, class_name: "Like", foreign_key: "liked_id", dependent: :destroy
    has_many :user1_matching, class_name: "Matching", foreign_key: "user1_id", dependent: :destroy
    has_many :user2_matching, class_name: "Matching", foreign_key: "user2_id", dependent: :destroy
    has_many :sender_direct_message, class_name: "DirectMessage", foreign_key: "sender_id", dependent: :destroy
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    # column validation
    validates :name, presence:true, uniqueness: true
    validates :email, presence:true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
        # for password authenticate
    has_secure_password
    validates :password, presence:true, length: { minimum: 4 }
        # for skill
    validates_with UserSkillValidator, fields: [:web, :crypto, :reversing, :pwn, :misc]

    validates :self_introduction, presence: true, length: { maximum: 200 }

    def User.digest(string)
        BCrypt::Password.create(
            string, 
            cost: ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        )
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
end
