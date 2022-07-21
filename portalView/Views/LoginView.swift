    //
    //  LoginView.swift
    //  portalView
    //
    //  Created by IACD-013 on 2022/07/20.
    //

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong!"
    @State var isLoading = false
    @State var isSuccess = false
    @EnvironmentObject var user: UserStore
    
    
    
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .top) {
                
                
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverView()
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(hex: "bdd5ea"))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading,16)
                        
                        TextField("email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                    
                    Divider()
                        .padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(hex: "bdd5ea"))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading,16)
                        
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.20), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y:460)
                
                HStack{
                    Text("Forgot password")
                        .font(.subheadline)
                        .foregroundColor(isFocused ? Color.white : Color("background1"))
                    
                    Spacer()
                    
                    Button {
                        self.login()
                    } label: {
                        Text("Log in ")
                            .foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(hex: "4cc9f0"))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(hex: "4cc9f0").opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .offset(y: isFocused ? 170 : 0)
                .padding()
                
            }
            .offset(y: isFocused ? -180 : 0)
            .animation(isFocused ? .easeInOut : nil, value: isFocused)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
                //MARK: Loading view
            if isLoading {
                LoadingView()
            }
            if isSuccess{
                SuccessView()
            }
        }
    }
    
        //MARK: Login functions
    func login(){
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password){ (result,error) in
            self.isLoading = false
            
            if error != nil{
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            }else{
                self.isSuccess = true
                self.user.isLogged = true
                //User Defualts
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.isSuccess = false
                    self.email = ""
                    self.password = ""
                    self.user.showLogin = false
                }
            }
        }
    }
    
        //MARK: Dismiss Keyboard
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn design and code.\nFrom scratch")
                    .font(.system(size: geometry.size.width/11, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 325, maxHeight: 100)
            .padding(.horizontal,16)
            .offset(x: viewState.width/20, y: viewState.height/20)
            
            
            Text("80 hours of courses for SwiftUI, React and design tools")
                .font(.subheadline)
                .frame(width: 250)
                .offset(x: viewState.width/25, y: viewState.height/25)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            //Background card view
            
            ZStack {
                Image("Blob")
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360 + 90: 90))
                    .blendMode(.plusDarker)
                    .animation(.linear(duration: 120).repeatForever(autoreverses: false), value: show)
                    .onAppear{ self.show = true }
                
                Image("Blob")
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
                    .blendMode(.overlay)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false), value: show)
            }
        )
        .background(
            Image("Card3")
                .offset(x: viewState.width/25, y: viewState.height/25)
                .scaleEffect(isDragging ? 1.1 : 1),
            alignment: .bottom)
        .background(Color(hex: "4ea8de"))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1,duration: 0.8), value: isDragging)
        .rotation3DEffect(Angle(degrees: 8), axis: (x: viewState.width, y: viewState.height, z: 0))
        .gesture(
            DragGesture().onChanged{ value in
                self.viewState = value.translation
                self.isDragging = true
            }
                .onEnded{ value in
                    self.viewState = .zero
                    self.isDragging = false
                }
        )
    }
}
