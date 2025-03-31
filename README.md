# Somativo: Projeto Swift 

### Projeto Swift Essencial: Sistema de Notificações

### Integrantes: Amanda Queiroz Sobral, Carlos Eduardo Domingues Hobmeier, João Vitor de Freitas e Theo Lucas Nicoleli


![image](https://github.com/user-attachments/assets/a68a1a46-3596-4bb3-9396-7d784452031c)


Este projeto implementa um sistema de envio de notificações utilizando o paradigma **Protocol-Oriented Programming (POP)** em Swift.


### 🔺 1. Protocolo notificável:

##### Enunciado:

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_um.png)

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

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_dois.png)

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

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_tres.png)


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

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_quatro.png)


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

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_cinco.png)


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

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_seis.png)


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

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_sete.png)

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

![image](https://github.com/joaoson/Swift---SOMATIVA1/blob/main/images/requisito_oito.png)

##### Implementação:

```swift
// Função genérica que filtra os canais de notificação de um tipo específico
func filtrarCanais<T>(canais: [Notificavel], tipo: T.Type) -> [T] {
    return canais.compactMap { $0 as? T }
}
```
