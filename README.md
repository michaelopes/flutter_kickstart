
# Flutter Kickstart

O projeto Flutter Kickstart surgiu para facilitar o dia a dia do desenvolvedor, trazendo uma série de funcionalidades uteis para a rotina de desenvolvimento, mas também, ajudando a começar um novo projeto, já que embarca diversas soluções para criação de novos projetos. O projeto também visa facilitar o entendimento de quem está começando com o Flutter facilitando alguns processos de desenvolvimento. 
O Flutter Kickstart utiliza de recursos/packages já existentes no mercado como o GoRouter para o gerenciamento de rotas, porém, há uma camada acima para contemplar como nós gostaríamos que as rotas fossem gerenciadas, contudo, também há funcionalidades próprias desenvolvidas exclusivas para o package como o sistema reativo de gerência de estados,assim como o sistema de temas, que será explicado à frente.




## Autores
- [@michaelopes](https://github.com/michaelopes)


## Projeto com exemplos

 - [Clique aqui para visualisar](https://github.com/michaelopes/flutter_kickstart/tree/develop/example)

Nesse link vai encontrar as funcionalidades aplicadas na prática.
## Iniciar um APP

```dart
void main() async {
  //É obrigatório a chamada desse método antes do runApp. 
  //Esse método é responsável pela iniciação do package 
  await Fk.init(
    //Diretório para pasta de traduções
    i18nDirectory: "assets/i18n/",
    //Traduções disponívels
    availableLanguages: ["pt_BR"],
    //Tradução padrão do app
    defaultLocale: const Locale("pt", "BR"),
    //Intermediador de requests HTTP (OPCIONAL)
    //Será exemplificado à frente 
    httpDriverMiddleware: AppHttpMiddleware(),
    //Intermediador de navegação de view (OPCIONAL).
    //Pode ser utilizado por exemplo para chegar se o usuário está 
    //com o login válido no app será exemplificado à frente 
    moduleMiddleware: AppModuleMiddleware(),
    //Intermediador de respostas HTTP (OPCIONAL).
    //Com esse parser é possivel customizar erros ou respostas para 
    //cada faixa de códigos HTTP ex: 200, 400, 500, etc..
    httpDriverResponseParser: AppHttpResponseParser(),
    baseUrl: "https://www.thecocktaildb.com/api/json",
  );

  runApp(
    FkApp(
      appTitle: "Flutter Kickstart",
      //Registos de módulos (VIEWS) do app
      modules: () => AppModules().modules,
      //Registos de injeções de depências no app
      injections: AppInjections().get,
      //Register do gerenciador global de erros
      globalFailureHandler: AppGlobalError(),
      //Register do FkTheme no app
      theme: AppTheme().theme,
    ),
  );
}
```


## Sistema de tradução (i18n)
Caso deseje trabalhar com traduções dentro do Flutter KickStart é bem simples.

Basta criar uma pasta de onde estará os arquivos de tradução com a extenção .json. 
Exemplo para tradução pt_BR será criado um arquivo no nosso exemplo, "pt_BR.json" dentro da pasta assets/i18n no root do projeto lembrado que essa pasta deverá ser referênciada no "pubspec.yaml" do projeto como abaixo:

```YAML
flutter:
  assets:
    - assets/i18n/
```
Após feito essa configuração basta criar o conteúdo do arquivo json como no exemplo abaixo, lembrado que não há limite de encadeamento de chaves de tradução.

```json
{
  "pages": {
    "drink": {
      "title": "Bebidas",
      "search_label": "Buscar por drinks",
      "search_placeholder": "Ex: margarita, beer, vodka...",
      "empty_search_message": "Realize uma busca de drink. Ex: margarita, beer, vodka..",
      "not_found_search_message": "Nenhum resultado foi encotrado com o termo buscado. Por favor, tente uma busca diferente,"
    },
    "drink_detail": {
      "ingredients": "Ingredientes",
      "instructions": "Instruções"
    }
  }
}
```