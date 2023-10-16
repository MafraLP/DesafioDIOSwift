let firstName = "Steve"
var surname: String?
= "Jobs"
//Quebra de linha acima para faclitar comentar e descomentar

//Esse primeiro print não parece nada com nada apresentado no curso até então, mas foi a única interpretação do enunciado que eu consegui executar
print("\(firstName) \(surname ?? "Wozniack")")

if let unwrappedLastName = surname {
    print("Nome unwrapped: \(firstName) \(unwrappedLastName)")
}

