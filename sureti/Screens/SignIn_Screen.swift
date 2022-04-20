    //
    //  SignIn_Screen.swift
    //  sureti
    //
    //  Created by Devolper.Scorpio on 20/04/2022.
    //

import SwiftUI

struct SignIn_Screen: View {
    
    @ObservedObject var observed = Observed()
    
    var body: some View {
        if observed.navigate_to_Register {
            SignUp_Screen()
        }else{
           
        VStack{
            Image("Logo")
            if observed.isValid  { Password_Card } else { email_Card }
            if observed.msg != "" {
                Text(observed.msg).lineLimit(03)
                    .foregroundColor(.white)
                    .font(.custom("Product Sans Regular", size: 12))
            }
        }.edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .background(
                Overlay()
            )
           
    }
    }
    
    var email_Card : some View{
        
        VStack(alignment: .leading){
            Text("Sign In or Create Account")
                .foregroundColor(Color("Primary_Color"))
                .font(.custom("Product Sans Bold", size: 20))
            Text("POLICYHOLDER ACCOUNT")
                .foregroundColor(Color.secondary)
                .font(.custom("Product Sans Regular", size: 12))
                .padding(.top , 1)
            FloatingTextField(placeHolder: "Email", text: $observed.email)
                .padding(.top)
                .padding(.bottom)
            if observed.isloading {
                HStack{
                    Spacer()
                    ProgressView()
                        .frame(width: 30, height: 30, alignment: .center)
                    Spacer()
                }
            }else{
            Button {
                if observed.email != ""{
                    observed.apiCall_vaildUser()
                }else{
                    print("Please fill")
                }
                
            } label: {
                HStack{
                    Spacer()
                    Custom_Button(text: "Next")
                    Spacer()
                }.padding(.top , 4)
            }
            }
        }.padding()
        
            .frame(width: UIScreen.screenWidth / 1.04, height: 270)
            .background(Color.white)
            .cornerRadius(15.0)
            .padding(.top , 90)
    }
    
    var Password_Card : some View{
        
        VStack(alignment: .leading){
            Text("Sign In ")
                .foregroundColor(Color("Primary_Color"))
                .font(.custom("Product Sans Bold", size: 20))
            Text("POLICYHOLDER ACCOUNT")
                .foregroundColor(Color.secondary)
                .font(.custom("Product Sans Regular", size: 12))
                .padding(.top , 1)
            FloatingTextField(placeHolder: "Password", text: $observed.password)
                .padding(.top)
            HStack{
                Spacer()
                Text("Forget Password?")
                    .underline()
                    .foregroundColor(Color("Primary_Color"))
                    .font(.custom("Product Sans Regular", size: 12))
            }
            .padding(.bottom)
            if observed.isloading {
                HStack{
                    Spacer()
                    ProgressView()
                        .frame(width: 30, height: 30, alignment: .center)
                    Spacer()
                }
               
            }else{
            Button {
                if observed.password != ""{
                    observed.apiCall_SignIn()
                }else{
                    print("Please fill")
                }
            } label: {
                HStack{
                    Spacer()
                    Custom_Button(text: "Sign In")
                    Spacer()
                }.padding(.top , 4)
                    .disabled(observed.password.isEmpty)
            }
            }
        }.padding()
        
            .frame(width: UIScreen.screenWidth / 1.04, height: 270)
            .background(Color.white)
            .cornerRadius(15.0)
            .padding(.top , 90)
    }
}

struct SignIn_Screen_Previews: PreviewProvider {
    static var previews: some View {
        SignIn_Screen()
    }
}


extension SignIn_Screen {
    
   struct User_Check_Model : Decodable {
       let Requested_Action : Bool
       let message : String
   }
    
    class Observed : ObservableObject{
        //TextField
        @Published var email: String = ""
        @Published var password: String = ""
        
        @Published var products_Response = [User_Check_Model]()
        @Published var isValid : Bool = false
        @Published var navigate_to_Register: Bool = false
        @Published var navigate_to_Home: Bool = false
        @Published var isloading: Bool = false
        @Published var msg : String = ""
        
        
        func apiCall_vaildUser(){
            self.isloading = true
                //Create url
            guard let url = URL(string: "https://devconsole.sureti.com:9000/Mobile/doesUserExist?email=\(email)")else {return}
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
                        
                        if main.message == "User Found." && main.Requested_Action {
                            self.isValid = true
                        }else if main.message == "User Not Found." && main.Requested_Action {
                            self.navigate_to_Register = true
                            self.msg = main.message
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
        
        func apiCall_SignIn(){
            self.isloading = true
                //Create url
            guard let url = URL(string: "https://devconsole.sureti.com:9000/Mobile/UserLogin?email=\(email)&password=\(password)&pushNotificationToken=\("")")else {return}
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
                        if main.message == "" && main.Requested_Action {
                            self.navigate_to_Home = true
                            self.msg = "Sucessfully Login"
                            
                        }
                        self.msg = main.message
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
