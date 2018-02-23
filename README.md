# Tutorial de On-Demand Resources para tvOS

Descrição
-----------
  Este é um projeto demonstrativo contendo o básico necessário para utilizar a ferramenta *On-Demand Resources* para tvOS.
  
  O On-Demand Resources é uma API criada para obtenção e gerenciamento de recursos para as aplicações na medida em que estes forem necessários, permitindo assim a construção de aplicações menores e a realização de downloads mais otimizados por parte do usuário. Outro fator importante é que o bom uso do ODR permite as aplicações serem lançadas de forma mais rápida.
  
  Nesse projeto podem ser adquiridos os seguintes conhecimentos sobre o tópico:
  
	* Tags
	* Tag Types
	* Requisição de assets
	* Tratamento de erros


Uso
----------
Os assets que não são necessários no download base do aplicativo podem ser programados para serem baixados em outro momento atribuindo tags à eles. Para fazer isso deve-se acessar a aba *Resource Tags* no projeto e atribuir tags aos assets.
![](/Screenshots/Screen1.png)
E através desse método é possível requisitar o(s) asset(s): 
`func requestImage(with tag: String, onSuccess: @escaping () -> Void, onFailure: @escaping (NSError) -> Void)`
Na imagem abaixo é possível ver os assets requisitados sendo baixados no app de exemplo:
![](/Screenshots/Screen3.png)

Créditos
--------

Licença
--------
