class Cognito
    @client = Aws::CognitoIdentityProvider::Client.new
  
    def self.authenticate(user_object)
        auth_object = {
            user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
            client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
            auth_flow: 'ADMIN_NO_SRP_AUTH',
            auth_parameters: user_object
        }
        puts auth_object
    
        @client.admin_initiate_auth(auth_object)
    end
  
    def self.sign_out(access_token)
        @client.global_sign_out(access_token: access_token)
    end
    
    def self.create_user(user_object)
        puts user_object[:NAME]
        #Add here all attributes required from your pool
        auth_object = {
            client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
            username: user_object[:USERNAME],            
            password: user_object[:PASSWORD],
            user_attributes: [
                {
                  name: "name",
                  value: user_object[:NAME]
                }
              ]            
        }
    
        @client.sign_up(auth_object)
    end
  end