import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct criarContaView: View {
    @State private var email = ""
    @State private var senha = ""
    @State private var nome = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            TextField("Nome", text: $nome)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            TextField("E-mail", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .autocapitalization(.none)

            SecureField("Senha", text: $senha)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button("Criar Conta") {
                criarConta()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }

    func criarConta() {
        Auth.auth().createUser(withEmail: email, password: senha) { result, error in
            if let error = error {
                errorMessage = "Erro: \(error.localizedDescription)"
                return
            }

            if let user = result?.user {
                let db = Firestore.firestore()
                db.collection("usuarios").document(user.uid).setData([
                    "nome": nome,
                    "email": email
                ]) { error in
                    if let error = error {
                        errorMessage = "Erro ao salvar dados: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
}
