# Somativo: Projeto Swift 

### Projeto Swift Essencial: Sistema de Notificações

![image](https://github.com/user-attachments/assets/a68a1a46-3596-4bb3-9396-7d784452031c)


Este projeto implementa um sistema de envio de notificações utilizando o paradigma **Protocol-Oriented Programming (POP)** em Swift.


### 🔺 1. Protocolo notificável:

##### Enunciado:

![image](https://github.com/user-attachments/assets/ea6cc00d-050e-4e30-a4ef-9cd8693894c1)

##### Implementação:

```swift
// Struct que representa uma mensagem, com tipo e conteúdo
struct Mensagem {
    let tipo: TipoMensagem
    let conteudo: String
}

// Protocolo que define um canal de notificação
protocol Notificavel {
    var mensagem: Mensagem { get }
    var prioridade: PrioridadeNotificacao { get }
    func enviarNotificacao()
}

```

### 🔺 2. Tipos conformantes:

##### Enunciado:

![image](https://github.com/user-attachments/assets/71d8fb28-79c7-470d-90ad-1825927eb2e4)

##### Implementação:

```swift
// Struct que representa envio de email
struct Email: Notificavel {
    let enderecoEmail: String                 
    let mensagem: Mensagem                  
    var prioridade: PrioridadeNotificacao = .baixa  

    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando email para \(enderecoEmail): \(mensagem.conteudo) - \(mensagem.tipo)")
    }
}

// Struct que representa envio de SMS
struct SMS: Notificavel {
    let numeroTelefone: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando SMS para \(numeroTelefone): \(mensagem.conteudo) - \(mensagem.tipo)")
    }
}

// Struct que representa envio de Push Notification
struct PushNotification: Notificavel {
    let tokenDispositivo: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando Push Notification para dispositivo \(tokenDispositivo): \(mensagem.conteudo) - \(mensagem.tipo)")
    }
}
```


### 🔺 3. Protocol extensions:

##### Enunciado:

![image](https://github.com/user-attachments/assets/7a067637-5c15-4a91-bba1-ca3722c30d38)


##### Implementação:

```swift
// Extensão do protocolo Notificavel que fornece uma implementação padrão para enviarNotificacao() e define a prioridade padrão como "baixa"
extension Notificavel {
    func enviarNotificacao() {
        print("Enviando notificação...")
    }

    var prioridade: PrioridadeNotificacao {
        return .baixa
    }
}
// Struct que representa o envio de notificações por email
struct Email: Notificavel {
    let enderecoEmail: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    // Implementação específica para envio por email
    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando email para \(enderecoEmail): \(mensagem.conteudo)- \(mensagem.tipo)")
    }
}

// Struct que representa o envio de notificações por SMS
struct SMS: Notificavel {
    let numeroTelefone: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    // Implementação específica para envio por SMS
    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando SMS para \(numeroTelefone): \(mensagem.conteudo)- \(mensagem.tipo)")
    }
}

// Struct que representa o envio de notificações via Push Notification
struct PushNotification: Notificavel {
    let tokenDispositivo: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    // Implementação específica para envio via push
    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando Push Notification para dispositivo \(tokenDispositivo): \(mensagem.conteudo) - \(mensagem.tipo)")
    }
}
```

### 🔺 4. Agrupamento de canais (Array com Protocol Composition):

##### Enunciado:

![image](https://github.com/user-attachments/assets/27e62c31-d0ce-46b9-b46f-863994467c03)


##### Implementação:

```swift
 // Array contendo diferentes canais de notificação (protocol composition)
        let canaisNotificacao: [Notificavel] = [email1, email2, sms1, sms2, push1, push2]

        // Envio geral de notificações
        print("Enviando notificações")
        canaisNotificacao.forEach { $0.enviarNotificacao() }
```


### 🔺 5. Sistema de mensagens:

##### Enunciado:

![image](https://github.com/user-attachments/assets/a9095285-281d-477b-9ada-5339a8edf987)


##### Implementação:

```swift
// Enum que representa os tipos de mensagens possíveis
enum TipoMensagem {
    case promocao
    case lembrete
    case alerta
}

// Enum que representa a prioridade de uma notificação
enum PrioridadeNotificacao {
    case baixa
    case media
    case alta
}

// Struct que representa uma mensagem, com tipo e conteúdo
struct Mensagem {
    let tipo: TipoMensagem
    let conteudo: String
}

// Protocolo que define um canal de notificação
protocol Notificavel {
    var mensagem: Mensagem { get }
    var prioridade: PrioridadeNotificacao { get }
    func enviarNotificacao()
}
```

### 🔺 6. Lógica principal:

##### Enunciado:

![image](https://github.com/user-attachments/assets/3dc45290-2b45-4079-9029-74e91952d436)


##### Implementação:

```swift
 // Função principal que executa o envio das notificações
    func executar() {
        // Criação de diferentes mensagens
        let mensagemPromocao = Mensagem(tipo: .promocao, conteudo: "PUC PR - AULA DE SWIFT")
        let mensagemLembrete = Mensagem(tipo: .lembrete, conteudo: "Comprar Whey para o João")
        let mensagemAlerta = Mensagem(tipo: .alerta, conteudo: "Lembrete de pagamento do boleto da PUC")

        // Criação de canais de notificação com diferentes mensagens e prioridades
        let email1 = Email(enderecoEmail: "jvfdevelopment@gmail.com", mensagem: mensagemPromocao, prioridade: .media)
        let email2 = Email(enderecoEmail: "carlos.hobmeier@hotmail.com", mensagem: mensagemLembrete)
        
        let sms1 = SMS(numeroTelefone: "+55 (41) 998970828", mensagem: mensagemAlerta, prioridade: .alta)
        let sms2 = SMS(numeroTelefone: "+55 (41) 999790762", mensagem: mensagemPromocao)
        
        let push1 = PushNotification(tokenDispositivo: "TOKEN123", mensagem: mensagemLembrete, prioridade: .media)
        let push2 = PushNotification(tokenDispositivo: "TOKEN456", mensagem: mensagemAlerta)

        // Array contendo diferentes canais de notificação (protocol composition)
        let canaisNotificacao: [Notificavel] = [email1, email2, sms1, sms2, push1, push2]

        // Envio geral de notificações
        print("Enviando notificações")
        canaisNotificacao.forEach { $0.enviarNotificacao() }
```

### 🔺 7. Desafios adicionais:

#### Prioridade de notificação:

##### Enunciado:

![image](https://github.com/user-attachments/assets/d8aba476-9ded-4095-a132-e5fb9cb3794e)

##### Implementação:

```swift
// Enum que representa a prioridade de uma notificação
enum PrioridadeNotificacao {
    case baixa
    case media
    case alta
}

(...)

protocol Notificavel {
    var mensagem: Mensagem { get }
    var prioridade: PrioridadeNotificacao { get } // <- Aqui!
    func enviarNotificacao()
}

(...)

// Struct que representa o envio de notificações por email
struct Email: Notificavel {
    let enderecoEmail: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    // Implementação específica para envio por email
    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando email para \(enderecoEmail): \(mensagem.conteudo)- \(mensagem.tipo)")
    }
}
```

#### Filtro de canais:

##### Enunciado:

![image](https://github.com/user-attachments/assets/bfbcbfc2-893e-46cc-a097-f5e52812d36a)

##### Implementação:

```swift
// Função genérica que filtra os canais de notificação de um tipo específico
func filtrarCanais<T>(canais: [Notificavel], tipo: T.Type) -> [T] {
    return canais.compactMap { $0 as? T }
}
```
