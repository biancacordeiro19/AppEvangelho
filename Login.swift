import SwiftUI

struct entrarView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: entrarView()) {
                    Text("Login")
                        .foregroundColor(.blue)
                        .padding()
                    
                    NavigationLink(destination: CriarContaView()) {
                        Text("Criar Conta")
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    Spacer()
                }
                .navigationTitle("Entrar")
            }
        }
    }
    
    // Tela de Criar Conta integrada
    struct CriarContaView: View {
        @State private var name: String = ""
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var confirmPassword: String = ""
        @State private var birthDate: Date = Date()
        @State private var errorMessage: String? = nil
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Criar Conta")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Nome completo", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                TextField("E-mail", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Senha", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                SecureField("Confirmar senha", text: $confirmPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Button(action: createAccount) {
                    Text("Criar Conta")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Cadastro")
        }
        
        private func createAccount() {
            guard !name.isEmpty else {
                errorMessage = "O nome é obrigatório."
                return
            }
            guard !email.isEmpty else {
                errorMessage = "O e-mail é obrigatório."
                return
            }
            guard password == confirmPassword else {
                errorMessage = "As senhas não coincidem."
                return
            }
            
            errorMessage = nil
            print("Conta criada com sucesso para \(name)!")
        }
    }
    

    
    // Preview para testar no Xcode
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            sidebar()
        }
    }
}
