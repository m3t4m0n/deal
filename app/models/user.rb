class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  def self.find_for_oauth(auth, signed_in_resource = nil)
    # user와 identity가 nil이 아니라면 받는다.
    
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    
    # user가 nil이라면 새로 생성
    
    if user.nil?
      # 이미 있는 이메일인지 확인
      email = auth.info.email
      user = User.where(:email => email).first
      
      unless self.where(email: auth.info.email).exists?
        # 없다면 새로운 데이터 생성
      
        if user.nil?
        # 카카오는 email 제공 X
        
          if auth.provider == "kakao"
            # provider별로 데이터 제공 해시의 이름이 다름
            # 각각의 omniauth별로 auth hash가 어떤 경로로, 어떤 이름으로 제공되는지 확인이 필요
            
            user = User.new(
              profile_img: auth.info.image,
              # 이 부분은 AWS S3와 연동할 때 프로필 이미지를 저장하기 위해 필요한 부분
          
              # remote_profile_img_url: auth.info.image.gsub('http://','https://'),
              
              password: Devise.friendly_token[0, 20]
            )
          
          else
            user = User.new(
              email: auth.info.email,
              profile_img: auth.info.image,
              #remote_profile_img_url: auth.info.image.gsub('http://', 'https://'),
              
              password: Devise.friendly_token[0, 20]
            )
            
          end
          user.save!
          
        end
      end
    end
    
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
    
  end
        
  # email이 없어도 가입 되도록
  def email_required?
    false
  end
  
end
