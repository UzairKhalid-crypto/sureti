    //
    //  SignUp_Screen.swift
    //  sureti
    //
    //  Created by Devolper.Scorpio on 20/04/2022.
    //

import SwiftUI

struct SignUp_Screen: View {
    
    @ObservedObject var observed = Observed()
    
    var body: some View {
        if observed.navigate_to_Login {
            SignIn_Screen()
        }else{
            ScrollView(.vertical , showsIndicators: false){
        VStack{
            Spacer()
            Image("Logo").padding(.bottom , 60)
            RegisterFloatingTextField(placeHolder: "First Name", text: $observed.firstName)
            RegisterFloatingTextField(placeHolder: "Last Name", text: $observed.lastName)
            RegisterFloatingTextField(placeHolder: "Email", text: $observed.email)
            RegisterFloatingTextField(placeHolder: "Password", text: $observed.password)
            RegisterFloatingTextField(placeHolder: "Confirm Password", text: $observed.confirmPassword)
            if observed.msg != "" {
                Text(observed.msg).lineLimit(03)
                    .foregroundColor(.white)
                    .font(.custom("Product Sans Regular", size: 12))
            }
            if observed.isloading {
                HStack{
                    Spacer()
                    ProgressView()
                        .frame(width: 30, height: 30, alignment: .center)
                    Spacer()
                }
                    .padding(.top , 200)
                    .padding(.bottom  ,10)
            }else{
            Button {
                if (observed.firstName != "" && observed.lastName != ""
                    && observed.email != "" && observed.password != ""
                    && observed.confirmPassword != ""){
                    if observed.password == observed.confirmPassword{
                        observed.apiCall()
                    }else{
                        print("Please passwoed Same")
                    }
                }else{
                    print("Please fill all field")
                }
            } label: {
                Custom_Button(text: "Create Account")
            }
            .padding(.top , 200)
            .padding(.bottom  ,10)
            }
                
            
            
        }.padding(40)
            .edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .background(
                Overlay()
            )
            }
        }
    }
    
}

struct SignUp_Screen_Previews: PreviewProvider {
    static var previews: some View {
        SignUp_Screen()
    }
}

extension SignUp_Screen {
    
    struct User_Check_Model : Decodable {
        let Requested_Action : Bool
        let message : String
    }
    
    class Observed : ObservableObject{
        //TextFields
        @Published var firstName: String = ""
        @Published var lastName: String = ""
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var confirmPassword: String = ""
        
        @Published var products_Response = [User_Check_Model]()
        @Published var navigate_to_Login: Bool = false
        @Published var isloading: Bool = false
        @Published var msg: String = ""
       
        
        func apiCall(){
            self.isloading = true
                //Create url
            guard let url = URL(string: "https://devconsole.sureti.com:9000/Mobile/RegisterUser?email=\(email)&password=\(password)&firstName=\(firstName)&lastName=\(lastName)&userCellNo=\("")&mailingAddress=\("")")else {return}
                //Create request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
                //:end
                //Fetch data
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                    //If sucess
                do{
                        //print("Login Sucesfully")
                    print(data)
                    let main = try JSONDecoder().decode(User_Check_Model.self, from: data)
                    print(main)
                    DispatchQueue.main.async {
                        self.products_Response = [main]
                        self.msg = main.message
                        if main.Requested_Action {
                            self.navigate_to_Login = true
                        }
                        self.isloading = false
                    }
                }catch{  // if error
                    print(error)
                }
                    //JSONSerialization
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }//:end JSONSerialization
            }//:end Fetch data
            
            task.resume()
        }
        
    }
}
